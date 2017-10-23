-- Example file with lots of options.
-- You can test with with this command:
-- cd ./etc && ../src/termit --init ../doc/rc.lua.example

require("termit.colormaps")
require("termit.utils")

defaults = {}
defaults.windowTitle = 'Termit'
defaults.startMaximized = true
defaults.hideTitlebarWhenMaximized = true
defaults.tabName = 'term'
defaults.encoding = 'UTF-8'
defaults.wordCharExceptions = '- .,_/'
defaults.font = 'Ricty 12'
--defaults.foregroundColor = 'gray'
--defaults.backgroundColor = 'black'
defaults.showScrollbar = true
defaults.hideSingleTab = false
defaults.hideTabbar = false
defaults.showBorder = true
defaults.hideMenubar = false
defaults.fillTabbar = true
defaults.scrollbackLines = 8192
defaults.geometry = '120x36'
defaults.allowChangingTitle = false
--defaults.backspaceBinding = 'AsciiBksp'
--defaults.deleteBinding = 'AsciiDel'
defaults.cursorBlinkMode = 'BlinkOff'
defaults.cursorShape = 'Ibeam'
defaults.tabPos = 'Top'
defaults.setStatusbar = function (tabInd)
    tab = tabs[tabInd]
    if tab then
        return tab.encoding..'  Bksp: '..tab.backspaceBinding..'  Del: '..tab.deleteBinding
    end
    return ''
end
-- defaults.colormap = termit.colormaps.delicate
defaults.matches = {['http[^ ]+'] = function (url) print('Matching url: '..url) end}
defaults.transparency = 0.5
setOptions(defaults)

-- bindKey('Ctrl-Page_Up', prevTab)
-- bindKey('Ctrl-Page_Down', nextTab)
-- bindKey('Ctrl-F', findDlg)
-- bindKey('Ctrl-2', function () print('Hello2!') end)
-- bindKey('Ctrl-3', function () print('Hello3!') end)
-- bindKey('Ctrl-3', nil) -- remove previous binding

-- don't close tab with Ctrl-w, use CtrlShift-w
-- bindKey('Ctrl-w', nil)
-- bindKey('CtrlShift-w', closeTab)

setKbPolicy('keycode')

-- bindMouse('DoubleClick', openTab)

--
userMenu = {}
table.insert(userMenu, {name='Close tab', action=closeTab})

table.insert(userMenu, {name='findNext', action=findNext, accel='Alt-n'})
table.insert(userMenu, {name='findPrev', action=findPrev, accel='Alt-p'})
table.insert(userMenu, {name='toggle menubar', action=function () toggleMenubar() end})
table.insert(userMenu, {name='toggle tabbar', action=function () toggleTabbar()  end})

function changeTabFontSize(delta)
    tab = tabs[currentTabIndex()]
    setTabFont(string.sub(tab.font, 1, string.find(tab.font, '%d+$') - 1)..(tab.fontSize + delta))
end

table.insert(userMenu, {name='Increase font size', action=function () changeTabFontSize(1) end})
table.insert(userMenu, {name='Decrease font size', action=function () changeTabFontSize(-1) end})
addMenu(userMenu, "User menu")
addPopupMenu(userMenu, "User menu")

addMenu(termit.utils.encMenu(), "Encodings")
addPopupMenu(termit.utils.encMenu(), "Encodings")
