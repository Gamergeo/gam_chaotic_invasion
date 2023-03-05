-- For logging features, you still need to activate log debugging
local verbose = false;

-- Gamergeo log features                 
-- Resets the log on session start.
function GAM_LOG_RESET()
    if not __write_output_to_logfile then
        return;
    end 
    local logTimeStamp = os.date("%d, %m %Y %X");
    --# assume logTimeStamp: string
    
    local popLog = io.open("gam_log.txt","w+");
    
    if popLog then
        popLog:write("NEW LOG ["..logTimeStamp.."] \n");
        popLog:flush();
        popLog:close();
    end
end

function GAM_LOG(text)
    if not __write_output_to_logfile then
        return; 
    end

    local logText = tostring(text);
    local logTimeStamp = os.date("%d, %m %Y %X");
    local popLog = io.open("gam_log.txt","a");
    --# assume logTimeStamp: string
    if popLog then
        popLog:write("GAM (chaotic_invasion):  [".. logTimeStamp .. "]:  "..logText .. "  \n");
        popLog :flush();
        popLog :close();
    end
    out.chaos("GAM (chaotic_invasion): [".. logTimeStamp .. "]:  "..logText .. "  ");
end

function GAM_LOG_INFO(text)
    if verbose then
        GAM_LOG(text);
    end
end

GAM_LOG_RESET();

CI_INVASION_STAGES = {
    START = { -- Before intro stage
        key = "start", 
        index = 0,
        message = "event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_early_primary_detail",
    },
    INTRO = { -- Intro : only message here
        key = "intro",
        message_key = "early",
        index = 1, 
        turn_triggered = true
    },
    MID_GAME = {  -- First stage of invasion
        key = "mid",
        message_key = "mid", 
        index = 2, 
        turn_triggered = true
    },
    END_GAME = { -- Second stage of invasion, spawn special characters
        key = "end", 
        message_key = "end",
        index = 3, 
        turn_triggered = true
    }, 
    VICTORY = {
        key = "victory", 
        message_key = "defeated",
        index = 4
    } -- Cleaning chaos effect, killing armies..
}

CI_SPECIAL_CHARACTERS = {
	ARCHAON = {
		key = "archaon",
		agent_subtype = "chs_archaon",
		forename = "names_name_2147343903",
		family_name = "names_name_2147357364",
		effect_bundle = "wh_main_bundle_military_upkeep_free_force_unbreakable"
	},
	KHOLEK = {
		key = "kholek",
		agent_subtype = "chs_kholek_suneater",
		forename = "names_name_2147345931",
		family_name = "names_name_2147345934",
		effect_bundle = "wh_main_bundle_military_upkeep_free_force_unbreakable"
	},
	SIGVALD = {
		key = "sigvald",
		agent_subtype = "chs_prince_sigvald",
		forename = "names_name_2147345922",
		family_name = "names_name_2147357370",
		effect_bundle = "wh_main_bundle_military_upkeep_free_force_unbreakable"
	},
	SARTHORAEL = {
		key = "sarthorael",
		agent_subtype = "chs_lord_of_change",
		forename = "names_name_2147357518",
		family_name = "names_name_2147357523",
		effect_bundle = "wh_main_bundle_military_upkeep_free_force_unbreakable"
	}
};

CI_AGENTS = {
    CHAOS = {
		{agent = "wizard", subtype = "chs_sorcerer_fire", weight = 1},
		{agent = "wizard", subtype = "chs_sorcerer_metal", weight = 1},
		{agent = "wizard", subtype = "chs_sorcerer_death", weight = 1},
		{agent = "champion", subtype = "chs_exalted_hero", weight = 3}
	},
}

CI_ARMY_TYPES = {
    CHAOS = {
        key = "chaos",
        effect_bundle = "wh_main_bundle_military_upkeep_free_force",
        buildings = {"wh_main_horde_chaos_settlement_3", "wh_main_horde_chaos_warriors_2", "wh_main_horde_chaos_forge_1"},
        faction_keys = {
            "wh_main_chs_chaos",
            "wh2_main_chs_chaos_incursion_def", 
            "wh2_main_chs_chaos_incursion_lzd",
            "wh2_main_chs_chaos_incursion_hef",
            "wh_main_chs_chaos_qb2",
            "wh_main_chs_chaos_qb3"
        }
    },
    NORSCA = {
        key = "norsca",
        effect_bundle = "wh_main_bundle_military_upkeep_free_force",
        faction_keys = {
            "wh_main_nor_bjornling",
            "wh_main_nor_norsca_qb1",
            "wh_main_nor_norsca_qb2",
            "wh_main_nor_norsca_qb3"
        }
    },
    BEASTMEN = {
        key = "beastmen",
        effect_bundle = "wh_main_bundle_military_upkeep_free_force",
        buildings = {"wh_dlc03_horde_beastmen_herd_5", "wh_dlc03_horde_beastmen_gors_3", "wh_dlc03_horde_beastmen_minotaurs_1"},
        faction_keys = {
            "wh_dlc03_bst_beastmen_chaos",
            "wh_dlc03_bst_beastmen_qb2",
            "wh_dlc03_bst_beastmen_qb3"
        }
    }
}

