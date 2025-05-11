return {

	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	dependencies = { 'nvim-lua/plenary.nvim' },

	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({})

		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers").new({}, {
				prompt_title = "Harpoon",
				finder = require("telescope.finders").new_table({
					results = file_paths,
				}),
				previewer = conf.file_previewer({}),
				sorter = conf.generic_sorter({}),
				attach_mappings = function(prompt_bufnr, map)
					map("i", "<C-d>", function()
						local state = require("telescope.actions.state")
						local selected_entry = state.get_selected_entry()

						table.remove(harpoon_files.items, selected_entry.index)
						toggle_telescope(harpoon:list())
					end)
					return true
				end,
			}):find()
		end

		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
		vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
			{ desc = "Open harpoon window" })

		for i = 1, 9 do
			vim.keymap.set('n', '<leader>' .. i, function() harpoon:list():select(i) end)
		end
		for i = 1, 9 do
			vim.keymap.set('n', '<leader>r' .. i, function() harpoon.mark.remove_file(i) end)
		end

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function() harpoon.ui:nav_prev() end)
		vim.keymap.set("n", "<C-S-N>", function() harpoon.ui:nav_next() end)
	end
}
