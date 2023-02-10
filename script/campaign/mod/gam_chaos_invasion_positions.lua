CI_LOCATIONS = {
    EMPIRE = {
        CHAOS = {        
            key = "empire_chaos",
            next = 1,
            positions = {
                {775, 609+5}, {770, 611+5}, {780, 611+5},
                {775, 609+10}, {770, 611+10}, {780, 611+10},
                {775, 609+15}, {770, 611+15}, {780, 611+15},
                {775, 609+20}, {770, 611+20}, {780, 611+20},
                {775, 609+25}, {770, 611+25}, {780, 611+25}
            }
         },
         NORSCA = {        
            key = "empire_norsca",
            random = true,
            positions = {
                {630, 680},	{697, 659}, {588, 708}, {540, 698}, {520, 693}, {494, 675}, {411, 673}, {374, 644},
                {420, 625}, {447, 639}, {519, 662}, {589, 688}, {495, 635}, {437, 610},
                {504, 609}, {448, 589}, {377, 565}
            }
         },
         BEASTMEN = {        
            key = "empire_beastmen",
            next = 1,
            positions = {
                {788, 605}
            }
         }
    },
    NAGGAROTH = {
         CHAOS = {        
            key = "naggaroth_chaos",
            next = 1,
            positions = {
                {49, 712}, {91, 712}, {130, 711}, {172, 713}, {213, 710}
            }
         },
         NORSCA = {        
            key = "naggaroth_norsca",
            next = 1,
            positions = {
                {630, 680},	{697, 659}, {588, 708}, {540, 698}, {520, 693}, {494, 675}, {411, 673}, {374, 644},
                {420, 625}, {447, 639}, {519, 662}, {589, 688}, {495, 635}, {437, 610},
                {504, 609}, {448, 589}, {377, 565}
            }
         },
         BEASTMEN = {        
            key = "naggaroth_beastmen",
            next = 1,
            positions = {
                {788, 605}
            }
         }    
    }
}

function CI_get_next_position(location)
    
    GAM_LOG("TODELETE: get_next_position("..location.key..")");
    local next_position;
    
    if location.random then
        local rand_position = cm:random_number(#location.positions);
        next_position = location.positions[rand_position];
    else
        local next = location.next;
        next_position = location.positions[next];
        next = next + 1;
        
        if next > #location.positions then
            next = 1;
        end
        
        location.next = next;
    end
    
    if not next_position then
        GAM_LOG("Error: Position not found for location: "..location.key.." (next: "..location.next..")");
    end
    
    return next_position;
end