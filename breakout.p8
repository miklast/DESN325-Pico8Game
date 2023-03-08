pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
--breakout

ball_x=1 --ball
ball_dx=2
ball_y=33
ball_dy=2
ball_r=2

pad_x=52 --pad
pad_y=120
pad_dx=0
pad_w=24
pad_h=3
--pad_c=7


col=10

function _init()
    cls()
end

function _update()

    bpress=false --controller logic

    if btn(0) then
        pad_dx=-5
        bpress=true
        --pad_x-=5
    end
    if btn(1) then
        pad_dx=5
        bpress=true
        --pad_x+=5
    end
    if not(bpress) then
        pad_dx=pad_dx/1.7
    end

    pad_x+=pad_dx --pad movement


    ball_x+=ball_dx --ball movement
    ball_y+=ball_dy


    if ball_x > 127 or ball_x < 0 then --ball collision
        ball_dx = -ball_dx
        sfx(0)
    end

    if ball_y > 127 or ball_y < 0 then
        ball_dy = -ball_dy
        sfx(0)
    end

    pad_c=7
    if ball_box(pad_x,pad_y,pad_w,pad_h) then
        pad_c=8
    end
end

function _draw()
    cls()
    rectfill(0,0,127,127,1)
    circfill(ball_x,ball_y,ball_r,col)
    rectfill(pad_x,pad_y,pad_x+pad_w,pad_y+pad_h,pad_c)
end

function ball_box (box_x, box_y, box_w,box_h) --universial collision function
    if ball_y-ball_r > box_y+box_h then
        return false
    end
    if ball_y+ball_r < box_y then
        return false
    end
    if ball_x-ball_r > box_x+box_w then
        return false
    end
    if ball_x+ball_r < box_x then
        return false
    end
    return true
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0101000018350183501834018330183101830018300183000d500103000d5000d5000f3000f3000e3000e5000e5000f5000f5000f5000f500105001c5001b5001a50019500185001850017500175001650016500
