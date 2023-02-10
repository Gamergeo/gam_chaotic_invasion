core:load_mod_script("/script/_lib/mod/gam_lib_mct.lua")
local invasion_stage = CI_INVASION_STAGES.MID_GAME;
local invasion_type = CI_INVASION_TYPES.EMPIRE;

-- First Phase : Empire invasion
local section = GAM_MOD:add_new_section("mid_empire", "First Phase : Empire invasion", false);
section:set_option_sort_function("index_sort");

-- Chaos armies
for _, army_type in pairs(CI_ARMY_TYPES) do
    local option_infos = {};
    option_infos.title = "number of "..army_type.key.." armies";
    option_infos.lower_bound = 0; 
    option_infos.upper_bound = 50;
    option_infos.game_default = false;
    option_infos.game_default_min = 0;

    if CI_ARMY_TYPES.CHAOS == army_type then
        option_infos.game_default_min = "0/4/6/8/12";
    end

    GAM_MOD:add_new_ci_randomizable_options(option_infos, CI_SETTINGS.ARMIES_PER_INVASION, invasion_stage, invasion_type, army_type);
end

local option_infos = {};
option_infos.title = "number of agents";
option_infos.lower_bound = 0; 
option_infos.upper_bound = 30;
option_infos.game_default = false;
option_infos.game_default_min = 4;
GAM_MOD:add_new_ci_randomizable_options(option_infos, CI_SETTINGS.AGENT_PER_INVASION, invasion_stage, invasion_type);