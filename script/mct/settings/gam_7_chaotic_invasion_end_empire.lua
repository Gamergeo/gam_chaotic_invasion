local gam_mod = mct:get_mod_by_key("gam_chaotic_invasion")

-- Second Phase : Empire invasion
local end_empire = gam_mod:add_new_section("end_empire", "Second Phase : Empire invasion", false);
end_empire:set_option_sort_function("index_sort");

-- Chaos armies
local end_empire_chaos = gam_mod:add_new_option("end_empire_chaos", "checkbox");
end_empire_chaos:set_text("Randomize number of chaos armies");
end_empire_chaos:set_tooltip_text("Armies of special characters (Archaon..) are not counted. If not checked, minimum is used.\nDefault: false.");
end_empire_chaos:set_default_value(true);

local end_empire_chaos_minimum = gam_mod:add_new_option("end_empire_chaos_minimum", "slider");
end_empire_chaos_minimum:set_text("Minimum");
end_empire_chaos_minimum:set_tooltip_text("Default: 0/8/12/16/24.");
end_empire_chaos_minimum:slider_set_min_max(0, 50);
end_empire_chaos_minimum:slider_set_step_size(1);
end_empire_chaos_minimum:set_default_value(8);

local end_empire_chaos_maximum = gam_mod:add_new_option("end_empire_chaos_maximum", "slider");
end_empire_chaos_maximum:set_text("Maximum");
end_empire_chaos_maximum:set_tooltip_text("Not used if not random or less than minimum.");
end_empire_chaos_maximum:slider_set_min_max(0, 50);
end_empire_chaos_maximum:slider_set_step_size(1);
end_empire_chaos_maximum:set_default_value(12);

-- norsca armies
local end_empire_norsca = gam_mod:add_new_option("end_empire_norsca", "checkbox");
end_empire_norsca:set_text("Randomize number of norsca armies");
end_empire_norsca:set_tooltip_text("If not checked, minimum is used.\nDefault: false.");
end_empire_norsca:set_default_value(true);

local end_empire_norsca_minimum = gam_mod:add_new_option("end_empire_norsca_minimum", "slider");
end_empire_norsca_minimum:set_text("Minimum");
end_empire_norsca_minimum:set_tooltip_text("Default: 4");
end_empire_norsca_minimum:slider_set_min_max(0, 50);
end_empire_norsca_minimum:slider_set_step_size(1);
end_empire_norsca_minimum:set_default_value(4);

local end_empire_norsca_maximum = gam_mod:add_new_option("end_empire_norsca_maximum", "slider");
end_empire_norsca_maximum:set_text("Maximum");
end_empire_norsca_maximum:set_tooltip_text("Not used if not random or less than minimum.");
end_empire_norsca_maximum:slider_set_min_max(0, 50);
end_empire_norsca_maximum:slider_set_step_size(1);
end_empire_norsca_maximum:set_default_value(6);

-- beastmen armies
local end_empire_beastmen = gam_mod:add_new_option("end_empire_beastmen", "checkbox");
end_empire_beastmen:set_text("Randomize number of beastmen armies");
end_empire_beastmen:set_tooltip_text("If not checked, minimum is used.\nDefault: false.");
end_empire_beastmen:set_default_value(true);

local end_empire_beastmen_minimum = gam_mod:add_new_option("end_empire_beastmen_minimum", "slider");
end_empire_beastmen_minimum:set_text("Minimum");
end_empire_beastmen_minimum:set_tooltip_text("Default: 1");
end_empire_beastmen_minimum:slider_set_min_max(0, 50);
end_empire_beastmen_minimum:slider_set_step_size(1);
end_empire_beastmen_minimum:set_default_value(1);

local end_empire_beastmen_maximum = gam_mod:add_new_option("end_empire_beastmen_maximum", "slider");
end_empire_beastmen_maximum:set_text("Maximum");
end_empire_beastmen_maximum:set_tooltip_text("Not used if not random or less than minimum.");
end_empire_beastmen_maximum:slider_set_min_max(0, 50);
end_empire_beastmen_maximum:slider_set_step_size(1);
end_empire_beastmen_maximum:set_default_value(2);

-- Number of agent
local end_empire_agent = gam_mod:add_new_option("end_empire_agent", "checkbox");
end_empire_agent:set_text("Randomize number of agents");
end_empire_agent:set_tooltip_text("Randomize number of agents. If not checked, minimum is used.\nDefault: false.");
end_empire_agent:set_default_value(true);

local end_empire_agent_minimum = gam_mod:add_new_option("end_empire_agent_minimum", "slider");
end_empire_agent_minimum:set_text("Minimum");
end_empire_agent_minimum:set_tooltip_text("Default: 8");
end_empire_agent_minimum:slider_set_min_max(0, 20);
end_empire_agent_minimum:slider_set_step_size(1);
end_empire_agent_minimum:set_default_value(8);

local end_empire_agent_maximum = gam_mod:add_new_option("end_empire_agent_maximum", "slider");
end_empire_agent_maximum:set_text("Maximum");
end_empire_agent_maximum:set_tooltip_text("Not used if not random or less than minimum.");
end_empire_agent_maximum:slider_set_min_max(0, 20);
end_empire_agent_maximum:slider_set_step_size(1);
end_empire_agent_maximum:set_default_value(12);

-- Special characters
local end_empire_archaon = gam_mod:add_new_option("end_empire_archaon", "checkbox");
end_empire_archaon:set_text("Archaon possible location");
end_empire_archaon:set_tooltip_text("Archaon and his army can spawn here.\nDefault: true");
end_empire_archaon:set_default_value(true);

local end_empire_kholek = gam_mod:add_new_option("end_empire_kholek", "checkbox");
end_empire_kholek:set_text("Kholek possible location");
end_empire_kholek:set_tooltip_text("Kholek and his army can spawn here.\nDefault: true");
end_empire_kholek:set_default_value(true);

local end_empire_sigvald = gam_mod:add_new_option("end_empire_sigvald", "checkbox");
end_empire_sigvald:set_text("Sigvald possible location");
end_empire_sigvald:set_tooltip_text("Kholek and his army can spawn here.\nDefault: true");
end_empire_sigvald:set_default_value(true);

local end_empire_sarthorael = gam_mod:add_new_option("end_empire_sarthorael", "checkbox");
end_empire_sarthorael:set_text("Sarthorael possible location");
end_empire_sarthorael:set_tooltip_text("Kholek and his army can spawn here.\nDefault: true");
end_empire_sarthorael:set_default_value(true);

local end_empire_winning = gam_mod:add_new_option("end_empire_winning", "checkbox");
end_empire_winning:set_text("Destroyed on win");
end_empire_winning:set_tooltip_text("If Archaon, Kholek and Sigvald are killed, all armies of this invasion will be destroyed.\nDefault: true");
end_empire_winning:set_default_value(true);