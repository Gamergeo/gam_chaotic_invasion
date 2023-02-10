local gam_mod = mct:get_mod_by_key("gam_chaotic_invasion")

-- First Phase : General Settings
local mid_general = gam_mod:add_new_section("mid_general", "First Phase : General Settings", false);
mid_general:set_option_sort_function("index_sort");

local mid_general_empire = gam_mod:add_new_option("mid_general_empire", "checkbox");
mid_general_empire:set_text("Empire invasion");
mid_general_empire:set_tooltip_text("If not checked, invasion won't spawn from the chaos waste.\nSee dedicated section for more configuration.\nDefaut: true.");
mid_general_empire:set_default_value(true);

local mid_general_naggaroth = gam_mod:add_new_option("mid_general_naggaroth", "checkbox");
mid_general_naggaroth:set_text("Naggaroth invasions");
mid_general_naggaroth:set_tooltip_text("If not checked, invasion won't spawn from naggaroth.\nSee dedicated section for more configuration.\nDefaut: false.");
mid_general_naggaroth:set_default_value(false);

local mid_general_additional = gam_mod:add_new_option("mid_general_additional", "checkbox");
mid_general_additional:set_text("Additional invasions");
mid_general_additional:set_tooltip_text("Random location invasions.\nSee dedicated section for more configuration.\nDefault: false.");
mid_general_additional:set_default_value(false);

-- Random turn
local option, option_min, option_max = GAM_MOD:add_new_ci_randomizable_options(2, 300, CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.MID_GAME);
option:set_text("Randomize start turn");
option:set_tooltip_text("Randomize the turn for the first phase of invasion to be triggered. If not checked, minimum is used.\nDefault: true.");
option_min:set_tooltip_text("Minimum turn for the first phase to be triggered.\nDefault: 90.");
option_max:set_tooltip_text("Maximum turn for the first phase to be triggered. Not used if not random or less than minimum.\nDefault: 110");

-- Character level
local mid_general_character_level = gam_mod:add_new_option("mid_general_character_level", "checkbox");
mid_general_character_level:set_text("Randomize character level");
mid_general_character_level:set_tooltip_text("Randomize hero / lord level. If not checked, minimum is used.\nDefault: false.");
mid_general_character_level:set_default_value(true);

local mid_general_character_level_minimum = gam_mod:add_new_option("mid_general_character_level_minimum", "slider");
mid_general_character_level_minimum:set_text("Minimum");
mid_general_character_level_minimum:set_tooltip_text("Default: 10");
mid_general_character_level_minimum:slider_set_min_max(1, 40);
mid_general_character_level_minimum:slider_set_step_size(1);
mid_general_character_level_minimum:set_default_value(10);

local mid_general_character_level_maximum = gam_mod:add_new_option("mid_general_character_level_maximum", "slider");
mid_general_character_level_maximum:set_text("Maximum");
mid_general_character_level_maximum:set_tooltip_text("Not used if not random or less than minimum.");
mid_general_character_level_maximum:slider_set_min_max(1, 40);
mid_general_character_level_maximum:slider_set_step_size(1);
mid_general_character_level_maximum:set_default_value(20);

-- Army level
local mid_general_army_level = gam_mod:add_new_option("mid_general_army_level", "checkbox");
mid_general_army_level:set_text("Randomize army level");
mid_general_army_level:set_tooltip_text("Randomize level of units in armies. If not checked, minimum is used.\nDefault: false.");
mid_general_army_level:set_default_value(true);

local mid_general_army_level_minimum = gam_mod:add_new_option("mid_general_army_level_minimum", "slider");
mid_general_army_level_minimum:set_text("Minimum");
mid_general_army_level_minimum:set_tooltip_text("Default: 0/0/3/6/9");
mid_general_army_level_minimum:slider_set_min_max(1, 9);
mid_general_army_level_minimum:slider_set_step_size(1);
mid_general_army_level_minimum:set_default_value(3);

local mid_general_army_level_maximum = gam_mod:add_new_option("mid_general_army_level_maximum", "slider");
mid_general_army_level_maximum:set_text("Maximum");
mid_general_army_level_maximum:set_tooltip_text("Not used if not random or less than minimum.");
mid_general_army_level_maximum:slider_set_min_max(1, 9);
mid_general_army_level_maximum:slider_set_step_size(1);
mid_general_army_level_maximum:set_default_value(6);
