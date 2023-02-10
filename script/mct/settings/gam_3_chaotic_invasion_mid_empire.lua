local gam_mod = mct:get_mod_by_key("gam_chaotic_invasion")

-- First Phase : Empire invasion
local mid_empire = gam_mod:add_new_section("mid_empire", "First Phase : Empire invasion", false);
mid_empire:set_option_sort_function("index_sort");

-- Chaos armies
local mid_empire_chaos = gam_mod:add_new_option("mid_empire_chaos", "checkbox");
mid_empire_chaos:set_text("Randomize number of chaos armies");
mid_empire_chaos:set_tooltip_text("If not checked, minimum is used.\nDefault: false.");
mid_empire_chaos:set_default_value(true);

local mid_empire_chaos_minimum = gam_mod:add_new_option("mid_empire_chaos_minimum", "slider");
mid_empire_chaos_minimum:set_text("Minimum");
mid_empire_chaos_minimum:set_tooltip_text("Default: 0/4/6/8/12.");
mid_empire_chaos_minimum:slider_set_min_max(0, 50);
mid_empire_chaos_minimum:slider_set_step_size(1);
mid_empire_chaos_minimum:set_default_value(4);

local mid_empire_chaos_maximum = gam_mod:add_new_option("mid_empire_chaos_maximum", "slider");
mid_empire_chaos_maximum:set_text("Maximum");
mid_empire_chaos_maximum:set_tooltip_text("Not used if not random or less than minimum.");
mid_empire_chaos_maximum:slider_set_min_max(0, 50);
mid_empire_chaos_maximum:slider_set_step_size(1);
mid_empire_chaos_maximum:set_default_value(6);

-- norsca armies
local mid_empire_norsca = gam_mod:add_new_option("mid_empire_norsca", "checkbox");
mid_empire_norsca:set_text("Randomize number of norsca armies");
mid_empire_norsca:set_tooltip_text("If not checked, minimum is used.\nDefault: false.");
mid_empire_norsca:set_default_value(false);

local mid_empire_norsca_minimum = gam_mod:add_new_option("mid_empire_norsca_minimum", "slider");
mid_empire_norsca_minimum:set_text("Minimum");
mid_empire_norsca_minimum:set_tooltip_text("Default: 0");
mid_empire_norsca_minimum:slider_set_min_max(0, 50);
mid_empire_norsca_minimum:slider_set_step_size(1);
mid_empire_norsca_minimum:set_default_value(0);

local mid_empire_norsca_maximum = gam_mod:add_new_option("mid_empire_norsca_maximum", "slider");
mid_empire_norsca_maximum:set_text("Maximum");
mid_empire_norsca_maximum:set_tooltip_text("Not used if not random or less than minimum.");
mid_empire_norsca_maximum:slider_set_min_max(0, 50);
mid_empire_norsca_maximum:slider_set_step_size(1);
mid_empire_norsca_maximum:set_default_value(0);

-- beastmen armies
local mid_empire_beastmen = gam_mod:add_new_option("mid_empire_beastmen", "checkbox");
mid_empire_beastmen:set_text("Randomize number of beastmen armies");
mid_empire_beastmen:set_tooltip_text("If not checked, minimum is used.\nDefault: false.");
mid_empire_beastmen:set_default_value(false);

local mid_empire_beastmen_minimum = gam_mod:add_new_option("mid_empire_beastmen_minimum", "slider");
mid_empire_beastmen_minimum:set_text("Minimum");
mid_empire_beastmen_minimum:set_tooltip_text("Default: 0");
mid_empire_beastmen_minimum:slider_set_min_max(0, 50);
mid_empire_beastmen_minimum:slider_set_step_size(1);
mid_empire_beastmen_minimum:set_default_value(0);

local mid_empire_beastmen_maximum = gam_mod:add_new_option("mid_empire_beastmen_maximum", "slider");
mid_empire_beastmen_maximum:set_text("Maximum");
mid_empire_beastmen_maximum:set_tooltip_text("Not used if not random or less than minimum.");
mid_empire_beastmen_maximum:slider_set_min_max(0, 50);
mid_empire_beastmen_maximum:slider_set_step_size(1);
mid_empire_beastmen_maximum:set_default_value(0);

-- Number of agent
local mid_empire_agent = gam_mod:add_new_option("mid_empire_agent", "checkbox");
mid_empire_agent:set_text("Randomize number of agents");
mid_empire_agent:set_tooltip_text("Randomize number of agents. If not checked, minimum is used.\nDefault: false.");
mid_empire_agent:set_default_value(true);

local mid_empire_agent_minimum = gam_mod:add_new_option("mid_empire_agent_minimum", "slider");
mid_empire_agent_minimum:set_text("Minimum");
mid_empire_agent_minimum:set_tooltip_text("Default: 4");
mid_empire_agent_minimum:slider_set_min_max(0, 20);
mid_empire_agent_minimum:slider_set_step_size(1);
mid_empire_agent_minimum:set_default_value(4);

local mid_empire_agent_maximum = gam_mod:add_new_option("mid_empire_agent_maximum", "slider");
mid_empire_agent_maximum:set_text("Maximum");
mid_empire_agent_maximum:set_tooltip_text("Not used if not random or less than minimum.");
mid_empire_agent_maximum:slider_set_min_max(0, 20);
mid_empire_agent_maximum:slider_set_step_size(1);
mid_empire_agent_maximum:set_default_value(6);