CI_DATA = {
	CI_LAST_UPDATE = -1,
    CI_INVASION_STAGE = 0,
	--CI_CURRENT_STAGE = CI_INVASION_STAGES.START.key,
	--CI_SETTING = 2, -- Not used anymore
	CI_RAZED_REGIONS = 0,
	CI_AUTORUN = false,
	CI_EARLY_TURNS = 0, -- Used by wh2_dlc17_lzd_chaos_map.lua
	CI_EXTRA_ARMIES = 0, -- Used by wh2_dlc17_lzd_chaos_map.lua
    --CI_MID_START_TURN = -1; --Start turn on phase 1. Useful for chance to start phase 2 in somes cases
};

local function current_stage()
    
    for _, value in pairs(CI_INVASION_STAGES) do
       if value.index == CI_DATA.CI_INVASION_STAGE then
           return value;
       end
    end
end

-- Easy access to current stage
local function is_start()
    return CI_INVASION_STAGES.START == current_stage();
end
local function is_intro()
    return CI_INVASION_STAGES.INTRO == current_stage();
end
local function is_mid_game()
    return CI_INVASION_STAGES.MID_GAME == current_stage();
end
local function is_end_game()
    return CI_INVASION_STAGES.END_GAME == current_stage();
end
local function is_victory()
    return CI_INVASION_STAGES.VICTORY == current_stage();
end

local function next_stage() 
    if is_start() then
        return CI_INVASION_STAGES.INTRO;
    elseif is_intro() then
        return CI_INVASION_STAGES.MID_GAME;
    elseif is_mid_game() then
        return CI_INVASION_STAGES.END_GAME;
    else
        return CI_INVASION_STAGES.VICTORY;
    end
end

-- Return the setting value for current stage
local function load_setting_for_current_stage(setting, ...)
	return CI_load_setting(setting, current_stage(), ...);
end

local function force_name(item)

    if item.key then
        return "CI_"..item.key;
    else
        return "CI_"..item;
    end
end

function CI_setup()
	GAM_LOG("CI_setup()");
	out.inc_tab("chaos");

	if cm:get_local_faction_name(true) then
		CI_DATA.CI_AUTORUN = false;
	else
		GAM_LOG("Autorun detected!");
		CI_DATA.CI_AUTORUN = true;
	end

	if CI_DATA.CI_AUTORUN == false then
		if cm:is_multiplayer() == false then
			local human_factions = cm:get_human_factions();
			local player_faction = cm:model():world():faction_by_key(human_factions[1]);

			if player_faction:subculture() == "wh_main_sc_nor_norsca" then
				GAM_LOG("Aborting Chaos invasion script, a player is Norsca!");
				out.dec_tab("chaos");
				Setup_Norsca_Chaos_Invasion();
				return;
			end
		end
	end

    -- TODO
	local chaos_faction = cm:model():world():faction_by_key(CI_ARMY_TYPES.CHAOS.faction_keys[1]);
    
	if chaos_faction:is_human() == false then
        CI_init_settings();
		CI_setup_armies();
		
		if cm:is_new_game() == true then
			cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "");
			
			GAM_LOG("Killing Archaon! - '"..chaos_faction:faction_leader():command_queue_index().."'");
			cm:set_character_immortality("character_cqi:"..chaos_faction:faction_leader():command_queue_index(), false);
			cm:kill_character(chaos_faction:faction_leader():command_queue_index(), true, false);
			
			cm:callback(function()
				cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "");
			end, 1);
		end
 
		if CI_load_setting(CI_SETTINGS.INVASIONS_ACTIVATED) then
			GAM_LOG("Creating Script Listeners");
			core:add_listener(
				"CI_FactionTurnStart",
				"FactionTurnStart",
				true,
				function(context) CI_FactionTurnStart(context) end,
				true
			);
			core:add_listener(
				"CI_CharacterRazedSettlement",
				"CharacterRazedSettlement",
				true,
				function(context) CI_CharacterRazedSettlement(context) end,
				true
			);
			core:add_listener(
				"CI_CharacterConvalescedOrKilled",
				"CharacterConvalescedOrKilled",
				true,
				function(context) CI_CharacterConvalescedOrKilled(context) end,
				true
			);
		else
			GAM_LOG("Disabling Chaos Invasion! (Off Setting)");
			cm:complete_scripted_mission_objective("wh_main_short_victory", "archaon_spawned", true);
			cm:complete_scripted_mission_objective("wh_main_long_victory", "archaon_spawned", true);
			cm:complete_scripted_mission_objective("wh_main_short_victory", "archaon_defeated", true);
			cm:complete_scripted_mission_objective("wh_main_long_victory", "archaon_defeated", true);
		end
	else
		GAM_LOG("Disabling Chaos Invasion! (Human Chaos)");
	end
	out.dec_tab("chaos");
