%w[a z x c v w t r Return].each do |key|
  remap "Alt-#{key}", to: "C-#{key}"
end

window class_only: 'google-chrome' do
  %w[f].each do |key|
    remap "Alt-#{key}", to: "C-#{key}"
  end
end