CI_LOCATIONS = {
    CHAOS_WASTE = {
        key = "chaos_waste",
        region_name = "wh_main_chaos_wastes", -- For message
        main_position = {775, 609}, -- Position for special character / message
        [CI_ARMY_TYPES.CHAOS.key] = {
            next = 1,
            positions = {
                {775, 609+5}, {770, 611+5}, {780, 611+5},
                {775, 609+10}, {770, 611+10}, {780, 611+10},
                {775, 609+15}, {770, 611+15}, {780, 611+15},
                {775, 609+20}, {770, 611+20}, {780, 611+20},
                {775, 609+25}, {770, 611+25}, {780, 611+25}
            }
         },
         [CI_ARMY_TYPES.NORSCA.key] = {
            positions = {
                {630, 680},	{697, 659}, {588, 708}, {540, 698}, {520, 693}, {494, 675}, {411, 673}, {374, 644},
                {420, 625}, {447, 639}, {519, 662}, {577, 693}, {495, 635}, {437, 610},
                {504, 609}, {448, 589}, {370, 581}
            }
         },
         [CI_ARMY_TYPES.BEASTMEN.key] = {
            positions = {
                {783, 633}, {788, 605}, {751, 654}, {762, 673}, {772, 676},
                {757, 659}, {767, 659}, {768, 684}, {768, 634}, {754, 646}
            }
         }
    },
    NAGGAROTH = {
        key = "naggaroth",
        region_name = "wh2_main_ironfrost_glacier_dagraks_end", -- For message
        main_position = {112, 704}, -- Position for special character / message
        [CI_ARMY_TYPES.CHAOS.key] = {
            next = 1,
            positions = {
                {41, 712}, {91, 712}, {130, 711}, {172, 713}, {213, 710},
                {59, 712}, {101, 712}, {140, 711}, {182, 713}, {223, 710}
            }
        },
        [CI_ARMY_TYPES.NORSCA.key] = {
            positions = { --TODO
                {403, 702}, {427, 710}, {287, 710}, {320, 706}, {9, 698},
                {281, 711}, {331, 703}, {8, 684}
            },
        },
        [CI_ARMY_TYPES.BEASTMEN.key] = {
            positions = {
                {39, 712}, {81, 712}, {120, 711}, {162, 713}, {203, 710},
                {49, 698}, {91, 698}, {130, 698}, {172, 698}, {213, 702}
            }
        },
    },
    LUSTRIA = {
        key = "lustria",
        region_name = "wh2_main_jungles_of_green_mist_pillars_of_unseen_constellations", -- For message
        main_position = {39, 124}, -- Position for special character / message
        
        [CI_ARMY_TYPES.CHAOS.key] = {
            positions = {
                {21, 124}, {23, 84}, {21, 71}, {25, 14}, {40, 63},
                {18 ,125}, {6, 177}, {26, 105}, {17, 53}
            }
        },

        [CI_ARMY_TYPES.NORSCA.key] = {
            positions = {
                {46, 200}, {43, 241}, {61, 210}, {67, 228}, {116, 213},
                {189, 182}, {29, 254}, {140, 190}, {225, 175}
            }
        },

        [CI_ARMY_TYPES.BEASTMEN.key] = {
            positions = {
                {38, 27}, {127, 12}, {175, 10}, {211, 9}, {43, 91},
                {89, 60}, {47, 114}, {35, 77}, {31, 25}

            }
        },
    },

    VORTEX = {
        key = "vortex",
        region_name = "wh2_main_sea_sea_of_dreams", -- For message
        main_position = {219, 338}, -- Position for special character / message
        
        [CI_ARMY_TYPES.CHAOS.key] = {
            positions = {
                {213, 331}, {214, 323}, {219, 320}, {228, 324}, {230, 328},
                {228, 336}, {212, 337}, {207, 333}, {210, 319}, {236, 320}
            }
        },

        [CI_ARMY_TYPES.NORSCA.key] = {
            positions = {
                {214, 459}, {231, 261}, {292, 287}, {305, 313}, {325, 364},
                {280, 489}, {261, 454}, {182, 453}, {133, 392}, {131, 309},
                {152, 280}
            }
        },

        [CI_ARMY_TYPES.BEASTMEN.key] = {
            positions = {
                {198, 308}, {190, 316}, {246, 338}, {233, 339}, {231, 348},
                {251, 368}, {223, 380}, {265, 396}, {265, 346}, {172, 353}
            }
        },
    },

    GREAT_OCEAN = {
        key = "great_ocean",
        region_name = "wh_main_sea_the_great_ocean", -- For message
        main_position = {306, 492}, -- Position for special character / message
        
        [CI_ARMY_TYPES.CHAOS.key] = {
            positions = {
                {306, 492+5}, {301, 492+5}, {311, 492+5},
                {306, 492+10}, {301, 492+10}, {311, 492+10},
                {306, 492+15}, {301, 492+15}, {311, 492+15},
                {306, 492+20}, {301, 492+20}, {311, 492+20},
                {306, 492+25}, {301, 492+25}, {311, 492+25}
            }
        },

        [CI_ARMY_TYPES.NORSCA.key] = {
            positions = {
                {316, 546}, {330, 550}, {308, 553}, {378, 530}, {412, 521},
                {375, 507}, {340, 493}, {248, 547}, {296, 450}, {277, 510},
                {406, 553}, {270, 535}
            }
        },

        [CI_ARMY_TYPES.BEASTMEN.key] = {
            positions = {
                {307, 544}, {335, 565}, {357, 508}, {341, 455}, {281, 520},
                {399, 506}, {354, 439}, {333, 481}, {274, 475}, {316, 450}
            }

        },
    },

    SOUTH_GREAT_OCEAN = {
        key = "south_great_ocean",
        region_name = "wh_main_sea_southern_straits_of_the_great_ocean", -- For message
        main_position = {343, 157}, -- Position for special character / message
        
        [CI_ARMY_TYPES.CHAOS.key] = {
            positions = {
                {343, 157+5}, {338, 157+5}, {348, 157+5},
                {343, 157+10}, {338, 157+10}, {348, 157+10},
                {343, 157+15}, {338, 157+15}, {348, 157+15},
                {343, 157+20}, {338, 157+20}, {348, 157+20},
                {343, 157+25}, {338, 157+25}, {348, 157+25}
            }
        },

        [CI_ARMY_TYPES.NORSCA.key] = {
            positions = {
                {248, 13}, {278, 13}, {308, 13}, {338, 13}, {368, 13},
                {230, 58}, {253, 137}, {390, 122}, {306, 198}, {276, 193},
                {354, 189}
            }
        },

        [CI_ARMY_TYPES.BEASTMEN.key] = {
            positions = {
                {321, 106}, {317, 118}, {334, 116}, {301, 106}, {301, 93},
                {310, 99}, {346, 69}, {348, 175}, {338, 175}, {343, 175}
            }
        },
    },
    UNKNOWM_SEAS = {
        key = "unknown_seas",
        region_name = "wh_main_sea_unknown_seas",
        main_position = {997, 108},
        [CI_ARMY_TYPES.CHAOS.key] = {
            positions = {
                {974, 101}, {992, 94}, {972, 95}, {990, 104}, {987, 95},
                {990, 112}, {994, 117}, {990, 11}, {985, 113}, {984, 120},
                {989, 108}, {996, 133}, {985, 135}
            }
        },
        [CI_ARMY_TYPES.NORSCA.key] = {
            positions = {
                {1007, 255}, {1006, 208}, {1006, 168}, {1008, 118}, {1008, 68},
                {1008, 26}, {813, 197}, {902, 134}, {941, 113}, {920, 202}
            }
        },
        [CI_ARMY_TYPES.BEASTMEN.key] = {
            positions = {
                {963, 187}, {1004, 289}, {1002, 296}, {955, 197}, {952, 160},
                {988, 180}, {954, 188}, {966, 288}, {933, 286}, {860, 306}
            }
        },
    },

    NAGASH_PYRAMID = {
        key = "nagash_pyramid",
        region_name = "wh2_main_great_mortis_delta_black_pyramid_of_nagash",
        main_position = {582, 63},
        [CI_ARMY_TYPES.CHAOS.key] = {
            positions = {
                {596, 70}, {587, 63}, {569, 60},
                {596, 70 + 5}, {587, 63 + 5}, {569, 60 + 5},
                {596, 70 + 10}, {587, 63 + 10}, {569, 60 + 10},
                {596, 70 + 15}, {587, 63 + 15}, {569, 60 + 15},
                {596, 70 + 20}, {587, 63 + 20}, {569, 60 + 20},

            }
        },
        [CI_ARMY_TYPES.NORSCA.key] = {
            positions = {
                {567, 12}, {586, 12}, {573, 18}, {548, 18}, {565, 32},
                {585, 32}, {592, 25}, {601, 14}, {609, 12}
            }
        },
        [CI_ARMY_TYPES.BEASTMEN.key] = {
            positions = {
                {729, 17}, {726, 41}, {533, 12}, {455, 16}, {413, 24}, 
                {414, 57}, {469, 60}, {480, 15}, {638, 13}
            }
        },
    },

    SYLVANIA = {
        key = "sylvania",
        region_name = "wh_main_eastern_sylvania_castle_drakenhof",
        main_position = {689, 419},
        [CI_ARMY_TYPES.CHAOS.key] = {
            positions = {
                {679, 417}, {677, 422}, {691, 430}, {694, 422}, {693, 416},
                {677, 423}, {690, 430}, {671, 423}, {681, 417}, {676, 438}
            }
        },
        [CI_ARMY_TYPES.NORSCA.key] = {
            positions = {
                {683, 402}, {681, 387}, {710, 399}, {714, 449}, {729, 474},
                {737, 495}, {705, 505}, {699, 463}, {649, 434}, {697, 422}
            }
        },
        [CI_ARMY_TYPES.BEASTMEN.key] = {
            positions = {
                {683, 452}, {673, 452}, {682, 461}, {686, 454}, {670, 449},
                {659, 446}, {644, 439}, {690, 468}, {626, 422}, {676, 444}
            }
        },
    },

    BADLANDS = {
        key = "badlands",
        region_name = "wh_main_eastern_badlands_valayas_sorrow",
        main_position = {687, 262},
        [CI_ARMY_TYPES.CHAOS.key] = {
            positions = {
                {674, 246}, {684, 246}, {694, 240},
                {674, 256}, {684, 256}, {694, 256}, 
                {674, 266},             {694, 266},
                {674, 276}, {684, 276}, {694, 276},
                {674, 286}, {684, 286}, {694, 286}
            }
        },
        [CI_ARMY_TYPES.NORSCA.key] = {
            positions = {
                {510, 155}, {578, 173}, {537, 185}, {552, 189}, {537, 206},
                {534, 220}, {510, 201}, {490, 189}, {471, 179}, {490, 170}, 
                {506, 178}
            }
        },
        [CI_ARMY_TYPES.BEASTMEN.key] = {
            positions = {
                {724, 238}, {717, 280}, {767, 250}, {715, 240}, {776, 225},
                {765, 252}, {796, 255}, {702, 230}, {765, 269}, {789, 301}
            }
        },
    },
    EMPIRE = {
        key = "empire",
        region_name = "wh_main_reikland_altdorf",
        main_position = {494, 450},
        [CI_ARMY_TYPES.CHAOS.key] = {
            positions = {
                {487, 434}, {492, 434}, {505, 434},
                {487, 444}, {492, 444}, {497, 444},
                {487, 454},             {497, 454},
                {494, 469}, {506, 469}
            }
        },
        [CI_ARMY_TYPES.NORSCA.key] = {
            positions = {
                {493, 478}, {448, 502}, {446, 527}, {454, 546}, {528, 547},
                {543, 527}, {557, 514}, {528, 500}, {434, 508}, {570, 569}
            }
        },
        [CI_ARMY_TYPES.BEASTMEN.key] = {
            positions = {
                {550, 461}, {581, 462}, {615, 475}, {593, 444}, {545, 450},
                {515, 426}, {525, 402}, {566, 409}, {582, 463}, {465, 438}
            }
        },
    },

};

CI_DATA = {
	CI_LAST_UPDATE = -1,
    CI_INVASION_STAGE = 0,
	--CI_SETTING = 2, -- Not used anymore
	CI_RAZED_REGIONS = 0,
	CI_AUTORUN = false,
	CI_EARLY_TURNS = 0, -- Used by wh2_dlc17_lzd_chaos_map.lua
	CI_EXTRA_ARMIES = 0, -- Used by wh2_dlc17_lzd_chaos_map.lua
	CI_LOCATIONS = {}, -- Will store location. Used for messages and keep same location
    CI_END_INVASIONS_NUMBER = -1; -- Number of invasion during end stage
};

