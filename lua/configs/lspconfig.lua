require("nvchad.configs.lspconfig").defaults()

local servers = {
	-- Web Development
	"html",
	"cssls",
	"ts_ls",
	"emmet_ls",
	"tailwindcss",
	"eslint",

	-- System Programming
	"clangd",
	"rust-analyzer",

	-- Scripting
	"lua_ls",
	"pyright",
	"bash-language-server",

	-- JVM Languages
	-- "jdtls",
	"kotlin_language_server",

	-- Data/Config Languages
	"jsonls",
	"yamlls",
	"taplo", -- TOML
	"lemminx", -- XML

	-- Go
	"gopls",

	-- Documentation
	"marksman",
	"texlab",
	"tinymist",

	-- DevOps
	"docker-compose-language-server",
	"dockerfile-language-server",
	"terraformls",

	-- Other
	"ast-grep",
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
			completion = {
				completionItem = {
					snippetSupport = true,
					resolveSupport = {
						properties = {
							"documentation",
							"detail",
							"additionalTextEdits",
						},
					},
					insertReplaceSupport = true,
					labelDetailsSupport = true,
					deprecatedSupport = true,
					commitCharactersSupport = true,
					documentationFormat = { "markdown", "plaintext" },
					preselectSupport = true,
					tagSupport = {
						valueSet = { 1 },
					},
				},
			},
			codeAction = {
				dynamicRegistration = true,
				codeActionLiteralSupport = {
					codeActionKind = {
						valueSet = {
							"",
							"quickfix",
							"refactor",
							"refactor.extract",
							"refactor.inline",
							"refactor.rewrite",
							"source",
							"source.organizeImports",
						},
					},
				},
			},
			hover = {
				dynamicRegistration = true,
				contentFormat = { "markdown", "plaintext" },
			},
			signatureHelp = {
				dynamicRegistration = true,
				signatureInformation = {
					documentationFormat = { "markdown", "plaintext" },
					parameterInformation = {
						labelOffsetSupport = true,
					},
				},
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
				diagnosticMode = "openFilesOnly", -- "workspace" or "openFilesOnly"
				typeCheckingMode = "basic", -- "off", "basic", or "strict"
				-- Diagnostic settings
				diagnosticSeverityOverrides = {
					reportUnusedImport = "warning",
					reportUnusedClass = "warning",
					reportUnusedFunction = "warning",
					reportUnusedVariable = "warning",
					reportDuplicateImport = "warning",
				},
				-- Additional analysis options
				autoImportCompletions = true,
				extraPaths = {},
				stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
				-- Indexing
				indexing = true,
				logLevel = "Information",
			},
		},
	},
	single_file_support = true,
}
-- JS / TS (ts_ls)
vim.lsp.config.ts_ls = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
	single_file_support = true,
}
vim.lsp.ast_grep = {
	cmd = { "ast-grep" },
	filetypes = { "html" },
}
-- C / C++ (clangd)
vim.lsp.config.clangd = {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
		"--offset-encoding=utf-8",
		"--all-scopes-completion",
		"--cross-file-rename",
		"--log=verbose",
		"--pch-storage=memory",
		"-j=8",
		"--enable-config",
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
		".git",
	},
	capabilities = {
		offsetEncoding = { "utf-8" },
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
	single_file_support = true,
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
				-- Custom snippets configuration removed - add specific snippets when needed
				-- snippets = {
				-- 	custom = {
				-- 		["Arc::new"] = {
				-- 			postfix = "arc",
				-- 			body = "Arc::new(${receiver})",
				-- 			description = "Put the expression into an Arc",
				-- 			requires = "std::sync::Arc",
				-- 			scope = "expr",
				-- 		},
				-- 	},
				-- },
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

-- Go (gopls)
vim.lsp.config.gopls = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod", ".git" },
	settings = {
		gopls = {
			-- Analysis settings
			analyses = {
				unusedparams = true,
				shadow = true,
				nilness = true,
				unusedwrite = true,
				useany = true,
			},
			-- Static check analyzers
			staticcheck = true,
			-- Completion settings
			completeUnimported = true,
			usePlaceholders = true,
			deepCompletion = true,
			-- Matcher
			matcher = "Fuzzy",
			-- Symbol settings
			symbolMatcher = "FastFuzzy",
			symbolStyle = "Dynamic",
			-- Hints
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			-- Codelens
			codelenses = {
				gc_details = true,
				generate = true,
				regenerate_cgo = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			-- Semantic tokens
			semanticTokens = true,
			-- Diagnostics
			diagnosticsDelay = "500ms",
			-- Experimental features
			experimentalPostfixCompletions = true,
		},
	},
	single_file_support = true,
}

-- JSON (jsonls)
vim.lsp.config.jsonls = {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { "package.json", ".git" },
	settings = {
		json = {
			-- Schemas
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
			-- Formatting
			format = {
				enable = true,
			},
			-- Keep lines (prevents reformatting)
			keepLines = {
				enable = true,
			},
		},
	},
	single_file_support = true,
	init_options = {
		provideFormatter = true,
	},
}

-- YAML (yamlls)
vim.lsp.config.yamlls = {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yml" },
	root_markers = { ".git" },
	settings = {
		yaml = {
			-- Schemas
			schemas = require("schemastore").yaml.schemas(),
			schemaStore = {
				enable = true,
				url = "https://www.schemastore.org/api/json/catalog.json",
			},
			-- Validation
			validate = true,
			-- Formatting
			format = {
				enable = true,
				singleQuote = false,
				bracketSpacing = true,
			},
			-- Hover
			hover = true,
			-- Completion
			completion = true,
			-- Custom tags
			customTags = {
				"!reference sequence",
				"!And",
				"!If",
				"!Not",
				"!Equals",
				"!Or",
				"!FindInMap sequence",
				"!Base64",
				"!Cidr",
				"!Ref",
				"!Sub",
				"!GetAtt",
				"!GetAZs",
				"!ImportValue",
				"!Select",
				"!Split",
				"!Join sequence",
			},
		},
	},
	single_file_support = true,
}

-- TOML (taplo)
vim.lsp.config.taplo = {
	cmd = { "taplo", "lsp", "stdio" },
	filetypes = { "toml" },
	root_markers = { "*.toml", ".git" },
	settings = {
		evenBetterToml = {
			schema = {
				enabled = true,
				repositoryEnabled = true,
				repositoryUrl = "https://taplo.tamasfe.dev/schema_index.json",
			},
			formatter = {
				alignEntries = false,
				alignComments = true,
				arrayTrailingComma = true,
				arrayAutoExpand = true,
				arrayAutoCollapse = true,
				compactArrays = true,
				compactInlineTables = false,
				indentTables = false,
				indentEntries = false,
				trailingNewline = true,
				reorderKeys = false,
				allowedBlankLines = 2,
				columnWidth = 80,
			},
		},
	},
	single_file_support = true,
}

-- HTML
vim.lsp.config.html = {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html", "templ" },
	root_markers = { "package.json", ".git" },
	settings = {
		html = {
			format = {
				enable = true,
				wrapLineLength = 120,
				wrapAttributes = "auto",
			},
			hover = {
				documentation = true,
				references = true,
			},
		},
	},
	single_file_support = true,
}

-- CSS
vim.lsp.config.cssls = {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { "package.json", ".git" },
	settings = {
		css = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		scss = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		less = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
	single_file_support = true,
}

-- Emmet
vim.lsp.config.emmet_ls = {
	cmd = { "emmet-ls", "--stdio" },
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
	},
	root_markers = { "package.json", ".git" },
	single_file_support = true,
}

-- TailwindCSS
vim.lsp.config.tailwindcss = {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
	},
	root_markers = { "tailwind.config.js", "tailwind.config.ts", "postcss.config.js", ".git" },
	settings = {
		tailwindCSS = {
			classAttributes = { "class", "className", "classList", "ngClass" },
			experimental = {
				classRegex = {
					"tw`([^`]*)",
					'tw="([^"]*)',
					'tw={"([^"}]*)',
					"tw\\.\\w+`([^`]*)",
					"tw\\(.*?\\)`([^`]*)",
				},
			},
			validate = true,
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidConfigPath = "error",
				invalidScreen = "error",
				invalidTailwindDirective = "error",
				invalidVariant = "error",
				recommendedVariantOrder = "warning",
			},
		},
	},
	single_file_support = true,
}

