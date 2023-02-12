

-- Gamergeo log features                 
-- Resets the log on session start.
function GAM_LOG_RESET()
    if not __write_output_to_logfile then
        return;
    end 
    local logTimeStamp = os.date("%d, %m %Y %X");
    --# assume logTimeStamp: string
    
    local popLog = io.open("gam_log.txt","w+");
    
    if popLog then
        popLog:write("NEW LOG ["..logTimeStamp.."] \n");
        popLog:flush();
        popLog:close();
    end
end

function GAM_LOG(text)
    if not __write_output_to_logfile then
        return; 
    end

    local logText = tostring(text);
    local logTimeStamp = os.date("%d, %m %Y %X");
    local popLog = io.open("gam_log.txt","a");
    --# assume logTimeStamp: string
    if popLog then
        popLog:write("GAM (chaotic_invasion):  [".. logTimeStamp .. "]:  "..logText .. "  \n");
        popLog :flush();
        popLog :close();
    end
    out.chaos("GAM (chaotic_invasion): [".. logTimeStamp .. "]:  "..logText .. "  ");
end

GAM_LOG_RESET();

-- For logging features, you still need to activate log debugging
local verbose = true;

CI_INVASION_STAGES = {
    START = {key = "start", index = 0}, -- Before intro stage
    INTRO = {key = "intro", index = 1, turn_triggered = true}, -- Intro : only message here
    MID_GAME = {key = "mid", index = 2, turn_triggered = true}, -- First stage of invasion
    END_GAME = {key = "end", index = 3, turn_triggered = true}, -- Second stage of invasion, spawn special characters
    VICTORY = {key = "victory", index = 4} -- Cleaning chaos effect, killing armies..
}

CI_INVASION_TYPES = {
    EMPIRE = {key = "empire", name = "Empire"},
    NAGGAROTH = {key = "naggaroth", name = "Naggaroth"},
    ADDITIONAL = {key = "additional", name = "Additional"}
}

CI_SPECIAL_CHARACTERS = {
    ARCHAON = {key = "archaon"},
    KHOLEK = {key = "kholek"},
    SIGVALD = {key = "sigvald"},
    SARTHORAEL = {key = "sarthorael"}     
}

CI_ARMY_TYPES = {
    CHAOS = {
        key = "chaos",
        effect_bundle = "wh_main_bundle_military_upkeep_free_force",
        buildings = {"wh_main_horde_chaos_settlement_3", "wh_main_horde_chaos_warriors_2", "wh_main_horde_chaos_forge_1"},
        main_faction_key = "wh_main_chs_chaos",
        other_faction_key = ""
    },
    NORSCA = {
        key = "norsca",
        effect_bundle = "wh_main_bundle_military_upkeep_free_force",
        main_faction_key = "wh_main_nor_bjornling",
        other_faction_key = ""
    },
    BEASTMEN = {
        key = "beastmen",
        effect_bundle = "wh_main_bundle_military_upkeep_free_force",
        buildings = {"wh_dlc03_horde_beastmen_herd_5", "wh_dlc03_horde_beastmen_gors_3", "wh_dlc03_horde_beastmen_minotaurs_1"},
        main_faction_key = "wh_dlc03_bst_beastmen_chaos",
        other_faction_key = ""
    }
}