-- Chaotic invasion settings
-- I really prefer to work with objects and linked enums so i make this, to connect mct and main lua script
-- key represents the mct key for setting
-- values represents values for settings, and can be of type {value} or {value, min, max} for randomizable settings
--        each values are divided per invasion_stage, invasion_type, character_type and army_type, if needed
--        Examples of direct access to value (not recommended) :
--                 character level maximum on second phase would be CI_SETTINGS[CHARACTER_LEVEL].values.end.max
--                 minimum number of norsca armies on first phase in naggaroth would be CI_SETTINGS[ARMIES_PER_INVASION].values.mid.naggaroth.norsca.minimum
-- Instead of accessing values directly, use CI_load_setting instead
CI_SETTINGS = {

    -- Is chaos invasion mechanism activated
    INVASIONS_ACTIVATED = {key = "invasions_activated", values = {value = true}},

    -- Invasions will have the same location for both stages of invasion
    KEEP_SAME_LOCATION = {key = "keep_same_location", values = {value = false}},

    -- Can two invasions spawn in same place
    SAME_LOCATION_POSSIBLE = {key = "same_location_possible", values = {value = false}},

    -- Can special character spawns everywhere
    CHARACTER_ANYWHERE = {key = "character_anywhere", values = {value = false}},

    -- Chaos waste invasion mandatory
    IS_LOCATION_MANDATORY = {
        key = "is_location_mandatory",
        values = {
            [CI_LOCATIONS.CHAOS_WASTE.key] = {value = true},
            [CI_LOCATIONS.NAGGAROTH.key] = {value = true}
        }
    },

    -- Show specific location messages
    LOCATION_MESSAGES = {key = "location_messages", values = {value = true}},

    -- Starting turn of invasion stages
    STARTING_TURN = {
        key = "starting_turn", 
        values = {
            [CI_INVASION_STAGES.MID_GAME.key] = {value = true, min = 90, max = 110},
            [CI_INVASION_STAGES.END_GAME.key] = {value = true, min = 140, max = 160}
        }
    },

    -- Number of invasion
    -- Stage dependent
    -- Only for additional invasion type
    INVASIONS_PER_STAGE = {
        key = "invasions_per_stage",
        values = {
            [CI_INVASION_STAGES.MID_GAME.key] = {value = false, min = 1, max = 1},
            [CI_INVASION_STAGES.END_GAME.key] = {value = true, min = 2, max = 4}
        }
    },

    -- Lords / Hero Level
    -- Stage dependent
    CHARACTER_LEVEL = {
        key = "character_level", 
        values = {
            [CI_INVASION_STAGES.MID_GAME.key] = {value = true, min = 10, max = 20},
            [CI_INVASION_STAGES.END_GAME.key] = {value = true, min = 20, max = 40}
        }
    },

    -- Unit army level
    -- Stage dependent
    ARMY_LEVEL = {
        key = "army_level", 
        values = {
            [CI_INVASION_STAGES.MID_GAME.key] = {value = true, min = 3, max = 6},
            [CI_INVASION_STAGES.END_GAME.key] = {value = true, min = 6, max = 9}
        }
    },

    -- Number of agent
    -- Stage and invasion type dependent
    AGENT_NUMBER = {
        key = "agent_number",
        values = {
            [CI_INVASION_STAGES.MID_GAME.key] = {value = true, min = 2, max = 4},
            [CI_INVASION_STAGES.END_GAME.key] = {value = true, min = 4, max = 6} 
       }
    },
    
    -- Number of chaos armies per invasion
    -- Stage, invasion type and army_type dependent
    ARMIES_PER_INVASION = {
        key = "armies_per_invasion",
        values = {
            [CI_INVASION_STAGES.MID_GAME.key] = {
                [CI_ARMY_TYPES.CHAOS.key] = {value = true, min = 4, max = 6},
                [CI_ARMY_TYPES.NORSCA.key] = {value = false, min = 0, max = 0},
                [CI_ARMY_TYPES.BEASTMEN.key] = {value = false, min = 0, max = 0}
            },
            [CI_INVASION_STAGES.END_GAME.key] = {
                [CI_ARMY_TYPES.CHAOS.key] = {value = true, min = 8, max = 12},
                [CI_ARMY_TYPES.NORSCA.key] = {value = true, min = 2, max = 6},
                [CI_ARMY_TYPES.BEASTMEN.key] = {value = true, min = 0, max = 1}
            },
        }
    },

    -- Is location activated
    LOCATION_ACTIVATED = {
        key = "location_activated",
        values = {
            [CI_LOCATIONS.CHAOS_WASTE.key] = {value = true},
            [CI_LOCATIONS.NAGGAROTH.key] = {value = true},
            [CI_LOCATIONS.LUSTRIA.key] = {value = true},
            [CI_LOCATIONS.UNKNOWM_SEAS.key] = {value = true},
            [CI_LOCATIONS.GREAT_OCEAN.key] = {value = true},
            [CI_LOCATIONS.SOUTH_GREAT_OCEAN.key] = {value = true},
            [CI_LOCATIONS.VORTEX.key] = {value = false},
            [CI_LOCATIONS.NAGASH_PYRAMID.key] = {value = false},
            [CI_LOCATIONS.SYLVANIA.key] = {value = false},
            [CI_LOCATIONS.BADLANDS.key] = {value = false},
            [CI_LOCATIONS.EMPIRE.key] = {value = false}
        }
    },

        -- Number of chaos armies per invasion
    -- Stage, invasion type and army_type dependent
    WINNING_KILL_ARMIES = {
        key = "winning_kill_armies",
        values = {
            [CI_ARMY_TYPES.CHAOS.key] = {value = true},
            [CI_ARMY_TYPES.NORSCA.key] = {value = false},
            [CI_ARMY_TYPES.BEASTMEN.key] = {value = false}
        }
    }
};

--------------------------------------------------------------
-------------------- Generic items methods -------------------
--------------------------------------------------------------

local function is_from_table(key, table)
    for _, item in pairs(table) do
        if item.key == key then
            return true;
        end
    end

    return false;
end

local function is_setting(key)
    return is_from_table(key, CI_SETTINGS);
end

local function item_keys(...)
    local keys = {};
    arg = {...};

    for i = 1, #arg do
        local param = arg[i];

        if param.key then
            keys[i] = param.key;
        else
            keys[i] = param;
        end
    end

    return keys;
end

local function item_key(item)
    return item_keys(item)[1];
end

local function force_name(item)
    return "CI_"..item_key(item);
end

local function output_values(values) 
    if not values then
        return "nil";
    elseif values.min ~= nil then
        return "{value: "..tostring(values.value)..", min: "..tostring(values.min)..", max: "..tostring(values.max).."}";
    else
        return "{value: "..tostring(values.value).."}";
    end
end

local function output_params(...)
    local keys = item_keys(...);
    local output = "";

    for i = 1, #keys do
        
        if i == 1 then
            output = keys[1];
        else
            output = output..", "..keys[i];
        end
    end
    return output;
end

local function output_table_param(table)
    local output = "";

    for i = 1, #table do
        
        if i == 1 then
            output = output_params(table[1]);
        else
            output = output..", "..output_params(table[i]);
        end
    end
    return output;
end


--------------------------------------------------------------
-----------------------     STAGES       ---------------------
--------------------------------------------------------------

local function current_stage()
    
    for _, value in pairs(CI_INVASION_STAGES) do
       if value.index == CI_DATA.CI_INVASION_STAGE then
           return value;
       end
    end
end

-- Easy access to current stage
local function is_start()
    return CI_INVASION_STAGES.START == current_stage();
end
local function is_intro()
    return CI_INVASION_STAGES.INTRO == current_stage();
end
local function is_mid_game()
    return CI_INVASION_STAGES.MID_GAME == current_stage();
end
local function is_end_game()
    return CI_INVASION_STAGES.END_GAME == current_stage();
end
local function is_victory()
    return CI_INVASION_STAGES.VICTORY == current_stage();
end

local function next_stage() 
    if is_start() then
        return CI_INVASION_STAGES.INTRO;
    elseif is_intro() then
        return CI_INVASION_STAGES.MID_GAME;
    elseif is_mid_game() then
        return CI_INVASION_STAGES.END_GAME;
    else
        return CI_INVASION_STAGES.VICTORY;
    end
end

-- Return the setting value for current stage
local function CI_load_setting_for_current_stage(setting, ...)
	return CI_load_setting(setting, current_stage(), ...);
end

--------------------------------------------------------------
-----------------------   Faction key    ---------------------
--------------------------------------------------------------

local function reset_faction_keys()
    GAM_LOG_INFO("reset_faction_keys()");

    for _, army_type in pairs(CI_ARMY_TYPES) do
        army_type.next = nil;
    end
end

-- Game can't handle when a given faction has too much armies.
-- So we try to split insaions as much as we can
local function next_faction_key(army_type)
    GAM_LOG_INFO("next_faction_key("..output_params(army_type)..")");
    local next = army_type.next;

    -- First call per stage
    if not next then
        next = 1;
    else 
        next = next + 1;
    end
    
    if not army_type.faction_keys[next] then
        next = 1;
    end

    army_type.next = next;
    return army_type.faction_keys[next];
end

