core:load_mod_script("/script/_lib/mod/!gam_chaotic_invasion.lua");
local gam_mod_name = "gam_chaotic_invasion"
local gam_mod = get_mct():register_mod("gam_chaotic_invasion");
GAM_LOG("Register MCT Mod");

-- Find localised text for setting.
-- Search first for setting key, then recursively search for default
local function localised_string(setting_key, suffix)
    local localised_string = "";
    local next_separator = 1;

    while localised_string == "" and next_separator do
        localised_string = effect.get_localised_string("mct_"..gam_mod_name.."_"..setting_key.."_"..suffix);
        
        next_separator = string.find(setting_key, "_");
            
        if next_separator then
            setting_key = string.sub(setting_key, next_separator + 1);
        end
    end
    
    return localised_string;
end

local function find_localised_text(setting_key)
    return localised_string(setting_key, "text");
end

local function find_localised_tooltip(setting_key)
    return localised_string(setting_key, "tooltip");
end

local function option_text_and_tooltip(option)
    local setting_key = option:get_key();
    local text = find_localised_text(setting_key);
    option:set_text(text);
    local tooltip = find_localised_tooltip(setting_key)
    option:set_tooltip_text(tooltip);
end

local function randomized_option_text_and_tooltip(option, option_min, option_max)
    local setting_key = option:get_key();
    local setting_key_minimum = option_min:get_key();
    local setting_key_maximum = option_max:get_key();
    option:set_text(find_localised_text(setting_key));
    local localised_tooltip = find_localised_tooltip(setting_key);
    if localised_tooltip == "" then
        option:set_tooltip_text("mct_gam_chaotic_invasion_default_random_tooltip", true);
    else
        option:set_tooltip_text(localised_tooltip);
    end
    option_min:set_text(find_localised_text(setting_key_minimum));
    option_min:set_tooltip_text(find_localised_tooltip(setting_key_minimum));
    option_max:set_text(find_localised_text(setting_key_maximum));
    option_max:set_tooltip_text(find_localised_tooltip(setting_key_maximum));
end

local function add_option(setting, ...)
    local setting_key = CI_mct_setting_keys(setting, ...);
    local option = gam_mod:add_new_option(setting_key, "checkbox");
    option:set_default_value(CI_load_setting(setting, ...));

    -- We can't call effect.get_localised_string before game is init, so we need to do when mct ui is created
    -- That's the only event i've found that can be late enough to not crash game, and early enough to have text and tooltip
    -- correctly initialized
    if not core:is_campaign() then
        option_text_and_tooltip(option);
    else
        core:add_ui_created_callback(function() option_text_and_tooltip(option) end);
    end
    
    return option;
end

local function add_randomizable_options(lower_bound, upper_bound, setting, ...)
    local setting_key, setting_key_minimum, setting_key_maximum  = CI_mct_setting_keys(setting, ...);

    -- Mod defaults, from CI_SETTINGS
    local value, min, max = CI_setting_values(setting, ...);

    local option = gam_mod:add_new_option(setting_key, "checkbox");
    option:set_default_value(value);

    local option_min = gam_mod:add_new_option(setting_key_minimum, "slider");
    option_min:slider_set_step_size(1);
    option_min:slider_set_min_max(lower_bound, upper_bound);
    option_min:set_default_value(min);

    local option_max = gam_mod:add_new_option(setting_key_maximum, "slider");
    option_max:slider_set_step_size(1);
    option_max:slider_set_min_max(lower_bound, upper_bound);
    option_max:set_default_value(max);

    if not core:is_campaign() then
        randomized_option_text_and_tooltip(option, option_min, option_max);
    else
        core:add_ui_created_callback(function() randomized_option_text_and_tooltip(option, option_min, option_max); end);
    end

    return option, option_min, option_max;
end

