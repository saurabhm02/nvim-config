return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 80,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = false,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
			terminal_mappings = true,
			persist_mode = false,
			auto_scroll = true,
		})

		local opts = { noremap = true, silent = true }

		-- Key mappings for navigating between terminal splits
		vim.api.nvim_buf_set_keymap(0, "t", "<m-h>", "<C-\\><C-n><C-W>h", opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<m-j>", "<C-\\><C-n><C-W>j", opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<m-k>", "<C-\\><C-n><C-W>k", opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<m-l>", "<C-\\><C-n><C-W>l", opts)

		-- Define functions for toggling specific terminals
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
		local node = Terminal:new({ cmd = "node", hidden = true })

		-- Define functions for toggling horizontal and vertical terminals
		function _TOGGLE_HORIZONTAL()
			vim.cmd("ToggleTerm size=10 direction=horizontal")
		end

		function _TOGGLE_FLOAT()
			vim.cmd("ToggleTerm size=50 direction=float")
		end

		function _LAZYGIT_TOGGLE()
			lazygit:toggle()
		end

		function _NODE_TOGGLE()
			node:toggle()
		end

		-- Set key mappings for toggling horizontal terminal
		vim.api.nvim_set_keymap("n", "<Leader>th", ":lua _TOGGLE_HORIZONTAL()<CR>", opts)

		-- Set key mappings for toggling Node and lazygit terminals
		vim.api.nvim_set_keymap("n", "<Leader>nt", ":lua _NODE_TOGGLE()<CR>", opts)
		vim.api.nvim_set_keymap("n", "<Leader>l", ":lua _LAZYGIT_TOGGLE()<CR>", opts)

		-- Set key mapping for toggling float direction terminal in insert mode
		vim.api.nvim_set_keymap("i", "<C-f>", "<Esc>:lua _TOGGLE_FLOAT()<CR>", opts)
		vim.api.nvim_set_keymap("n", "<Leader>tf", "<Esc>:lua _TOGGLE_FLOAT()<CR>", opts)
	end,
}
