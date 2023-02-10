local gam_mod = mct:get_mod_by_key("gam_chaotic_invasion")

-- Second Phase : General Settings
local end_general = gam_mod:add_new_section("end_general", "Second Phase : General Settings", false);
end_general:set_option_sort_function("index_sort");

local end_general_empire = gam_mod:add_new_option("end_general_empire", "checkbox");
end_general_empire:set_text("Empire invasion");
end_general_empire:set_tooltip_text("If not checked, invasion won't spawn from the chaos waste.\nSee dedicated section for more configuration.\nDefaut: true.");
end_general_empire:set_default_value(true);

local end_general_naggaroth = gam_mod:add_new_option("end_general_naggaroth", "checkbox");
end_general_naggaroth:set_text("Naggaroth invasions");
end_general_naggaroth:set_tooltip_text("If not checked, invasion won't spawn from naggaroth.\nSee dedicated section for more configuration.\nDefaut: true.");
end_general_naggaroth:set_default_value(true);

local end_general_additional = gam_mod:add_new_option("end_general_additional", "checkbox");
end_general_additional:set_text("Additional invasions");
end_general_additional:set_tooltip_text("Random location invasions.\nSee dedicated section for more configuration.\nDefault: false.");
end_general_additional:set_default_value(true);

-- Random turn
local end_general_turn = gam_mod:add_new_option("end_general_turn", "checkbox");
end_general_turn:set_text("Randomize start turn");
end_general_turn:set_tooltip_text("Randomize the turn for the second phase of invasion to be triggered. If not checked, minimum is used.\nDefault: true.");
end_general_turn:set_default_value(true);

local end_general_turn_minimum = gam_mod:add_new_option("end_general_turn_minimum", "slider");
end_general_turn_minimum:set_text("Minimum");
end_general_turn_minimum:set_tooltip_text("Minimum turn for the second phase to be triggered.\nDefault: 140.");
end_general_turn_minimum:slider_set_min_max(3, 300);
end_general_turn_minimum:slider_set_step_size(1);
end_general_turn_minimum:set_default_value(140);

local end_general_turn_maximum = gam_mod:add_new_option("end_general_turn_maximum", "slider");
end_general_turn_maximum:set_text("Maximum");
end_general_turn_maximum:set_tooltip_text("Maximum turn for the second phase to be triggered. Not used if not random or less than minimum.\nDefault: 160");
end_general_turn_maximum:slider_set_min_max(3, 300);
end_general_turn_maximum:slider_set_step_size(1);
end_general_turn_maximum:set_default_value(160);

-- Character level
local end_general_character_level = gam_mod:add_new_option("end_general_character_level", "checkbox");
end_general_character_level:set_text("Randomize character level");
end_general_character_level:set_tooltip_text("Randomize hero / lord level. If not checked, minimum is used.\nDefault: false.");
end_general_character_level:set_default_value(true);

local end_general_character_level_minimum = gam_mod:add_new_option("end_general_character_level_minimum", "slider");
end_general_character_level_minimum:set_text("Minimum");
end_general_character_level_minimum:set_tooltip_text("Default: 10");
end_general_character_level_minimum:slider_set_min_max(1, 40);
end_general_character_level_minimum:slider_set_step_size(1);
end_general_character_level_minimum:set_default_value(20);

local end_general_character_level_maximum = gam_mod:add_new_option("end_general_character_level_maximum", "slider");
end_general_character_level_maximum:set_text("Maximum");
end_general_character_level_maximum:set_tooltip_text("Not used if not random or less than minimum.");
end_general_character_level_maximum:slider_set_min_max(1, 40);
end_general_character_level_maximum:slider_set_step_size(1);
end_general_character_level_maximum:set_default_value(40);

-- Army level
local end_general_army_level = gam_mod:add_new_option("end_general_army_level", "checkbox");
end_general_army_level:set_text("Randomize army level");
end_general_army_level:set_tooltip_text("Randomize level of units in armies. If not checked, minimum is used.\nDefault: false.");
end_general_army_level:set_default_value(true);

local end_general_army_level_minimum = gam_mod:add_new_option("end_general_army_level_minimum", "slider");
end_general_army_level_minimum:set_text("Minimum");
end_general_army_level_minimum:set_tooltip_text("Default: 0/0/3/6/9");
end_general_army_level_minimum:slider_set_min_max(1, 9);
end_general_army_level_minimum:slider_set_step_size(1);
end_general_army_level_minimum:set_default_value(6);

local end_general_army_level_maximum = gam_mod:add_new_option("end_general_army_level_maximum", "slider");
end_general_army_level_maximum:set_text("Maximum");
end_general_army_level_maximum:set_tooltip_text("Not used if not random or less than minimum.");
end_general_army_level_maximum:slider_set_min_max(1, 9);
end_general_army_level_maximum:slider_set_step_size(1);
end_general_army_level_maximum:set_default_value(9);
