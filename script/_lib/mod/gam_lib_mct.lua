core:load_mod_script("/script/_lib/mod/gam_lib_chaos_invasion.lua")
GAM_MOD = get_mct():register_mod("gam_chaotic_invasion");

CI_init_settings(true); -- Init default settings

function GAM_MOD:add_new_ci_option(setting, invasion_stage, invasion_type)
    local setting_key = CI_mct_setting_keys(setting, invasion_stage, invasion_type);
    local option = self:add_new_option(setting_key, "checkbox");
    
    option:set_default_value(CI_load_setting(setting, invasion_stage, invasion_type));
    return option;
end

function GAM_MOD:add_new_ci_randomizable_options(lower_bound, upper_bound, setting, invasion_stage, invasion_type)
    local setting_key, setting_key_minimum, setting_key_maximum  = CI_mct_setting_keys(setting, invasion_stage, invasion_type);

    local value, min, max = CI_setting_values(setting, invasion_stage, invasion_type);

    local option = self:add_new_option(setting_key, "checkbox");
    option:set_default_value(value);

    local option_min = self:add_new_option(setting_key_minimum, "slider");
    
    option_min:set_text("Minimum");
    option_min:slider_set_step_size(1);
    option_min:slider_set_min_max(lower_bound, upper_bound);
    option_min:set_default_value(min);

    local option_max = self:add_new_option(setting_key_maximum, "slider");

    option_max:set_text("Maximum");
    option_max:slider_set_step_size(1);
    option_max:slider_set_min_max(lower_bound, upper_bound);
    option_max:set_default_value(max);

    return option, option_min, option_max;
end