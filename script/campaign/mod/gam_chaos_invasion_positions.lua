CI_LOCATIONS = {
    [CI_INVASION_TYPES.EMPIRE.key] = {
        [CI_ARMY_TYPES.CHAOS.key] = {
            next = 1,
            main_position = {775, 609}, -- Position for special character / message
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
                {420, 625}, {447, 639}, {519, 662}, {589, 688}, {495, 635}, {437, 610},
                {504, 609}, {448, 589}, {377, 565}
            }
         },
         [CI_ARMY_TYPES.BEASTMEN.key] = {
            positions = {
                {788, 605}
            }
         }
    },
    [CI_INVASION_TYPES.NAGGAROTH.key] = {
        next = 1,
        positions = {
            {49, 712}, {91, 712}, {130, 711}, {172, 713}, {213, 710}
        }
    },

    [CI_INVASION_TYPES.ADDITIONAL.key] = {
        TEST = {
            positions = {
                {200, 200}
            }
        },
        LUSTRIA = {
            positions = {
                {282, 15}, {307, 24}
            }
        },
        SEA_OF_SERPENTS = {
            positions = {
                {125, 240}, {140, 250}
            }
        },
        VAMPIRE_COAST = {
            positions = {
                {470, 155}, {510, 175}
            }
        },
        FAR_EAST = {
            positions = {
                {890, 150}, {910, 160}
            }
        }
    }
}

CI_ADDITIONAL_LOCATIONS = CI_LOCATIONS[CI_INVASION_TYPES.ADDITIONAL.key];

function CI_next_location(invasion_type, army_type)

end

local function next_position(location)
    if not location.positions then
        GAM_LOG("Error: Incorrect location provided");
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