-- Return true is given faction is from chaos invasion. If army_type is given, only look in this one.
local function is_invasion_faction(faction_key, army_type)
    GAM_LOG_INFO("is_invasion_faction("..output_params(faction_key, army_type)..")");

	local invasion_faction = false;
	local army_types = CI_ARMY_TYPES;

	if army_type then
        army_types[army_type.key] = army_type;
	end

	for _, army_type in pairs(army_types) do
		for i = 1, #army_type.faction_keys do
			if army_type.faction_keys[i] == faction_key then
				invasion_faction = true;
			end
		end
	end

	return invasion_faction;
end

--------------------------------------------------------------
-----------------------     SETTINGS     ---------------------
--------------------------------------------------------------

-- Return MCT setting keys (type value / min / max)
function CI_mct_setting_keys(setting, ...)
    GAM_LOG_INFO("CI_mct_setting_keys("..output_params(setting, ...)..")");
    local keys = item_keys(...);
    
    if not is_setting(setting.key) then
        GAM_LOG("Error: Setting must be provided");
        return;
    end

    if not keys then
        return setting.key;
    end

    local mct_key = "";

    for i = 1, #keys do

        if mct_key == "" then
            mct_key = keys[i].."_";
        else
            mct_key = mct_key..keys[i].."_";
        end
    end

    mct_key = mct_key..setting.key;
    
    return mct_key, mct_key.."_minimum", mct_key.."_maximum";
end

-- Return values for setting and parameter, if exists
-- Returned values can be final values or table of values
local function setting_values(setting, ...)
    GAM_LOG_INFO("setting_values("..output_params(setting, ...)..")");
    local keys = item_keys(...);
    local values = setting.values;
    
    for i = 1, #keys do
        
        if values[keys[i]] == nil then
            GAM_LOG("Error: incorrect parameter: "..keys[i].." for setting "..setting.key);
            return;
        end

        values = values[keys[i]];
    end

    return values;
end

-- Return {value / min / max}
-- Use CI_load_setting to get the final value of setting instead
function CI_setting_values(setting, ...)
    GAM_LOG_INFO("CI_setting_values("..output_params(setting, ...)..")");
    
    local values = setting_values(setting, ...);

    if not values or values.value == nil then
        GAM_LOG("Error: Values not found for "..output_params(setting, ...))
        return;
    end
    
    GAM_LOG_INFO("\tReturn "..output_values(values));
    return values.value, values.min, values.max;
end

-- Return settings value or random between min and max values or min if randomized setting
-- Each parameter can be the table item or its key
function CI_load_setting(setting, ...)
    GAM_LOG_INFO("CI_load_setting("..output_params(setting, ...)..")");

    local value, min, max = CI_setting_values(setting, ...);

    -- Random settings if min or max is not null and settings is at true
    if min ~= nil then
        if value then
            local rand = cm:random_number(max, min);
            GAM_LOG_INFO("Return: "..rand);
            return rand;
        else
            GAM_LOG_INFO("Return: "..min);
            return min;
        end
    end

    GAM_LOG_INFO("Return: "..tostring(value));
    return value;
end

-- Force save values (value, min, max) for setting. Does not verify pre-existence of values (useful for create new settings ingame)
local function force_save_setting(values, setting, ...)
    GAM_LOG_INFO("force_save_setting("..output_values(values)..","..output_params(setting, ...)..")");

    if values.value == nil then
        GAM_LOG("Error : Incorrect values format: "..output_values(values).." for setting"..output_params(setting, ...));
        return;
    end

    local keys = item_keys(...);

    if #keys == 0 then
        setting.values = {value = values.value, min = values.min, max = values.max};
    else
        local setting_values = setting.values;

        for i = 1, #keys do

            if i == #keys then
                setting_values[keys[i]] = {value = values.value, min = values.min, max = values.max};
            else
                setting_values = setting_values[keys[i]];
            end
        end
    end
end

-- Set values (value, min, max) for setting.
local function save_setting(values, setting, ...)
    GAM_LOG_INFO("save_setting("..output_values(values)..","..output_params(setting, ...)..")");

    if values.value == nil then
        GAM_LOG("Error : Incorrect values format: "..output_values(values).." for setting"..output_params(setting, ...));
        return;
    end

    local _, min, _ = CI_setting_values(setting, ...);

    if min ~= nil and values.min == nil then
        GAM_LOG("Error : Minimum expected: "..output_values(values).." for setting"..output_params(setting, ...));
        return;
    end
    if values.min ~= nil and values.max == nil then
        GAM_LOG("Error : Maximum expected: "..output_values(values).." for setting"..output_params(setting, ...));
        return;
    end

    force_save_setting(values, setting, ...);
end

-- For settings of type random / min / max, validate and modify settings :
-- Maximum must be greater than minimum
local function validate_random_setting(setting, ...)
    GAM_LOG_INFO("validate_random_setting("..output_params(setting, ...)..")");
    local value, min, max = CI_setting_values(setting, ...);
    -- Random settings if min or max is not null and settings is true
    if (min or max) and value then
        if max < min then
            local mct_key, mct_mininum_key, mct_maxinum_key = CI_mct_setting_keys(setting, ...)

            GAM_LOG("Incorrect setting : "..mct_mininum_key.." must be greater than "..mct_maxinum_key);
            local values = {value = false, min = min, max = min}
            save_setting(values, setting, ...);
        end
    end
end

-- Init setting values from mct setting
-- gobal method cause of recursivity in lua
local function init_setting(mct_settings, setting, ...)
    GAM_LOG_INFO("init_setting(mct_settings,"..output_params(setting, ...)..")");
    local values = setting_values(setting, ...);

    -- Error, should not happen
    if not values then
        GAM_LOG("Error...")
        return;
    end
    
    -- Final level
    if values.value ~= nil then

        if mct_settings then
            local mct_key, mct_minimum_key, mct_maximum_key = CI_mct_setting_keys(setting, ...);
            
            if not mct_settings then
                return;
            end
            local value = mct_settings[mct_key];

            if value == nil then
                GAM_LOG("Error: MCT Value not found");
            end
            
            local setting_values = {value = value, min = mct_settings[mct_minimum_key], max = mct_settings[mct_maximum_key]};
            save_setting(setting_values, setting, ...);
        end

        validate_random_setting(setting, ...);

    else

        -- We init each sublevel
        for key, _ in pairs(values) do 
            local arg = {...};
            table.insert(arg, key);
            init_setting(mct_settings, setting, unpack(arg));
        end
    end
end

-- Validation rules for starting turn
local function validate_settings_starting_turn()
    GAM_LOG_INFO("validate_settings_starting_turn()");
    local mid_turn_random, mid_turn_min, mid_turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.MID_GAME);
    local end_turn_random, end_turn_min, end_turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.END_GAME);

    -- MID_GAME (Stage 2) must start at turn 2 minimum
    if mid_turn_min < 2 then
        mid_turn_min = 2;
    end
    if mid_turn_max < 2 then
        mid_turn_max = 2;
    end

    -- END_GAME (Stage 3) must start at turn 3 minimum
    if end_turn_min < 3 then
        end_turn_min = 3;
    end
    if end_turn_max < 3 then
        end_turn_max = 3;
    end

    -- End game must start after mid game, so min and max has to be greater
    if end_turn_min <= mid_turn_min then
        end_turn_min = mid_turn_min + 1;
    end
    if end_turn_max <= mid_turn_max then
        end_turn_max = mid_turn_max + 1;
    end

    local mid_values = {value = mid_turn_random, min = mid_turn_min, max = mid_turn_max};
    local end_values = {value = end_turn_random, min = end_turn_min, max = end_turn_max};

    save_setting(mid_values, CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.MID_GAME);
    save_setting(end_values, CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.END_GAME);

    local intro_turn_min = 15;
    local intro_turn_max = 25;

    -- Prepare Intro stage
    if mid_turn_min <= 25 then
        intro_turn_min = 1;
        intro_turn_max = mid_turn_min - 1;       
    end

    local intro_values = {value = true, min = intro_turn_min, max = intro_turn_max};
    force_save_setting(intro_values, CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.INTRO);
end

-- Init settings table from mct setting
local function init_and_validate_settings(mct_settings)
    GAM_LOG_INFO("validate_settings_starting_turn(mct_settings)");
    for _, setting in pairs(CI_SETTINGS) do
        init_setting(mct_settings, setting);
    end

    validate_settings_starting_turn();

    local _, min, max = CI_setting_values(CI_SETTINGS.INVASIONS_PER_STAGE, CI_INVASION_STAGES.END_GAME);

    -- User has changed invasion number, we need to reload it
    if CI_DATA.CI_END_INVASIONS_NUMBER < min or CI_DATA.CI_END_INVASIONS_NUMBER > max then
        CI_DATA.CI_END_INVASIONS_NUMBER = CI_load_setting(CI_SETTINGS.INVASIONS_PER_STAGE, CI_INVASION_STAGES.END_GAME);
    end

    local _, intro_turn_min, intro_turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.INTRO);
    local _, mid_turn_min, mid_turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.MID_GAME);
    local _, end_turn_min, end_turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.END_GAME);

    GAM_LOG("Intro min turn: "..intro_turn_min..", max turn:"..intro_turn_max);
    GAM_LOG("Mid game min turn: "..mid_turn_min..", max turn:"..mid_turn_max);
    GAM_LOG("End game min turn: "..end_turn_min..", max turn:"..end_turn_max);
