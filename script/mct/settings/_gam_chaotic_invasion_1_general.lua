core:load_mod_script("/script/_lib/mod/gam_lib_mct.lua");

GAM_MOD:set_title("Chaotic invasion", false);
GAM_MOD:set_author("Gamergeo");
GAM_MOD:set_description("Several options to get invasions more random. Chaos invasions are divided into categories:\n - Empire invasion: Classic invasion from the chaos waste\n-Naggaroth invasion: Classic invasion from Naggaroth\n-Additional invasions: New invasions in random location.\n\nEach of these invasions can be activated in main section, and configured in dedicated section, for both phases.\n\nWarning : Please notify that difficulty settings are no longer used. Please select settings instead.\nDefault settings on tooltips are settings from the base game, if possible, not mod's default values. A/B/C/D/E represents the defaults values for difficulty Off/On/Hard/Very Hard/Legendary", false);
GAM_MOD:set_section_sort_function("index_sort");

-- General Section
local section = GAM_MOD:get_section_by_key("default");
section:set_localised_text("General Settings", false);
section:set_option_sort_function("index_sort");

local option_infos = {};
option_infos.title = "Invasion features";
option_infos.tooltip = "If not checked, invasion won't spawn at all.";
GAM_MOD:add_new_ci_option(option_infos, CI_SETTINGS.INVASIONS_ACTIVATED);