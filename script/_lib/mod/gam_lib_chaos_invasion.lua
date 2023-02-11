local verbose = false;

CI_INVASION_STAGES = {
    START = {key = "start", index = 0}, -- Before intro stage
    INTRO = {key = "intro", index = 1, turn_triggered = true}, -- Intro : only message here
    MID_GAME = {key = "mid", index = 2, turn_triggered = true}, -- First stage of invasion
    END_GAME = {key = "end", index = 3, turn_triggered = true}, -- Second stage of invasion, spawn special characters
    VICTORY = {key = "victory", index = 4} -- Cleaning chaos effect, killing armies..
}

CI_INVASION_TYPES = {
    EMPIRE = {key = "empire", name = "Empire"},
    NAGGAROTH = {key = "naggaroth", name = "Naggaroth"},
    ADDITIONAL = {key = "additional", name = "Additional"}
}

CI_SPECIAL_CHARACTERS = {
    ARCHAON = {key = "archaon"},
    KHOLEK = {key = "kholek"},
    SIGVALD = {key = "sigvald"},
    SARTHORAEL = {key = "sarthorael"}     
}

CI_ARMY_TYPES = {
    CHAOS = {
        key = "chaos",
        effect_bundle = "wh_main_bundle_military_upkeep_free_force",
        buildings = {"wh_main_horde_chaos_settlement_3", "wh_main_horde_chaos_warriors_2", "wh_main_horde_chaos_forge_1"}
    },
    NORSCA = {
        key = "norsca",
        effect_bundle = "wh_main_bundle_military_upkeep_free_force",
    },
    BEASTMEN = {
        key = "beastmen",
        effect_bundle = "wh_main_bundle_military_upkeep_free_force",
        buildings = {"wh_dlc03_horde_beastmen_herd_5", "wh_dlc03_horde_beastmen_gors_3", "wh_dlc03_horde_beastmen_minotaurs_1"}
    }
}

