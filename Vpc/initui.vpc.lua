

--~ cd btn "glider_bg0"
--~ cd btn "glider_sprites1"
--~ cd btn "glider_sprites2"
--~ cd btn "glider_sprites3"
--~ cd btn "glider_sprites4"
--~ cd btn "glider_sprites5"
--~ cd btn "glider_sprites6"
--~ cd btn "glider_sprites7"
--~ cd btn "glider_sprites8"
--~ cd btn "glider_sprites9"
--~ cd btn "glider_sprites10"
--~ cd btn "glider_sprites11"
--~ cd btn "glider_sprites12"
--~ cd btn "glider_sprites13"
--~ cd btn "glider_sprites14"
--~ cd btn "glider_sprites15"
--~ cd btn "glider_sprites16"
--~ cd btn "glider_spritesme"
--~ cd btn "btn_continue"

-- lvl -1 is home
-- lvl -2 is tutorial1
-- lvl -3 is victory screen

on initui
    global curlevel
    set the style of cd btn "glider_bg0" to "transparent"
    set the showlabel of cd btn "glider_bg0" to false
    set the autohilite of cd btn "glider_bg0" to false
    
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
