function InsertPluginPoint()

  local current_line = vim.fn.line( '.' )
  local function_name = ''

  local current_node = vim.treesitter.get_node()

  while current_node do
    if current_node:type() == 'function_definition' then
      break
    end
    current_node = current_node:parent()
  end

  if not current_node then
    return

  for i = 0, current_node:named_child_count() - 1, 1 do
    local child = current_node:named_child(i)
    local type = child:type()

    if type == 'identifier' or type == 'operator_name' then
      function_name = vim.treesitter.get_node_text( child, vim.api.nvim_get_current_buf() )
      break
    else
      local name = find_name( child )

      if name then
        function_name = name
        break
      end
    end
  end


  print( function_name )
  print( vim.treesitter.get_node_text( current_node, vim.api.nvim_get_current_buf() ) )

  local file_name = vim.fn.expand( '%:t' )
  local extension = file_name:match( "^.+(%..+)$" )
  local file_name_no_ext = file_name:gsub( extension, "" )

  -- local line = '/* PLUGINSTART (' .. file_name_no_ext .. '.' .. function_name .. '.plugin.inc) */'
-- vim.api.nvim_buf_set_lines( 0, current_line, current_line, true, { line } )

 -- line = '/* PLUGINEND - end of plugin - edit keyline do not alter */'
 -- vim.api.nvim_buf_set_lines( 0, current_line + 1, current_line + 1, true, { line } )

end

vim.cmd( [[command! MatfloPlugin lua InsertPluginPoint()]] )

