local gam_mod = mct:get_mod_by_key("gam_chaotic_invasion")

-- First Phase : naggaroth invasion
local mid_naggaroth = gam_mod:add_new_section("mid_naggaroth", "First Phase : Naggaroth invasion", false);
mid_naggaroth:set_option_sort_function("index_sort");

-- Chaos armies
local mid_naggaroth_chaos = gam_mod:add_new_option("mid_naggaroth_chaos", "checkbox");
mid_naggaroth_chaos:set_text("Randomize number of chaos armies");
mid_naggaroth_chaos:set_tooltip_text("If not checked, minimum is used.\nDefault: false.");
mid_naggaroth_chaos:set_default_value(false);

local mid_naggaroth_chaos_minimum = gam_mod:add_new_option("mid_naggaroth_chaos_minimum", "slider");
mid_naggaroth_chaos_minimum:set_text("Minimum");
mid_naggaroth_chaos_minimum:set_tooltip_text("Default: 0");
mid_naggaroth_chaos_minimum:slider_set_min_max(0, 50);
mid_naggaroth_chaos_minimum:slider_set_step_size(1);
mid_naggaroth_chaos_minimum:set_default_value(0);

local mid_naggaroth_chaos_maximum = gam_mod:add_new_option("mid_naggaroth_chaos_maximum", "slider");
mid_naggaroth_chaos_maximum:set_text("Maximum");
mid_naggaroth_chaos_maximum:set_tooltip_text("Not used if not random or less than minimum.");
mid_naggaroth_chaos_maximum:slider_set_min_max(0, 50);
mid_naggaroth_chaos_maximum:slider_set_step_size(1);
mid_naggaroth_chaos_maximum:set_default_value(0);

-- norsca armies
local mid_naggaroth_norsca = gam_mod:add_new_option("mid_naggaroth_norsca", "checkbox");
mid_naggaroth_norsca:set_text("Randomize number of norsca armies");
mid_naggaroth_norsca:set_tooltip_text("If not checked, minimum is used.\nDefault: false.");
mid_naggaroth_norsca:set_default_value(false);

local mid_naggaroth_norsca_minimum = gam_mod:add_new_option("mid_naggaroth_norsca_minimum", "slider");
mid_naggaroth_norsca_minimum:set_text("Minimum");
mid_naggaroth_norsca_minimum:set_tooltip_text("Default: 0");
mid_naggaroth_norsca_minimum:slider_set_min_max(0, 50);
mid_naggaroth_norsca_minimum:slider_set_step_size(1);
mid_naggaroth_norsca_minimum:set_default_value(0);

local mid_naggaroth_norsca_maximum = gam_mod:add_new_option("mid_naggaroth_norsca_maximum", "slider");
mid_naggaroth_norsca_maximum:set_text("Maximum");
mid_naggaroth_norsca_maximum:set_tooltip_text("Not used if not random or less than minimum.");
mid_naggaroth_norsca_maximum:slider_set_min_max(0, 50);
mid_naggaroth_norsca_maximum:slider_set_step_size(1);
mid_naggaroth_norsca_maximum:set_default_value(0);

-- beastmen armies
local mid_naggaroth_beastmen = gam_mod:add_new_option("mid_naggaroth_beastmen", "checkbox");
mid_naggaroth_beastmen:set_text("Randomize number of beastmen armies");
mid_naggaroth_beastmen:set_tooltip_text("If not checked, minimum is used.\nDefault: false.");
mid_naggaroth_beastmen:set_default_value(false);

local mid_naggaroth_beastmen_minimum = gam_mod:add_new_option("mid_naggaroth_beastmen_minimum", "slider");
mid_naggaroth_beastmen_minimum:set_text("Minimum");
mid_naggaroth_beastmen_minimum:set_tooltip_text("Default: 0");
mid_naggaroth_beastmen_minimum:slider_set_min_max(0, 50);
mid_naggaroth_beastmen_minimum:slider_set_step_size(1);
mid_naggaroth_beastmen_minimum:set_default_value(0);

local mid_naggaroth_beastmen_maximum = gam_mod:add_new_option("mid_naggaroth_beastmen_maximum", "slider");
mid_naggaroth_beastmen_maximum:set_text("Maximum");
mid_naggaroth_beastmen_maximum:set_tooltip_text("Not used if not random or less than minimum.");
mid_naggaroth_beastmen_maximum:slider_set_min_max(0, 50);
mid_naggaroth_beastmen_maximum:slider_set_step_size(1);
mid_naggaroth_beastmen_maximum:set_default_value(0);

-- Number of agent
local mid_naggaroth_agent = gam_mod:add_new_option("mid_naggaroth_agent", "checkbox");
mid_naggaroth_agent:set_text("Randomize number of agents");
mid_naggaroth_agent:set_tooltip_text("Randomize number of agents. If not checked, minimum is used.\nDefault: false.");
mid_naggaroth_agent:set_default_value(false);

local mid_naggaroth_agent_minimum = gam_mod:add_new_option("mid_naggaroth_agent_minimum", "slider");
mid_naggaroth_agent_minimum:set_text("Minimum");
mid_naggaroth_agent_minimum:set_tooltip_text("Default: 0");
mid_naggaroth_agent_minimum:slider_set_min_max(0, 20);
mid_naggaroth_agent_minimum:slider_set_step_size(1);
mid_naggaroth_agent_minimum:set_default_value(0);

local mid_naggaroth_agent_maximum = gam_mod:add_new_option("mid_naggaroth_agent_maximum", "slider");
mid_naggaroth_agent_maximum:set_text("Maximum");
mid_naggaroth_agent_maximum:set_tooltip_text("Not used if not random or less than minimum.");
mid_naggaroth_agent_maximum:slider_set_min_max(0, 20);
mid_naggaroth_agent_maximum:slider_set_step_size(1);
mid_naggaroth_agent_maximum:set_default_value(0);