end

function CI_FactionTurnStart(context)
    
    local next_stage = next_stage();
    
    -- Nothing to do
    if not next_stage.turn_triggered then
        return;
    end

	if context:faction():is_human() == true or CI_DATA.CI_AUTORUN == true then
		local turn_number = cm:model():turn_number();

		if CI_DATA.CI_LAST_UPDATE < turn_number then
			GAM_LOG("Chaos Event Update : Turn "..turn_number);
			out.inc_tab("chaos");
			CI_DATA.CI_LAST_UPDATE = turn_number;

            -- I've changed the mechanism to start an invasion stage, but will have the smae probalities except
            -- that in base game, a stage can start on minimal turn, due to formula used
            -- So each turn a random value between min and max is set, if this value is less than current_turn, we start stage
            
            local turn_start = CI_load_setting(CI_SETTINGS.STARTING_TURN, next_stage);
            local _, turn_min, turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, next_stage);
                
            if next_stage == CI_INVASION_STAGES.END_GAME then
                -- Early turns used by wh2_dlc17_lzd_chaos_map.lua
                CI_DATA.CI_EARLY_TURNS = CI_DATA.CI_EARLY_TURNS or 0; -- Savegame compatibility
                turn_start = turn_start - CI_DATA.CI_EARLY_TURNS;
            end

            GAM_LOG("Next Event: "..next_stage.key);
            GAM_LOG("\tFirst Possible Turn: "..turn_min);
            GAM_LOG("\tLast Possible Turn: "..turn_max);
            GAM_LOG("\tTurns Early: "..CI_DATA.CI_EARLY_TURNS);
            GAM_LOG("\tCurrent starting turn: "..turn_start);

            if turn_start <= turn_number then
                GAM_LOG("\t\tSuccess!");
                
                if next_stage == CI_INVASION_STAGES.INTRO then    
                    CI_Event_1_Intro();
                elseif next_stage == CI_INVASION_STAGES.MID_GAME then
                    CI_Event_2_MidGame();
                elseif next_stage == CI_INVASION_STAGES.END_GAME then
                    CI_Event_3_EndGame();
                end
            else
                GAM_LOG("\t\tFailed!");
            end
        end
    end
	out.dec_tab("chaos");
end

-- TODO : Integrate new factions
function CI_CharacterRazedSettlement(context)
	--TODO
end

-- TODO : Integrate new factions
function CI_CharacterConvalescedOrKilled(context)
	--TODO
end

function CI_Event_1_Intro()
	GAM_LOG("CI_Event_1_Intro()");
	out.inc_tab("chaos");
    CI_DATA.CI_INVASION_STAGE = CI_INVASION_STAGES.INTRO.index;
	local human_factions = cm:get_human_factions();
	
	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_early_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_early_secondary_detail",
			true, 29
		);
		GAM_LOG("Showing Chaos Event : "..human_factions[i]);
	end
    
	--CI_apply_chaos_corruption(); No chaos corruption on Intro
	out.dec_tab("chaos");
end

