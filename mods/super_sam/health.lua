
local healths = {}

local function check_for_death(name, health)
    if health < 0 then
        -- dead
        minetest.chat_send_player(name, "You would have died...")
        super_sam.set_health(name, 0)
    end
end

function super_sam.set_health(name, health)
    healths[name] = health
    check_for_death(name, health)
end

function super_sam.get_health(name)
    return healths[name] or 0
end

function super_sam.add_health(name, health)
    local max = 3
    local sum = (healths[name] or 0) + health
    if max and sum > max then
        sum = max
    end
    healths[name] = sum
    check_for_death(name, sum)
    return sum
end

super_sam.register_on_pickup("super_sam:heart", function(player)
    local playername = player:get_player_name()
    super_sam.add_health(playername, 1)
    super_sam.update_player_hud(player)
    -- TODO: sound
end)

super_sam.register_on_nodetouch("super_sam:lava_source", function(player)
    local playername = player:get_player_name()
    super_sam.add_health(playername, -1)
    super_sam.update_player_hud(player)
end)