local function add_general_options()
    local section = gam_mod:get_section_by_key ("default")
    section:set_option_sort_function("index_sort");

    add_option(CI_SETTINGS.INVASIONS_ACTIVATED);
    add_option(CI_SETTINGS.KEEP_SAME_LOCATION);
    add_option(CI_SETTINGS.SAME_LOCATION_POSSIBLE);
    add_option(CI_SETTINGS.IS_LOCATION_MANDATORY, CI_LOCATIONS.CHAOS_WASTE);
    add_option(CI_SETTINGS.IS_LOCATION_MANDATORY, CI_LOCATIONS.NAGGAROTH);
    add_option(CI_SETTINGS.CHARACTER_ANYWHERE);
    add_option(CI_SETTINGS.LOCATION_MESSAGES);
    add_option(CI_SETTINGS.WINNING_KILL_ARMIES, CI_ARMY_TYPES.CHAOS);
    add_option(CI_SETTINGS.WINNING_KILL_ARMIES, CI_ARMY_TYPES.NORSCA);
    add_option(CI_SETTINGS.WINNING_KILL_ARMIES, CI_ARMY_TYPES.BEASTMEN);
end

local function add_stage_options(invasion_stage)
    local section = gam_mod:add_new_section(invasion_stage.key);
    section:set_option_sort_function("index_sort");

    add_randomizable_options(2, 300, CI_SETTINGS.STARTING_TURN, invasion_stage);
    add_randomizable_options(1, 10, CI_SETTINGS.INVASIONS_PER_STAGE, invasion_stage);
    add_randomizable_options(1, 50, CI_SETTINGS.ARMIES_PER_INVASION, invasion_stage, CI_ARMY_TYPES.CHAOS);
    add_randomizable_options(0, 50, CI_SETTINGS.ARMIES_PER_INVASION, invasion_stage, CI_ARMY_TYPES.NORSCA);
    add_randomizable_options(0, 50, CI_SETTINGS.ARMIES_PER_INVASION, invasion_stage, CI_ARMY_TYPES.BEASTMEN);
    add_randomizable_options(1, 40, CI_SETTINGS.CHARACTER_LEVEL, invasion_stage);
    add_randomizable_options(0, 9, CI_SETTINGS.ARMY_LEVEL, invasion_stage);
    add_randomizable_options(0, 50, CI_SETTINGS.AGENT_NUMBER, invasion_stage);
end

local function add_location_section()
    local section = gam_mod:add_new_section("location");
    section:set_option_sort_function("index_sort");
    section:set_tooltip_text("mct_gam_chaotic_invasion_location_section_tooltip");
    add_option(CI_SETTINGS.LOCATION_ACTIVATED, CI_LOCATIONS.CHAOS_WASTE);
    add_option(CI_SETTINGS.LOCATION_ACTIVATED, CI_LOCATIONS.NAGGAROTH);
    add_option(CI_SETTINGS.LOCATION_ACTIVATED, CI_LOCATIONS.LUSTRIA);
    add_option(CI_SETTINGS.LOCATION_ACTIVATED, CI_LOCATIONS.UNKNOWM_SEAS);
    add_option(CI_SETTINGS.LOCATION_ACTIVATED, CI_LOCATIONS.GREAT_OCEAN);
    add_option(CI_SETTINGS.LOCATION_ACTIVATED, CI_LOCATIONS.SOUTH_GREAT_OCEAN);
    add_option(CI_SETTINGS.LOCATION_ACTIVATED, CI_LOCATIONS.VORTEX);
    add_option(CI_SETTINGS.LOCATION_ACTIVATED, CI_LOCATIONS.NAGASH_PYRAMID);
    add_option(CI_SETTINGS.LOCATION_ACTIVATED, CI_LOCATIONS.SYLVANIA);
    add_option(CI_SETTINGS.LOCATION_ACTIVATED, CI_LOCATIONS.BADLANDS);
    add_option(CI_SETTINGS.LOCATION_ACTIVATED, CI_LOCATIONS.EMPIRE);
    add_option(CI_SETTINGS.LOCATION_ACTIVATED, CI_LOCATIONS.DWARF_MOUNTAINS);
end

gam_mod:set_section_sort_function("index_sort");

add_general_options();
add_location_section();
add_stage_options(CI_INVASION_STAGES.MID_GAME);
add_stage_options(CI_INVASION_STAGES.END_GAME);