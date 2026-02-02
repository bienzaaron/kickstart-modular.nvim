vim.api.nvim_create_user_command('OpenProject', function(opts)
  local cwd = opts.fargs[1]
  if cwd then
    require('neo-tree.command').execute {
      dir = cwd,
    }
    require('telescope.builtin').find_files { cwd = cwd }
  end
end, {
  range = true,
  bang = true,
  nargs = 1,
  desc = 'Open a recent project',
})

local aj = [[
         _                       _     
        / /\                    /\ \   
       / /  \                   \ \ \  
      / / /\ \                  /\ \_\ 
     / / /\ \ \                / /\/_/ 
    / / /  \ \ \      _       / / /    
   / / /___/ /\ \    /\ \    / / /     
  / / /_____/ /\ \   \ \_\  / / /      
 / /_________/\ \ \  / / /_/ / /       
/ / /_       __\ \_\/ / /__\/ /        
\_\___\     /____/_/\/_______/         
                                       
]]
local aj_split = {}
for s in aj:gmatch '[^\r\n]+' do
  table.insert(aj_split, s)
end
return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      config = {
        project = { enable = true, action = 'OpenProject' },
        week_header = {
          enable = true,
          append = aj_split,
        },
      },
    }
  end,
  dependenices = { { 'nvim-tree/nvim-web-devicons' } },
}