function CI_Event_2_MidGame()
	GAM_LOG("CI_Event_2_MidGame()");
	out.inc_tab("chaos");
    CI_DATA.CI_INVASION_STAGE = CI_INVASION_STAGES.MID_GAME.index;
	local human_factions = cm:get_human_factions();
	
    -- TODO Location
	for i = 1, #human_factions do
		cm:show_message_event_located(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_mid_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_mid_secondary_detail",
			CI_LOCATIONS.EMPIRE.main_position[1], -- TODO
			CI_LOCATIONS.EMPIRE.main_position[2],
			true, 30
		);
		GAM_LOG("Showing Chaos Event : "..human_factions[i]);
		cm:make_region_visible_in_shroud(human_factions[i], "wh_main_chaos_wastes"); -- TODO
	end

    CI_spawn_invasions();
	--CI_spawn_chaos(event.army_spawns);
	--CI_spawn_agents(event.agent_spawns);
	--CI_declare_war(CI_CHAOS_ARMY_SPAWNS.faction_key);
	CI_apply_chaos_corruption();
	CI_personality_swap(2);
	cm:set_camera_position(518.37, 473.95, 10.83, 0.0, 11.30);
	out.dec_tab("chaos");

	CI_clean_items();
end

function CI_Event_3_EndGame()
	GAM_LOG("CI_Event_3_EndGame");
    CI_DATA.CI_INVASION_STAGE = CI_INVASION_STAGES.END_GAME.index;
    
	CI_personality_swap(3);
	CI_apply_chaos_corruption();

	CI_clean_items();
end

function CI_Event_4_Victory()
	GAM_LOG("CI_Event_4_Victory");

	CI_personality_swap(4);
    CI_DATA.CI_INVASION_STAGE = CI_INVASION_STAGES.VICTORY.index;
end


