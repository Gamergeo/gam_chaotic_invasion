core:load_mod_script("/script/_lib/mod/gam_lib_mct.lua");
local invasion_stage = CI_INVASION_STAGES.MID_GAME;

-- First Phase : General Settings
local section = GAM_MOD:add_new_section("mid", "First Phase : General Settings", false);
section:set_option_sort_function("index_sort");

-- Is INVASION_TYPE Activated
local option_infos = {};
option_infos.title = "Empire invasion";
option_infos.tooltip = "If not checked, invasion won't spawn from the chaos waste.\nSee dedicated section for more configuration.";
option_infos.game_default = true;
GAM_MOD:add_new_ci_option(option_infos, CI_SETTINGS.IS_ACTIVATED, invasion_stage, CI_INVASION_TYPES.EMPIRE);

local option_infos = {};
option_infos.title = "Naggaroth invasion";
option_infos.tooltip = "If not checked, invasion won't spawn from naggaroth.\nSee dedicated section for more configuration.";
option_infos.game_default = false;
GAM_MOD:add_new_ci_option(option_infos, CI_SETTINGS.IS_ACTIVATED, invasion_stage, CI_INVASION_TYPES.NAGGAROTH);

local option_infos = {};
option_infos.title = "Additional invasion";
option_infos.tooltip = "Random location invasions.\nSee dedicated section for more configuration.";
option_infos.game_default = false;
GAM_MOD:add_new_ci_option(option_infos, CI_SETTINGS.IS_ACTIVATED, invasion_stage, CI_INVASION_TYPES.ADDITIONAL);

-- Random turn
local option_infos = {};
option_infos.title = "start turn";
option_infos.tooltip = "Randomize the turn for the first phase of invasion to be triggered.";
option_infos.game_default = true;
option_infos.game_default_min = 90; 
option_infos.game_default_max = 110;
option_infos.lower_bound = 2; 
option_infos.upper_bound = 300;
GAM_MOD:add_new_ci_randomizable_options(option_infos, CI_SETTINGS.STARTING_TURN, invasion_stage);

-- Character level
local option_infos = {};
option_infos.title = "character level";
option_infos.tooltip = "Randomize hero / lord level.";
option_infos.game_default = false;
option_infos.game_default_min = 10;
option_infos.lower_bound = 1; 
option_infos.upper_bound = 40;
GAM_MOD:add_new_ci_randomizable_options(option_infos, CI_SETTINGS.CHARACTER_LEVEL, invasion_stage);

-- Army level
local option_infos = {};
option_infos.title = "army level";
option_infos.tooltip = "Randomize level of units in armies.";
option_infos.game_default = false;
option_infos.game_default_min = "0/0/3/6/9";
option_infos.lower_bound = 1; 
option_infos.upper_bound = 9;
GAM_MOD:add_new_ci_randomizable_options(option_infos, CI_SETTINGS.ARMY_LEVEL, invasion_stage);
