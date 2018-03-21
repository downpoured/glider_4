

-- cd btn "glider_bg0"
-- cd btn "glider_sprites1-16"
-- cd btn "glider_spritesme"
-- cd btn "glider_spritesshadow"
-- cd btn "btn_continue"
-- cd fld "roomname"
-- cd fld "score"
-- cd fld "lives"
-- cd fld "behindlives"
-- cd fld "gameover"
-- cd btn "glider_spriteslivesicon"

-- script of cd btn "btn_continue":

on mouseup
    global curlevel, state
    if curlevel is "needreset" then
        initSpriteConstantsAndLoadGameData
        initui
        put "nogame" into state
        put -1 into curlevel
        refreshOnLevelChange
    else if curlevel is "" or curlevel is -1 then
        initSpriteConstantsAndLoadGameData
        initui
        put "nogame" into state
        put -2 into curlevel
        refreshOnLevelChange
    else if curlevel is -2 then
        startnewgame
        refreshOnLevelChange
    else if curlevel is -3 then
        put "nogame" into state
        put -1 into curlevel
        refreshOnLevelChange
    end if
end mouseup

on startnewgame
    global cheat_invincible, state, curlevel, sprites_right_forward, sprites_shadoRght, clockcount
    global lastdirpressed, dy
    global levelsseen
    initSpriteConstantsAndLoadGameData
    put false into cheat_invincible
    put "playing" into state
    put 3 into cd fld "lives"
    put 0 into cd fld "score"
    put 1 into curlevel
    set the icon of cd btn "glider_spritesme" to sprites_right_forward
    set the icon of cd btn "glider_spritesshadow" to sprites_shadoRght
    set the topleft of cd btn "glider_spritesme" to 20, 20
    set the topleft of cd btn "glider_spritesshadow" to -400, -400
    put "" into lastdirpressed
    put "" into levelsseen
    put 1 into line 1 of levelsseen
    put 0 into dy
    put 0 into clockcount
end startnewgame

on initui
    global curlevel, sprites_right_forward
    set the style of cd btn "glider_bg0" to "transparent"
    set the showlabel of cd btn "glider_bg0" to false
    set the autohilite of cd btn "glider_bg0" to false
    set the style of cd fld "roomname" to "shadow"
    set the style of cd fld "score" to "shadow"
    set the style of cd fld "behindlives" to "shadow"
    set the style of cd fld "lives" to "transparent"
    set the style of cd btn "glider_spriteslivesicon" to "transparent"
    set the style of cd fld "gameover" to "shadow"
    set the defaulttextfont of cd fld "gameover" to "times"
    set the defaulttextsize of cd fld "gameover" to "18"
    set the textalign of cd fld "gameover" to "center"
    
    set the style of cd btn "glider_bg0" to "transparent"
    set the style of cd btn "glider_spritesme" to "transparent"
    set the style of cd btn "glider_spritesshadow" to "transparent"
    set the rect of cd btn "glider_bg0" to -1, -1, 515, 345
    set the rect of cd btn "glider_spritesme" to 0,0,48,20
    set the rect of cd btn "glider_spritesshadow" to 0,0,48,20
    
    put 20 into basey
    put 22 into h
    set the rect of cd fld "roomname" to 28-26, basey-18, 177, h
    set the rect of cd fld "score" to 245-26, basey-18, (245-26)+78, h
    set the rect of cd fld "behindlives" to 328-26, basey-18, (328-26)+207, h
    set the rect of cd fld "lives" to 395-26, basey-18, (395-26)+22, h
    set the rect of cd btn "glider_spriteslivesicon" to 419-26, basey-18, (419-26)+42, h
    set the rect of cd fld "gameover" to 23,23,23+451,23+236
    set the icon of cd btn "glider_spriteslivesicon" to sprites_right_forward
    set the showlabel of cd btn "glider_spriteslivesicon" to false
    
    set the locktext of cd fld "roomname" to true 
    set the locktext of cd fld "score" to true 
    set the locktext of cd fld "lives" to true 
    set the locktext of cd fld "behindlives" to true 
    set the locktext of cd fld "gameover" to true 
    
    repeat with x=1 to 16
        hide cd btn ("glider_sprites" & x)
        set the style of cd btn ("glider_sprites" & x) to "transparent"
        set the showlabel of cd btn ("glider_sprites" & x)  to false
        set the autohilite of cd btn ("glider_sprites" & x)  to false
        set the icon of cd btn ("glider_sprites" & x) to 0
    end repeat
    
    set the style of cd btn "btn_continue" to "osdefault"
    put -1 into curlevel
    refreshOnLevelChange
end initui



