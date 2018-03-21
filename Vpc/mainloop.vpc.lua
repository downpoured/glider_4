
-- level data:
-- Welcome|numberOObjects|leftOpen|rightOpen|animateKind|animateNumber|animateDelay|conditionCode
-- level objects:
-- typename|typynumber|c1|c2|c3|c4|amount|extra|isOn|typename|typynumber|c1|c2|c3|c4|amount|extra|isOn

function intersectRoomObject curlvldata, curlvlObjects, myrect1, myrect2, myrect3, myrect4
    global curlevel, lvlObjects, propsperobj
    put item 2 of curlvldata into numobjects
    put "" into ret
    repeat with i = 1 to numobjects
        put (propsperobj * i) + 2 into j
        put rectIntersect(myrect1, myrect2, myrect3, myrect4, item j of curlvlObjects,item j+1 of curlvlObjects,item j+2 of curlvlObjects, item j+3 of curlvlObjects) into intersected
        if intersected != "0" then
            -- put (propsperobj * i) + 0 into j
            --put "|" i & "|" & item j of curlvlObjects & "|" & item j+6 of curlvlObjects & "|"& item j+7 of curlvlObjects & "|"& item j+8 of curlvlObjects & "|" after result
            put "|" & i after result
        end if
    end repeat
    if length(result) > 0 then
        -- delete initial |
        put char 2 to the number of chars in result into result
    end if
    return ret
end intersectRoomObject


on initmainloop
    global momentumx, momentumy
    global lastdirpressed, propsperobj
    put "" into lastdirpressed
    put 0 into momentumx
    put 0 into momentumy
    put 9 into propsperobj
    set the itemdel to "|"
    repeat with x = 1 to 16
        hide cd btn ("glider_sprite" & x)
    end repeat
    updateLevel
end initmainloop

on refreshOnLevelChange
    global curlevel
    repeat with x=1 to 16
        hide cd btn ("glider_sprites" & x)
    end repeat
    show cd btn "btn_continue"
    if curlevel is "" or curlevel is -1 then
        put -1 into curlevel
        set the icon of cd btn "glider_bg0" to 1
        set the rect of cd btn "btn_continue" to 422,48,422+123,48+74
        set the label of cd btn "btn_continue" to "New Game"
    else if curlevel is -2 then
        set the icon of cd btn "glider_bg0" to 2
        set the rect of cd btn "btn_continue" to 126,300,126+254,300+36
        set the label of cd btn "btn_continue" to "Start"
    else if curlevel is -3 then
        set the icon of cd btn "glider_bg0" to 3
        set the rect of cd btn "btn_continue" to 126,300,126+254,300+36
        set the label of cd btn "btn_continue" to "Back"
    else
        set the icon of cd btn "glider_bg0" to 3+curlevel
        hide cd btn "btn_continue"
        
    end if
end refreshOnLevelChange

function mainloop
    global momentumx, momentumy
    global lastdirpressed, curlevel, lvlData
    -- ideally, the hit box would be bigger to account for case when you are moving really fast
    -- and could warp through a solid object
    -- but we never go that fast, don't need it yet
    if lastdirpressed is "-1" then
        put -5 into dx
    else if lastdirpressed is "1" then
        put 5 into dx
    end if
    put line curlevel of lvlData into curlvldata
    put line curlevel of lvlObjects into curlvlObjects
    
    put item 3 of curlvldata into leftopen
    put item 4 of curlvldata into rghtopen
    put intersectRoomObject(curlvldata, curlvlObjects, the left of cd btn "glider", the top of cd btn "glider", the right of cd btn "glider", the bottom of cd btn "glider") into intersects
    put the number of items in intersects into numintersects
    put false into isdead
    repeat with i = 1 to numintersects
        getCollideResult objtypename, isOn, amount, extra
    end repeat
    
    if newx < 0 then
        if not isdead and leftopen != "0"
            put curlevel - 1 into 
        end if
    end if
    
end mainloop

on afterkeydown
    global lastdirpressed
    if keychar() is "ArrowLeft" then
        put "-1" into lastdirpressed
    else if keychar() is "ArrowLeft" then
        put "1" into lastdirpressed
    end if
end afterkeydown