end

-- Init and validate settings table.
local function init_settings()
    GAM_LOG("init_settings()");
    local mct = get_mct();
    if mct then -- MCT Settings
        local gam_mod = mct:get_mod_by_key("gam_chaotic_invasion");
        init_and_validate_settings(gam_mod:get_settings());
        GAM_LOG("MCT Settings loaded");
        
        core:add_listener(
            "gam_chaotic_invasion_MctFinalized",
            "MctFinalized",
            true,
            function(context)
                local mct = get_mct();
                local gam_mod = mct:get_mod_by_key("gam_chaotic_invasion");
                init_and_validate_settings(gam_mod:get_settings());
                GAM_LOG("MCT Settings modified");
            end,
            true
        )
    else -- Default settings
        init_and_validate_settings();
    end
end

--------------------------------------------------------------
-----------------------     POSITIONS    ---------------------
--------------------------------------------------------------

local function random_position(minx, maxx, miny, maxy)
    local x = cm:random_number(maxx, minx);
    local y = cm:random_number(maxy, miny);

    return {x, y};
end

-- Verify if location is in selected_locations
local function already_selected_location(location, selected_locations)
    GAM_LOG_INFO("already_selected_location("..location.key.." in ("..output_table_param(selected_locations).."))");
    local location_key = item_key(location);
    local already_selected = false;

    for i = 1, #selected_locations do
        if selected_locations[i].key == location_key then
            already_selected = true;
        end
    end

    return already_selected;
end

local function location_by_key(location_key)
    for _, location in pairs(CI_LOCATIONS) do
        if location.key == location_key then
            return location;
        end
    end
end

-- Return a random location
-- @param selected_locations try to avoid repeating if option sameçlocation_possible = false
local function random_location(selected_locations)
    GAM_LOG_INFO("random_location("..output_table_param(selected_locations)..")");

    local available_locations = {};
    local all_available_locations = {};
    local same_location_possible = CI_load_setting(CI_SETTINGS.SAME_LOCATION_POSSIBLE);

    for _, location in pairs(CI_LOCATIONS) do
        -- Location is activated
        if CI_load_setting(CI_SETTINGS.LOCATION_ACTIVATED, location) then
            table.insert(all_available_locations, location);
            
            if same_location_possible or not already_selected_location(location, selected_locations) then
                table.insert(available_locations, location);
            end
        end
    end

    local random_number = cm:random_number(#available_locations);
    local selected_location = available_locations[random_number];

    if not selected_location then
        random_number = cm:random_number(#all_available_locations);
        selected_location = all_available_locations[random_number];
        GAM_LOG("Error: not enough location, random one ("..selected_location.key..") is set");
    end

    GAM_LOG_INFO("\tFind location: "..selected_location.key);

    return selected_location;
end

-- Return X random locations
-- @param forced_locations : location are forced if possible (enough invasions_per_stage)
local function random_locations(invasions_per_stage, forced_locations)
    GAM_LOG_INFO("random_locations("..invasions_per_stage..", "..output_table_param(forced_locations)..")");
    local locations = {};

    -- forced_locations
    for i = 1, #forced_locations do
        
        if #locations == invasions_per_stage then
            return locations;
        end

        locations[i] = forced_locations[i];
    end

    -- random_locations
    while #locations < invasions_per_stage do
        table.insert(locations, random_location(locations));
    end

    -- Reset locations
    for i = 1, #locations do
        local location = locations[i];
        if location.next ~= nil then
            location.next = 1;
        else 
            for _, army_location in pairs(location) do
                if army_location.next ~= nil then
                    army_location.next = 1
                end
            end
        end
    end

    return locations;
end

-- Prepare a set of locations from user settings
local function prepare_locations()
    GAM_LOG_INFO("prepare_locations()");

    local _, _, max_invasions_per_stage_mid = CI_setting_values(CI_SETTINGS.INVASIONS_PER_STAGE, CI_INVASION_STAGES.MID_GAME);
    local _, _, max_invasions_per_stage_end = CI_setting_values(CI_SETTINGS.INVASIONS_PER_STAGE, CI_INVASION_STAGES.END_GAME);

    local max_invasions = math.max(max_invasions_per_stage_mid, max_invasions_per_stage_end);

    local locations = {};

    -- Chaos waste mandatory
    if CI_load_setting(CI_SETTINGS.IS_LOCATION_MANDATORY, CI_LOCATIONS.CHAOS_WASTE) then
        table.insert(locations, CI_LOCATIONS.CHAOS_WASTE);
    end

    -- Naggaroth mandatory
    if CI_load_setting(CI_SETTINGS.IS_LOCATION_MANDATORY, CI_LOCATIONS.NAGGAROTH) and not is_mid_game() then
        table.insert(locations, CI_LOCATIONS.NAGGAROTH);
    end

    locations = random_locations(max_invasions, locations);

    return locations;
end

local function init_locations()
    GAM_LOG_INFO("init_locations()");
    local locations = prepare_locations();

    for i = 1, #locations do
        CI_DATA.CI_LOCATIONS[i] = locations[i].key;
    end

    CI_DATA.CI_END_INVASIONS_NUMBER = CI_load_setting(CI_SETTINGS.INVASIONS_PER_STAGE, CI_INVASION_STAGES.END_GAME);

    GAM_LOG("Locations has been initialized: "..output_table_param(locations));
    return locations;
end

local function locations_from_data()
    GAM_LOG_INFO("locations_from_data()");

    local locations = {};

    -- Savegame compatibilty
    if not CI_DATA.CI_LOCATIONS then 
        init_locations();
    end

    for i = 1, #CI_DATA.CI_LOCATIONS do
        locations[i] = location_by_key(CI_DATA.CI_LOCATIONS[i]);
    end

    return locations;
end

-- Return locations for given invasion_stage
local function locations_for_current_stage()
    GAM_LOG_INFO("locations_for_current_stage()");

    local invasion_stage = current_stage();
    local locations;

    -- In intro stage, we need to init CI_DATA.CI_LOCATIONS
    if is_intro() then
        invasion_stage = CI_INVASION_STAGES.END_GAME;
        locations = init_locations();
    elseif is_mid_game() and not CI_load_setting(CI_SETTINGS.KEEP_SAME_LOCATION) then
        -- If we are mid_game and user doesn't want to keep same place, we need to find new locations
        locations = prepare_locations();
    else
        -- or stored invasion are used
        locations = locations_from_data();
    end

    local invasions_per_stage;
    if CI_INVASION_STAGES.END_GAME == invasion_stage then
        invasions_per_stage = CI_DATA.CI_END_INVASIONS_NUMBER;
    else
        invasions_per_stage = CI_load_setting(CI_SETTINGS.INVASIONS_PER_STAGE, invasion_stage);
    end

    -- User has changed settings
    if invasions_per_stage > #locations then
        locations = init_locations();
    end

    local locations_for_stage = {};
    for i = 1, invasions_per_stage do
        locations_for_stage[i] = locations[i];
    end

    GAM_LOG("Find locations for current stage: "..output_table_param(locations_for_stage));
    return locations_for_stage;
end

-- Return next coordonates for given location
-- Depending cases, can be random or ordored
local function next_position(location, army_type)
    GAM_LOG_INFO("next_position("..output_params(location, army_type)..")");

    if location.positions == nil then
        if not army_type then
            GAM_LOG("Error : army_type not given but mandatory for "..location.key);
        end

        location = location[army_type.key];
    end

    if not location.positions then
        GAM_LOG("Error: Incorrect location provided");
        return; 
    end

    local next_position;

    if location.next then
        local next = location.next;
        next_position = location.positions[next];
        next = next + 1;
        
        if next > #location.positions then
            next = 1;
        end
        
        location.next = next;
    else
        local rand_position = cm:random_number(#location.positions);
        next_position = location.positions[rand_position];
    end
    
    if not next_position then
        GAM_LOG("Error: Next position not found.");
    end
    
    return next_position;
end

--------------------------------------------------------------
--------------------        Messages       -------------------
--------------------------------------------------------------

-- Return generic or location message key
local function message_details_keys(location)
	local key = "event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_" ..current_stage().message_key;

	-- Location messages
	if location then
		key = key.."_" ..location.key;
	end

	return key.."_primary_detail", key.."_secondary_detail";
end

-- Return message id (image ?) for current stage
local function message_id()

	if is_intro() then
		return 29;
	elseif is_mid_game() then
		return 30;
	elseif is_end_game() then
		return 31;
	elseif is_victory() then
		return 35;
	end
end

local function show_messages(faction_key, locations)

	-- Only non located generic message
	if is_victory() or (is_intro() and not CI_load_setting(CI_SETTINGS.LOCATION_MESSAGES)) then
		local primary_message, secondary_message = message_details_keys();

        GAM_LOG("Show event message: "..primary_message.." to "..faction_key);
		cm:show_message_event(
			faction_key,
			primary_message,
			"",
			secondary_message,
			true, 
			message_id()
		);
	else
        local done_locations = {};
		for i = 1, #locations do
            local location = locations[i];
            
            -- We show only one message per different location
            if not already_selected_location(location, done_locations) then
                table.insert(done_locations, location);
                local primary_message, secondary_message;

                if i == 1 then --Generic messages
                    primary_message, secondary_message = message_details_keys();
                else
                    primary_message, secondary_message = message_details_keys(location);
                end

                GAM_LOG("Show event message: "..primary_message.." to "..faction_key);

                cm:show_message_event_located(
                    faction_key,
                    primary_message,
                    "",
                    secondary_message,
                    location.main_position[1],
                    location.main_position[2],
                    true, 
                    message_id()
                );
                
            end

            if is_mid_game() or is_end_game() then
			    cm:make_region_visible_in_shroud(faction_key, location.region_name);
            end
		end
	end
end

--------------------------------------------------------------
--------------------     Chaos invasion    -------------------
--------------------------------------------------------------

function CI_setup()
	GAM_LOG("CI_setup()");
	out.inc_tab("chaos");

	if cm:get_local_faction_name(true) then
		CI_DATA.CI_AUTORUN = false;
	else
		GAM_LOG("Autorun detected!");
		CI_DATA.CI_AUTORUN = true;
	end

	if CI_DATA.CI_AUTORUN == false then
		if cm:is_multiplayer() == false then
			local human_factions = cm:get_human_factions();
			local player_faction = cm:model():world():faction_by_key(human_factions[1]);

			if player_faction:subculture() == "wh_main_sc_nor_norsca" then
				GAM_LOG("Aborting Chaos invasion script, a player is Norsca!");
				out.dec_tab("chaos");
				Setup_Norsca_Chaos_Invasion();
				return;
			end
		end
	end

    -- TODO
	local chaos_faction = cm:model():world():faction_by_key(CI_ARMY_TYPES.CHAOS.faction_keys[1]);
    
	if chaos_faction:is_human() == false then
        init_settings();
		CI_setup_armies();
		
		if cm:is_new_game() == true then
			cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "");
			
			GAM_LOG("Killing Archaon! - '"..chaos_faction:faction_leader():command_queue_index().."'");
			cm:set_character_immortality("character_cqi:"..chaos_faction:faction_leader():command_queue_index(), false);
			cm:kill_character(chaos_faction:faction_leader():command_queue_index(), true, false);
			
			cm:callback(function()
				cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "");
			end, 1);
		end
 
		if CI_load_setting(CI_SETTINGS.INVASIONS_ACTIVATED) then
			GAM_LOG("Creating Script Listeners");
			core:add_listener(
				"CI_FactionTurnStart",
				"FactionTurnStart",
				true,
				function(context) CI_FactionTurnStart(context) end,
				true
			);
			core:add_listener(
				"CI_CharacterRazedSettlement",
				"CharacterRazedSettlement",
				true,
				function(context) CI_CharacterRazedSettlement(context) end,
				true
			);
			core:add_listener(
				"CI_CharacterConvalescedOrKilled",
				"CharacterConvalescedOrKilled",
				true,
				function(context) CI_CharacterConvalescedOrKilled(context) end,
				true
			);
		else
			GAM_LOG("Disabling Chaos Invasion! (Off Setting)");
			cm:complete_scripted_mission_objective("wh_main_short_victory", "archaon_spawned", true);
			cm:complete_scripted_mission_objective("wh_main_long_victory", "archaon_spawned", true);
			cm:complete_scripted_mission_objective("wh_main_short_victory", "archaon_defeated", true);
			cm:complete_scripted_mission_objective("wh_main_long_victory", "archaon_defeated", true);
		end
	else
		GAM_LOG("Disabling Chaos Invasion! (Human Chaos)");
	end
	out.dec_tab("chaos");
end

function CI_FactionTurnStart(context)

	if context:faction():is_human() == true or CI_DATA.CI_AUTORUN == true then
        local next_stage = next_stage();
    
        -- Nothing to do
        if not next_stage.turn_triggered then
            return;
        end

		local turn_number = cm:model():turn_number();

		if CI_DATA.CI_LAST_UPDATE < turn_number then
			GAM_LOG("Chaos Event Update : Turn "..turn_number);
			out.inc_tab("chaos");
			CI_DATA.CI_LAST_UPDATE = turn_number;

            -- I've changed the mechanism to start an invasion stage, but will have the smae probalities except
            -- that in base game, a stage can start on minimal turn, due to formula used
            -- So each turn a random value between min and max is set, if this value is less than current_turn, we start stage
            
            local turn_start = CI_load_setting(CI_SETTINGS.STARTING_TURN, next_stage);
            local _, turn_min, turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, next_stage);
                
            if next_stage == CI_INVASION_STAGES.END_GAME then
                -- Early turns used by wh2_dlc17_lzd_chaos_map.lua
                CI_DATA.CI_EARLY_TURNS = CI_DATA.CI_EARLY_TURNS or 0; -- Savegame compatibility ???
                turn_start = turn_start - CI_DATA.CI_EARLY_TURNS;
            end

            GAM_LOG("Next Event: "..next_stage.key);
            GAM_LOG("\tFirst Possible Turn: "..turn_min);
            GAM_LOG("\tLast Possible Turn: "..turn_max);
            GAM_LOG("\tTurns Early: "..CI_DATA.CI_EARLY_TURNS);
            GAM_LOG("\tCurrent starting turn: "..turn_start);

            if turn_start <= turn_number then
                GAM_LOG("\t\tSuccess!");
                
                if next_stage == CI_INVASION_STAGES.INTRO then    
                    CI_Event_1_Intro();
                elseif next_stage == CI_INVASION_STAGES.MID_GAME then
                    CI_Event_2_MidGame();
                elseif next_stage == CI_INVASION_STAGES.END_GAME then
                    CI_Event_3_EndGame();
                end
            else
                GAM_LOG("\t\tFailed!");
            end
        end
    end
	out.dec_tab("chaos");
