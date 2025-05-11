return {

	'nvim-telescope/telescope.nvim', branch = '0.1.x',

	dependencies = { 'nvim-lua/plenary.nvim' },

	config = function()
		require('telescope').setup({})

		local builtin = require('telescope.builtin')
		--	file finder
		vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
		--	file finder (only in git)
		vim.keymap.set('n', '<C-p>', builtin.git_files, {})
		--	searches word cursor is on (only alphanum part)
		vim.keymap.set('n', '<leader>pws', function()
			local word = vim.fn.expand("<cword>") builtin.grep_string({ search = word })
		end)
		-- searches complete word cursor is on
		vim.keymap.set('n', '<leader>pWs', function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		--dynamic input search with grep
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		-- open ff for help
		vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
	end
}