-- ESLint
vim.lsp.config.eslint = {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
	},
	root_markers = {
		".eslintrc",
		".eslintrc.js",
		".eslintrc.json",
		".eslintrc.yml",
		"eslint.config.js",
		"package.json",
		".git",
	},
	settings = {
		codeAction = {
			disableRuleComment = {
				enable = true,
				location = "separateLine",
			},
			showDocumentation = {
				enable = true,
			},
		},
		codeActionOnSave = {
			enable = false,
			mode = "all",
		},
		format = true,
		nodePath = "",
		onIgnoredFiles = "off",
		packageManager = "npm",
		problems = {
			shortenToSingleLine = false,
		},
		quiet = false,
		rulesCustomizations = {},
		run = "onType",
		useESLintClass = false,
		validate = "on",
		workingDirectory = {
			mode = "location",
		},
	},
	single_file_support = true,
}

-- Terraform
vim.lsp.config.terraformls = {
	cmd = { "terraform-ls", "serve" },
	filetypes = { "terraform", "tf", "terraform-vars" },
	root_markers = { ".terraform", ".git" },
	settings = {
		terraform = {
			-- Validation settings
			validation = {
				enableEnhancedValidation = true,
			},
			-- Completion settings
			completion = {
				enable = true,
			},
		},
	},
	single_file_support = true,
}
