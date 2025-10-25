local present, dap_vt = pcall(require, "nvim-dap-virtual-text")

if not present then
  return
end

dap_vt.setup {
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
  only_first_definition = true,
  all_references = false,
  clear_on_continue = false,
  virt_text_pos = "eol", -- or 'inline' for IntelliJ-like inline display
  all_frames = false,
  virt_lines = false,
  virt_text_win_col = nil,
}