function CI_special_character_invasions(invasions)

	-- Nothing to do
	if CI_INVASION_STAGES.END_GAME ~= current_stage() then
		return;
	end

    for _, special_character in pairs(CI_SPECIAL_CHARACTERS) do
        
        local available_invasions = {};

        for i = 1, #invasions do
            if load_setting_for_current_stage(CI_SPECIAL_CHARACTERS, invasions[i].invasion_type, special_character) then
				table.insert(available_invasions, invasions[i]);
			end
        end

		local selected_invasion_number = cm:random_number(#available_invasions);
		available_invasions[selected_invasion_number][special_character.key] = true;
    end
end

-- Spawn all invasions for current stage
function CI_spawn_invasions()
    GAM_LOG("CI_spawn_invasions()");

	local invasions = {};

    for _, invasion_type in pairs(CI_INVASION_TYPES) do
        if load_setting_for_current_stage(CI_SETTINGS.IS_ACTIVATED, invasion_type) then

			if CI_INVASION_TYPES.ADDITIONAL ~= invasion_type then
				local invasion = {invasion_type = invasion_type};
				table.insert(invasions, invasion);
			else
				for i = 1, load_setting_for_current_stage(CI_SETTINGS.ADDITIONAL_INVASION_NUMBER) do
					local invasion = {invasion_type = invasion_type};
					table.insert(invasions, invasion);
				end
			end
        end
    end

	-- Due to different faction keys used, there is an order. First invasion spawn must be the one where archaon is.
	CI_special_character_invasions(invasions);

	local ordered_invasions = {};

	for i = 1, #invasions do
		
		if invasions[i].archaon == true then
			table.insert(ordered_invasions, 1, invasions[i]);
		else 
			table.insert(ordered_invasions, invasions[i]);
		end
	end

	for i = 1, #ordered_invasions do

		-- TODO :Special character spawn
		CI_spawn_armies(ordered_invasions[i].invasion_type);
    end
end

-- Spawn invasion for invasion_type (Empire, Naggaroth, Additionnal)
function CI_spawn_armies(invasion_type)
    GAM_LOG("CI_spawn_armies("..invasion_type.key..")");
	out.inc_tab("chaos");
	local location = CI_location(invasion_type);
	GAM_LOG("Spawn "..invasion_type.key.." invasion in "..location.key);
    
    for _, army_type in pairs(CI_ARMY_TYPES) do
        local number_armies = load_setting_for_current_stage(CI_SETTINGS.ARMIES_PER_INVASION, invasion_type, army_type);
		if number_armies then
			GAM_LOG("Spawn "..number_armies.." "..army_type.key.." armies.");
			out.inc_tab("chaos");
			local faction_key = CI_next_faction(army_type);
			GAM_LOG("Selected faction: "..faction_key);
			
			for _ = 1, number_armies do
				local position = CI_next_position(location, army_type);
				local char_level = load_setting_for_current_stage(CI_SETTINGS.CHARACTER_LEVEL);
				local army_level = load_setting_for_current_stage(CI_SETTINGS.ARMY_LEVEL);
				
				CI_spawn_army(faction_key, army_type, position, char_level, army_level);
			end
			out.dec_tab("chaos");
		else
			GAM_LOG("No "..army_type.key.." army.");
		end
    end
	
	out.dec_tab("chaos");
end

function CI_spawn_army(faction_key, army_type, position, char_level, army_level)
    GAM_LOG("CI_spawn_army("..faction_key..","..army_type.key..",["..position[1]..","..position[2].."],"..char_level..","..army_level..")");
    
    local x, y = cm:find_valid_spawn_location_for_character_from_position(faction_key, position[1], position[2], true);
    
    if x > -1 and y > -1 then
        local force = random_army_manager:generate_force(force_name(army_type), 19, false);
        local turn_number = cm:model():turn_number();
        
        -- TODO?
        local invasion_key = "GAM_CI_"..army_type.key.."_"..core:get_unique_counter();
        --local invasion_key = "CI_chaos_"..position_key.."_T"..turn_number.."_"..core:get_unique_counter();
        local army_invasion = invasion_manager:new_invasion(invasion_key, faction_key, force, {x, y});
        army_invasion:add_character_experience(char_level, true);
        army_invasion:apply_effect(army_type.effect_bundle, 0);

        if army_level > 0 then
            army_invasion:add_unit_experience(army_level);
        end
            
        army_invasion:start_invasion(
            function(self)
                local force = self:get_force();
                local force_cqi = force:command_queue_index();
                cm:add_building_to_force(force_cqi, army_type.buildings);
            end);
            
        GAM_LOG("Army Spawn: "..army_type.key.." ("..tostring(x).." / "..tostring(y)..")");
    else
        GAM_LOG("Failed Army Spawn!");
    end
    out.dec_tab("chaos");
end

-- TODO : Chaos corruption settings
function CI_chaos_corruption()    
    local chaos_corruption = 1;
    
    if is_end_game() then
        chaos_corruption = chaos_corruption + (CI_DATA.CI_RAZED_REGIONS / 10);
        chaos_corruption = math.floor(chaos_corruption);
    end
    
    return chaos_corruption;
end

-- Merge CI_apply_chaos_corruption and CI_invasion_effect_bundle_update
-- Planning on adding several settings on chaos corruption, so i merge these methods for more flexibility
-- All effects for effect bundle is managed here, not on DB
function CI_apply_chaos_corruption()
    GAM_LOG("CI_apply_chaos_corruption()");
	out.chaos("CI_apply_chaos_corruption()");

    local chaos_corruption = CI_chaos_corruption();
    local human_factions = cm:get_human_factions();
    
    GAM_LOG("Applied chaos corruption: "..chaos_corruption);
    
    -- Faction effect - Display
    local effect_bundle_faction_name = "gam_effect_bundle_faction_ci_"..current_stage().key;
    local effect_bundle_faction = cm:create_new_custom_effect_bundle(effect_bundle_faction_name);
    
    if is_end_game() then
        effect_bundle_faction:add_effect("wh2_main_dummy_chaos_regions_razed", "faction_to_faction_own_unseen", CI_DATA.CI_RAZED_REGIONS);
        
        local archaon, kholek, sigvald = CI_invasion_deaths();

        if archaon == 1 then
            effect_bundle_faction:add_effect("wh2_main_dummy_chaos_archaon_alive", "faction_to_faction_own_unseen", 1);
        else
            effect_bundle_faction:add_effect("wh2_main_dummy_chaos_archaon_dead", "faction_to_faction_own_unseen", 1);
        end
        if kholek == 1 then
            effect_bundle_faction:add_effect("wh2_main_dummy_chaos_kholek_alive", "faction_to_faction_own_unseen", 1);
        else
            effect_bundle_faction:add_effect("wh2_main_dummy_chaos_kholek_dead", "faction_to_faction_own_unseen", 1);
        end
        if sigvald == 1 then
            effect_bundle_faction:add_effect("wh2_main_dummy_chaos_sigvald_alive", "faction_to_faction_own_unseen", 1);
        else
            effect_bundle_faction:add_effect("wh2_main_dummy_chaos_sigvald_dead", "faction_to_faction_own_unseen", 1);
        end
    end
	
	for i = 1, #human_factions do
		local faction = cm:model():world():faction_by_key(human_factions[i]);
        local faction_key = faction:name();
        local effect_dummy;

        if faction:state_religion() == "wh_main_religion_chaos" then
            effect_dummy = "wh_main_effect_religion_conversion_chaos_events_dummy";
        else
            effect_dummy = "wh_main_effect_religion_conversion_chaos_events_bad_dummy";
        end
        
        effect_bundle_faction:add_effect(effect_dummy, "faction_to_province_own", chaos_corruption);
        
		cm:remove_effect_bundle("gam_effect_bundle_faction_ci_mid", human_factions[i]);
		cm:remove_effect_bundle("gam_effect_bundle_faction_ci_end", human_factions[i]);
		cm:apply_custom_effect_bundle_to_faction(effect_bundle_faction, faction);
	end 
    
    -- Region effect : X chaos corruption to each region
    local effect_bundle_region_name = "gam_effect_bundle_region"
    local region_list = cm:model():world():region_manager():region_list();
    
    local effect_bundle_region = cm:create_new_custom_effect_bundle(effect_bundle_region_name);
	effect_bundle_region:add_effect("wh_main_effect_religion_conversion_chaos_events_bad", "region_to_province_own", chaos_corruption);
	effect_bundle_region:set_duration(0);

	for i = 0, region_list:num_items() - 1 do
		local current_region = region_list:item_at(i);
		local region_key = current_region:name();

		if current_region:is_province_capital() == true then
			cm:remove_effect_bundle_from_region(effect_bundle_region_name, region_key);
			cm:apply_custom_effect_bundle_to_region(effect_bundle_region, current_region);
		end
	end
end

-- TODO All chaos faction
function CI_invasion_deaths()
	local chaos_faction = cm:model():world():faction_by_key(CI_ARMY_TYPES.chaos.faction_key);
	local archaon = 0;
	local kholek = 0;
	local sigvald = 0;
	local char_list = chaos_faction:character_list();
	
	for i = 0, char_list:num_items() - 1 do
		local current_char = char_list:item_at(i);

		if current_char:character_subtype("chs_archaon") or current_char:character_subtype("chs_kholek_suneater") or current_char:character_subtype("chs_prince_sigvald") then
			if current_char:has_military_force() == true then
				if current_char:is_wounded() == false then
					if current_char:character_subtype("chs_archaon") == true and current_char:is_faction_leader() == true then
						archaon = 1;
					elseif current_char:character_subtype("chs_kholek_suneater") == true  then
						kholek = 1;
					elseif current_char:character_subtype("chs_prince_sigvald") == true  then
						sigvald = 1;
					end
				end
			end
		end
	end
	return archaon, kholek, sigvald;
end

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("CI_DATA", CI_DATA, context);
	end
);
cm:add_loading_game_callback(
	function(context)
		if cm:is_new_game() == false then
			CI_DATA = cm:load_named_value("CI_DATA", CI_DATA, context);
		end
	end
);