local modelos = {
["11"] = 11;
["22"] = 22;
["24"] = 24;
["25"] = 25;
["31"] = 31;
["32"] = 32;
["34"] = 34;
["35"] = 35;
["39"] = 39;
["43"] = 43;
["44"] = 44;
["54"] = 54;
["63"] = 63;
["67"] = 67;
["71"] = 71;
["77"] = 77;
["82"] = 82;
["83"] = 83;
["84"] = 84;
["87"] = 87;
["121"] = 121;
["122"] = 122;
["129"] = 129;
["131"] = 131;
["132"] = 132;
["133"] = 133;
["134"] = 134;
["135"] = 135;
["155"] = 155;
["162"] = 162;
["167"] = 167;
["183"] = 183;
["190"] = 190;
["196"] = 196;
["197"] = 197;
["199"] = 199;
["202"] = 202;
["206"] = 206;
["213"] = 213;
["214"] = 214;
["218"] = 218;
["235"] = 235;
["265"] = 265;
["267"] = 267;
["279"] = 279;
["280"] = 280;
["281"] = 281;
["282"] = 282;
["283"] = 283;
["284"] = 284;
["298"] = 298;
["304"] = 304;
["311"] = 311;
["427"] = 427;
["502"] = 502;
["503"] = 503;
["523"] = 523;
["528"] = 528;
["490"] = 490;
["597"] = 597;
["598"] = 598;
["599"] = 599;
["601"] = 601;
["416"] = 416;
--- Ejemplo --->
}


function cargarModelos()
    for i,v in pairs(modelos) do
        local tex = engineLoadTXD("modelos/"..i..".txd", v);
        engineImportTXD(tex, v);
        local mod = engineLoadDFF("modelos/"..i..".dff", v); 
        engineReplaceModel(mod, v);
    end
end
addEventHandler("onClientResourceStart", resourceRoot, cargarModelos)