end

function CI_CharacterRazedSettlement(context)
	if is_end_game() then
		local faction = context:character():faction();
		local faction_key = faction:name();

		if is_invasion_faction(faction_key) then
			CI_DATA.CI_RAZED_REGIONS = CI_DATA.CI_RAZED_REGIONS + 1;
			CI_apply_chaos_corruption();
		end
	end
end

function CI_CharacterConvalescedOrKilled(context)
	if is_end_game() then
		local character = context:character();
		local faction = character:faction();

		if is_invasion_faction(faction:name(), CI_ARMY_TYPES.CHAOS) then
			if (character:character_subtype("chs_archaon") == true and character:is_faction_leader() == true) or 
					character:character_subtype("chs_kholek_suneater") == true or 
					character:character_subtype("chs_prince_sigvald") == true then

				local archaon, kholek, sigvald = CI_invasion_deaths();

				CI_apply_chaos_corruption();

				if archaon == 0 and kholek == 0 and sigvald == 0 then
					CI_Event_4_Victory();
				end
			end
		end
	end
end

function CI_Event_1_Intro()
	GAM_LOG("CI_Event_1_Intro()");
	out.inc_tab("chaos");
    CI_DATA.CI_INVASION_STAGE = CI_INVASION_STAGES.INTRO.index;
	local locations = locations_for_current_stage();

	local human_factions = cm:get_human_factions();	
	for i = 1, #human_factions do
		show_messages(human_factions[i], locations);
	end
    
	--CI_apply_chaos_corruption(); No chaos corruption on Intro
	out.dec_tab("chaos");
end

function CI_Event_2_MidGame()
	GAM_LOG("CI_Event_2_MidGame()");
	out.inc_tab("chaos");
    CI_DATA.CI_INVASION_STAGE = CI_INVASION_STAGES.MID_GAME.index;
	local locations = locations_for_current_stage();
	
	local human_factions = cm:get_human_factions();
	for i = 1, #human_factions do
		show_messages(human_factions[i], locations);
	end

    CI_spawn_invasions(locations);
    CI_spawn_agents();
	CI_apply_chaos_corruption();
	CI_personality_swap(2);
	out.dec_tab("chaos");
end

function CI_Event_3_EndGame()
	GAM_LOG("CI_Event_3_EndGame");
	out.inc_tab("chaos");
    CI_DATA.CI_INVASION_STAGE = CI_INVASION_STAGES.END_GAME.index;
	local locations = locations_for_current_stage();

	local human_factions = cm:get_human_factions();
	for i = 1, #human_factions do
		show_messages(human_factions[i], locations);
	end
    
    CI_spawn_invasions(locations);
    CI_spawn_agents();
	CI_apply_chaos_corruption();
	CI_personality_swap(3);

    cm:register_instant_movie("Warhammer/chs_rises");
	out.dec_tab("chaos");
end

