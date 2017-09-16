local register_button = sfinv_buttons.register_button
local function btn_error(player, msg)
	minetest.chat_send_player(player:get_player_name(), msg)
end

if minetest.global_exists("sethome") then
	register_button("useful_buttons:home", {
		title = "Go Home",
		image = "useful_buttons_home.png",
		action = function(player)
			local home = sethome.get(player:get_player_name())
			if home then
				player:set_pos(home)
			else
				btn_error(player, "No home has been set")
			end
		end
	})

	register_button("useful_buttons:sethome", {
		title = "Set home",
		image = "useful_buttons_set_home.png",
		action = function(player)
			sethome.set(player:get_player_name(), player:get_pos())
		end
	})
end

register_button("useful_buttons:day", {
	title = "Day",
	image = "useful_buttons_day.png",
	action = function(player)
		if minetest.check_player_privs(player, { settime = true }) then
			minetest.set_timeofday(0.25)
		else
			btn_error(player, "You don't have the settime privilege!")
		end
	end,
	show = function(player)
		return minetest.check_player_privs(player, { settime = true })
	end
})

register_button("useful_buttons:night", {
	title = "Night",
	image = "useful_buttons_night.png",
	action = function(player)
		if minetest.check_player_privs(player, { settime = true }) then
			minetest.set_timeofday(0.85)
		else
			btn_error(player, "You don't have the settime privilege!")
		end
	end,
	show = function(player)
		return minetest.check_player_privs(player, { settime = true })
	end
})

register_button("useful_buttons:clear_all", {
	title = "Clear all",
	image = "useful_buttons_clear_all.png",
	action = function(player)
		player:get_inventory():set_list("main", {})
		player:get_inventory():set_list("craft", {})
	end,
	show = function(player)
		return minetest.check_player_privs(player, { settime = true })
	end
})
