local home = os.getenv("HOME")
local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local lombok_path = jdtls_path .. "/lombok.jar"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/jdtls-workspace/" .. project_name

-- Ensure workspace directory exists
vim.fn.mkdir(workspace_dir, "p")

-- Paths to java-debug and vscode-java-test plugins
local java_debug_path = home .. "/.local/share/java/java-debug"
local java_test_path = home .. "/.local/share/java/vscode-java-test"

-- Prepare bundles for extensions
local bundles = {}
if vim.fn.isdirectory(java_debug_path) == 1 then
	vim.list_extend(
		bundles,
		vim.split(
			vim.fn.glob(
				java_debug_path .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
				1
			),
			"\n"
		)
	)
end
if vim.fn.isdirectory(java_test_path) == 1 then
	vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/server/*.jar", 1), "\n"))
end

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. lombok_path,
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		-- Add preview features support
		"--enable-preview",
		"-jar",
		vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		jdtls_path .. "/config_linux",
		"-data",
		workspace_dir,
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
	settings = {
		java = {
			signatureHelp = { enabled = true },
			completion = {
				favoriteStaticMembers = {
					"org.junit.jupiter.api.Assertions.*",
					"org.mockito.Mockito.*",
					"org.mockito.ArgumentMatchers.*",
					"org.mockito.Answers.*",
				},
			},
			configuration = {
				runtimes = {
					{
						name = "JavaSE-25",
						-- path = home .. "/.sdkman/candidates/java/25-tem", -- Fixed path expansion
						path = "/usr/lib/jvm/java-25-openjdk/",
					},
				},
			},
			-- Set compiler compliance to Java 25 with preview features
			compile = {
				nullAnalysis = {
					mode = "disabled",
				},
			},
			-- Enable preview features in project settings
			project = {
				referencedLibraries = {},
			},
			-- Format settings
			format = {
				enabled = false,
			},
			eclipse = {
				downloadSources = true,
			},
			cleanup = {
				actionsOnSave = {},
			},
			validation = {
				enabled = false,
			},
			-- Add source and target version settings
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
		},
	},
	init_options = {
		bundles = bundles,
		settings = {
			["java.format.enabled"] = false,
			["java.format.onType.enabled"] = false,
			["java.format.insertSpaces"] = false,
			["java.cleanup.actionsOnSave"] = {},
			-- Enable preview features
			["java.compile.nullAnalysis.mode"] = "disabled",
			["java.configuration.maven.userSettings"] = nil,
		},
		extendedClientCapabilities = {
			classFileContentsSupport = true,
			generateToStringPromptSupport = true,
			hashCodeEqualsPromptSupport = true,
			advancedExtractRefactoringSupport = true,
			advancedOrganizeImportsSupport = true,
			generateConstructorsPromptSupport = true,
			generateDelegateMethodsPromptSupport = true,
			moveRefactoringSupport = true,
			overrideMethodsPromptSupport = true,
			inferSelectionSupport = { "extractMethod", "extractVariable", "extractField" },
		},
	},
}

-- Only start jdtls if we're in a Java project
if require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }) then
	require("jdtls").start_or_attach(config)
end