function CI_Event_4_Victory()
	GAM_LOG("CI_Event_4_Victory");
    CI_DATA.CI_INVASION_STAGE = CI_INVASION_STAGES.VICTORY.index;

	local human_factions = cm:get_human_factions();
	for i = 1, #human_factions do
		show_messages(human_factions[i]);
	end

    -- Kill all armies
    for _, army_type in pairs(CI_ARMY_TYPES) do
        
        -- Kill all armies
        if CI_load_setting(CI_SETTINGS.WINNING_KILL_ARMIES, army_type) then
            for i = 1, #army_type.faction_keys do
                local faction_key = army_type.faction_keys[i];
                local faction = cm:model():world():faction_by_key(faction_key);
                cm:kill_all_armies_for_faction(faction);
                GAM_LOG("Kill all armies for "..faction_key)
            end
        elseif CI_ARMY_TYPES.CHAOS == army_type then
            for i = 1, #CI_ARMY_TYPES.CHAOS.faction_keys do
                local chaos_faction = cm:model():world():faction_by_key(CI_ARMY_TYPES.CHAOS.faction_keys[i]);
                local character_list = chaos_faction:character_list();
        
                for j = 0, character_list:num_items() - 1 do
                    local character = character_list:item_at(j);
            
                    if character:character_subtype(CI_SPECIAL_CHARACTERS.ARCHAON.agent_subtype) or 
                            character:character_subtype(CI_SPECIAL_CHARACTERS.KHOLEK.agent_subtype) or 
                            character:character_subtype(CI_SPECIAL_CHARACTERS.SIGVALD.agent_subtype) or 
                            character:character_subtype(CI_SPECIAL_CHARACTERS.SARTHORAEL.agent_subtype) then
                        cm:set_character_immortality("character_cqi:"..character:command_queue_index(), false);
                        cm:kill_character(character:command_queue_index(), false, true);
                        GAM_LOG("Killed character for "..CI_ARMY_TYPES.CHAOS.faction_keys[i]);
                    end
                end
            end
        end
    end
	
	cm:complete_scripted_mission_objective("wh_main_short_victory", "archaon_spawned", true);
	cm:complete_scripted_mission_objective("wh_main_long_victory", "archaon_spawned", true);

	cm:complete_scripted_mission_objective("wh_main_short_victory", "archaon_defeated", true);
	cm:complete_scripted_mission_objective("wh_main_long_victory", "archaon_defeated", true);

	CI_apply_chaos_corruption(); -- Remove corruption effect
	CI_personality_swap(4);
end

local function create_army(faction_key, force_name, effect_bundle, position, char_level, army_level)
	GAM_LOG_INFO("create_army("..faction_key..","..force_name..","..effect_bundle..",["..position[1]..","..position[2].."],"..char_level..","..army_level..")");
	local army_invasion;
    local x, y = cm:find_valid_spawn_location_for_character_from_position(faction_key, position[1], position[2], true);
    
    if x > -1 and y > -1 then
        local force = random_army_manager:generate_force(force_name, 19, false);
        local turn_number = cm:model():turn_number();
        
        -- TODO?
        local invasion_key = "GAM_"..force_name.."_"..faction_key.."_"..x.."_"..y.."_T"..turn_number.."_"..core:get_unique_counter();
        --local invasion_key = "CI_chaos_"..position_key.."_T"..turn_number.."_"..core:get_unique_counter();
        army_invasion = invasion_manager:new_invasion(invasion_key, faction_key, force, {x, y});
        army_invasion:add_character_experience(char_level, true);
        army_invasion:apply_effect(effect_bundle, 0);

        if army_level > 0 then
            army_invasion:add_unit_experience(army_level);
        end
        
        GAM_LOG("Spawned Army, requested ("..position[1]..", "..position[2].."),find ("..tostring(x).." / "..tostring(y)..")");
	end

	return army_invasion;
end

local function spawn_army(faction_key, army_type, location)
    GAM_LOG("spawn_army("..faction_key..","..army_type.key..","..location.key..")");
	local position = next_position(location, army_type);

	local char_level = CI_load_setting_for_current_stage(CI_SETTINGS.CHARACTER_LEVEL);
	local army_level = CI_load_setting_for_current_stage(CI_SETTINGS.ARMY_LEVEL);
    
	local army_invasion = create_army(faction_key, force_name(army_type), army_type.effect_bundle, position, char_level, army_level);
    
	if army_invasion then
        army_invasion:start_invasion(
            function(self)
                if army_type.buildings then
                    local force = self:get_force();
                    local force_cqi = force:command_queue_index();
                    cm:add_building_to_force(force_cqi, army_type.buildings);
                end
            end);
    else
        GAM_LOG("Failed Army Spawn!("..position[1]..", "..position[2]..")");
    end
    out.dec_tab("chaos");

	return army_invasion;
end

-- Return true if the character is the leader of the faction (the only character present for now)
local function is_faction_leader(character, faction_key)
    GAM_LOG_INFO("is_faction_leader("..character.key..", "..faction_key..")");
	local faction = cm:model():world():faction_by_key(faction_key);
	local char_list = faction:character_list();
	
	for i = 0, char_list:num_items() - 1 do
		local current_char = char_list:item_at(i);

		if current_char:character_subtype(CI_SPECIAL_CHARACTERS.ARCHAON.agent_subtype) 
            or current_char:character_subtype(CI_SPECIAL_CHARACTERS.KHOLEK.agent_subtype) 
            or current_char:character_subtype(CI_SPECIAL_CHARACTERS.SIGVALD.agent_subtype) 
            or current_char:character_subtype(CI_SPECIAL_CHARACTERS.SARTHORAEL.agent_subtype) then
            return false;
		end
	end

    return true;
end

local function spawn_character(character, faction_key, location)
    GAM_LOG("spawn_character("..character.key..","..faction_key..","..location.key..")");
	local position = location.main_position;
    local try = 1;
    local army_invasion;

    while try <= 10 and not army_invasion do
        try = try + 1;
        army_invasion = create_army(faction_key, force_name(character), character.effect_bundle, position, 40, 9);

        -- We try elsewhere
        if not army_invasion then
            position[1] = position[1] + 2 * try;
            position[2] = position[2] + 2 * try;
        end
    end

    if army_invasion then
        local faction_leader = is_faction_leader(character, faction_key);
        
        if faction_leader then
            GAM_LOG(character.key.." is the leader of faction "..faction_key);
        else
            GAM_LOG(character.key.." is not the leader of faction "..faction_key);
        end
        army_invasion:create_general(faction_leader, character.agent_subtype, character.forename, "", character.family_name, "");
        army_invasion:set_general_immortal(true);
        army_invasion:start_invasion(
            function(self)
                local force = self:get_force();
                local force_cqi = force:command_queue_index();
                cm:add_building_to_force(force_cqi, CI_ARMY_TYPES.CHAOS.buildings);
            end);
    else
        GAM_LOG("Error : Failed Character Army Spawn!("..location.main_position[1]..", "..location.main_position[2]..")");
    end
end

-- Return special character invasion number. They will spawn in this invasion.
local function character_invasion_number(number_of_invasions)

    -- Characters will spawn in the first invasion
    if not CI_load_setting(CI_SETTINGS.CHARACTER_ANYWHERE) then
        return 1, 1, 1;
    else
        return cm:random_number(number_of_invasions), cm:random_number(number_of_invasions), cm:random_number(number_of_invasions);
    end
end

-- Declare war between faction_keys and all faction
local function declare_war(warring_faction_keys) 

    local faction_list = cm:model():world():faction_list();

	for i = 0, faction_list:num_items() - 1 do
		local faction = faction_list:item_at(i);
		local faction_key = faction:name();
		
		if faction:is_null_interface() == false and faction:is_dead() == false and faction:culture() ~= "wh_main_chs_chaos" and faction:culture() ~= "wh_dlc03_bst_beastmen" then

            for i = 1, #warring_faction_keys do
                local warring_faction_key = warring_faction_keys[i];
                cm:force_declare_war(warring_faction_key, faction_key, false, false);
                cm:force_diplomacy("faction:"..warring_faction_key, "faction:"..faction_key, "peace", false, false, true);
            end
		end
	end
end