CI_SETTINGS = {
    INVASIONS_ACTIVATED = "invasion_activated",
    STARTING_TURN = "starting_turn",
    CHARACTER_LEVEL = "character_level",

    -- Unit army level
    -- Stage dependent
    ARMY_LEVEL = "army_level",

    -- Is specific invasion activated
    -- Stage and invasion type dependent
    IS_ACTIVATED = "is_activated",

    -- Number of chaos armies per invasion
    -- Stage, invasion type and army_type dependent
    ARMIES_PER_INVASION = "armies_per_invasion",

    -- Number of agent per invasion
    -- Stage and invasion type dependent
    AGENT_PER_INVASION = "agent_per_invasion",

    -- Number of additional invasion
    -- Stage and invasion type dependent
    -- Only for additional invasion type
    NUMBER_OF_ADDITIONAL_INVASIONS = "number_of_invasions",

    -- Can special character spawn
    -- Stage, invasion type and character dependent
    -- Only on end stage
    SPECIAL_CHARACTERS_POSSIBLE = "special_character_possible",

    -- Kill all armies of this invasion on winning stage
    WINNING_KILL_ARMIES = "winning_kill_armies",
    
    -- Can two additional invasions spawn in same place
    SAME_LOCATION_POSSIBLE = "same_location_possible",
    LOCATION_ACTIVATED = "location_activated"
}

local function is_setting(setting)
    for _, value in pairs(CI_SETTINGS) do
        if value == setting then
            return true;
        end
    end
    return false;
end

local function item_keys(...)
    local keys;
    arg = {...};

    for i = 1, #arg do
        keys = {};
        local param = arg[i];

        if param.key then
            keys[i] = param.key;
        else
            keys[i] = param;
        end
    end

    return keys;
end

-- Return setting keys (type value / min / max)
function CI_setting_keys(setting, ...)
    local keys = item_keys(...);
    
    if not is_setting(setting) then
        GAM_LOG("Error: Incorrect setting provided: "..tostring(setting));
        return "";
    end

    if not keys then
        return setting;
    end

    local key = "";

    for i = 1, #keys do

        if key == "" then
            key = keys[i].."_";
        else
            key = key..keys[i].."_";
        end
    end

    key = key..setting;
    
    return key, key.."_minimum", key.."_maximum";
end

