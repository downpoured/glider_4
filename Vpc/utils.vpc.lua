

function rectIntersect x0, x1, y0, y1, boxx0, boxx1, boxy0, boxy1
    if (x0 >= boxx1 or y0 >= boxy1)  then
        -- it's way outside on the right or bottom
        return 0 -- no overlap
     else if (x1 < boxx0 or y1 < boxy0)  then
        -- it's way outside on the left or top
        return 0 -- no overlap
     else if (x0 >= boxx0 and x1 <= boxx1 and y0 >= boxy0 and y1 <= boxy1)  then
        return 1 -- CompletelyCovers;
     else if (boxx0 >= x0 and boxx1 <= x1 and boxy0 >= y0 and boxy1 <= y1)  then
        return 2 -- CompletelyWithin;
     else
        return 3 -- PartialOverlap;
    end if
end rectIntersect

function getCollideResult objtypename, isOn, amount, extra
    put "" into resultpt1
    put "" into resultpt2
    put "/" & objtypename & "/" into objtypenametest
    if objtypenametest is in "/table/shelf/books/cabnet/obsRct/drip/toastr/ball/fshBwl/basket/macTsh/" then
        put "crashIt" into resultpt1
        return resultpt1 & "|" & resultpt2
    end if
            
    if objtypename == "extRct" then
        put "moveIt" into resultpt1
        put amount into resultpt2
    else if objtypename == "flrVnt" then
        put "liftIt" into resultpt1
    else if objtypename == "celVnt" then
        put "dropIt" into resultpt1
    else if objtypename == "celDct" then
        if (isOn) then
            put "dropIt" into resultpt1
        else
            put "moveIt" into resultpt1
            put extra into resultpt2
        end if
    else if objtypename == "candle" then
        put "burnIt" into resultpt1
    else if objtypename == "lftFan" then
        if (isOn) then
            put "turnItLeft" into resultpt1
        else
            put "ignoreIt" into resultpt1
        end if
    else if objtypename == "ritFan" then
        if (isOn) then
            put "turnItRight" into resultpt1
        else
            put "ignoreIt" into resultpt1
        end if
    else if objtypename == "clock" then
        put "getitem_awardIt" into resultpt1
        put amount into resultpt2
    else if objtypename == "paper" then
        put "getitem_extraIt" into resultpt1
        put amount into resultpt2
    else if objtypename == "grease" then
        if (isOn) then
            put "spillIt" into resultpt1
        else
            put "slideIt" into resultpt1
        end if
    else if objtypename == "bnsRct" then
        put "trickIt" into resultpt1
        put amount into resultpt2
    else if objtypename == "battry" then
        put "getitem_energizeIt" into resultpt1
        put amount into resultpt2
    else if objtypename == "rbrBnd" then
        put "getitem_bandIt" into resultpt1
        put amount into resultpt2
    else if objtypename == "litSwt" then
        put "lightIt" into resultpt1
    else if objtypename == "outlet" then
        put "zapIt" into resultpt1
    else if objtypename == "thermo" then
        put "airOnIt" into resultpt1
    else if objtypename == "shredr" then
        if (isOn) then
            put "shredIt" into resultpt1
        else
            put "ignoreIt" into resultpt1
        end if
    else if objtypename == "pwrSwt" then
        put "toggleIt" into resultpt1
        put amount into resultpt2 -- 	{object# linked to}
    else if objtypename == "guitar" then
        put "playIt" into resultpt1
        put "0" into resultpt2
    else if objtypename == "upStar" then
        put "ascendIt" into resultpt1
        put amount into resultpt2 -- {room # linked to}
    else if objtypename == "dnStar" then
        put "descendIt" into resultpt1
        put amount into resultpt2 -- {room # linked to}
    else
        put "ignoreIt" into resultpt1
    end if
    return resultpt1 & "|" & resultpt2
end getCollideResult

on initSpriteConstantsAndLoadGameData
    global sprites_ventpatternx, sprites_ventpatterny
    put 73 into sprites_ventpatternx -- not ready yet
    put 72 into sprites_ventpatterny

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
    put 2 into sprites_shadoRght
    put 3 into sprites_shadoLft
    put 4 into sprites_right_forward
    put 5 into sprites_right_tipped
    put 6 into sprites_left_forward
    put 7 into sprites_left_tipped
    put 8 into sprites_turn_endpoint
    put 9 into sprites_right_forward2
    put 10 into sprites_right_tipped2
    put 11 into sprites_left_forward2
    put 12 into sprites_left_tipped2
    put 13 into sprites_turn_endpoint2
    put 14 into sprites_burnrght1
    put 15 into sprites_burnrght2
    put 16 into sprites_burnlft1
    put 17 into sprites_burnlft2
    put 18 into sprites_alldeadrght
    put 19 into sprites_alldeadlft
    put 20 into sprites_celVnt
    put 21 into sprites_celDct
    put 22 into sprites_flrVnt
    put 23 into sprites_paper
    put 24 into sprites_toastr
    put 25 into sprites_toast1
    put 26 into sprites_toast2
    put 27 into sprites_toast3
    put 28 into sprites_toast4
    put 29 into sprites_toast5
    put 30 into sprites_toast6
    put 31 into sprites_teaKtl
    put 32 into sprites_lftFan
    put 33 into sprites_ritFan
    put 34 into sprites_table
    put 35 into sprites_shredr
    put 36 into sprites_books
    put 37 into sprites_clock
    put 38 into sprites_candle
    put 39 into sprites_rbrBnd
    put 40 into sprites_ball
    put 41 into sprites_fshBwl
    put 42 into sprites_fish1
    put 43 into sprites_fish2
    put 44 into sprites_fish3
    put 45 into sprites_fish4
    put 46 into sprites_grease
    put 47 into sprites_greasefall1
    put 48 into sprites_greasefall2
    put 49 into sprites_litSwt
    put 50 into sprites_thermo
    put 51 into sprites_outlet
    put 52 into sprites_outletspark1
    put 53 into sprites_outletspark2
    put 54 into sprites_pwrSwt
    put 55 into sprites_guitar
    put 56 into sprites_drip
    put 57 into sprites_shelf
    put 58 into sprites_basket
    put 59 into sprites_paintg
    put 60 into sprites_battry
    put 61 into sprites_macTsh
    put 62 into sprites_upStar
    put 63 into sprites_dnStar
    put 64 into sprites_candleflame1
    put 65 into sprites_candleflame2
    put 66 into sprites_candleflame3
    put 67 into sprites_drop1
    put 68 into sprites_drop2
    put 69 into sprites_drop3
    put 70 into sprites_drop4
    put 71 into sprites_drop5

    
    global lvlData, lvlObjects
    put "Welcome...|5|0|1|0|0|0|0" into line 1 of lvlData
    put "Top of the reading list|7|1|1|0|0|0|0" into line 2 of lvlData
    put "Under Me!|5|1|1|0|0|0|0" into line 3 of lvlData
    put "Looking at you...|6|1|1|0|0|0|0" into line 4 of lvlData
    put "You're invited...|6|1|1|2|1|1|0" into line 5 of lvlData
    put "Jane be nimble...|5|1|1|1|1|1|0" into line 6 of lvlData
    put "Hmm... a tall cabinet|7|1|1|0|0|0|0" into line 7 of lvlData
    put "Timing is the key...|9|1|1|0|0|0|0" into line 8 of lvlData
    put "More enemies...|8|1|1|0|1|2|0" into line 9 of lvlData
    put "Up a Down Staircase|4|1|1|1|1|1|0" into line 10 of lvlData
    put "Still on this floor...|9|1|1|0|0|0|2" into line 11 of lvlData
    put "Deeper still...|3|1|0|1|2|0|0" into line 12 of lvlData
    put "What, a bombshelter?|11|0|1|0|0|0|0" into line 13 of lvlData
    put "Power station...|7|1|1|1|1|0|2" into line 14 of lvlData
    put "This is the basement|6|1|1|0|0|0|0" into line 15 of lvlData
    put "Nothing here...|4|1|1|0|0|0|2" into line 16 of lvlData
    put "The Looking Glass|3|1|0|0|0|0|0" into line 17 of lvlData
    put "Welcome, 2nd Floor|7|0|1|0|0|0|0" into line 18 of lvlData
    put "Zis Room|11|1|1|0|0|0|0" into line 19 of lvlData
    put "This Old House...|6|1|1|0|0|0|0" into line 20 of lvlData
    put "The North Room|9|1|1|0|0|0|0" into line 21 of lvlData
    put "Windtunnels|8|1|1|0|0|0|0" into line 22 of lvlData
    put "Noisy Kids!|5|1|1|0|0|0|0" into line 23 of lvlData
    put "LeadFish|8|1|1|0|0|0|0" into line 24 of lvlData
    put "Air Steps|7|1|1|0|0|0|0" into line 25 of lvlData
    put "Fan Fun!|9|1|1|0|0|0|0" into line 26 of lvlData
    put "Stormy Weather...|10|1|1|0|0|0|2" into line 27 of lvlData
    put "Slippery when greasy...|7|1|1|0|0|0|0" into line 28 of lvlData
    put "Turn me on...|6|1|1|0|0|0|1" into line 29 of lvlData
    put "Finally!!!|6|1|1|0|0|0|0" into line 30 of lvlData
    put "Tempted...|7|1|1|0|0|0|0" into line 31 of lvlData
    put "Look Familiar?|6|1|0|0|0|0|0" into line 32 of lvlData
    put "You found me!|7|0|1|0|0|0|0" into line 33 of lvlData
    put "Welcome to Floor 3|6|1|1|1|2|1|0" into line 34 of lvlData
    put "A toaster?  Here?|8|1|1|0|0|0|0" into line 35 of lvlData
    put "The galley...|6|1|1|0|1|0|0" into line 36 of lvlData
    put "Wow - High Shelf!|10|1|1|0|0|0|0" into line 37 of lvlData
    put "Love these Candles...|10|1|1|0|0|0|0" into line 38 of lvlData
    put "Windy Room...|10|1|1|2|2|0|0" into line 39 of lvlData
    put "Monty Hall|11|1|0|0|0|0|0" into line 40 of lvlData
    put "" into line 1 of lvlObjects
    put "flrVnt|8|325|69|338|117|44|0|0|table|1|223|186|232|356|0|0|0|flrVnt|8|325|421|338|469|44|0|0|macTsh|" after line 1 of lvlObjects
    put "43|165|186|223|231|0|0|0|clock|16|194|322|223|354|500|0|0" after line 1 of lvlObjects
    put "" into line 2 of lvlObjects
    put "flrVnt|8|325|60|338|108|44|0|0|shelf|2|112|181|119|368|0|0|0|books|3|58|183|113|247|0|0|0|flrVnt|8|3" after line 2 of lvlObjects
    put "25|394|338|442|44|0|0|clock|16|84|336|113|368|600|0|0|books|3|58|245|113|309|0|0|0|paintg|40|80|45|1" after line 2 of lvlObjects
    put "73|147|0|0|0" after line 2 of lvlObjects
    put "" into line 3 of lvlObjects
    put "flrVnt|8|325|53|338|101|44|0|0|table|1|178|209|187|408|0|0|0|flrVnt|8|325|345|338|393|208|0|0|flrVnt" after line 3 of lvlObjects
    put "|8|325|453|338|501|44|0|0|clock|16|149|211|178|243|700|0|0" after line 3 of lvlObjects
    put "" into line 4 of lvlObjects
    put "flrVnt|8|325|47|338|95|44|0|0|cabnet|4|220|121|318|312|0|0|0|flrVnt|8|325|337|338|385|44|0|0|shelf|2" after line 4 of lvlObjects
    put "|87|206|94|306|0|0|0|battry|20|63|291|89|309|50|0|0|mirror|41|61|13|207|182|0|0|0" after line 4 of lvlObjects
    put "" into line 5 of lvlObjects
    put "flrVnt|8|325|45|338|93|44|0|0|table|1|218|159|227|325|0|0|0|flrVnt|8|325|423|338|471|44|0|0|clock|16" after line 5 of lvlObjects
    put "|189|157|218|189|800|0|0|cabnet|4|37|260|103|383|0|0|0|window|37|73|20|224|141|0|0|0" after line 5 of lvlObjects
    put "" into line 6 of lvlObjects
    put "flrVnt|8|325|38|338|86|44|0|0|table|1|224|104|233|384|0|0|0|candle|11|203|215|224|247|57|0|0|flrVnt|" after line 6 of lvlObjects
    put "8|325|434|338|482|44|0|0|books|3|170|264|225|328|0|0|0" after line 6 of lvlObjects
    put "" into line 7 of lvlObjects
    put "flrVnt|8|325|58|338|106|44|0|0|celDct|10|24|37|37|85|57|7|0|celDct|10|24|388|37|436|109|7|1|cabnet|4" after line 7 of lvlObjects
    put "|120|167|318|357|0|0|0|flrVnt|8|325|446|338|494|44|0|0|paper|17|99|291|120|339|1500|0|0|bnsRct|19|88" after line 7 of lvlObjects
    put "|256|120|288|1500|0|0" after line 7 of lvlObjects
    put "" into line 8 of lvlObjects
    put "table|1|237|154|246|284|0|0|0|shelf|2|144|268|151|418|0|0|0|clock|16|116|270|145|302|1000|0|0|outlet" after line 8 of lvlObjects
    put "|25|191|255|216|287|300|0|0|flrVnt|8|325|84|338|132|44|0|0|flrVnt|8|325|446|338|494|44|0|0|books|3|9" after line 8 of lvlObjects
    put "1|352|146|416|0|0|0|guitar|29|153|296|323|360|0|0|0|bnsRct|19|57|353|89|417|1000|0|0" after line 8 of lvlObjects
    put "" into line 9 of lvlObjects
    put "celVnt|9|24|191|36|239|193|0|0|flrVnt|8|325|56|338|104|44|0|0|flrVnt|8|325|382|338|430|44|0|0|books|" after line 9 of lvlObjects
    put "3|141|111|196|175|0|0|0|cabnet|4|263|251|323|351|0|0|0|cabnet|4|194|114|325|250|0|0|0|bnsRct|19|35|3" after line 9 of lvlObjects
    put "76|67|440|1000|0|0|clock|16|165|219|194|251|1000|0|0" after line 9 of lvlObjects
    put "" into line 10 of lvlObjects
    put "upStar|44|54|224|308|385|18|0|0|flrVnt|8|325|31|338|79|44|0|0|flrVnt|8|325|275|338|323|44|0|0|table|" after line 10 of lvlObjects
    put "1|228|108|237|219|0|0|0" after line 10 of lvlObjects
    put "" into line 11 of lvlObjects
    put "shelf|2|140|93|147|195|0|0|0|shelf|2|129|303|136|488|0|0|0|books|3|76|333|131|397|0|0|0|flrVnt|8|325" after line 11 of lvlObjects
    put "|20|338|68|44|0|0|flrVnt|8|325|412|338|460|161|0|0|clock|16|149|206|178|238|2000|0|0|table|1|221|138" after line 11 of lvlObjects
    put "|230|267|0|0|0|litSwt|24|97|119|123|137|0|0|0|paper|17|109|439|130|487|2000|0|0" after line 11 of lvlObjects
    put "" into line 12 of lvlObjects
    put "dnStar|45|54|149|308|310|15|0|0|flrVnt|8|325|24|338|72|44|0|0|paintg|40|69|26|162|128|0|0|0" after line 12 of lvlObjects
    put "" into line 13 of lvlObjects
    put "cabnet|4|216|34|325|96|0|0|0|ritFan|13|163|51|217|86|157|0|1|flrVnt|8|325|127|338|175|44|0|0|cabnet|" after line 13 of lvlObjects
    put "4|264|174|328|481|0|0|0|grease|18|236|171|265|203|478|0|1|clock|16|236|431|265|463|3000|0|0|paper|17" after line 13 of lvlObjects
    put "|244|381|265|429|2000|0|0|battry|20|240|359|266|377|80|0|0|rbrBnd|21|242|321|265|353|4|0|0|clock|16|" after line 13 of lvlObjects
    put "236|289|265|321|1000|0|0|battry|20|240|271|266|289|40|0|0" after line 13 of lvlObjects
    put "" into line 14 of lvlObjects
    put "outlet|25|139|220|164|252|80|0|0|litSwt|24|139|293|165|311|0|0|0|flrVnt|8|325|50|338|98|44|0|0|outle" after line 14 of lvlObjects
    put "t|25|141|352|166|384|120|0|0|celDct|10|24|46|37|94|98|14|0|flrVnt|8|325|435|338|483|44|0|0|celDct|10" after line 14 of lvlObjects
    put "|24|398|37|446|141|14|1" after line 14 of lvlObjects
    put "" into line 15 of lvlObjects
    put "upStar|44|54|155|308|316|12|0|0|table|1|263|25|272|150|0|0|0|candle|11|243|111|264|143|44|0|0|flrVnt" after line 15 of lvlObjects
    put "|8|325|421|338|469|44|0|0|shelf|2|167|332|174|413|0|0|0|lftFan|12|113|371|168|406|140|0|1" after line 15 of lvlObjects
    put "" into line 16 of lvlObjects
    put "litSwt|24|205|172|231|190|0|0|0|drip|32|192|237|205|253|320|120|0|table|1|230|13|239|113|0|0|0|ritFa" after line 16 of lvlObjects
    put "n|13|177|12|231|47|512|0|1" after line 16 of lvlObjects
    put "" into line 17 of lvlObjects
    put "flrVnt|8|325|31|338|79|44|0|0|extRct|5|111|382|246|430|24|0|0|mirror|41|84|359|270|451|0|0|0" after line 17 of lvlObjects
    put "" into line 18 of lvlObjects
    put "dnStar|45|54|187|308|348|10|0|0|flrVnt|8|325|248|338|296|44|0|0|basket|42|247|97|318|160|0|0|0|table" after line 18 of lvlObjects
    put "|1|230|358|239|458|0|0|0|clock|16|202|426|231|458|1000|0|0|bnsRct|19|240|377|272|441|1000|0|0|paintg" after line 18 of lvlObjects
    put "|40|66|384|159|486|0|0|0" after line 18 of lvlObjects
    put "" into line 19 of lvlObjects
    put "flrVnt|8|325|11|338|59|44|0|0|celDct|10|24|67|37|115|305|19|1|shelf|2|151|155|158|255|0|0|0|shelf|2|" after line 19 of lvlObjects
    put "161|326|168|388|0|0|0|books|3|107|325|162|389|0|0|0|table|1|223|262|232|391|0|0|0|flrVnt|8|325|257|3" after line 19 of lvlObjects
    put "38|305|255|0|0|flrVnt|8|325|405|338|453|44|0|0|bnsRct|19|171|324|203|356|5000|0|0|paper|17|131|208|1" after line 19 of lvlObjects
    put "52|256|1000|0|0|bnsRct|19|142|258|174|322|1000|0|0" after line 19 of lvlObjects
    put "" into line 20 of lvlObjects
    put "flrVnt|8|325|38|338|86|44|0|0|celDct|10|24|37|37|85|57|19|0|cabnet|4|199|162|323|275|0|0|0|clock|16|" after line 20 of lvlObjects
    put "171|155|200|187|1000|0|0|flrVnt|8|325|277|338|325|44|0|0|drip|32|38|386|51|402|318|120|0" after line 20 of lvlObjects
    put "" into line 21 of lvlObjects
    put "flrVnt|8|325|60|338|108|44|0|0|shelf|2|96|200|103|361|0|0|0|pwrSwt|28|197|158|223|176|5|0|0|shelf|2|" after line 21 of lvlObjects
    put "185|157|192|257|0|0|0|shredr|27|184|260|208|324|0|0|1|rbrBnd|21|73|198|96|230|3|0|0|cabnet|4|75|376|" after line 21 of lvlObjects
    put "183|480|0|0|0|flrVnt|8|325|363|338|411|210|0|0|bnsRct|19|193|213|225|245|1000|0|0" after line 21 of lvlObjects
    put "" into line 22 of lvlObjects
    put "flrVnt|8|325|63|338|111|44|0|0|shelf|2|115|173|122|422|0|0|0|ritFan|13|189|182|243|217|512|0|1|lftFa" after line 22 of lvlObjects
    put "n|12|60|388|115|423|227|0|1|paper|17|94|345|115|393|1000|0|0|flrVnt|8|325|443|338|491|44|0|0|pwrSwt|" after line 22 of lvlObjects
    put "28|126|410|152|428|4|0|0|cabnet|4|242|172|327|363|0|0|0" after line 22 of lvlObjects
    put "" into line 23 of lvlObjects
    put "flrVnt|8|325|42|338|90|44|0|0|table|1|222|146|231|270|0|0|0|ball|34|190|207|222|239|44|0|0|ball|34|2" after line 23 of lvlObjects
    put "93|290|325|322|44|0|0|flrVnt|8|325|375|338|423|44|0|0" after line 23 of lvlObjects
    put "" into line 24 of lvlObjects
    put "flrVnt|8|325|58|338|106|44|0|0|cabnet|4|161|110|321|221|0|0|0|table|1|226|226|235|326|0|0|0|flrVnt|8" after line 24 of lvlObjects
    put "|325|420|338|468|44|0|0|rbrBnd|21|204|294|227|326|4|0|0|fshBwl|35|198|226|227|258|44|120|0|paper|17|" after line 24 of lvlObjects
    put "141|177|162|225|1000|0|0|books|3|107|113|162|177|0|0|0" after line 24 of lvlObjects
    put "" into line 25 of lvlObjects
    put "flrVnt|8|325|41|338|89|215|0|0|table|1|188|57|197|227|0|0|0|clock|16|161|181|190|213|1000|0|0|flrVnt" after line 25 of lvlObjects
    put "|8|325|241|338|289|128|0|0|table|1|231|302|240|412|0|0|0|drip|32|38|215|51|231|324|120|0|flrVnt|8|32" after line 25 of lvlObjects
    put "5|459|338|507|44|0|0" after line 25 of lvlObjects
    put "" into line 26 of lvlObjects
    put "shelf|2|186|32|193|294|0|0|0|ritFan|13|133|42|187|77|341|0|0|flrVnt|8|325|373|338|421|154|0|0|pwrSwt" after line 26 of lvlObjects
    put "|28|99|120|125|138|2|0|0|lftFan|12|202|458|257|493|88|0|0|shelf|2|256|431|263|511|0|0|0|pwrSwt|28|15" after line 26 of lvlObjects
    put "6|486|182|504|5|0|0|paper|17|307|65|328|113|1000|0|0|paper|17|307|112|328|160|1000|0|0" after line 26 of lvlObjects
    put "" into line 27 of lvlObjects
    put "flrVnt|8|325|13|338|61|44|0|0|flrVnt|8|325|227|338|275|44|0|0|cabnet|4|198|86|321|215|0|0|0|clock|16" after line 27 of lvlObjects
    put "|170|92|199|124|1000|0|0|litSwt|24|162|385|188|403|0|0|0|books|3|157|438|212|502|0|0|0|flrVnt|8|325|" after line 27 of lvlObjects
    put "372|338|420|217|0|0|table|1|210|375|219|509|0|0|0|celVnt|9|24|277|36|325|305|0|0|window|37|84|224|23" after line 27 of lvlObjects
    put "6|354|0|0|0" after line 27 of lvlObjects
    put "" into line 28 of lvlObjects
    put "flrVnt|8|325|24|338|72|44|0|0|cabnet|4|188|84|321|393|0|0|0|grease|18|159|82|188|114|392|0|1|ball|34" after line 28 of lvlObjects
    put "|157|202|189|234|96|0|0|clock|16|170|397|199|429|1000|0|0|flrVnt|8|325|424|338|472|44|0|0|paintg|40|" after line 28 of lvlObjects
    put "62|259|155|361|0|0|0" after line 28 of lvlObjects
    put "" into line 29 of lvlObjects
    put "guitar|29|151|131|321|195|0|0|0|thermo|26|170|215|197|233|0|0|0|flrVnt|8|325|41|338|89|44|0|0|flrVnt" after line 29 of lvlObjects
    put "|8|325|269|338|317|44|0|0|shelf|2|84|354|91|419|0|0|0|rbrBnd|21|62|357|85|389|2|0|0" after line 29 of lvlObjects
    put "" into line 30 of lvlObjects
    put "fshBwl|35|171|168|200|200|44|80|0|cabnet|4|62|279|141|486|0|0|0|flrVnt|8|325|327|338|375|162|0|0|flr" after line 30 of lvlObjects
    put "Vnt|8|325|19|338|67|44|0|0|outlet|25|159|244|184|276|80|0|0|mirror|41|58|88|160|179|0|0|0" after line 30 of lvlObjects
    put "" into line 31 of lvlObjects
    put "upStar|44|54|60|308|221|34|0|0|cabnet|4|71|237|325|361|0|0|0|table|1|221|417|230|511|0|0|0|flrVnt|8|" after line 31 of lvlObjects
    put "325|365|338|413|44|0|0|paper|17|201|416|222|464|1000|0|0|rbrBnd|21|199|480|222|512|5|0|0|flrVnt|8|32" after line 31 of lvlObjects
    put "5|105|338|153|44|0|0" after line 31 of lvlObjects
    put "" into line 32 of lvlObjects
    put "upStar|44|54|30|308|191|35|0|0|flrVnt|8|325|91|338|139|44|0|0|cabnet|4|219|217|320|426|0|0|0|candle|" after line 32 of lvlObjects
    put "11|199|222|220|254|74|0|0|battry|20|195|408|221|426|40|0|0|flrVnt|8|325|426|338|474|44|0|0" after line 32 of lvlObjects
    put "" into line 33 of lvlObjects
    put "flrVnt|8|325|59|338|107|44|0|0|celDct|10|24|56|37|104|305|34|0|flrVnt|8|325|438|338|486|44|0|0|cabne" after line 33 of lvlObjects
    put "t|4|137|321|324|431|0|0|0|table|1|238|202|247|316|0|0|0|clock|16|109|319|138|351|1000|0|0|paper|17|2" after line 33 of lvlObjects
    put "18|204|239|252|1000|0|0" after line 33 of lvlObjects
    put "" into line 34 of lvlObjects
    put "dnStar|45|54|139|308|300|31|0|0|flrVnt|8|325|209|338|257|44|0|0|celDct|10|24|65|37|113|305|34|1|shel" after line 34 of lvlObjects
    put "f|2|188|321|195|421|0|0|0|clock|16|160|390|189|422|1000|0|0|flrVnt|8|325|447|338|495|44|0|0" after line 34 of lvlObjects
    put "" into line 35 of lvlObjects
    put "dnStar|45|54|5|308|166|32|0|0|flrVnt|8|325|182|338|230|44|0|0|toastr|33|304|379|331|417|114|120|0|sh" after line 35 of lvlObjects
    put "elf|2|105|332|112|490|0|0|0|clock|16|173|410|202|442|1000|0|0|flrVnt|8|325|460|338|508|201|0|0|table" after line 35 of lvlObjects
    put "|1|201|410|210|510|0|0|0|books|3|52|343|107|407|0|0|0" after line 35 of lvlObjects
    put "" into line 36 of lvlObjects
    put "flrVnt|8|325|54|338|102|44|0|0|outlet|25|175|128|200|160|120|0|0|flrVnt|8|325|354|338|402|146|0|0|ca" after line 36 of lvlObjects
    put "bnet|4|25|335|115|457|0|0|0|teaKtl|36|172|436|202|477|120|0|0|cabnet|4|25|148|81|209|0|0|0" after line 36 of lvlObjects
    put "" into line 37 of lvlObjects
    put "shelf|2|95|132|102|448|0|0|0|flrVnt|8|325|73|338|121|76|0|0|grease|18|67|134|96|166|448|0|1|celDct|1" after line 37 of lvlObjects
    put "0|24|256|37|304|73|37|1|paper|17|75|321|96|369|1000|0|0|clock|16|67|368|96|400|1000|0|0|rbrBnd|21|73" after line 37 of lvlObjects
    put "|399|96|431|5|0|0|flrVnt|8|325|326|338|374|96|0|0|battry|20|70|302|96|320|40|0|0|books|3|42|177|97|2" after line 37 of lvlObjects
    put "41|0|0|0" after line 37 of lvlObjects
    put "" into line 38 of lvlObjects
    put "flrVnt|8|325|53|338|101|44|0|0|flrVnt|8|325|305|338|353|115|0|0|table|1|169|136|178|281|0|0|0|shelf|" after line 38 of lvlObjects
    put "2|90|136|97|469|0|0|0|books|3|115|141|170|205|0|0|0|table|1|225|359|234|493|0|0|0|candle|11|204|393|" after line 38 of lvlObjects
    put "225|425|116|0|0|clock|16|141|248|170|280|1000|0|0|books|3|37|180|92|244|0|0|0|paper|17|70|423|91|471" after line 38 of lvlObjects
    put "|1000|0|0" after line 38 of lvlObjects
    put "" into line 39 of lvlObjects
    put "flrVnt|8|325|11|338|59|44|0|0|flrVnt|8|325|446|338|494|44|0|0|flrVnt|8|325|243|338|291|44|0|0|celVnt" after line 39 of lvlObjects
    put "|9|24|103|36|151|325|0|0|celVnt|9|24|150|36|198|325|0|0|celVnt|9|24|197|36|245|325|0|0|celVnt|9|24|2" after line 39 of lvlObjects
    put "87|36|335|325|0|0|celVnt|9|24|335|36|383|325|0|0|celVnt|9|24|383|36|431|325|0|0|paintg|40|68|212|161" after line 39 of lvlObjects
    put "|314|0|0|0" after line 39 of lvlObjects
    put "" into line 40 of lvlObjects
    put "celDct|10|24|35|37|83|305|31|1|celDct|10|24|127|37|175|66|36|0|celDct|10|24|221|37|269|67|37|0|celDc" after line 40 of lvlObjects
    put "t|10|24|313|37|361|64|41|0|celDct|10|24|398|37|446|57|40|0|flrVnt|8|325|126|338|174|44|0|0|flrVnt|8|" after line 40 of lvlObjects
    put "325|218|338|266|44|0|0|flrVnt|8|325|311|338|359|44|0|0|flrVnt|8|325|396|338|444|44|0|0|cabnet|4|213|" after line 40 of lvlObjects
    put "11|324|76|0|0|0|paper|17|193|29|214|77|1000|0|0" after line 40 of lvlObjects
end initSpriteConstantsAndLoadGameData

