
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
            put "|" & i after result
        end if
    end repeat
    if length(result) > 0 then
        -- delete initial |
        put char 2 to the number of chars in result into result
    end if
    return ret
end intersectRoomObject




on mainloopgame_motion
    global lastdirpressed, curlevel, lvlData
    global dy
    if dy is "" then
        put 0 into dy
    end if
    if lastdirpressed is "-1" then
        put -5 into dx
    else if lastdirpressed is "1" then
        put 5 into dx
    end if
    set the topleft of cd btn "glider_spritesme" to (the left of cd btn "glider_spritesme" + dx), (the top of cd btn "glider_spritesme" + dy)
end mainloopgame_motion

on mainloopgame_collisions
    global dy
    put line curlevel of lvlData into curlvldata
    put line curlevel of lvlObjects into curlvlObjects
    
    put item 3 of curlvldata into leftopen
    put item 4 of curlvldata into rghtopen
    put intersectRoomObject(curlvldata, curlvlObjects, the left of cd btn "glider_spritesme", the top of cd btn "glider_spritesme", the right of cd btn "glider_spritesme", the bottom of cd btn "glider_spritesme") into intersects
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
end mainloopgame_collisions

on mainloopgame
    global curlevel, lvlData, dy
    -- ideally, the hit box would be bigger to account for case when you are moving really fast
    -- and could warp through a solid object
    -- but we never go that fast, don't need it yet
    mainloopgame_collisions
    mainloopgame_motion
end mainloopgame

on mainloopdying
    global deathcount, state, curlevel
    if deathcount < 400 then
        put deathcount+1 into deathcount
    else
        subtract 1 from cd fld "lives"
        if cd fld "lives" < 0 then
            put "nogame" into state
            put -3 into curlevel
            refreshOnLevelChange
        else
            set the topleft of cd btn "glider_spritesme" to 20,20
            set the icon of cd btn "glider_spritesme" to sprites_right_forward
            put "playing" into state
        end if
    end if
end mainloopdying


on mainloop
    global state
    if state is "playing" then
        mainloopgame
    else if state is "dying" then
        mainloopdying
    end if
end mainloop

on idle
    mainloop
end idle

on afterkeydown
    global lastdirpressed, cheat_invincible
    if keychar() is "ArrowLeft" then
        put "-1" into lastdirpressed
    else if keychar() is "ArrowLeft" then
        put "1" into lastdirpressed
    else if keyChar() is "I" and shiftKey() then
        answer "toggle cheatcode:invincible"
    end if
end afterkeydown


on refreshOnLevelChange
    global curlevel
    repeat with x=1 to 16
        hide cd btn ("glider_sprites" & x)
    end repeat
    hide cd btn "glider_spritesme"
    hide cd btn "glider_spritesshadow"
    
    global lastdirpressed, propsperobj
    put "" into lastdirpressed
    put 9 into propsperobj
    set the itemdel to "|"
    
    hide cd fld "roomname"
    hide cd fld "score"
    hide cd fld "lives"
    hide cd fld "behindlives"
    hide cd btn "glider_spriteslivesicon"
    hide cd fld "gameover"
    
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
        if cd fld "lives" > 0 then
            hide cd fld "gameover"
        else
            show cd fld "gameover"
            put "Game Over..." & newline & newline & "Your score was "& (cd fld "score") & "." into fld "gameover"
        end if
    else
        show cd btn "glider_spritesme"
        show cd btn "glider_spritesshadow"
        show cd fld "roomname"
        show cd fld "score"
        show cd fld "lives"
        show cd fld "behindlives"
        hide cd btn "glider_spriteslivesicon"
        set the icon of cd btn "glider_bg0" to 3+curlevel
        hide cd btn "btn_continue"
    end if
end refreshOnLevelChange