CI_SETTINGS = {

    -- Is chaos invasion mechanism activated
    INVASIONS_ACTIVATED = {key = "invasions_activated", values = {value = true}},

    -- Starting turn of invasion stages
    STARTING_TURN = {
        key = "starting_turn", 
        values = {
            [CI_INVASION_STAGES.MID_GAME.key] = {value = true, min = 90, max = 110},
            [CI_INVASION_STAGES.END_GAME.key] = {value = true, min = 140, max = 160}
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

    -- Is specific invasion activated
    -- Stage and invasion type dependent
    IS_ACTIVATED = {
        key = "is_activated",
        values = {
            [CI_INVASION_STAGES.MID_GAME.key] = {
                [CI_INVASION_TYPES.EMPIRE.key] = {value = true},
                [CI_INVASION_TYPES.NAGGAROTH.key] = {value = false},
                [CI_INVASION_TYPES.ADDITIONAL.key] = {value = false}
            },
            [CI_INVASION_STAGES.END_GAME.key] = {
                [CI_INVASION_TYPES.EMPIRE.key] = {value = true},
                [CI_INVASION_TYPES.NAGGAROTH.key] = {value = true},
                [CI_INVASION_TYPES.ADDITIONAL.key] = {value = true}
            },
        }
    },
    
    -- Number of chaos armies per invasion
    -- Stage, invasion type and army_type dependent
    ARMIES_PER_INVASION = {
        key = "armies_per_invasion",
        values = {
            [CI_INVASION_STAGES.MID_GAME.key] = {
                [CI_INVASION_TYPES.EMPIRE.key] = {
                    [CI_ARMY_TYPES.CHAOS.key] = {value = true, min = 4, max = 6},
                    [CI_ARMY_TYPES.NORSCA.key] = {value = false, min = 0, max = 0},
                    [CI_ARMY_TYPES.BEASTMEN.key] = {value = false, min = 0, max = 0}
                },
                [CI_INVASION_TYPES.NAGGAROTH.key] = {
                    [CI_ARMY_TYPES.CHAOS.key] = {value = false, min = 0, max = 0},
                    [CI_ARMY_TYPES.NORSCA.key] = {value = false, min = 0, max = 0},
                    [CI_ARMY_TYPES.BEASTMEN.key] = {value = false, min = 0, max = 0}
                },
                [CI_INVASION_TYPES.ADDITIONAL.key] = {
                    [CI_ARMY_TYPES.CHAOS.key] = {value = false, min = 0, max = 0},
                    [CI_ARMY_TYPES.NORSCA.key] = {value = false, min = 0, max = 0},
                    [CI_ARMY_TYPES.BEASTMEN.key] = {value = false, min = 0, max = 0}
                }
            },
            [CI_INVASION_STAGES.END_GAME.key] = {
                [CI_INVASION_TYPES.EMPIRE.key] = {
                    [CI_ARMY_TYPES.CHAOS.key] = {value = true, min = 8, max = 12},
                    [CI_ARMY_TYPES.NORSCA.key] = {value = true, min = 4, max = 6},
                    [CI_ARMY_TYPES.BEASTMEN.key] = {value = true, min = 1, max = 2}
                },
                [CI_INVASION_TYPES.NAGGAROTH.key] = {
                    [CI_ARMY_TYPES.CHAOS.key] = {value = true, min = 4, max = 6},
                    [CI_ARMY_TYPES.NORSCA.key] = {value = false, min = 0, max = 0},
                    [CI_ARMY_TYPES.BEASTMEN.key] = {value = false, min = 0, max = 0}
                },
                [CI_INVASION_TYPES.ADDITIONAL.key] = {
                    [CI_ARMY_TYPES.CHAOS.key] = {value = true, min = 4, max = 8},
                    [CI_ARMY_TYPES.NORSCA.key] = {value = true, min = 2, max = 4},
                    [CI_ARMY_TYPES.BEASTMEN.key] = {value = true, min = 0, max = 1}
                }
            },
        }
    },

    -- Number of agent per invasion
    -- Stage and invasion type dependent
    AGENT_PER_INVASION = {
        key = "agent_per_invasion",
        values = {
            [CI_INVASION_STAGES.MID_GAME.key] = {
                [CI_INVASION_TYPES.EMPIRE.key] = {value = true, min = 2, max = 4},
                [CI_INVASION_TYPES.NAGGAROTH.key] = {value = false, min = 0, max = 0},
                [CI_INVASION_TYPES.ADDITIONAL.key] = {value = false, min = 0, max = 0}
            },
            [CI_INVASION_STAGES.END_GAME.key] = {
                [CI_INVASION_TYPES.EMPIRE.key] = {value = true, min = 4, max = 6},
                [CI_INVASION_TYPES.NAGGAROTH.key] = {value = true, min = 1, max = 2},
                [CI_INVASION_TYPES.ADDITIONAL.key] = {value = true, min = 1, max = 2}
            },
        }
    },

    -- Number of additional invasion
    -- Stage and invasion type dependent
    -- Only for additional invasion type
    NUMBER_OF_INVASIONS = {
        key = "number_of_invasions",
        values = {
            [CI_INVASION_STAGES.MID_GAME.key] = {
                [CI_INVASION_TYPES.ADDITIONAL.key] = {value = false, min = 0, max = 0}
            },
            [CI_INVASION_STAGES.END_GAME.key] = {
                [CI_INVASION_TYPES.ADDITIONAL.key] = {value = true, min = 1, max = 2}
            },
        }
    },

    -- Can special character spawn
    -- Stage, invasion type and character dependent
    -- Only on end stage
    SPECIAL_CHARACTERS_POSSIBLE = {
        key = "special_character_possible",
        values = {
            [CI_INVASION_STAGES.END_GAME.key] = {
                [CI_INVASION_TYPES.EMPIRE.key] = {
                    [CI_SPECIAL_CHARACTERS.ARCHAON.key] = {value = true},
                    [CI_SPECIAL_CHARACTERS.KHOLEK.key] = {value = true},
                    [CI_SPECIAL_CHARACTERS.SIGVALD.key] = {value = true},
                    [CI_SPECIAL_CHARACTERS.SARTHORAEL.key] = {value = true}
                },
                [CI_INVASION_TYPES.NAGGAROTH.key] = {
                    [CI_SPECIAL_CHARACTERS.ARCHAON.key] = {value = false},
                    [CI_SPECIAL_CHARACTERS.KHOLEK.key] = {value = false},
                    [CI_SPECIAL_CHARACTERS.SIGVALD.key] = {value = false},
                    [CI_SPECIAL_CHARACTERS.SARTHORAEL.key] = {value = false}
                },
                [CI_INVASION_TYPES.ADDITIONAL.key] = {
                    [CI_SPECIAL_CHARACTERS.ARCHAON.key] = {value = false},
                    [CI_SPECIAL_CHARACTERS.KHOLEK.key] = {value = false},
                    [CI_SPECIAL_CHARACTERS.SIGVALD.key] = {value = false},
                    [CI_SPECIAL_CHARACTERS.SARTHORAEL.key] = {value = false}
                },
            }
        }
    },

    -- Kill all armies of this invasion on winning stage
    WINNING_KILL_ARMIES = {
        key = "winning_kill_armies",
        values = {
            [CI_INVASION_STAGES.END_GAME.key] = {
                [CI_INVASION_TYPES.EMPIRE.key] = {value = true},
                [CI_INVASION_TYPES.NAGGAROTH.key] = {value = true},
                [CI_INVASION_TYPES.ADDITIONAL.key] = {value = true}
            },
        }
    }
}

-- Return element for key in table
local function find_by_key(search_key, table)

    for _, item in pairs(table) do
        if item.key == search_key then
            return item;
        end
    end
end

-- Sometimes we give object key, sometimes object.
-- This method returns object everytime
local function get_items(setting, invasion_stage, invasion_type, special_type)
    local setting_key, invasion_stage_key, invasion_type_key, special_type_key;
    local setting_item, invasion_stage_item, invasion_type_item, special_type_item;

    setting_key = setting.key or setting;
    setting_item = find_by_key(setting_key, CI_SETTINGS);

    if invasion_stage then
        invasion_stage_key = invasion_stage.key or invasion_stage;
        invasion_stage_item = find_by_key(invasion_stage_key, CI_INVASION_STAGES);
        if invasion_type then
            invasion_type_key = invasion_type.key or invasion_type;
            invasion_type_item = find_by_key(invasion_type_key, CI_INVASION_TYPES);

            if special_type then
                -- Special type can be army type or special characters
                special_type_key = special_type.key or special_type;
                special_type_item = find_by_key(special_type_key, CI_ARMY_TYPES) or find_by_key(special_type_key, CI_SPECIAL_CHARACTERS);
            end
        end
    end

    return setting_item, invasion_stage_item, invasion_type_item, special_type_item;
end

-- Return MCT setting keys (type value / min / max)
-- invasion_stage is CI_INVASION_STAGES,
-- invasion_type is CI_INVASION_TYPES,
-- special_type can be CI_ARMY_TYPES or CI_SPECIAL_CHARACTERS
function CI_mct_setting_keys(setting, invasion_stage, invasion_type, special_type)
    local setting, invasion_stage, invasion_type, special_type = get_items(setting, invasion_stage, invasion_type, special_type);
    if not setting then
        GAM_LOG("Error: Setting must be provided");
        return;
    end

    local setting_key = setting.key;

    if special_type then
        setting_key = special_type.key.."_"..setting_key;
    end

    if invasion_type then
        setting_key = invasion_type.key.."_"..setting_key;
    end

    if invasion_stage then
        setting_key = invasion_stage.key.."_"..setting_key;
    end
    
    return setting_key, setting_key.."_minimum", setting_key.."_maximum";
end

-- Return value / min / max
function CI_setting_values(setting, invasion_stage, invasion_type, special_type)
    local setting, invasion_stage, invasion_type, special_type = get_items(setting, invasion_stage, invasion_type, special_type);
    local values, value, min, max;
    if not invasion_stage then
        values = setting.values;
    else
        if not invasion_type then
            values = setting.values[invasion_stage.key];
        else
            if not special_type then
                values = setting.values[invasion_stage.key][invasion_type.key];
            else
                values = setting.values[invasion_stage.key][invasion_type.key][special_type.key];
            end
        end
    end
    local mct_key_for_output = CI_mct_setting_keys(setting, invasion_stage, invasion_type, special_type)
    if not values then
        GAM_LOG("Error: Values not found for setting "..mct_key_for_output);
        return;
    elseif verbose then
        local output_value = "result: "..tostring(values.value);
        if values.min ~= nil then
            output_value = output_value.." (min: "..tostring(values.min)..", max: "..tostring(values.max)..")";
        end

        GAM_LOG("Asking values for setting "..mct_key_for_output.. ", "..output_value);
    end
    
    return values.value, values.min, values.max;
end

-- Return settings value or random between min and max values if randomized
function CI_load_setting(setting, invasion_stage, invasion_type, special_type)
    local setting, invasion_stage, invasion_type, special_type = get_items(setting, invasion_stage, invasion_type, special_type);
    local value, min, max = CI_setting_values(setting, invasion_stage, invasion_type, special_type);

    if value == nil then
        GAM_LOG("Error: Value not found for setting "..CI_mct_setting_keys(setting, invasion_stage, invasion_type, special_type));
        return;
    end

    -- Random settings if min or max is not null and settings is at true
    if (min or max) and value then
        return cm:random_number(max, min);
    end

    return value;
end

-- Set values (value, min, max) for setting.
function CI_save_setting(values, setting, invasion_stage, invasion_type, special_type)
    local setting, invasion_stage, invasion_type, special_type = get_items(setting, invasion_stage, invasion_type, special_type);
    
    if not invasion_stage then
        setting.values = values;
    else
        if not invasion_type then
            setting.values[invasion_stage.key] = values;
        else

            if not special_type then
                setting.values[invasion_stage.key][invasion_type.key] = values;
            else
                setting.values[invasion_stage.key][invasion_type.key][special_type.key] = values;
            end
        end
    end
end

-- Init setting values from mct setting
local function init_setting(mct_settings, setting, invasion_stage, invasion_type, special_type)
    
    if not mct_settings then
        return;
    end

    local mct_key, mct_minimum_key, mct_maximum_key = CI_mct_setting_keys(setting, invasion_stage, invasion_type, special_type);
    local value = mct_settings[mct_key];

    if value == nil then
        GAM_LOG("Error: MCT Value not found");
    end
    
    local values = {value, mct_settings[mct_minimum_key], mct_settings[mct_maximum_key]};
    CI_save_setting(values, setting, invasion_stage, invasion_type, special_type);
end

-- For settings of type random / min / max, validate and modify settings :
-- Maximum must be greater than minimum
local function validate_random_setting(setting, invasion_stage, invasion_type, special_type)
    local value, min, max = CI_setting_values(setting, invasion_stage, invasion_type, special_type);
    -- Random settings if min or max is not null and settings is true
    if (min or max) and value then
        if max <= min then
            local mct_key, mct_mininum_key, mct_maxinum_key = CI_mct_setting_keys(setting, invasion_stage, invasion_type, special_type)

            GAM_LOG("Incorrect setting : "..mct_mininum_key.." must be greater than "..mct_maxinum_key);
            local values = {value = false, min = min, max = min}
        end
    end
end

local function init_and_validate_setting(mct_settings, setting)

    local values = setting.values;

    if values.value ~= nil then
        init_setting(mct_settings, setting);
        validate_random_setting(setting);
    else 
        
        -- Stage dependent settings
        for invasion_stage_key, values in pairs(values) do

            if values.value ~= nil then
                init_setting(mct_settings, setting, invasion_stage_key);
                validate_random_setting(setting, invasion_stage_key);
            else

                -- Stage and invasion type dependent settings
                for invasion_type_key, values in pairs(values) do
                    
                    if values.value ~= nil then
                        init_setting(mct_settings, setting, invasion_stage_key, invasion_type_key);
                        validate_random_setting(setting, invasion_stage_key, invasion_type_key);
                    else

                        -- Stage, invasion type and others dependent settings
                        for special_type_key, values in pairs(values) do
                            init_setting(mct_settings, setting, invasion_stage_key, invasion_type_key, special_type_key);
                            validate_random_setting(setting, invasion_stage_key, invasion_type_key, special_type_key);
                        end
                    end
                end
            end
        end
    end
end

local function validate_settings_starting_turn()
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

    CI_save_setting(mid_values, CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.MID_GAME);
    CI_save_setting(end_values, CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.END_GAME);

    local intro_turn_min = 15;
    local intro_turn_max = 25;

    -- Prepare Intro stage
    if mid_turn_min <= 25 then
        intro_turn_min = 1;
        intro_turn_max = mid_turn_min - 1;       
    end

    local intro_values = {value = true, min = intro_turn_min, max = intro_turn_max};
    CI_save_setting(intro_values, CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.INTRO);
end

local function validate_settings_activated()
    if CI_load_setting(CI_SETTINGS.INVASIONS_ACTIVATED) then

        local invasion_stages = {CI_INVASION_STAGES.MID_GAME, CI_INVASION_STAGES.END_GAME}

        for  i = 1, #invasion_stages do
            local invasion_stage = invasion_stages[i]
            local at_least_one_activated = false;
            local only_additional_activated = true;

            for _, invasion_type in pairs(CI_INVASION_TYPES) do
             
                if CI_load_setting(CI_SETTINGS.IS_ACTIVATED, invasion_stage, invasion_type) then
                    at_least_one_activated = true;

                    if CI_INVASION_TYPES.ADDITIONAL ~= invasion_type then
                        only_additional_activated = false;
                    end
                end
            end

            only_additional_activated = only_additional_activated and at_least_one_activated;

            if not at_least_one_activated then
                GAM_LOG("Incorrect setting: Invasions activated but no invasion set for stage "..invasion_stage.key.." (Empire invasion activated)");
                CI_save_setting({value = true}, CI_SETTINGS.IS_ACTIVATED, invasion_stage, CI_INVASION_TYPES.EMPIRE);
            end

            if only_additional_activated then
                
                local invasions, invasions_min, invasions_max = CI_setting_values(CI_SETTINGS.NUMBER_OF_INVASIONS, invasion_stage, CI_INVASION_TYPES.ADDITIONAL);

                if invasions_min < 1 then
                    GAM_LOG("Incorrect setting: Only additional invasion activated, minimum additional invasion must be greather than 1");
                    invasions_min = 1;
                end

                if invasions_max < 1 then
                    GAM_LOG("Incorrect setting: Only additional invasion activated, maximum additional invasion must be greather than 1");
                    invasions_max = 1;
                end

                local values = {invasions, invasions_min, invasions_max};
                CI_save_setting(values, CI_SETTINGS.NUMBER_OF_INVASIONS, invasion_stage, CI_INVASION_TYPES.ADDITIONAL);
            end
        end
    end
end

local function validate_settings_special_characters()

    for _, special_character in pairs(CI_SPECIAL_CHARACTERS) do
        local found = false;

        for _, invasion_type in pairs(CI_INVASION_TYPES) do
            local is_activated = CI_load_setting(CI_SETTINGS.IS_ACTIVATED, CI_INVASION_STAGES.END_GAME, invasion_type);
            local can_spawn = CI_load_setting(CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, invasion_type, special_character);

            if can_spawn and not is_activated then
                GAM_LOG("Incorrect setting: "..special_character.key.." can't spawn in "..invasion_type.." cause this invasion is desactivated");
                can_spawn = false;
                CI_save_setting({value = false}, CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, invasion_type, special_character);
            end

            if can_spawn then
                found = true;
            end
        end

        -- Character must be somewhere, find the first possible location
        if not found then
            GAM_LOG("Incorrect setting: Invasion activated but "..special_character.key.." is nowhere");

            for _, invasion_type in pairs(CI_INVASION_TYPES) do
                if CI_load_setting(CI_SETTINGS.IS_ACTIVATED, CI_INVASION_STAGES.END_GAME, invasion_type) then
                    CI_save_setting({value = true}, CI_SETTINGS.SPECIAL_CHARACTERS_POSSIBLE, CI_INVASION_STAGES.END_GAME, invasion_type, special_character);
                    GAM_LOG(special_character.key.." will spawn in naggaroth");
                end
            end
        end
    end
end

-- Init settings table from mct setting
local function init_and_validate_settings(mct_settings)
    for _, setting in pairs(CI_SETTINGS) do
        init_and_validate_setting(mct_settings, setting);
    end

    validate_settings_starting_turn();
    validate_settings_activated();
    validate_settings_special_characters();

    local _, intro_turn_min, intro_turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.INTRO);
    local _, mid_turn_min, mid_turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.MID_GAME);
    local _, end_turn_min, end_turn_max = CI_setting_values(CI_SETTINGS.STARTING_TURN, CI_INVASION_STAGES.END_GAME);

    GAM_LOG("Intro min turn: "..intro_turn_min..", max turn:"..intro_turn_max);
    GAM_LOG("Mid game min turn: "..mid_turn_min..", max turn:"..mid_turn_max);
    GAM_LOG("End game min turn: "..end_turn_min..", max turn:"..end_turn_max);
end

function CI_init_settings(default_settings)
    GAM_LOG("CI_init_settings");
    local mct = get_mct();
    if mct and not default_settings then -- MCT Settings
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

-- Gamergeo log features                 
--resets the log on session start.
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

GAM_LOG_RESET();