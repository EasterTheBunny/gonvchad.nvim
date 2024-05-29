local configs = require("nvchad.configs.lspconfig")
local lspconfig = require("lspconfig")
local confs = require("lspconfig/configs")

local servers = {
  html = {},
  tsserver = {},
  cssls = {},
  gopls = {},
  golangci_lint_ls = {
    filetypes = {"go", "gomod"},
  },
}

if not confs.golangcilsp then
  confs.golangcilsp = {
    default_config = {
      cmd = {"golangci-lint-langserver"},
      root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
      init_options = {
        command = {"golangci-lint", "run", "--out-format", "json", "--issues-exit-code=1"},
      },
    },
  }
end

-- lsps with default config
for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  lspconfig[name].setup(opts)
end

