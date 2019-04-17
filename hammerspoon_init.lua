hs.logger.historySize(1000)

local logger = hs.logger.new('remapper', "info")

local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
   end
end

local function remapKey(modifiers, key, code)
   hs.hotkey.bind(modifiers, key, code, nil, code)
end

-- カーソル移動
for k, v in pairs({h='left', j='down', k='up', l='right'}) do
  remapKey({'command'}, k, keyCode(v))
  remapKey({'command', 'shift'}, k, keyCode(v, {'shift'}))
end

string.format("volume down: %s", hs.audiodevice.defaultOutputDevice():outputVolume())
-- Volume調整
hs.hotkey.bind({'command'}, '-', function()
  local new_volume = math.max(0, math.ceil(hs.audiodevice.current().volume - 5))
  hs.alert.show(string.format("volume down: %s", new_volume), 0.5)
  hs.audiodevice.defaultOutputDevice():setVolume(new_volume)
end)

hs.hotkey.bind({'command'}, '=', function()
  local new_volume = math.min(100, math.ceil(hs.audiodevice.current().volume + 5))
  hs.alert.show(string.format("volume up: %s", new_volume), 0.5)
  hs.audiodevice.defaultOutputDevice():setVolume(new_volume)
end)

-- 明るさ調整
local builtin_screen = nil
for _, v in pairs(hs.screen.allScreens()) do
  -- MBPの内部ディスプレイ
  if v:name() == "Color LCD" then
    builtin_screen = v
  end
end
logger:i(builtin_screen)
logger:i(builtin_screen:getBrightness())

local function getCurrentBrightness()
  return math.ceil(builtin_screen:getBrightness() * 10) / 10
end

hs.hotkey.bind({'command'}, '1', function()
  local new_brightness = math.max(0,  getCurrentBrightness()- 0.2)
  hs.alert.show(string.format("brightness down: %s", new_brightness), 0.5)
  builtin_screen:setBrightness(new_brightness)
end)

hs.hotkey.bind({'command'}, '2', function()
  local new_brightness = math.min(1, getCurrentBrightness() + 0.2)
  hs.alert.show(string.format("brightness up: %s", new_brightness), 0.5)
  builtin_screen:setBrightness(new_brightness)
end)


-- iTer2内のctrl+jが改行になってしまう問題
local function handleGlobalAppEvent(name, event, app)
  if event == hs.application.watcher.activated then
    if name == 'iTerm2' then
        hs.hotkey.bind({"ctrl"}, "j", function()
            hs.eventtap.keyStroke({}, "kana", 0)
        end)
    else
        hs.hotkey.disableAll("ctrl", "j")
    end
  end
end
appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()
