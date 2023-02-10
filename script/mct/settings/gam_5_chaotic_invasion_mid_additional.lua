local gam_mod = mct:get_mod_by_key("gam_chaotic_invasion")

-- First Phase : Additional invasion
local mid_additional = gam_mod:add_new_section("mid_additional", "First Phase : Additional invasion", false);
mid_additional:set_option_sort_function("index_sort");

-- Number of invasion
local mid_additional_invasion = gam_mod:add_new_option("mid_additional_invasion", "checkbox");
mid_additional_invasion:set_text("Randomize number of additional invasions");
mid_additional_invasion:set_tooltip_text("If not checked, minimum is used.\n");
mid_additional_invasion:set_default_value(false);

local mid_additional_invasion_minimum = gam_mod:add_new_option("mid_additional_invasion_minimum", "slider");
mid_additional_invasion_minimum:set_text("Minimum");
mid_additional_invasion_minimum:slider_set_min_max(0, 4);
mid_additional_invasion_minimum:slider_set_step_size(1);
mid_additional_invasion_minimum:set_default_value(0);

local mid_additional_invasion_maximum = gam_mod:add_new_option("mid_additional_invasion_maximum", "slider");
mid_additional_invasion_maximum:set_text("Maximum");
mid_additional_invasion_maximum:set_tooltip_text("Not used if not additional or less than minimum.");
mid_additional_invasion_maximum:slider_set_min_max(0, 4);
mid_additional_invasion_maximum:slider_set_step_size(1);
mid_additional_invasion_maximum:set_default_value(0);

-- Chaos armies
local mid_additional_chaos = gam_mod:add_new_option("mid_additional_chaos", "checkbox");
mid_additional_chaos:set_text("Randomize number of chaos armies per invasion");
mid_additional_chaos:set_tooltip_text("If not checked, minimum is used.\n");
mid_additional_chaos:set_default_value(false);

local mid_additional_chaos_minimum = gam_mod:add_new_option("mid_additional_chaos_minimum", "slider");
mid_additional_chaos_minimum:set_text("Minimum");
mid_additional_chaos_minimum:slider_set_min_max(0, 50);
mid_additional_chaos_minimum:slider_set_step_size(1);
mid_additional_chaos_minimum:set_default_value(0);

local mid_additional_chaos_maximum = gam_mod:add_new_option("mid_additional_chaos_maximum", "slider");
mid_additional_chaos_maximum:set_text("Maximum");
mid_additional_chaos_maximum:set_tooltip_text("Not used if not additional or less than minimum.");
mid_additional_chaos_maximum:slider_set_min_max(0, 50);
mid_additional_chaos_maximum:slider_set_step_size(1);
mid_additional_chaos_maximum:set_default_value(0);

-- norsca armies
local mid_additional_norsca = gam_mod:add_new_option("mid_additional_norsca", "checkbox");
mid_additional_norsca:set_text("Randomize number of norsca armies per invasion");
mid_additional_norsca:set_tooltip_text("If not checked, minimum is used.\n");
mid_additional_norsca:set_default_value(false);

local mid_additional_norsca_minimum = gam_mod:add_new_option("mid_additional_norsca_minimum", "slider");
mid_additional_norsca_minimum:set_text("Minimum");
mid_additional_norsca_minimum:slider_set_min_max(0, 50);
mid_additional_norsca_minimum:slider_set_step_size(1);
mid_additional_norsca_minimum:set_default_value(0);

local mid_additional_norsca_maximum = gam_mod:add_new_option("mid_additional_norsca_maximum", "slider");
mid_additional_norsca_maximum:set_text("Maximum");
mid_additional_norsca_maximum:set_tooltip_text("Not used if not additional or less than minimum.");
mid_additional_norsca_maximum:slider_set_min_max(0, 50);
mid_additional_norsca_maximum:slider_set_step_size(1);
mid_additional_norsca_maximum:set_default_value(0);

-- beastmen armies
local mid_additional_beastmen = gam_mod:add_new_option("mid_additional_beastmen", "checkbox");
mid_additional_beastmen:set_text("Randomize number of beastmen armies per invasion");
mid_additional_beastmen:set_tooltip_text("If not checked, minimum is used.\n");
mid_additional_beastmen:set_default_value(false);

local mid_additional_beastmen_minimum = gam_mod:add_new_option("mid_additional_beastmen_minimum", "slider");
mid_additional_beastmen_minimum:set_text("Minimum");
mid_additional_beastmen_minimum:slider_set_min_max(0, 50);
mid_additional_beastmen_minimum:slider_set_step_size(1);
mid_additional_beastmen_minimum:set_default_value(0);

local mid_additional_beastmen_maximum = gam_mod:add_new_option("mid_additional_beastmen_maximum", "slider");
mid_additional_beastmen_maximum:set_text("Maximum");
mid_additional_beastmen_maximum:set_tooltip_text("Not used if not additional or less than minimum.");
mid_additional_beastmen_maximum:slider_set_min_max(0, 50);
mid_additional_beastmen_maximum:slider_set_step_size(1);
mid_additional_beastmen_maximum:set_default_value(0);

-- Number of agent
local mid_additional_agent = gam_mod:add_new_option("mid_additional_agent", "checkbox");
mid_additional_agent:set_text("Randomize number of agents per invasion");
mid_additional_agent:set_tooltip_text("Randomize number of agents. If not checked, minimum is used.\nDefault: false.");
mid_additional_agent:set_default_value(false);

local mid_additional_agent_minimum = gam_mod:add_new_option("mid_additional_agent_minimum", "slider");
mid_additional_agent_minimum:set_text("Minimum");
mid_additional_agent_minimum:set_tooltip_text("Default: 0");
mid_additional_agent_minimum:slider_set_min_max(0, 20);
mid_additional_agent_minimum:slider_set_step_size(1);
mid_additional_agent_minimum:set_default_value(0);

local mid_additional_agent_maximum = gam_mod:add_new_option("mid_additional_agent_maximum", "slider");
mid_additional_agent_maximum:set_text("Maximum");
mid_additional_agent_maximum:set_tooltip_text("Not used if not random or less than minimum.");
mid_additional_agent_maximum:slider_set_min_max(0, 20);
mid_additional_agent_maximum:slider_set_step_size(1);
mid_additional_agent_maximum:set_default_value(0);