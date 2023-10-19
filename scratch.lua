local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function get_project_root()
  return vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
end

local function ensure_file_exists(filepath)
    -- Check if file exists
    if vim.fn.filereadable(filepath) == 0 then
        -- Create the file if it doesn't exist
        local file = io.open(filepath, "w")

        if file ~= nil then
            file:close()
        end
    end
end

local function split_string(inputstr)
    local sep = "----"
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      str = str:gsub("%s+", "")
      str = string.gsub(str, "%s+", "")
      if str == "plus" then
        str = "#ff0000"
      elseif str == "minus" then
        str = "#000ff0"
      end
      table.insert(t, str)
    end
    return t
end

local function get_build_commands(filepath)
    local lines = {}
    local file = io.open(filepath, "r")
    if not file then
        return nil, "Failed to open file."
    end
    for line in file:lines() do
      table.insert(lines, split_string(line))
    end
    file:close()
    return lines
end

local Terminal  = require('toggleterm.terminal').Terminal

local function toggle(cmd)
  local term = Terminal:new({
    cmd = cmd,
    dir = get_project_root(),
    hidden = true,
    close_on_exit = false,
    direction = 'horizontal',
    size = 25,
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
    on_close = function(term)
      -- no-op
    end,
  })
  term:toggle()
end

local function add_line_to_top(filename, line)
    local f = io.open(filename, "r")
    if not f then
        print("Failed to open file for reading: " .. filename)
        return
    end
    local content = f:read("*all")
    f:close()
    content = line .. "\n" .. content
    f = io.open(filename, "w")
    if not f then
        print("Failed to open file for writing: " .. filename)
        return
    end
    f:write(content)
    f:close()
end

local function handle_exit(prompt_bufnr, savefile)
  local cmd = ""
  if type(action_state.get_current_line()) == "string" then
    cmd = action_state.get_current_line()
    add_line_to_top(savefile, cmd .. " ---- plus")
  else
    cmd = action_state.get_current_selection().value[1]
  end
  actions.close(prompt_bufnr)
  toggle(cmd)
end

local function show_custom_picker(lines, opts, savefile)
  local val = pickers.new(opts, {
    prompt_title = "colors",
    finder = finders.new_table {
      results = lines,
      entry_maker = function(entry)
        return {
          value = entry,
          ordinal = entry[2] or "#ff0000",
          display = entry[1],
        }
      end
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(_, map) -- Ensure you use the correct function name
      map('i', '<CR>', function (prompt_bufnr) handle_exit(prompt_bufnr, savefile) end)
      map('n', '<CR>', function (prompt_bufnr) handle_exit(prompt_bufnr, savefile) end)
      return true -- Let Telescope continue attaching other mappings as well
    end,
  }):find()
end

function Foobar()
  local commands_file = get_project_root() .. "/.quickbuild_commands"
  ensure_file_exists(commands_file)
  local lines = get_build_commands(commands_file)
  local opts = require("telescope.themes").get_dropdown{}
  show_custom_picker(lines, opts, commands_file)
end

vim.cmd("command! Foobar lua Foobar()")

vim.api.nvim_set_keymap("n", "<leader>X", "<cmd>lua Foobar()<CR>", {noremap = true, silent = true})

