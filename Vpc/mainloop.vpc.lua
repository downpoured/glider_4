
-- -- level data:
-- 1|roomname
-- 2|numberOObjects
-- 3|leftOpen
-- 4|rightOpen
-- 5|animateKind
-- 6|animateNumber
-- 7|animateDelay
-- 8|conditionCode
-- -- level objects:
-- 1|typename
-- 2|typynumber
-- 3|c1
-- 4|c2
-- 5|c3
-- 6|c4
-- 7|amount
-- 8|extra
-- 9|isOn


function intersectRoomObject curlvldata, curlvlObjects, myrect1, myrect2, myrect3, myrect4
    global curlevel, lvlObjects, propsperobj
    put item 2 of curlvldata into numobjects
    put "" into ret
    repeat with i = 1 to numobjects
        put (propsperobj * (i-1)) - 1 into j
        put rectIntersect(myrect1, myrect2, myrect3, myrect4, item (j+3) of curlvlObjects,item (j+4) of curlvlObjects,item (j+5) of curlvlObjects, item (j+6) of curlvlObjects) into intersected
        if intersected != "0" then
            put "|" & i after ret
        end if
    end repeat
    if length(ret) > 0 then
        -- delete initial |
        put char 2 to (the number of chars in ret) of ret into ret
    end if
    return ret
end intersectRoomObject




on mainloopgame_motion curlvldata, curlvlObjects
    global lastdirpressed, curlevel, lvlData
    global dx, dy
    if dy is "" then
        put 0 into dy
    end if
    if lastdirpressed is "-1" then
        add -5 to dx
    else if lastdirpressed is "1" then
        add 5 to dx
    end if
    set the topleft of cd btn "glider_spritesme" to (the left of cd btn "glider_spritesme" + dx), (the top of cd btn "glider_spritesme" + dy)
    set the topleft of cd btn "glider_spritesshadow" to (the left of cd btn "glider_spritesme" + dx), 320
end mainloopgame_motion

on mainloopgame_checkbounds curlvldata, curlvlObjects
    global lastdirpressed, curlevel, lvlData
    put (item 3 of curlvldata is 1) into leftopen
    put (item 4 of curlvldata is 1) into rghtopen
    if the bottom of cd btn "glider_spritesme" > 300 then
        begindeath
        set the bottom of cd btn "glider_spritesme" to 300
    else if the top of cd btn "glider_spritesme" < 30 then
        set the top of cd btn "glider_spritesme" to 30
    end if
    
    if the left of cd btn "glider_spritesme" <= 0 then
        if leftopen then
            beginloadlevel curlevel - 1
            set the topleft of cd btn "glider_spritesme" to 450,20
        else
            set the left of cd btn "glider_spritesme" to 0
        end if
    else if the right of cd btn "glider_spritesme" >= 511 then
        if rghtopen then
            beginloadlevel curlevel + 1
            set the topright of cd btn "glider_spritesme" to 20,20
        else
            set the right of cd btn "glider_spritesme" to 511
        end if
    end if
end mainloopgame_checkbounds

on newlevelbonus
    global levelsseen, curlevel
    if line (curlevel) of levelsseen is "" then
        put "1" into line (curlevel) of levelsseen
        add 200 to cd fld "score"
    end if
end newlevelbonus

on mainloopgame_collisions curlvldata, curlvlObjects
    global dx, dy, propsperobj
    
    put intersectRoomObject(curlvldata, curlvlObjects, the left of cd btn "glider_spritesme", the top of cd btn "glider_spritesme", the right of cd btn "glider_spritesme", the bottom of cd btn "glider_spritesme") into intersects
    put the number of items in intersects into numintersects
    put false into isdead
    
    put 0 into dx 
    put 5 into dy -- by default, we fall
    repeat with numintersect = 1 to numintersects
        put item (numintersect) of intersects into i
        put item (((i-1)*propsperobj)+(1-1)) of curlvlObjects into objtypename
        put item (((i-1)*propsperobj)+(7-1)) of curlvlObjects into amount
        put item (((i-1)*propsperobj)+(8-1)) of curlvlObjects into extra
        put item (((i-1)*propsperobj)+(9-1)) of curlvlObjects into isOn
        put getCollideResult(objtypename, isOn, amount, extra) into clr
        put item 1 of clr into collideType
        put item 2 of clr into collideAmt
        
        if collideType is "crashIt" then
            begindeath
        else if collideType is "moveIt" then
            -- not yet supported
        else if collideType is "liftIt" then
            put -5 into dy
        else if collideType is "dropIt" then
            put 5 into dy
        else if collideType is "burnIt" then
            begindeath
            set the icon of cd btn "glider_spritesme" to sprites_burnrght1
        else if collideType is "turnItLeft" then
            put -6 into dx
        else if collideType is "turnItRight" then
            put 6 into dx
        else if collideType is "lightIt" then
            -- not yet supported
        else if collideType is "zapIt" then
            if the icon of cd btn ("glider_sprites" & i) is sprites_outletspark1 then
                begindeath
            end if
        else if collideType is "airOnIt" then
            -- not yet supported
        else if collideType is "shredIt" then
            begindeath
        else if collideType is "upStar" then
            beginloadlevel collideAmt
        else if collideType is "dnStar" then
            beginloadlevel collideAmt
        else if collideType is "getitem_extraIt" then
            add 1 to cd fld "lives"
        else if collideType is "getitem_awardIt" then
            add 50 to cd fld "score"
        end if
        
        if "getitem_" is in collideType then
            -- hide it since it is gone
            put 0 into item (((i-1)*propsperobj)+(9-1)) of curlvlObjects
            hide cd btn ("glider_sprites" & i)
        end if
    end repeat