local settings = {

    -- Invasions activated
    [CI_setting_keys(CI_SETTINGS.INVASIONS_ACTIVATED)] = true,
    [CI_setting_keys(CI_SETTINGS.SAME_LOCATION_POSSIBLE)] = false,

    -- Starting turn
    [CI_setting_keys(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.MID_GAME)] = {value = true, min = 90, max = 110},
    [CI_setting_keys(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.END_GAME)] = {value = true, min = 140, max = 160},

    -- Character level
    [CI_setting_keys(CI_SETTINGS.CHARACTER_LEVEL, CI_INVASION_STAGES.MID_GAME)] = {value = true, min = 10, max = 20},
    [CI_setting_keys(CI_SETTINGS.CHARACTER_LEVEL, CI_INVASION_STAGES.END_GAME)] = {value = true, min = 20, max = 40},

    -- Army level
    [CI_setting_keys(CI_SETTINGS.ARMY_LEVEL, CI_INVASION_STAGES.MID_GAME)] = {value = true, min = 3, max = 6},
    [CI_setting_keys(CI_SETTINGS.ARMY_LEVEL, CI_INVASION_STAGES.END_GAME)] = {value = true, min = 6, max = 9},
    
    -- Army per invasion
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.MID_GAME, CI_INVASION_TYPES.EMPIRE, CI_ARMY_TYPES.CHAOS)] = {value = true, min = 4, max = 6},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.MID_GAME, CI_INVASION_TYPES.EMPIRE, CI_ARMY_TYPES.NORSCA)] = {value = false, min = 0, max = 0},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.MID_GAME, CI_INVASION_TYPES.EMPIRE, CI_ARMY_TYPES.BEASTMEN)] = {value = false, min = 0, max = 0},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.MID_GAME, CI_INVASION_TYPES.NAGGAROTH, CI_ARMY_TYPES.CHAOS)] = {value = false, min = 0, max = 0},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.MID_GAME, CI_INVASION_TYPES.NAGGAROTH, CI_ARMY_TYPES.NORSCA)] = {value = false, min = 0, max = 0},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.MID_GAME, CI_INVASION_TYPES.NAGGAROTH, CI_ARMY_TYPES.BEASTMEN)] = {value = false, min = 0, max = 0},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.MID_GAME, CI_INVASION_TYPES.ADDITIONAL, CI_ARMY_TYPES.CHAOS)] = {value = false, min = 0, max = 0},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.MID_GAME, CI_INVASION_TYPES.ADDITIONAL, CI_ARMY_TYPES.NORSCA)] = {value = false, min = 0, max = 0},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.MID_GAME, CI_INVASION_TYPES.ADDITIONAL, CI_ARMY_TYPES.BEASTMEN)] = {value = false, min = 0, max = 0},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.EMPIRE, CI_ARMY_TYPES.CHAOS)] = {value = true, min = 8, max = 12},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.EMPIRE, CI_ARMY_TYPES.NORSCA)] = {value = true, min = 2, max = 4},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.EMPIRE, CI_ARMY_TYPES.BEASTMEN)] = {value = true, min = 1, max = 2},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.NAGGAROTH, CI_ARMY_TYPES.CHAOS)] = {value = true, min = 4, max = 6},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.NAGGAROTH, CI_ARMY_TYPES.NORSCA)] = {value = true, min = 0, max = 0},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.NAGGAROTH, CI_ARMY_TYPES.BEASTMEN)] = {value = true, min = 0, max = 0},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.ADDITIONAL, CI_ARMY_TYPES.CHAOS)] = {value = true, min = 4, max = 8},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.ADDITIONAL, CI_ARMY_TYPES.NORSCA)] = {value = true, min = 2, max = 4},
    [CI_setting_keys(CI_SETTINGS.ARMIES_PER_INVASION, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.ADDITIONAL, CI_ARMY_TYPES.BEASTMEN)] = {value = true, min = 0, max = 1},

    -- Agent per invasion
    [CI_setting_keys(CI_SETTINGS.AGENT_PER_INVASION, CI_INVASION_STAGES.MID_GAME, CI_INVASION_TYPES.EMPIRE)] = {value = true, min = 2, max = 4},
    [CI_setting_keys(CI_SETTINGS.AGENT_PER_INVASION, CI_INVASION_STAGES.MID_GAME, CI_INVASION_TYPES.NAGGAROTH)] = {value = false, min = 0, max = 0},
    [CI_setting_keys(CI_SETTINGS.AGENT_PER_INVASION, CI_INVASION_STAGES.MID_GAME, CI_INVASION_TYPES.BEASTMEN)] = {value = false, min = 0, max = 0},
    [CI_setting_keys(CI_SETTINGS.AGENT_PER_INVASION, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.EMPIRE)] = {value = true, min = 4, max = 6},
    [CI_setting_keys(CI_SETTINGS.AGENT_PER_INVASION, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.NAGGAROTH)] = {value = true, min = 1, max = 2},
    [CI_setting_keys(CI_SETTINGS.AGENT_PER_INVASION, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.BEASTMEN)] = {value = true, min = 1, max = 2},

    -- Number of invasion
    [CI_setting_keys(CI_SETTINGS.NUMBER_OF_ADDITIONAL_INVASIONS, CI_INVASION_STAGES.MID_GAME)] = {value = false, min = 0, max = 1},
    [CI_setting_keys(CI_SETTINGS.NUMBER_OF_ADDITIONAL_INVASIONS, CI_INVASION_STAGES.END_GAME)] = {value = true, min = 1, max = 2},

    -- Special character possible 
    [CI_setting_keys(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.EMPIRE, CI_SPECIAL_CHARACTERS.ARCHAON)] = true,
    [CI_setting_keys(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.NAGGAROTH, CI_SPECIAL_CHARACTERS.ARCHAON)] = false,
    [CI_setting_keys(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.ADDITIONAL, CI_SPECIAL_CHARACTERS.ARCHAON)] = false,
    [CI_setting_keys(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.EMPIRE, CI_SPECIAL_CHARACTERS.KHOLEK)] = true,
    [CI_setting_keys(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.NAGGAROTH, CI_SPECIAL_CHARACTERS.KHOLEK)] = false,
    [CI_setting_keys(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.ADDITIONAL, CI_SPECIAL_CHARACTERS.KHOLEK)] = false,
    [CI_setting_keys(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.EMPIRE, CI_SPECIAL_CHARACTERS.SIGVALD)] = true,
    [CI_setting_keys(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.NAGGAROTH, CI_SPECIAL_CHARACTERS.SIGVALD)] = false,
    [CI_setting_keys(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.ADDITIONAL, CI_SPECIAL_CHARACTERS.SIGVALD)] = false,
    [CI_setting_keys(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.EMPIRE, CI_SPECIAL_CHARACTERS.SARTHORAEL)] = true,
    [CI_setting_keys(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.NAGGAROTH, CI_SPECIAL_CHARACTERS.SARTHORAEL)] = false,
    [CI_setting_keys(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.ADDITIONAL, CI_SPECIAL_CHARACTERS.SARTHORAEL)] = false,

    [CI_setting_keys(CI_SETTINGS.WINNING_KILL_ARMIES, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.EMPIRE)] = true,
    [CI_setting_keys(CI_SETTINGS.WINNING_KILL_ARMIES, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.NAGGAROTH)] = true,
    [CI_setting_keys(CI_SETTINGS.WINNING_KILL_ARMIES, CI_INVASION_STAGES.END_GAME, CI_INVASION_TYPES.ADDITIONAL)] = true,
}

