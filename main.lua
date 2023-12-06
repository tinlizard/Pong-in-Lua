local paddle1 = {
    x = 5,
    y=50,
    width=20,
    height=120,
    score = 0
}

local paddle2 = {
    x=775,
    y=50,
    width=20,
    height=120,
    score = 0
}
local ball = {
    x=400,
    y=100,
    radius=10,
    offset=1
}

--generate -1 or 1 randomly
function random_num()
    local one = 1
    math.randomseed(os.time())
    local num = math.random(2)
    if num % 2 == 0 then
        one = 1
    else
        one = -1
    end
    return one
end

function love.load()
    love.window.setTitle("Pong")
end

function IsBallColliding()
    -- Collision with Paddle 1
    if ball.x - ball.radius <= paddle1.x + paddle1.width and
       ball.x + ball.radius >= paddle1.x and
       ball.y + ball.radius >= paddle1.y and
       ball.y - ball.radius <= paddle1.y + paddle1.height then
        return true
    end

    -- Collision with Paddle 2
    if ball.x + ball.radius >= paddle2.x and
       ball.x - ball.radius <= paddle2.x + paddle2.width and
       ball.y + ball.radius >= paddle2.y and
       ball.y - ball.radius <= paddle2.y + paddle2.height then
        return true
    end

    return false
end


function love.draw()
    love.graphics.rectangle("fill", paddle1.x, paddle1.y, paddle1.width, paddle1.height)
    love.graphics.rectangle("fill", paddle2.x, paddle2.y, paddle2.width, paddle2.height)
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
    local padddle_1_score_str = tostring(paddle1.score)
    local paddle_2_score_str = tostring(paddle2.score) 
    local font = love.graphics.newFont(24)
    love.graphics.setFont(font)
    love.graphics.print(padddle_1_score_str,10,10)
    love.graphics.print(paddle_2_score_str,770,10)
end


local one = random_num()

--reverse ball direction
function reverse_direction()
    local randomPosOrNeg = random_num()
    ball.offset = randomPosOrNeg
    one = -one
end

--reset ball position
function ResetPosition(paddle)
    paddle.score = paddle.score+1
    ball.x = 400
    ball.y = 100
    reverse_direction()
end

function love.update(dt)
    ball.x = ball.x+one
    ball.y = ball.y+ball.offset
    local colliding = IsBallColliding()
    if love.keyboard.isDown("w") then
        paddle1.y = paddle1.y-1.3
    end
    if love.keyboard.isDown("s") then
        paddle1.y = paddle1.y+1.3
    end
    if love.keyboard.isDown("up")then
        paddle2.y = paddle2.y-1.3
    end
    if love.keyboard.isDown("down")then
        paddle2.y = paddle2.y+1.3
    end
    if colliding then
        reverse_direction()
    end
    if ball.y <= 0 or ball.y>=590 then
        ball.offset = -ball.offset
    end
    if ball.x >= 785 then
        ResetPosition(paddle1)
    elseif ball.x<=0 then
       ResetPosition(paddle2)
    end
end
