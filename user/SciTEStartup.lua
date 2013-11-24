cmd_windows = {
    FileExplorer = 'explorer ',
    InternetExplorer = 'start '
}
cmd_unix = {
    FileExplorer = 'xdg-open ',
    InternetExplorer = 'xdg-open '
}
function getcmd(mode)
    if props['PLAT_WIN'] == '1' then
        return cmd_windows[mode]
    elseif props['PLAT_GTK'] == '1' then
        return cmd_unix[mode]
    end
end
-- only support path consist of ansi characters.
function OpenFolder(dir)
    local cmd = getcmd("FileExplorer")
    dir='"'..dir..'"'
    os.execute(cmd..dir)
end

function Localhost(path)
    local s, pos, url, host, root, cmd
    root = 'htdocs'
    host = 'localhost'  -- ensure host is right!
    cmd = getcmd("InternetExplorer")
    if props['PLAT_WIN'] == '1' then
        s = string.gsub(path, '\\', '/')
    end
    pos = string.find(s, root) or string.len(path)
    url = 'http://'..host..string.sub(s, pos+string.len(root))
    os.execute(cmd..url)
    s=nil
end
