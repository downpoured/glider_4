

function rectIntersect x0, x1, y0, y1, boxx0, boxx1, boxy0, boxy1
    if (x0 >= boxx1 || y0 >= boxy1)  then
        -- it's way outside on the right or bottom
        return 0 -- no overlap
     else if (x1 < boxx0 || y1 < boxy0)  then
        -- it's way outside on the left or top
        return 0 -- no overlap
     else if (x0 >= boxx0 && x1 <= boxx1 && y0 >= boxy0 && y1 <= boxy1)  then
        return 1 -- CompletelyCovers;
     else if (boxx0 >= x0 && boxx1 <= x1 && boxy0 >= y0 && boxy1 <= y1)  then
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

