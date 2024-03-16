local M = {}
local config = function()
    local opts = {
        non_standalone = true,
        injector = { ---@type table<lc.lang, lc.inject>
            ['cpp'] = {
                before = { '#include <bits/stdc++.h>', 'using namespace std;' },
                -- after = 'int main() {}', -- not needed now
            },
        },
    }
    require('leetcode').setup(opts)
end
M.config = config
return M
