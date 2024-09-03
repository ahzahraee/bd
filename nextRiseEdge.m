function nre = nextRiseEdge(wm,index0, l)

i = index0;

while(wm(i) == 0 && i<l)
    i = i+1;
end

if wm(i) == 0
    nre = -1;
else
    nre = i;
end