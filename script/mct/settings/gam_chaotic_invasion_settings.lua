core:load_mod_script("/script/_lib/mod/gam_lib_chaos_invasion.lua")
CI_init_settings(true); -- Init default settings

local gam_mod_name = "gam_chaotic_invasion";

GAM_LOG("Register MCT Mod");
local gam_mod = get_mct():register_mod(gam_mod_name);

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

local function add_option(setting, invasion_stage, invasion_type, special_type)
    local setting_key = CI_mct_setting_keys(setting, invasion_stage, invasion_type, special_type);
    local option = gam_mod:add_new_option(setting_key, "checkbox");
    
    option:set_default_value(CI_load_setting(setting, invasion_stage, invasion_type, special_type));
    local text = find_localised_text(setting_key);

    option:set_text(text);
    local tooltip = find_localised_tooltip(setting_key)
    option:set_tooltip_text(tooltip);
    return option;
end

local function add_randomizable_options(lower_bound, upper_bound, setting, invasion_stage, invasion_type, special_type)
    local setting_key, setting_key_minimum, setting_key_maximum  = CI_mct_setting_keys(setting, invasion_stage, invasion_type, special_type);

    -- Mod defaults, from CI_SETTINGS
    local value, min, max = CI_setting_values(setting, invasion_stage, invasion_type, special_type);

    local option = gam_mod:add_new_option(setting_key, "checkbox");
    option:set_text(find_localised_text(setting_key));
    local localised_tooltip = find_localised_tooltip(setting_key);
    if localised_tooltip == "" then
        option:set_tooltip_text("mct_gam_chaotic_invasion_default_random_tooltip", true);
    else
        option:set_tooltip_text(localised_tooltip);
    end

    option:set_default_value(value);

    local option_min = gam_mod:add_new_option(setting_key_minimum, "slider");
    option_min:set_text(find_localised_text(setting_key_minimum));
    option_min:set_tooltip_text(find_localised_tooltip(setting_key_minimum));
    option_min:slider_set_step_size(1);
    option_min:slider_set_min_max(lower_bound, upper_bound);
    option_min:set_default_value(min);

    local option_max = gam_mod:add_new_option(setting_key_maximum, "slider");
    option_max:set_text(find_localised_text(setting_key_maximum));
    option_max:set_tooltip_text(find_localised_tooltip(setting_key_maximum));
    option_max:slider_set_step_size(1);
    option_max:slider_set_min_max(lower_bound, upper_bound);
    option_max:set_default_value(max);

    return option, option_min, option_max;
end

local function add_general_options(invasion_stage)

    add_option(CI_SETTINGS.IS_ACTIVATED, invasion_stage, CI_INVASION_TYPES.EMPIRE);
    add_option(CI_SETTINGS.IS_ACTIVATED, invasion_stage, CI_INVASION_TYPES.NAGGAROTH);
    add_option(CI_SETTINGS.IS_ACTIVATED, invasion_stage, CI_INVASION_TYPES.ADDITIONAL);
    add_randomizable_options(2, 300, CI_SETTINGS.STARTING_TURN, invasion_stage);
    add_randomizable_options(1, 40, CI_SETTINGS.CHARACTER_LEVEL, invasion_stage);
    add_randomizable_options(0, 9, CI_SETTINGS.ARMY_LEVEL, invasion_stage);
end

local function add_invasion_options(invasion_stage, invasion_type)

    if CI_INVASION_TYPES.ADDITIONAL == invasion_type then
        add_randomizable_options(0, 5, CI_SETTINGS.NUMBER_OF_INVASIONS, invasion_stage, invasion_type);
    end

    add_randomizable_options(0, 50, CI_SETTINGS.ARMIES_PER_INVASION, invasion_stage, invasion_type, CI_ARMY_TYPES.CHAOS);
    add_randomizable_options(0, 50, CI_SETTINGS.ARMIES_PER_INVASION, invasion_stage, invasion_type, CI_ARMY_TYPES.NORSCA);
    add_randomizable_options(0, 50, CI_SETTINGS.ARMIES_PER_INVASION, invasion_stage, invasion_type, CI_ARMY_TYPES.BEASTMEN);
    add_randomizable_options(0, 50, CI_SETTINGS.AGENT_PER_INVASION, invasion_stage, invasion_type);

    if CI_INVASION_STAGES.END_GAME == invasion_stage then
        add_option(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, invasion_stage, invasion_type, CI_SPECIAL_CHARACTERS.ARCHAON);
        add_option(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, invasion_stage, invasion_type, CI_SPECIAL_CHARACTERS.KHOLEK);
        add_option(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, invasion_stage, invasion_type, CI_SPECIAL_CHARACTERS.SIGVALD);
        add_option(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, invasion_stage, invasion_type, CI_SPECIAL_CHARACTERS.SARTHORAEL);
    end

end

local function add_section(invasion_stage, invasion_type)
    local section_name = "";

    if not invasion_type then
        section_name = invasion_stage.key;
    else
        section_name = invasion_stage.key.."_"..invasion_type.key;
    end

    local section = gam_mod:add_new_section(section_name);
    section:set_option_sort_function("index_sort");

    if not invasion_type then
        add_general_options(invasion_stage);
    else
        add_invasion_options(invasion_stage, invasion_type);
    end
end

local function add_invasion_sections(invasion_stage)
    add_section(invasion_stage, CI_INVASION_TYPES.EMPIRE);
    add_section(invasion_stage, CI_INVASION_TYPES.NAGGAROTH);
    add_section(invasion_stage, CI_INVASION_TYPES.ADDITIONAL);
end

gam_mod:set_section_sort_function("index_sort");
add_option(CI_SETTINGS.INVASIONS_ACTIVATED);
-- Stage General settings
add_section(CI_INVASION_STAGES.MID_GAME);
add_section(CI_INVASION_STAGES.END_GAME);
add_invasion_sections(CI_INVASION_STAGES.MID_GAME);
add_invasion_sections(CI_INVASION_STAGES.END_GAME);