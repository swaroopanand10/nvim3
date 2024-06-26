local M = {}
local config = function()
    local opts = {
        -- received_problems_path = "$(CWD)/$(PROBLEM)/$(PROBLEM).$(FEXT)",
        -- received_problems_path = "$(CWD)/$(JAVA_TASK_CLASS)/$(JAVA_TASK_CLASS).$(FEXT)",
        received_problems_path = function(task, file_extension)
            local hyphen = string.find(task.group, ' - ')
            local contest, problem, path
            if not hyphen then
                contest = 'unknown_contest'
            else
                contest = string.sub(task.group, hyphen + 3)
            end
            contest = string.gsub(contest, '%s+', '')
            contest = string.gsub(contest, '%(', '-')
            contest = string.gsub(contest, '%)', '-')
            problem = string.gsub(task.name, '%s+', '')
            problem = string.gsub(problem, '%(', '-')
            problem = string.gsub(problem, '%)', '-')
            path = vim.fn.getcwd()
            return string.format('%s/%s/%s.%s', path, problem, problem, file_extension)
        end,
    }
    require('competitest').setup(opts)
end
local keys = {
    {
        '<leader>ac',
        '<cmd>:CompetiTest receive problem<cr>',
        silent = true,
        desc = 'CompetiTest receive problem',
    },
    {
        '<leader>ar',
        '<cmd>:CompetiTest run<cr>',
        silent = true,
        desc = 'run testcases',
    },
    {
        '<leader>aa',
        '<cmd>:CompetiTest add_testcase<cr>',
        silent = true,
        desc = 'add testcases',
    },
    {
        '<leader>ae',
        '<cmd>:CompetiTest edit_testcase<cr>',
        silent = true,
        desc = 'edit testcases',
    },
    {
        '<leader>aA',
        '<cmd>:CompetiTest delete_testcase<cr>',
        silent = true,
        desc = 'delete testcases',
    },
    {
        '<leader>aw',
        '<cmd>:CompetiTest show_ui<cr>',
        silent = true,
        desc = 'open testcase ui (no-recomp)',
    },
}
M.config = config
M.keys = keys
return M