local function ouput_values(values)

    if not is_table(values) then
        return tostring(values);
    else
        return "Value: "..tostring(values.value)..", min: "..tostring(values.min)..", max"..tostring(values.max);
    end
end


local function is_from_table(key, table)
    for _, item in pairs(table) do
        if item.key == key then
            return true;
        end
    end

    return false;
end

-- Return {value / min / max}
-- Use CI_load_setting to get the final value of setting instead
function CI_setting_values(setting_key, ...)
    if verbose then
        GAM_LOG("CI_setting_values("..CI_setting_keys(setting_key, ...)..")");
    end
    
    local setting_key = CI_setting_keys(setting_key, ...);
    local values = settings[setting_key];

    if values == nil then
        GAM_LOG("Error: Values not found for: "..setting_key);
        return;
    elseif not is_table(values) then
        return values;
    else
        return values.value, values.min, values.max;
    end
end

-- Return settings value or random between min and max values if randomized
function CI_load_setting(setting, ...)
    if verbose then
        GAM_LOG("CI_load_setting("..CI_setting_keys(setting, ...)..")");
    end
    local value, min, max = CI_setting_values(setting, ...);

    -- Random settings if min or max is not null and settings is at true
    if (min or max) and value then
        return cm:random_number(max, min);
    end

    return value;
end

-- Set values (value, min, max) for setting.
local function save_setting(values, setting, ...)

    if verbose then
        GAM_LOG("save_setting("..ouput_values(values)..","..CI_setting_keys(setting, ...)..")");
    end

    if values.value ~= nil and (values.min == nil or values.max == nil) then
        GAM_LOG("Error : Incorrect values format: "..ouput_values(values).." for setting"..CI_setting_keys(setting, ...));
        return;
    end

    local value, min, max = CI_setting_values(setting, ...);

    if min ~= nil and values.min == nil then
        GAM_LOG("Error : Minimum expected: "..ouput_values(values).." for setting"..CI_setting_keys(setting, ...));
        return;
    end
    if values.min ~= nil and values.max == nil then
        GAM_LOG("Error : Maximum expected: "..ouput_values(values).." for setting"..CI_setting_keys(setting, ...));
        return;
    end

    CI_SETTINGS[CI_setting_keys(setting, ...)] = values;
end

