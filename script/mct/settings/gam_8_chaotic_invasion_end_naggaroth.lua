local gam_mod = mct:get_mod_by_key("gam_chaotic_invasion")

-- Second Phase : naggaroth invasion
local end_naggaroth = gam_mod:add_new_section("end_naggaroth", "Second Phase : Naggaroth invasion", false);
end_naggaroth:set_option_sort_function("index_sort");

-- Chaos armies
local end_naggaroth_chaos = gam_mod:add_new_option("end_naggaroth_chaos", "checkbox");
end_naggaroth_chaos:set_text("Randomize number of chaos armies");
end_naggaroth_chaos:set_tooltip_text("If not checked, minimum is used.\nDefault: false.");
end_naggaroth_chaos:set_default_value(true);

local end_naggaroth_chaos_minimum = gam_mod:add_new_option("end_naggaroth_chaos_minimum", "slider");
end_naggaroth_chaos_minimum:set_text("Minimum");
end_naggaroth_chaos_minimum:set_tooltip_text("Default: 0/4/6/8/12");
end_naggaroth_chaos_minimum:slider_set_min_max(0, 50);
end_naggaroth_chaos_minimum:slider_set_step_size(1);
end_naggaroth_chaos_minimum:set_default_value(4);

local end_naggaroth_chaos_maximum = gam_mod:add_new_option("end_naggaroth_chaos_maximum", "slider");
end_naggaroth_chaos_maximum:set_text("Maximum");
end_naggaroth_chaos_maximum:set_tooltip_text("Not used if not random or less than minimum.");
end_naggaroth_chaos_maximum:slider_set_min_max(0, 50);
end_naggaroth_chaos_maximum:slider_set_step_size(1);
end_naggaroth_chaos_maximum:set_default_value(6);

-- norsca armies
local end_naggaroth_norsca = gam_mod:add_new_option("end_naggaroth_norsca", "checkbox");
end_naggaroth_norsca:set_text("Randomize number of norsca armies");
end_naggaroth_norsca:set_tooltip_text("If not checked, minimum is used.\nDefault: false.");
end_naggaroth_norsca:set_default_value(false);

local end_naggaroth_norsca_minimum = gam_mod:add_new_option("end_naggaroth_norsca_minimum", "slider");
end_naggaroth_norsca_minimum:set_text("Minimum");
end_naggaroth_norsca_minimum:set_tooltip_text("Default: 0");
end_naggaroth_norsca_minimum:slider_set_min_max(0, 50);
end_naggaroth_norsca_minimum:slider_set_step_size(1);
end_naggaroth_norsca_minimum:set_default_value(0);

local end_naggaroth_norsca_maximum = gam_mod:add_new_option("end_naggaroth_norsca_maximum", "slider");
end_naggaroth_norsca_maximum:set_text("Maximum");
end_naggaroth_norsca_maximum:set_tooltip_text("Not used if not random or less than minimum.");
end_naggaroth_norsca_maximum:slider_set_min_max(0, 50);
end_naggaroth_norsca_maximum:slider_set_step_size(1);
end_naggaroth_norsca_maximum:set_default_value(0);

-- beastmen armies
local end_naggaroth_beastmen = gam_mod:add_new_option("end_naggaroth_beastmen", "checkbox");
end_naggaroth_beastmen:set_text("Randomize number of beastmen armies");
end_naggaroth_beastmen:set_tooltip_text("If not checked, minimum is used.\nDefault: false.");
end_naggaroth_beastmen:set_default_value(false);

local end_naggaroth_beastmen_minimum = gam_mod:add_new_option("end_naggaroth_beastmen_minimum", "slider");
end_naggaroth_beastmen_minimum:set_text("Minimum");
end_naggaroth_beastmen_minimum:set_tooltip_text("Default: 0");
end_naggaroth_beastmen_minimum:slider_set_min_max(0, 50);
end_naggaroth_beastmen_minimum:slider_set_step_size(1);
end_naggaroth_beastmen_minimum:set_default_value(0);

local end_naggaroth_beastmen_maximum = gam_mod:add_new_option("end_naggaroth_beastmen_maximum", "slider");
end_naggaroth_beastmen_maximum:set_text("Maximum");
end_naggaroth_beastmen_maximum:set_tooltip_text("Not used if not random or less than minimum.");
end_naggaroth_beastmen_maximum:slider_set_min_max(0, 50);
end_naggaroth_beastmen_maximum:slider_set_step_size(1);
end_naggaroth_beastmen_maximum:set_default_value(0);

-- Number of agent
local end_naggaroth_agent = gam_mod:add_new_option("end_naggaroth_agent", "checkbox");
end_naggaroth_agent:set_text("Randomize number of agents");
end_naggaroth_agent:set_tooltip_text("Randomize number of agents. If not checked, minimum is used.\nDefault: false.");
end_naggaroth_agent:set_default_value(true);

local end_naggaroth_agent_minimum = gam_mod:add_new_option("end_naggaroth_agent_minimum", "slider");
end_naggaroth_agent_minimum:set_text("Minimum");
end_naggaroth_agent_minimum:set_tooltip_text("Default: 0");
end_naggaroth_agent_minimum:slider_set_min_max(0, 20);
end_naggaroth_agent_minimum:slider_set_step_size(1);
end_naggaroth_agent_minimum:set_default_value(2);

local end_naggaroth_agent_maximum = gam_mod:add_new_option("end_naggaroth_agent_maximum", "slider");
end_naggaroth_agent_maximum:set_text("Maximum");
end_naggaroth_agent_maximum:set_tooltip_text("Not used if not random or less than minimum.");
end_naggaroth_agent_maximum:slider_set_min_max(0, 20);
end_naggaroth_agent_maximum:slider_set_step_size(1);
end_naggaroth_agent_maximum:set_default_value(4);

-- Special characters
local end_naggaroth_archaon = gam_mod:add_new_option("end_naggaroth_archaon", "checkbox");
end_naggaroth_archaon:set_text("Archaon possible location");
end_naggaroth_archaon:set_tooltip_text("Archaon and his army can spawn here.\nDefault: false");
end_naggaroth_archaon:set_default_value(false);

local end_naggaroth_kholek = gam_mod:add_new_option("end_naggaroth_kholek", "checkbox");
end_naggaroth_kholek:set_text("Kholek possible location");
end_naggaroth_kholek:set_tooltip_text("Kholek and his army can spawn here.\nDefault: false");
end_naggaroth_kholek:set_default_value(false);

local end_naggaroth_sigvald = gam_mod:add_new_option("end_naggaroth_sigvald", "checkbox");
end_naggaroth_sigvald:set_text("Sigvald possible location");
end_naggaroth_sigvald:set_tooltip_text("Kholek and his army can spawn here.\nDefault: false");
end_naggaroth_sigvald:set_default_value(false);

local end_naggaroth_sarthorael = gam_mod:add_new_option("end_naggaroth_sarthorael", "checkbox");
end_naggaroth_sarthorael:set_text("Sarthorael possible location");
end_naggaroth_sarthorael:set_tooltip_text("Kholek and his army can spawn here.\nDefault: false");
end_naggaroth_sarthorael:set_default_value(false);

local end_naggaroth_winning = gam_mod:add_new_option("end_naggaroth_winning", "checkbox");
end_naggaroth_winning:set_text("Destroyed on win");
end_naggaroth_winning:set_tooltip_text("If Archaon, Kholek and Sigvald are killed, all armies of this invasion will be destroyed.\nDefault: true");
end_naggaroth_winning:set_default_value(true);