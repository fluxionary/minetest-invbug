local f = string.format

minetest.register_craftitem("invbug:item", {})

minetest.register_on_joinplayer(function(player)
	local inv = player:get_inventory()
	inv:set_size("invbug:test", 2)
	inv:set_list("invbug:test", {"invbug:item 99", "invbug:item 33"})
end)

minetest.register_allow_player_inventory_action(function(player, action, inv, info)
	if action == "move" and info.to_list == "invbug:test" then
		return 0
	elseif action == "put" and info.listname == "invbug:test" then
		return 0
	end
end)

minetest.register_on_player_inventory_action(function(player, action, inv, info)
	if action == "move" and info.from_list == "invbug:test" then
		local from_stack = inv:get_stack(info.from_list, info.from_index)
		local to_stack = inv:get_stack(info.to_list, info.to_index)
		minetest.chat_send_player(player:get_player_name(),
			f("took %s (from_stack=%q to_stack=%q)", info.count, from_stack:to_string(), to_stack:to_string())
		)

		inv:set_list("invbug:test", {"invbug:item 99", "invbug:item 33"})
	elseif action == "take" and info.listname == "invbug:test" then
	end

end)

minetest.register_chatcommand("invbug", {
	func = function(name)
		minetest.show_formspec(name, "invbug", [[
			size[8,6]

			list[current_player;invbug:test;0,0;2,1;]
			list[current_player;main;0,1.5;8,4;]
			listring[]
		]])
	end
})