-- For settings of type random / min / max, validate and modify settings :
-- Maximum must be greater than minimum
local function validate_random_setting(setting, ...)
    local value, min, max = CI_setting_values(setting, ...);
    -- Random settings if min or max is not null and settings is true
    if (min or max) and value then
        if max <= min then
            local _, mininum_key, maxinum_key = CI_setting_keys(setting, ...)

            GAM_LOG("Incorrect setting : "..mininum_key.." must be greater than "..maxinum_key);
            local values = {value = false, min = min, max = min}
            save_setting(values, setting, ...);
        end
    end
end

-- Init setting values from mct setting
function CI_init_setting(mct_settings, setting, ...)
    if verbose then
        GAM_LOG("init_and_validate_setting(mct_settings,"..CI_setting_keys(setting, ...)..")");
    end

    if mct_settings then
        local key, minimum_key, maximum_key = CI_setting_keys(setting, ...);

        local mct_value = mct_settings[key];
        local mct_min = mct_settings[minimum_key];
        local mct_max = mct_settings[maximum_key];

        local values = mct_value;

        if mct_min ~= nil then
            values = {values = mct_value, min = mct_min, max = mct_max};
        end

        CI_SETTINGS[key] = values;

        local values = CI_setting_values(setting, ...);
    end
    validate_random_setting(setting, ...);
end

-- Validation rules for starting turn
local function validate_settings_starting_turn()
    local mid_turn_random, mid_turn_min, mid_turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.MID_GAME);
    local end_turn_random, end_turn_min, end_turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.END_GAME);

    -- MID_GAME (Stage 2) must start at turn 2 minimum
    if mid_turn_min < 2 then
        mid_turn_min = 2;
    end
    if mid_turn_max < 2 then
        mid_turn_max = 2;
    end

    -- END_GAME (Stage 3) must start at turn 3 minimum
    if end_turn_min < 3 then
        end_turn_min = 3;
    end
    if end_turn_max < 3 then
        end_turn_max = 3;
    end

    -- End game must start after mid game, so min and max has to be greater
    if end_turn_min <= mid_turn_min then
        end_turn_min = mid_turn_min + 1;
    end
    if end_turn_max <= mid_turn_max then
        end_turn_max = mid_turn_max + 1;
    end

    local mid_values = {value = mid_turn_random, min = mid_turn_min, max = mid_turn_max};
    local end_values = {value = end_turn_random, min = end_turn_min, max = end_turn_max};

    save_setting(mid_values, CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.MID_GAME);
    save_setting(end_values, CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.END_GAME);

    local intro_turn_min = 15;
    local intro_turn_max = 25;

    -- Prepare Intro stage
    if mid_turn_min <= 25 then
        intro_turn_min = 1;
        intro_turn_max = mid_turn_min - 1;       
    end

    local intro_values = {value = true, min = intro_turn_min, max = intro_turn_max};
    save_setting(intro_values, CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.INTRO);
end

-- Validation rules for IS_ACTIVATED
local function validate_settings_activated()
    if CI_load_setting(CI_SETTINGS.INVASIONS_ACTIVATED) then

        local invasion_stages = {CI_INVASION_STAGES.MID_GAME, CI_INVASION_STAGES.END_GAME}

        for  i = 1, #invasion_stages do
            local invasion_stage = invasion_stages[i]
            local at_least_one_activated = false;
            local only_additional_activated = true;

            for _, invasion_type in pairs(CI_INVASION_TYPES) do
             
                if CI_load_setting(CI_SETTINGS.IS_ACTIVATED, invasion_stage, invasion_type) then
                    at_least_one_activated = true;

                    if CI_INVASION_TYPES.ADDITIONAL ~= invasion_type then
                        only_additional_activated = false;
                    end
                end
            end

            only_additional_activated = only_additional_activated and at_least_one_activated;

            if not at_least_one_activated then
                GAM_LOG("Incorrect setting: Invasions activated but no invasion set for stage "..invasion_stage.key.." (Empire invasion activated)");
                save_setting({value = true}, CI_SETTINGS.IS_ACTIVATED, invasion_stage, CI_INVASION_TYPES.EMPIRE);
            end

            if only_additional_activated then
                
                local invasions, invasions_min, invasions_max = CI_setting_values(CI_SETTINGS.NUMBER_OF_INVASIONS, invasion_stage, CI_INVASION_TYPES.ADDITIONAL);

                if invasions_min < 1 then
                    GAM_LOG("Incorrect setting: Only additional invasion activated, minimum additional invasion must be greather than 1");
                    invasions_min = 1;
                end

                if invasions_max < 1 then
                    GAM_LOG("Incorrect setting: Only additional invasion activated, maximum additional invasion must be greather than 1");
                    invasions_max = 1;
                end

                local values = {invasions, invasions_min, invasions_max};
                save_setting(values, CI_SETTINGS.NUMBER_OF_INVASIONS, invasion_stage, CI_INVASION_TYPES.ADDITIONAL);
            end
        end
    end
