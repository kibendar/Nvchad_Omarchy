local present, maven = pcall(require, "maven")

if not present then
  return
end

local executable = "./mvnw"
if vim.fn.executable(executable) == 0 then
  executable = "mvn"
end

maven.setup {

  executable = executable,
  cwd = nil, -- Use current working directory
  settings = nil, -- Use default Maven settings
  commands = { -- Custom Maven goals
    { cmd = { "clean", "compile" }, desc = "Clean and compile project" },
    { cmd = { "clean", "test" }, desc = "Clean and run tests" },
    { cmd = { "clean", "package" }, desc = "Clean and package project" },
    { cmd = { "clean", "install" }, desc = "Clean and install to local repo" },
    { cmd = { "dependency:tree" }, desc = "Show dependency tree" },
    { cmd = { "dependency:analyze" }, desc = "Analyze dependencies" },
    { cmd = { "spring-boot:run" }, desc = "Run Spring Boot application" },
    { cmd = { "exec:java" }, desc = "Execute Java main class" },
    { cmd = { "clean", "verify" }, desc = "Clean and verify project" },
    { cmd = { "versions:display-dependency-updates" }, desc = "Check for dependency updates" },
    { cmd = { "help:effective-pom" }, desc = "Show effective POM" },
  },
}
