require("nvchad.configs.lspconfig").defaults()

local servers = {
	"html",
	"cssls",
	"lua_ls",
	"pyright",
	-- "jdtls",
	"texlab",
	"clangd",
	"ts_ls",
	"ast-grep",
	"docker-compose-language-server",
	"dockerfile-language-server",
	"bash-language-server",
	"kotlin_language_server", -- Added Kotlin LSP
	"rust-analyzer",
	"lemminx",
	"marksman",
	"tinymist",
}
vim.lsp.enable(servers)
vim.lsp.config("*", {
	root_markers = { ".git" },
})
vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
})

-- Markdown (marksman)
vim.lsp.config.marksman = {
	cmd = { "marksman", "server" },
	filetypes = { "markdown", "markdown.mdx" },
	root_markers = {
		".marksman.toml",
		".git",
		".obsidian",
		"README.md",
	},
	settings = {
		marksman = {
			-- Completion settings
			completion = {
				wiki = {
					enabled = true,
				},
			},
			-- Cross-references and linking
			references = {
				enabled = true,
			},
			-- Document symbols
			outline = {
				enabled = true,
			},
			-- Hover information
			hover = {
				enabled = true,
			},
			-- Diagnostics
			diagnostics = {
				enabled = true,
			},
			-- Wiki-style linking (useful for note-taking)
			wiki = {
				enabled = true,
			},
		},
	},
	single_file_support = true,
}
-- Java (jdtls)
-- vim.lsp.config.jdtls = {
-- 	cmd = { "jdtls" },
-- 	filetypes = { "java" },
-- 	root_markers = { ".git", "pom.xml", "build.gradle", "gradlew", ".project" },
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	single_file_support = true,
-- }
-- Kotlin (kotlin_language_server)
vim.lsp.config.kotlin_language_server = {
	cmd = { "kotlin-language-server" },
	filetypes = { "kotlin" },
	root_markers = {
		"build.gradle",
		"build.gradle.kts",
		"settings.gradle",
		"settings.gradle.kts",
		"gradlew",
		"pom.xml",
		".git",
	},
	cmd_env = {
		JAVA_HOME = "/usr/lib/jvm/java-21-openjdk",
		PATH = "/usr/lib/jvm/java-21-openjdk/bin:" .. vim.env.PATH,
	},
	settings = {
		kotlin = {
			-- Compiler options
			compiler = {
				jvm = {
					target = "21", -- or "11", "8" depending on your project
				},
			},
			-- Indexing settings
			indexing = {
				enabled = true,
			},
			-- Completion settings
			completion = {
				snippets = {
					enabled = true,
				},
			},
			-- Diagnostics
			diagnostics = {
				enabled = true,
			},
			-- External sources (for JAR files)
			externalSources = {
				useKlsScheme = true,
				autoConvertToKotlin = true,
			},
		},
	},
	init_options = {
		storagePath = vim.fn.stdpath("cache") .. "/kotlin-language-server",
	},
	single_file_support = true,
}
-- Python (pyright)
vim.lsp.config.pyright = {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace", -- or "openFilesOnly" for better performance
				typeCheckingMode = "basic", -- "off", "basic", or "strict"
			},
		},
	},
	single_file_support = true,
}
-- JS / TS (tsserver)
vim.lsp.config.tsserver = {
	cmd = { "tsserver" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
}
vim.lsp.ast_grep = {
	cmd = { "ast-grep" },
	filetypes = { "html" },
}
-- C / C++ (clangd)
vim.lsp.config.clangd = {
	cmd = {
		"clangd",
		"--clang-tidy",
		"--background-index",
		"--offset-encoding=utf-8",
	},
	filetypes = { "c", "cpp" },
	root_markers = { ".clangd", "compile_commands.json", ".git" },
}
-- Lua (lua_ls)
vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true, -- add this too
				},
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