end

-- Validation rules for special character
local function validate_settings_special_characters()

    -- Character can spawn for invasion_type only if invasion_type is activated
    for _, special_character in pairs(CI_SPECIAL_CHARACTERS) do
        local found = false;

        for _, invasion_type in pairs(CI_INVASION_TYPES) do
            local is_activated = CI_load_setting(CI_SETTINGS.IS_ACTIVATED, CI_INVASION_STAGES.END_GAME, invasion_type);
            local can_spawn = CI_load_setting(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, invasion_type, special_character);

            if can_spawn and not is_activated then
                GAM_LOG("Incorrect setting: "..special_character.key.." can't spawn in "..invasion_type.." cause this invasion is desactivated");
                can_spawn = false;
                save_setting({value = false}, CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, invasion_type, special_character);
            end

            if can_spawn then
                found = true;
            end
        end

        -- Character must be somewhere, find the first possible location
        if not found then
            GAM_LOG("Incorrect setting: Invasion activated but "..special_character.key.." is nowhere");

            for _, invasion_type in pairs(CI_INVASION_TYPES) do
                if CI_load_setting(CI_SETTINGS.IS_ACTIVATED, CI_INVASION_STAGES.END_GAME, invasion_type) then
                    save_setting({value = true}, CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, invasion_type, special_character);
                    GAM_LOG(special_character.key.." will spawn in "..invasion_type.key);
                end
            end
        end
    end
end

-- Init settings table from mct setting
local function init_and_validate_settings(mct_settings)
    for _, setting in pairs(CI_SETTINGS) do
        CI_init_setting(mct_settings, setting);
    end

    validate_settings_starting_turn();
    validate_settings_activated();
    validate_settings_special_characters();

    local _, intro_turn_min, intro_turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.INTRO);
    local _, mid_turn_min, mid_turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.MID_GAME);
    local _, end_turn_min, end_turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.END_GAME);

    GAM_LOG("Intro min turn: "..intro_turn_min..", max turn:"..intro_turn_max);
    GAM_LOG("Mid game min turn: "..mid_turn_min..", max turn:"..mid_turn_max);
    GAM_LOG("End game min turn: "..end_turn_min..", max turn:"..end_turn_max);
end

-- Init and validate settings table.
function CI_init_settings(default_settings)
    GAM_LOG("CI_init_settings");
    local mct = get_mct();
    if mct and not default_settings then -- MCT Settings
        local gam_mod = mct:get_mod_by_key("gam_chaotic_invasion");
        init_and_validate_settings(gam_mod:get_settings());
        GAM_LOG("MCT Settings loaded");
        
        core:add_listener(
            "gam_chaotic_invasion_MctFinalized",
            "MctFinalized",
            true,
            function(context)
                local mct = get_mct();
                local gam_mod = mct:get_mod_by_key("gam_chaotic_invasion");
                init_and_validate_settings(gam_mod:get_settings());
                GAM_LOG("MCT Settings modified");
            end,
            true
        )
    else -- Default settings
        init_and_validate_settings();
    end
end