end mainloopgame_collisions

on mainloopgame
    global curlevel, lvlData, lvlObjects, dx, dy
    -- ideally, the hit box would be bigger to account for case when you are moving really fast
    -- and could warp through a solid object
    -- but we never go that fast, don't need it yet
    put line (curlevel) of lvlData into curlvldata
    put line (curlevel) of lvlObjects into curlvlObjects
    mainloopgame_collisions curlvldata, curlvlObjects
    mainloopgame_checkbounds curlvldata, curlvlObjects
    mainloopgame_motion curlvldata, curlvlObjects
    mainloopgame_periodic curlvldata, curlvlObjects
end mainloopgame

on mainloopgame_periodic curlvldata, curlvlObjects
    global clockcount, propsperobj
    add 1 to clockcount
    if clockcount mod 20 is 1 then
        put item 2 of curlvldata into numobjects
        repeat with i = 1 to numobjects
            put (propsperobj * (i-1)) - 1 into j
            put item (j+1) of curlvlObjects into objtypename
            if objtypename is "outlet" then
                if the icon of cd btn ("glider_sprites" & i) is sprites_outletspark1 then
                    set the icon of cd btn ("glider_sprites" & i) to sprites_outlet
                else
                    set the icon of cd btn ("glider_sprites" & i) to sprites_outletspark1
                end if
            end if
        end repeat
    end if
end mainloopgame_periodic

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

on mainlooploadinglevel
    global loadcount, state, curlevel
    if loadcount < 400 then
        put deathcount+1 into deathcount
        put "." after cd fld "roomname"
    else
        refreshOnLevelChange
        put "playing" into state
    end if
end mainlooploadinglevel

on beginloadlevel nextlevel
    global loadcount, state, curlevel
    newlevelbonus
    put nextlevel into curlevel
    if curlevel < 1 then
            put 1 into curlevel --sanity check
    else if curlevel > 40 then
            put 40 into curlevel --sanity check
    end if
    -- skipped levels we don't yet support
    if curlevel is 7 then
        put curlevel+1 into curlevel
    end if
    if curlevel is 13 then
        put curlevel+1 into curlevel
    end if
    if curlevel is 28 then
        put curlevel+1 into curlevel
    end if
    if curlevel is 29 then
        put curlevel+1 into curlevel
    end if
    if curlevel is 37 then
        put curlevel+1 into curlevel
    end if
    
    put 0 into loadcount
    put "Loading" into cd fld "roomname"
    put "loadinglevel" into state
end beginloadlevel

on mainloop
    global state
    if state is "playing" then
        mainloopgame
    else if state is "dying" then
        mainloopdying
    else if state is "loadinglevel" then
        mainlooploadinglevel
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
        if cheat_invincible is true then
            put false into cheat_invincible
        else
            put true into cheat_invincible
        end if
    else if keyChar() is "N" and shiftKey() then
        global curlevel, state
        put "needreset" into curlevel
        put "nogame" into state
        refreshOnLevelChange
        show cd btn "btn_continue"
        set the label of cd btn "btn_continue" to "Start Over"
    end if
end afterkeydown

on begindeath
    global state, deathcount, sprites_alldeadrght, cheat_invincible
    if cheat_invincible is not true then
        put "dying" into state
        put 0 into deathcount
        set the icon of cd btn "glider_spritesme" to sprites_alldeadrght
    end if
