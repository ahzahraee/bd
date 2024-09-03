function nfe = nextFallEdge(wr,nre,h)

row = nre;

while (wr(row) ~= 0 && row<h)
    row = row +1;
end

if (wr(row) == 0)
    nfe = row-1;
else
    nfe = h;
end