-- latex (texlab)
vim.lsp.config.texlab = {
	settings = {
		texlab = {
			build = {
				executable = "latexmk",
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				onsave = true,
			},
			forwardsearch = {
				executable = "zathura",
				args = { "--synctex-forward", "%l:1:%f", "%p" },
			},
		},
	},
}
-- docker compose lsp
vim.lsp.config["docker-compose-language-server"] = {
	cmd = { "docker-compose-langserver", "--stdio" },
	filetypes = { "yaml.docker-compose", "yaml" },
	root_markers = { "docker-compose.yml", "docker-compose.yaml", "compose.yml", "compose.yaml", ".git" },
	settings = {
		dockercompose = {
			enable = true,
		},
	},
}
-- dockerfile lsp
vim.lsp.config["dockerfile-language-server"] = {
	cmd = { "docker-langserver", "--stdio" },
	filetypes = { "dockerfile" },
	root_markers = { "dockerfile", "dockerfile", ".dockerignore", ".git" },
	settings = {
		docker = {
			languageserver = {
				diagnostics = {
					-- enable all diagnostics
					deprecatedmaintainer = true,
					directivecasing = true,
					emptycontinuationline = true,
					instructioncasing = true,
					instructioncmdmultiple = true,
					instructionentrypointmultiple = true,
					instructionhealthcheckmultiple = true,
					instructionjsoninsinglequotes = true,
				},
				formatter = {
					ignoremultilineinstructions = true,
				},
			},
		},
	},
}
-- bash lsp (bash-language-server)
vim.lsp.config["bash-language-server"] = {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash" },
	root_markers = { ".git", ".bashrc", ".bash_profile" },
	settings = {
		bashide = {
			-- enable/disable background analysis
			backgroundanalysismaxfiles = 500,
			-- enable/disable shellcheck integration
			enablesourceerrordiagnostics = false,
			-- glob pattern for files to include in workspace symbol search
			includeallworkspacesymbols = true,
			-- path to shellcheck executable (optional)
			shellcheckpath = "shellcheck",
			-- shellcheck arguments (optional)
			shellcheckarguments = "--external-sources",
		},
	},
	single_file_support = true,
}

-- xml (lemminx)
vim.lsp.config.lemminx = {
	cmd = { "lemminx" },
	filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
	root_markers = {
		".git",
		"pom.xml",
		"build.gradle",
		"build.gradle.kts",
		"web.xml",
		"*.xsd",
	},
	settings = {
		xml = {
			-- server settings
			server = {
				workdir = "~/.cache/lemminx",
			},
			-- completion settings
			completion = {
				autoclosetags = true,
				autocloseremovescontent = false,
			},
			-- validation settings
			validation = {
				enabled = true,
				namespaces = {
					enabled = "always", -- "always", "never", or "onnamespaceencountered"
				},
				schema = {
					enabled = "always", -- "always", "never", or "onvalidschema"
				},
				disallowdoctypedecl = false,
				resolveexternalentities = false,
			},
			-- formatting settings
			format = {
				enabled = true,
				splitattributes = false,
				joincdatalines = false,
				joincommentlines = false,
				joincontentlines = false,
				spacebeforeemptyclosetag = true,
				quotations = "doublequotes", -- "doublequotes" or "singlequotes"
				preserveattributelinebreaks = false,
				preserveemptycontent = false,
				preservednewlines = 2,
				maxlinewidth = 0, -- 0 means no limit
				grammarawareformatting = true,
			},
			-- symbol settings
			symbols = {
				enabled = true,
				excluded = {},
				maxitemscomputed = 5000,
				showreferencedgrammars = false,
			},
			-- codelens settings
			codelens = {
				enabled = false,
			},
			-- hover settings
			hover = {
				enabled = true,
			},
			-- folding settings
			foldings = {
				includeclosingtaginfold = false,
			},
			-- preferences
			preferences = {
				includeinlayparameternamehints = "none", -- "none", "literals", or "all"
				includeinlaypropertydeclarationtypehints = false,
				includeinlayvariabletypehints = false,
				includeinlayfunctionlikereturntypehints = false,
				showschemadocumentationtype = "all", -- "all", "documentation", or "none"
			},
			-- catalogs for schema/dtd resolution
			catalogs = {
				-- add paths to xml catalogs if needed
				-- "path/to/catalog.xml"
			},
			-- java-specific settings (lemminx runs on java)
			java = {
				home = nil, -- will use java_home if not set
			},
		},
	},
	single_file_support = true,
	-- custom initialization options
	init_options = {
		settings = {
			xml = {
				logs = {
					client = true,
					server = true,
				},
				trace = {
					server = "verbose", -- "off", "messages", "verbose"
				},
			},
		},
		extendedclientcapabilities = {
			codelens = {
				codelenskind = {
					supported = true,
				},
			},
			actionablenotificationsupported = true,
			opensettingscommandsupported = true,
		},
	},
}