end begindeath

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
    set the itemdelimiter to "|"
    
--~     --temp
--~     answer "temp"
--~     hide cd btn "glider_bg0"
    
    
    hide cd fld "roomname"
    hide cd fld "score"
    hide cd fld "lives"
    hide cd fld "behindlives"
    hide cd btn "glider_spriteslivesicon"
    hide cd fld "gameover"
    
    show cd btn "btn_continue"
    if curlevel is "needreset" then
        exit refreshOnLevelChange
    else if curlevel is "" or curlevel is -1 then
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
        global sprites_shadoRght, sprites_shadoLft, sprites_right_forward, sprites_right_tipped, sprites_left_forward, sprites_left_tipped
        global sprites_turn_endpoint, sprites_right_forward2, sprites_right_tipped2, sprites_left_forward2, sprites_left_tipped2, sprites_turn_endpoint2
        global sprites_burnrght1, sprites_burnrght2, sprites_burnlft1, sprites_burnlft2, sprites_alldeadrght, sprites_alldeadlft
        global sprites_celVnt, sprites_celDct, sprites_flrVnt, sprites_paper, sprites_toastr, sprites_toast1
        global sprites_toast2, sprites_toast3, sprites_toast4, sprites_toast5, sprites_toast6, sprites_teaKtl
        global sprites_lftFan, sprites_ritFan, sprites_table, sprites_shredr, sprites_books, sprites_clock
        global sprites_candle, sprites_rbrBnd, sprites_ball, sprites_fshBwl, sprites_fish1, sprites_fish2
        global sprites_fish3, sprites_fish4, sprites_grease, sprites_greasefall1, sprites_greasefall2, sprites_litSwt
        global sprites_thermo, sprites_outlet, sprites_outletspark1, sprites_outletspark2, sprites_pwrSwt, sprites_guitar
        global sprites_drip, sprites_shelf, sprites_basket, sprites_paintg, sprites_battry, sprites_macTsh
        global sprites_upStar, sprites_dnStar, sprites_candleflame1, sprites_candleflame2, sprites_candleflame3, sprites_drop1
        global sprites_drop2, sprites_drop3, sprites_drop4, sprites_drop5
        show cd btn "glider_spritesme"
        show cd btn "glider_spritesshadow"
        show cd fld "roomname"
        show cd fld "score"
        show cd fld "lives"
        show cd fld "behindlives"
        hide cd btn "glider_spriteslivesicon"
        set the icon of cd btn "glider_bg0" to 3+curlevel
        hide cd btn "btn_continue"
        
        -- actually load the room
        global curlevel, lvlData, lvlObjects, dx, dy, propsperobj
        put line (curlevel) of lvlData into curlvldata
        put item 1 of curlvldata into cd fld "roomname"
        
        -- actually load the room's objects
        put line (curlevel) of lvlObjects into curlvlObjects
        put item 2 of curlvldata into numobjects
        repeat with i = 1 to numobjects
            put (propsperobj * (i-1)) - 1 into j
            set the rect of cd btn ("glider_sprites" & i) to item (j+3) of curlvlObjects,item (j+4) of curlvlObjects,item (j+5) of curlvlObjects, item (j+6) of curlvlObjects
            set the icon of cd btn ("glider_sprites" & i) to 0 -- invisible by default
            show cd btn ("glider_sprites" & i)
            put item (j+1) of curlvlObjects into objtypename
            if objtypename is "flrVnt" or objtypename is "celVnt" or objtypename is "celDct" then
                global sprites_ventpatterny
                set the icon of cd btn ("glider_sprites" & i) to sprites_ventpatterny
            else if objtypename is "outlet" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_outlet
            else if objtypename is "clock" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_clock
            else if objtypename is "battry" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_battry
            else if objtypename is "paper" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_paper
            
            -- bnsRct is a bonus rectangle
            else if objtypename is "litSwt" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_litSwt
            else if objtypename is "grease" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_grease
            else if objtypename is "rbrBnd" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_rbrBnd
            else if objtypename is "drip" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_drip
            else if objtypename is "shredr" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_shredr
            else if objtypename is "ball" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_ball
            else if objtypename is "fshBwl" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_fshBwl
            else if objtypename is "pwrSwt" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_pwrSwt
            else if objtypename is "thermo" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_thermo
            else if objtypename is "toastr" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_toastr
            else if objtypename is "teaKtl" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_teaKtl
            else if objtypename is "macTsh" then
                set the icon of cd btn ("glider_sprites" & i) to sprites_macTsh
            end if
        end repeat
    end if
end refreshOnLevelChange