-- Spawn all invasions for current stage
function CI_spawn_invasions(locations)
    GAM_LOG("CI_spawn_invasions(locations)");
	out.inc_tab("chaos");
	reset_faction_keys();

	local kholek_invasion_number, sigvald_invasion_number, sarthorael_invasion_number = character_invasion_number(#locations);
    local warring_faction_keys = {};
	
	for invasion_number = 1, #locations do
		local location = locations[invasion_number];
		GAM_LOG("Spawn invasion in "..location.key);
		out.inc_tab("chaos");
        
        local army_types = {CI_ARMY_TYPES.CHAOS, CI_ARMY_TYPES.NORSCA, CI_ARMY_TYPES.BEASTMEN};
        for i = 1, #army_types do
		    local army_type = army_types[i];
			local faction_key = next_faction_key(army_type);

            local already_used_faction_key = false;
            for i = 1, #warring_faction_keys do
                if warring_faction_keys[i] == faction_key then
                    already_used_faction_key = true;
                end
            end

            if not already_used_faction_key then
                table.insert(warring_faction_keys, faction_key);
            end

			GAM_LOG("Selected faction: "..faction_key.." for "..army_type.key);

			local number_armies = CI_load_setting_for_current_stage(CI_SETTINGS.ARMIES_PER_INVASION, army_type);

            -- Special character spawn
            if is_end_game() and CI_ARMY_TYPES.CHAOS == army_type then
                
        		CI_DATA.CI_EXTRA_ARMIES = CI_DATA.CI_EXTRA_ARMIES or 0; -- Savegame compatibility
                number_armies = number_armies + CI_DATA.CI_EXTRA_ARMIES;

                -- Archaon is always in first invasion and always leader
                if invasion_number == 1 then
                    spawn_character(CI_SPECIAL_CHARACTERS.ARCHAON, faction_key, location);
                end
            
                if invasion_number == kholek_invasion_number then
                    spawn_character(CI_SPECIAL_CHARACTERS.KHOLEK, faction_key, location);
                end

                if invasion_number == sigvald_invasion_number then
                    spawn_character(CI_SPECIAL_CHARACTERS.SIGVALD, faction_key, location);
                end

                if invasion_number == sarthorael_invasion_number then
                    spawn_character(CI_SPECIAL_CHARACTERS.SARTHORAEL, faction_key, location);
                end
            end

			if number_armies then
				GAM_LOG("Spawn "..number_armies.." "..army_type.key.." armies.");
				out.inc_tab("chaos");
				
				for _ = 1, number_armies do
					spawn_army(faction_key, army_type, location);
				end
				out.dec_tab("chaos");
			else
				GAM_LOG("No "..army_type.key.." army.");
			end
		end
		
		out.dec_tab("chaos");
	end

    declare_war(warring_faction_keys);
end

function CI_spawn_agents()
    GAM_LOG("CI_spawn_agents()");
	out.inc_tab("chaos");

    local num_agents = CI_load_setting_for_current_stage(CI_SETTINGS.AGENT_NUMBER);

	if num_agents > 0 then
		local weighted_agents = weighted_list:new();
		for i = 1, #CI_AGENTS.CHAOS do
			local agent = CI_AGENTS.CHAOS[i];
			weighted_agents:add_item(agent, agent.weight);
		end

		for i = 1, num_agents do
			local selected_agent = weighted_agents:weighted_select();
			local position; local x = -1; local y = -1; local try = 1;

            while try <= 10 and (x <= -1 or y <= -1) do
                position = random_position(10, 700, 100, 550);
			    x, y = cm:find_valid_spawn_location_for_character_from_position(CI_ARMY_TYPES.CHAOS.faction_keys[1], position[1], position[2], true);
                
                try = try + 1;
            end

			if x > -1 and y > -1 then
                local agent_xp = CI_load_setting_for_current_stage(CI_SETTINGS.CHARACTER_LEVEL);
				cm:create_agent(
					CI_ARMY_TYPES.CHAOS.faction_keys[1],
					selected_agent.agent,
					selected_agent.subtype,
					x, y,
					false,
					function(cqi)
						cm:add_agent_experience("character_cqi:"..cqi, agent_xp, true);
					end
				);
				GAM_LOG("Spawned Chaos Agent "..i.." ("..tostring(x).." / "..tostring(y)..")");
			else
				out.GAM_LOG("FAILED Chaos Agent Spawn "..i);
			end
		end
	end
	out.dec_tab("chaos");
end

-- TODO : Chaos corruption settings
function CI_chaos_corruption()
    local chaos_corruption = 0;
    
    if is_mid_game() then
        chaos_corruption = 1;
    elseif is_end_game() then
        chaos_corruption = 1 + (CI_DATA.CI_RAZED_REGIONS / 10);
        chaos_corruption = math.floor(chaos_corruption);
    end
    
    return chaos_corruption;
end

-- Merge CI_apply_chaos_corruption and CI_invasion_effect_bundle_update
-- Planning on adding several settings on chaos corruption, so i merge these methods for more flexibility
-- All effects for effect bundle is managed here, not on DB
function CI_apply_chaos_corruption()
    GAM_LOG("CI_apply_chaos_corruption()");

    local chaos_corruption = CI_chaos_corruption();
    local human_factions = cm:get_human_factions();
    
    GAM_LOG("Applied chaos corruption: "..chaos_corruption);
    
    -- Faction effect - Display
    local effect_bundle_faction_name = "gam_effect_bundle_faction_ci_"..current_stage().key;
    local effect_bundle_faction = cm:create_new_custom_effect_bundle(effect_bundle_faction_name);
    
    if is_end_game() then
        effect_bundle_faction:add_effect("wh2_main_dummy_chaos_regions_razed", "faction_to_faction_own_unseen", CI_DATA.CI_RAZED_REGIONS);
        
        local archaon, kholek, sigvald = CI_invasion_deaths();

        if archaon == 1 then
            effect_bundle_faction:add_effect("wh2_main_dummy_chaos_archaon_alive", "faction_to_faction_own_unseen", 1);
        else
            effect_bundle_faction:add_effect("wh2_main_dummy_chaos_archaon_dead", "faction_to_faction_own_unseen", 1);
        end
        if kholek == 1 then
            effect_bundle_faction:add_effect("wh2_main_dummy_chaos_kholek_alive", "faction_to_faction_own_unseen", 1);
        else
            effect_bundle_faction:add_effect("wh2_main_dummy_chaos_kholek_dead", "faction_to_faction_own_unseen", 1);
        end
        if sigvald == 1 then
            effect_bundle_faction:add_effect("wh2_main_dummy_chaos_sigvald_alive", "faction_to_faction_own_unseen", 1);
        else
            effect_bundle_faction:add_effect("wh2_main_dummy_chaos_sigvald_dead", "faction_to_faction_own_unseen", 1);
        end
    end
	
	for i = 1, #human_factions do
		local faction = cm:model():world():faction_by_key(human_factions[i]);
        local effect_dummy;

        if faction:state_religion() == "wh_main_religion_chaos" then
            effect_dummy = "wh_main_effect_religion_conversion_chaos_events_dummy";
        else
            effect_dummy = "wh_main_effect_religion_conversion_chaos_events_bad_dummy";
        end
        
		cm:remove_effect_bundle("gam_effect_bundle_faction_ci_mid", human_factions[i]);
		cm:remove_effect_bundle("gam_effect_bundle_faction_ci_end", human_factions[i]);

        if not is_victory() then
            effect_bundle_faction:add_effect(effect_dummy, "faction_to_province_own", chaos_corruption);
		    cm:apply_custom_effect_bundle_to_faction(effect_bundle_faction, faction);
        end
	end 
    
    -- Region effect : X chaos corruption to each region
    local effect_bundle_region_name = "gam_effect_bundle_region"
    local region_list = cm:model():world():region_manager():region_list();
    
    local effect_bundle_region = cm:create_new_custom_effect_bundle(effect_bundle_region_name);
	effect_bundle_region:add_effect("wh_main_effect_religion_conversion_chaos_events_bad", "region_to_province_own", chaos_corruption);
	effect_bundle_region:set_duration(0);

	for i = 0, region_list:num_items() - 1 do
		local current_region = region_list:item_at(i);
		local region_key = current_region:name();

		if current_region:is_province_capital() == true then
			cm:remove_effect_bundle_from_region(effect_bundle_region_name, region_key);
            if not is_victory() then
			    cm:apply_custom_effect_bundle_to_region(effect_bundle_region, current_region);
            end
		end
	end
end

function CI_invasion_deaths()
    GAM_LOG_INFO("CI_invasion_deaths()");
    local archaon = 0;
    local kholek = 0;
    local sigvald = 0;
    for i = 1, #CI_ARMY_TYPES.CHAOS.faction_keys do
        local chaos_faction = cm:model():world():faction_by_key(CI_ARMY_TYPES.CHAOS.faction_keys[i]);
        local char_list = chaos_faction:character_list();
        
        for j = 0, char_list:num_items() - 1 do
            local current_char = char_list:item_at(j);

            if current_char:character_subtype("chs_archaon") or current_char:character_subtype("chs_kholek_suneater") or current_char:character_subtype("chs_prince_sigvald") then
                if current_char:has_military_force() == true then
                    if current_char:is_wounded() == false then
                        if current_char:character_subtype("chs_archaon") == true then
                            archaon = 1;
                        elseif current_char:character_subtype("chs_kholek_suneater") == true  then
                            kholek = 1;
                        elseif current_char:character_subtype("chs_prince_sigvald") == true  then
                            sigvald = 1;
                        end
                    end
                end
            end
        end
    end

	return archaon, kholek, sigvald;
end

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
if core:is_campaign() then
    cm:add_saving_game_callback(
        function(context)
            cm:save_named_value("CI_DATA", CI_DATA, context);
        end
    );
    cm:add_loading_game_callback(
        function(context)
            if cm:is_new_game() == false then
                CI_DATA = cm:load_named_value("CI_DATA", CI_DATA, context);
            end
        end
    );
end