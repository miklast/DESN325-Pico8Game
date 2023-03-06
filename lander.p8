pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
function _init()
    g=0.025 --gravity
    make_player()
    make_ground()
end

function _update()
    move_player()
end

function _draw()
    cls()
    draw_stars()
    draw_player()
    draw_ground()
end

function make_player()
    p={}
    p.x=60 --position
    p.y=8
    p.dx=0 --movement
    p.dy=0;
    p.sprite=1;
    p.thrust=0.075
end
function draw_player()
    spr(p.sprite,p.x,p.y)
    pal(12, 8)

end

function move_player()
    p.dy+=g --add gravity

    thrust()

    p.x=p.dx --player move
    p.y=p.dy

    stay_on_screen()
end

function thrust()
    --add thrust
    if (btn(0)) p.dx-=p.thrust
    if (btn(1)) p.dx+=p.thrust
    if (btn(2)) p.dy-=p.thrust
    
    --thrust sound
    if (btn(0) or btn(1) or btn(2)) sfx(0)
end

function stay_on_screen() 
    if (p.x<0) then --left side
        p.x=0
        p.dx=0
    end
    if (p.x>119) then --right side
        p.x=119
        p.dx=0
    end
    if (p.y<0) then
        p.y=0
        p.dy=0
    end
end

function rndb(low, high)
    return flr(rnd(high-low+1)+low)
end

function draw_stars()
    srand(1)
    for i=1, 50 do
        pset(rndb(0,127), rndb(0,127), rndb(5,7))
    end
    srand(time())
end

function make_ground()
--create the ground
gnd={}
local top=96 --highest point
local btm=120 --lowest point
--set up the landing pad
pad={}
pad.width=15
pad.x=rndb(0,126-pad.width)
pad.y=rndb(top,btm)
pad.sprite=2
--create ground at pad
for i=pad.x,pad.x+pad.width do
gnd[i]=pad.y
end
--create ground right of pad
for i=pad.x+pad.width+1,127 do
local h=rndb(gnd[i-1]-3,gnd[i-1]+3)
gnd[i]=mid(top,h,btm)
end
--create ground left of pad
for i=pad.x-1,0,-1 do
local h=rndb(gnd[i+1]-3,gnd[i+1]+3)
gnd[i]=mid(top,h,btm)
end
end
function draw_ground()
for i=0,127 do
line(i,gnd[i],i,127,5)
end
spr(pad.sprite, pad.x, pad.y, 2,1)
end


__gfx__
0000000000666600761dddddddddd766000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000066c76607666666666666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070066ccc7660076666666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700066cccc660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000665555660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700066666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000050550500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000660660660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000007650040000600005650050000300003650030000200002650030000300001650020000200003650036500660004600056000660006600056000560003600036000560007600096000000000000
