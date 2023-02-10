local gam_mod = mct:get_mod_by_key("gam_chaotic_invasion")

-- Second Phase : Additional invasion
local end_additional = gam_mod:add_new_section("end_additional", "Second Phase : Additional invasion", false);
end_additional:set_option_sort_function("index_sort");

-- Number of invasion
local end_additional_invasion = gam_mod:add_new_option("end_additional_invasion", "checkbox");
end_additional_invasion:set_text("Randomize number of additional invasions");
end_additional_invasion:set_tooltip_text("If not checked, minimum is used.\n");
end_additional_invasion:set_default_value(true);

local end_additional_invasion_minimum = gam_mod:add_new_option("end_additional_invasion_minimum", "slider");
end_additional_invasion_minimum:set_text("Minimum");
end_additional_invasion_minimum:slider_set_min_max(0, 4);
end_additional_invasion_minimum:slider_set_step_size(1);
end_additional_invasion_minimum:set_default_value(1);

local end_additional_invasion_maximum = gam_mod:add_new_option("end_additional_invasion_maximum", "slider");
end_additional_invasion_maximum:set_text("Maximum");
end_additional_invasion_maximum:set_tooltip_text("Not used if not additional or less than minimum.");
end_additional_invasion_maximum:slider_set_min_max(0, 4);
end_additional_invasion_maximum:slider_set_step_size(1);
end_additional_invasion_maximum:set_default_value(2);

-- Chaos armies
local end_additional_chaos = gam_mod:add_new_option("end_additional_chaos", "checkbox");
end_additional_chaos:set_text("Randomize number of chaos armies per invasion");
end_additional_chaos:set_tooltip_text("If not checked, minimum is used.\n");
end_additional_chaos:set_default_value(true);

local end_additional_chaos_minimum = gam_mod:add_new_option("end_additional_chaos_minimum", "slider");
end_additional_chaos_minimum:set_text("Minimum");
end_additional_chaos_minimum:slider_set_min_max(0, 50);
end_additional_chaos_minimum:slider_set_step_size(1);
end_additional_chaos_minimum:set_default_value(4);

local end_additional_chaos_maximum = gam_mod:add_new_option("end_additional_chaos_maximum", "slider");
end_additional_chaos_maximum:set_text("Maximum");
end_additional_chaos_maximum:set_tooltip_text("Not used if not additional or less than minimum.");
end_additional_chaos_maximum:slider_set_min_max(0, 50);
end_additional_chaos_maximum:slider_set_step_size(1);
end_additional_chaos_maximum:set_default_value(8);

-- norsca armies
local end_additional_norsca = gam_mod:add_new_option("end_additional_norsca", "checkbox");
end_additional_norsca:set_text("Randomize number of norsca armies per invasion");
end_additional_norsca:set_tooltip_text("If not checked, minimum is used.\n");
end_additional_norsca:set_default_value(true);

local end_additional_norsca_minimum = gam_mod:add_new_option("end_additional_norsca_minimum", "slider");
end_additional_norsca_minimum:set_text("Minimum");
end_additional_norsca_minimum:slider_set_min_max(0, 50);
end_additional_norsca_minimum:slider_set_step_size(1);
end_additional_norsca_minimum:set_default_value(2);

local end_additional_norsca_maximum = gam_mod:add_new_option("end_additional_norsca_maximum", "slider");
end_additional_norsca_maximum:set_text("Maximum");
end_additional_norsca_maximum:set_tooltip_text("Not used if not additional or less than minimum.");
end_additional_norsca_maximum:slider_set_min_max(0, 50);
end_additional_norsca_maximum:slider_set_step_size(1);
end_additional_norsca_maximum:set_default_value(4);

-- beastmen armies
local end_additional_beastmen = gam_mod:add_new_option("end_additional_beastmen", "checkbox");
end_additional_beastmen:set_text("Randomize number of beastmen armies per invasion");
end_additional_beastmen:set_tooltip_text("If not checked, minimum is used.\n");
end_additional_beastmen:set_default_value(true);

local end_additional_beastmen_minimum = gam_mod:add_new_option("end_additional_beastmen_minimum", "slider");
end_additional_beastmen_minimum:set_text("Minimum");
end_additional_beastmen_minimum:slider_set_min_max(0, 50);
end_additional_beastmen_minimum:slider_set_step_size(1);
end_additional_beastmen_minimum:set_default_value(0);

local end_additional_beastmen_maximum = gam_mod:add_new_option("end_additional_beastmen_maximum", "slider");
end_additional_beastmen_maximum:set_text("Maximum");
end_additional_beastmen_maximum:set_tooltip_text("Not used if not additional or less than minimum.");
end_additional_beastmen_maximum:slider_set_min_max(0, 50);
end_additional_beastmen_maximum:slider_set_step_size(1);
end_additional_beastmen_maximum:set_default_value(1);

-- Number of agent
local end_additional_agent = gam_mod:add_new_option("end_additional_agent", "checkbox");
end_additional_agent:set_text("Randomize number of agents per invasion");
end_additional_agent:set_tooltip_text("Randomize number of agents. If not checked, minimum is used.\nDefault: false.");
end_additional_agent:set_default_value(true);

local end_additional_agent_minimum = gam_mod:add_new_option("end_additional_agent_minimum", "slider");
end_additional_agent_minimum:set_text("Minimum");
end_additional_agent_minimum:set_tooltip_text("Default: 0");
end_additional_agent_minimum:slider_set_min_max(0, 20);
end_additional_agent_minimum:slider_set_step_size(1);
end_additional_agent_minimum:set_default_value(0);

local end_additional_agent_maximum = gam_mod:add_new_option("end_additional_agent_maximum", "slider");
end_additional_agent_maximum:set_text("Maximum");
end_additional_agent_maximum:set_tooltip_text("Not used if not random or less than minimum.");
end_additional_agent_maximum:slider_set_min_max(0, 20);
end_additional_agent_maximum:slider_set_step_size(1);
end_additional_agent_maximum:set_default_value(2);

-- Special characters
local end_additional_archaon = gam_mod:add_new_option("end_additional_archaon", "checkbox");
end_additional_archaon:set_text("Archaon possible location");
end_additional_archaon:set_tooltip_text("Archaon and his army can spawn here.\nDefault: false");
end_additional_archaon:set_default_value(false);

local end_additional_kholek = gam_mod:add_new_option("end_additional_kholek", "checkbox");
end_additional_kholek:set_text("Kholek possible location");
end_additional_kholek:set_tooltip_text("Kholek and his army can spawn here.\nDefault: false");
end_additional_kholek:set_default_value(false);

local end_additional_sigvald = gam_mod:add_new_option("end_additional_sigvald", "checkbox");
end_additional_sigvald:set_text("Sigvald possible location");
end_additional_sigvald:set_tooltip_text("Kholek and his army can spawn here.\nDefault: false");
end_additional_sigvald:set_default_value(false);

local end_additional_sarthorael = gam_mod:add_new_option("end_additional_sarthorael", "checkbox");
end_additional_sarthorael:set_text("Sarthorael possible location");
end_additional_sarthorael:set_tooltip_text("Kholek and his army can spawn here.\nDefault: false");
end_additional_sarthorael:set_default_value(false);

local end_additional_winning = gam_mod:add_new_option("end_additional_winning", "checkbox");
end_additional_winning:set_text("Destroyed on win");
end_additional_winning:set_tooltip_text("If Archaon, Kholek and Sigvald are killed, all armies of this invasion will be destroyed.\nDefault: true");
end_additional_winning:set_default_value(true);