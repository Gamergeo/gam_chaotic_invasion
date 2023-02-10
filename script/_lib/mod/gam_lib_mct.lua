core:load_mod_script("/script/_lib/mod/gam_lib_chaos_invasion.lua")
GAM_MOD = get_mct():get_mod_by_key("gam_chaotic_invasion");
if not GAM_MOD then
    GAM_LOG("Register MCT Mod");
    GAM_MOD = get_mct():register_mod("gam_chaotic_invasion");
    CI_init_settings(true); -- Init default settings
end

local function is_not_empty(string)
    return string and string ~= "";
end

local function init_tooltip(tooltip, game_default)
    if is_not_empty(game_default) then
        game_default = tostring(game_default);

        if is_not_empty(tooltip) then
            tooltip = tooltip.."\nDefault: "..game_default;
        else
            tooltip = "Default: "..game_default;
        end
    end

    -- MCT Crash if not string
    if not tooltip then
        tooltip = "";
    end

    return tooltip;
end

local function init_tooltip_random(tooltip, game_default)

    if is_not_empty(tooltip) then
        return init_tooltip(tooltip.."\nIf not checked, minimum is used.", game_default);
    else
        return init_tooltip("If not checked, minimum is used.", game_default);
    end
end

local function init_tooltip_minimum(tooltip, game_default)
    return init_tooltip(tooltip, game_default);
end

local function init_tooltip_maximum(tooltip, game_default)

    if is_not_empty(tooltip) then
        return init_tooltip(tooltip.."\nNot used if not random or less than minimum.", game_default);
    else
        return init_tooltip("Not used if not random or less than minimum.", game_default);
    end
end

-- option_infos :
--     - title
--     - tooltip
--     - game_default for display only
function GAM_MOD:add_new_ci_option(option_infos, setting, invasion_stage, invasion_type, special_type)
    local setting_key = CI_mct_setting_keys(setting, invasion_stage, invasion_type, special_type);
    GAM_LOG(setting_key);
    local option = self:add_new_option(setting_key, "checkbox");
    
    option:set_default_value(CI_load_setting(setting, invasion_stage, invasion_type, special_type));
    option:set_text(option_infos.title);
    local tooltip = init_tooltip(option_infos.tooltip, option_infos.game_default);
    GAM_LOG("a"..tooltip);
    option.set_tooltip_text(""..tooltip);
    return option;
end

-- option_infos :
--     - title
--     - tooltip 
--     - game_default for display only
--     - game_default_min for display only
--     - game_default_max for display only
--     - lower_bound
--     - upper_bound
function GAM_MOD:add_new_ci_randomizable_options(option_infos, setting, invasion_stage, invasion_type, special_type)
    local setting_key, setting_key_minimum, setting_key_maximum  = CI_mct_setting_keys(setting, invasion_stage, invasion_type, special_type);

    -- Mod defaults, from CI_SETTINGS
    local default_value, default_min, default_max = CI_setting_values(setting, invasion_stage, invasion_type, special_type);

    local option = self:add_new_option(setting_key, "checkbox");
    option:set_default_value(default_value);
    option:set_text("Randomize "..option_infos.title);
    local tooltip = init_tooltip_random(option_infos.tooltip, option_infos.game_default);
    GAM_LOG(tooltip);
    option.set_tooltip_text(tooltip);

    local option_min = self:add_new_option(setting_key_minimum, "slider");
    
    option_min:set_text("Minimum");
    option_min:slider_set_step_size(1);
    option_min:slider_set_min_max(option_infos.lower_bound, option_infos.upper_bound);
    option_min:set_default_value(default_min);
    option_min.set_tooltip_text(init_tooltip_minimum("", option_infos.game_default_min));
    GAM_LOG(init_tooltip_minimum("", option_infos.game_default_min));

    local option_max = self:add_new_option(setting_key_maximum, "slider");

    option_max:set_text("Maximum");
    option_max:slider_set_step_size(1);
    option_min:slider_set_min_max(option_infos.lower_bound, option_infos.upper_bound);
    option_max:set_default_value(default_max);
    option_max.set_tooltip_text(init_tooltip_maximum("", option_infos.game_default_max));
    GAM_LOG(init_tooltip_minimum("", option_infos.game_default_max));

    return option, option_min, option_max;
end