-- rust (rust-analyzer)
vim.lsp.config["rust-analyzer"] = {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = {
		"cargo.toml",
		"cargo.lock",
		"rust-project.json",
		".git",
	},
	settings = {
		["rust-analyzer"] = {
			-- import settings
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			-- cargo settings
			cargo = {
				buildscripts = {
					enable = true,
				},
				allfeatures = true,
				loadoutdirsfromcheck = true,
				runbuildscripts = true,
			},
			-- procedural macros
			procmacro = {
				enable = true,
				ignored = {},
				attributes = {
					enable = true,
				},
			},
			-- diagnostics
			diagnostics = {
				enable = true,
				disabled = {},
				remapprefix = {},
				warningsashint = {},
				warningsasinfo = {},
			},
			-- lens settings (show references, implementations, etc.)
			lens = {
				enable = true,
				debug = {
					enable = true,
				},
				implementations = {
					enable = true,
				},
				references = {
					adt = {
						enable = false,
					},
					enumvariant = {
						enable = false,
					},
					method = {
						enable = false,
					},
					trait = {
						enable = false,
					},
				},
				run = {
					enable = true,
				},
			},
			-- inlay hints
			inlayhints = {
				bindingmodehints = {
					enable = false,
				},
				chaininghints = {
					enable = true,
				},
				closingbracehints = {
					enable = true,
					minlines = 25,
				},
				closurereturntypehints = {
					enable = "never",
				},
				lifetimeelisionhints = {
					enable = "never",
					useparameternames = false,
				},
				maxlength = 25,
				parameterhints = {
					enable = true,
				},
				reborrowhints = {
					enable = "never",
				},
				rendercolons = true,
				typehints = {
					enable = true,
					hideclosureinitialization = false,
					hidenamedconstructor = false,
				},
			},
			-- completion settings
			completion = {
				callable = {
					snippets = "fill_arguments",
				},
				postfix = {
					enable = true,
				},
				privateeditable = {
					enable = false,
				},
				snippets = {
					custom = {},
				},
			},
			-- assist settings (code actions)
			assist = {
				importenforcegranularity = true,
				importprefix = "plain",
			},
			-- call hierarchy
			callinfo = {
				full = true,
			},
			-- check settings (for cargo check)
			checkonsave = {
				enable = true,
				command = "clippy",
				extraargs = {},
				alltargets = true,
			},
			-- highlighting settings
			highlightrelated = {
				breakpoints = {
					enable = true,
				},
				exitpoints = {
					enable = true,
				},
				references = {
					enable = true,
				},
				yieldpoints = {
					enable = true,
				},
			},
			-- hover settings
			hover = {
				documentation = {
					enable = true,
				},
				links = {
					enable = true,
				},
				memorylayout = {
					alignment = "hexadecimal",
					enable = false,
					niches = false,
					offset = "hexadecimal",
					size = "both",
				},
			},
			-- workspace settings
			workspace = {
				symbol = {
					search = {
						scope = "workspace",
						kind = "only_types",
					},
				},
			},
			-- semantic tokens
			semantichighlighting = {
				strings = {
					enable = true,
				},
				punctuation = {
					enable = false,
					separate = {
						macro = {
							bang = false,
						},
					},
					specialization = {
						enable = false,
					},
				},
				operator = {
					enable = true,
					specialization = {
						enable = false,
					},
				},
			},
			-- typing settings
			typing = {
				autoclosinganglebrackets = {
					enable = false,
				},
			},
			-- experimental features
			experimental = {
				procattrmacros = true,
			},
		},
	},
	-- capabilities for enhanced features
	capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
		textdocument = {
			completion = {
				completionitem = {
					snippetsupport = true,
					resolvesupport = {
						properties = { "documentation", "detail", "additionaltextedits" },
					},
				},
			},
		},
		experimental = {
			serverstatusnotification = true,
		},
	}),
	-- custom initialization options
	init_options = {
		lspmux = {
			version = "1",
			method = "connect",
			server = "rust-analyzer",
		},
	},
	single_file_support = false, -- rust-analyzer works best with cargo projects
}

-- Typst LSP (tinymist)
vim.lsp.config.tinymist = {
	cmd = { "tinymist" }, -- make sure 'tinymist' is in your PATH
	filetypes = { "typst", "typ" },
	root_markers = { ".git", "typst.toml" },
	settings = {
		tinymist = {
			-- optional settings if tinymist supports them
			lint = true, -- enable diagnostics/linting
			completion = true, -- enable completion
			hover = true, -- hover info
			outline = true, -- symbols/document outline
		},
	},
	single_file_support = true,
}
