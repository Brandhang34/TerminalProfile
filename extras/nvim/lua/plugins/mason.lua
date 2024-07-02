return {
  {
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"luacheck",
				"shellcheck",
				"shfmt",
				"tailwindcss-language-server",
				"css-lsp",
			})
		end,
	}
}
