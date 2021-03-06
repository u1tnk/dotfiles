%w[a z x c v w t r p Return].each do |key|
  remap "Alt-#{key}", to: "C-#{key}" end
remap "Shift-Alt-bracketright", to: "Ctrl-Page_Down"
remap "Shift-Alt-bracketleft", to: "Ctrl-Page_Up"

window class_only: 'google-chrome' do
  %w[f].each do |key|
    remap "Alt-#{key}", to: "Ctrl-#{key}"
  end
  remap "Shift-Alt-t", to: "Shift-Ctrl-t"
end

# see: https://github.com/nonstop/termit/wiki/Termit-Lua-API
window class_only: 'termit' do
  remap "Alt-c", to: "Ctrl-Insert"
  remap "Alt-v", to: "Shift-Insert"
  remap "Shift-Alt-bracketright", to: "Alt-Right"
  remap "Shift-Alt-bracketleft", to: "Alt-Left"
  remap "Alt-w", to: "Shift-Ctrl-w"
end

window class_only: 'urxvt' do
  remap "Alt-c", to: "Ctrl-Alt-c"
  remap "Alt-v", to: "Ctrl-Alt-v"
end

window class_only: 'slack' do
  remap "Alt-Up", to: "Ctrl-Up"
end
