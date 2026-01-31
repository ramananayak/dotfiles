-- Load LSP configs
for _, server in ipairs({ "lua_ls", "pyright", "ruff", "marksman" }) do
	local config_path = vim.fn.stdpath("config") .. "/lsp/" .. server .. ".lua"
	local ok, config = pcall(dofile, config_path)
	if ok then
		vim.lsp.config(server, config)
	end
	vim.lsp.enable(server)
end
