<h1 align=center>Neovim Lua Config</h1>
<h3 align=center>Bindings</h3>
<br>

The following table shows custom bindings defined in `lua/config/remap.lua` and plugin configs.

| Key         | Modes | Description                    | Plugin           | Context
| ---         | ----- | -----------                    | ------           | -------
| ,           |       | Leader key                     |                  | Global
| \<L>\<L>    | i, v  | Exit mode                      |                  | Global
| \<L>q       | n     | Quit neovim                    |                  | Global
| \<L>Q       | n     | Force-quit neovim              |                  | Global
| \<L>s       | n     | Save file                      |                  | Global
| \<L>S       | n     | Save and close file            |                  | Global
| \<L>ep      | n     | Open neovim explorer           |                  | Global
| \<L>tn      | n     | Open new tab                   |                  | Global
| \<L>tc      | n     | Close current tab              |                  | Global
| \<S-\>>     | n     | Nav tab right                  |                  | Global
| \<S-\<>     | n     | Nav tab left                   |                  | Global
| \<L>y       | n, v  | Yank to system clipboard       |                  | Global
| \<L>p       | n, v  | Paste from system clipboard    |                  | Global
| {           | n, v  | Nav block down                 |                  | Global
| }           | n, v  | Nav block up                   |                  | Global
| gt _key_    | n, v  | Goto _key_                     |                  | Global
| \<L>a       | n     | Select all                     |                  | Global
| b           | n     | Browse files                   | Snacks.Dashboard | Dashboard
| r           | n     | Browse recent files            | Snacks.Dashboard | Dashboard
| g           | n     | Grep search file               | Snacks.Dashboard | Dashboard
| q           | n     | Quit neovim                    | Snacks.Dashboard | Dashboard
| \<L>;       | n     | Open explorer                  | Snacks.Explorer  | Global
| l           | n     | Confirm                        | Snacks.Explorer  | Explorer
| a           | n     | Add file/directory             | Snacks.Explorer  | Explorer
| d           | n     | Delete file/directory          | Snacks.Explorer  | Explorer
| r           | n     | Rename file/directory          | Snacks.Explorer  | Explorer
| c           | n     | Copy file/directory            | Snacks.Explorer  | Explorer
| m           | n     | Move file/directory            | Snacks.Explorer  | Explorer
| o           | n     | Open file/directory            | Snacks.Explorer  | Explorer
| O           | n     | Open file in new tab           | Snacks.Explorer  | Explorer
| P           | n     | Toggle file preview            | Snacks.Explorer  | Explorer
| y           | n     | Yank file/directory path       | Snacks.Explorer  | Explorer
| p           | n     | Paste clipboard                | Snacks.Explorer  | Explorer
| \<L>/       | n     | Grep search                    | Snacks.Explorer  | Explorer
| h           | n     | Collapse node                  | Snacks.Explorer  | Explorer
| Z           | n     | Collapse all                   | Snacks.Explorer  | Explorer
| H           | n     | Toggle hidden                  | Snacks.Explorer  | Explorer
| \<BS>       | n     | Nav up tree                    | Snacks.Explorer  | Explorer
| .           | n     | Focus directory                | Snacks.Explorer  | Explorer
| I           | n     | Toggle indent guides           | Snacks.Indent    | Global
| \<L>nh      | n     | Show notification history      | Snacks.Notifier  | Global
| tf          | n     | Search files                   | Snacks.Picker    | Global
| to          | n     | Search recent                  | Snacks.Picker    | Global
| tg          | n     | Grep search                    | Snacks.Picker    | Global
| tb          | n     | Search buffers                 | Snacks.Picker    | Global
| tr          | n     | Search registers               | Snacks.Picker    | Global
| tc          | n     | Search command history         | Snacks.Picker    | Global
| tn          | n     | Search notifications           | Snacks.Picker    | Global
| tgf         | n     | Search git files               | Snacks.Picker    | Global
| tgl         | n     | Search git log                 | Snacks.Picker    | Global
| tgs         | n     | View git status                | Snacks.Picker    | Global
| tgd         | n     | View git dif                   | Snacks.Picker    | Global
| tdd         | n     | View diagnostics               | Snacks.Picker    | Global
| tdb         | n     | View diagnostics buffers       | Snacks.Picker    | Global
| tdec        | n     | Goto declaration               | Snacks.Picker    | Global
| tdef        | n     | Goto definition                | Snacks.Picker    | Global
| tref        | n     | Goto reference                 | Snacks.Picker    | Global
| timp        | n     | Goto implementation            | Snacks.Picker    | Global
| ttyp        | n     | Goto type definition           | Snacks.Picker    | Global
| tsym        | n     | Goto symbols                   | Snacks.Picker    | Global
| \<C-p>      | i, n  | Toggle preview                 | Snacks.Picker    | Picker
| \<C-n>      | i, n  | Preview scroll down            | Snacks.Picker    | Picker
| \<C-u>      | i, n  | Preview scroll up              | Snacks.Picker    | Picker
| \<C-h>      | i, n  | Toggle hidden files            | Snacks.Picker    | Picker
| \<C-s>      | i, n  | Open in split                  | Snacks.Picker    | Picker
| \<C-v>      | i, n  | Open in vertical split         | Snacks.Picker    | Picker
| \<C-t>      | i, n  | Open in new tab                | Snacks.Picker    | Picker
| \<ESC>      | i, n  | Close active picker            | Snacks.Picker    | Picker
| \<L>d       | n, v  | Toggle comments on selection   | Mini.Comments    | Global
| sa _char_   | v     | Surround selection with _char_ | Mini.Surround    | Global
| sr _x_ _y_  | v     | Replace _x_ with _y_           | Mini.Surround    | Global
| saiw _char_ | n     | Surround (w)ord with _char_    | Mini.Surround    | Global
| saiW _char_ | n     | Surround (W)ord with _char_    | Mini.Surround    | Global
| \<C-h>      | n, v  | Move selection left            | Mini.Move        | Global
| \<C-l>      | n, v  | Move selection right           | Mini.Move        | Global
| \<C-j>      | n, v  | Move selection down            | Mini.Move        | Global
| \<C-k>      | n, v  | Move selection up              | Mini.Move        | Global
| \<L>J       | n, v  | Split/join bracketed content   | Mini.Splitjoin   | Global
| ga          | v     | Start alignment                | Mini.Align       | Global
| gp          | v     | Start alignment preview        | Mini.Align       | Global
| ga _key_    | v     | Align selection by _key_       | Mini.Align       | Global
| gp _key_    | v     | Preview alignment by _key_     | Mini.Align       | Global
| \<L>ff      | n     | View diagnostics               | Trouble          | Global
| \<L>fb      | n     | View buffer diagnostics        | Trouble          | Global
| \<L>fs      | n     | View symbols                   | Trouble          | Global
| \<L>fd      | n     | View defs & refs               | Trouble          | Global
| \<L>fl      | n     | View location list             | Trouble          | Global
| \<L>fx      | n     | View quickfix list             | Trouble          | Global

