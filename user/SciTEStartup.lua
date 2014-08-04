DocumentRoot = '/htdocs'
cmd = {
    windows = {
        FileExplorer = 'explorer ',
        Browser = 'start '
    },
    unix = {
        FileExplorer = 'xdg-open ',
        Browser = 'xdg-open '
    }
}
function getcmd(proc)
    if props['PLAT_WIN'] == '1' then
        return cmd.windows[proc]
    elseif props['PLAT_GTK'] == '1' then
        return cmd.unix[proc]
    end
end

-- only support path consist of ansi characters.
function OpenFolder(dir)
    local cmd = getcmd("FileExplorer")
    dir='"'..dir..'"'
    os.execute(cmd..dir)
end

function Localhost(path)
    local s, pos, url, cmd
    cmd = getcmd("Browser")
    if props['PLAT_WIN'] == '1' then
        s = string.gsub(path, '\\', '/')
    end
    pos = string.find(s, DocumentRoot..'/')
    if pos then
        url = 'http://127.1'..string.sub(s, pos+string.len(DocumentRoot))
    else
        url = 'file:///'..s
    end
    url = string.gsub(url, ' ', '%%20')
    os.execute(cmd..url)
    s=nil
end
