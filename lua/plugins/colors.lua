return {

	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha"
		})
		vim.cmd.colorscheme "catppuccin"
		vim.api.nvim_create_user_command('Light', function()
			vim.cmd.colorscheme "catppuccin-latte"
		end, {})
	end
}
