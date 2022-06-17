-- A global variable for the Hyper Mode
hyper = hs.hotkey.modal.new({}, nil)

hyper.pressed = function()
   hyper:enter()
end

hyper.released = function()
   hyper:exit()
end

hs.hotkey.bind({}, 'F18', hyper.pressed, hyper.released)


-- global forwarding ctrl-t, ctrl-c, ...

hyper:bind({}, 't', nil, function() hs.eventtap.keyStroke({"cmd"}, 't') end)
hyper:bind({}, 'c', nil, function() hs.eventtap.keyStroke({"cmd"}, 'c') end)
hyper:bind({}, 'v', nil, function() hs.eventtap.keyStroke({"cmd"}, 'v') end)
hyper:bind({}, 'p', nil, function() hs.eventtap.keyStroke({"cmd"}, 'p') end)
hyper:bind({}, 's', nil, function() hs.eventtap.keyStroke({"cmd"}, 's') end)
hyper:bind({}, 'w', nil, function() hs.eventtap.keyStroke({"ctrl"}, 'w') end)
hyper:bind({}, '[', nil, function() hs.eventtap.keyStroke({"ctrl"}, '[') end)

-- vim homerow movement

hyper:bind({}, 'j', nil, function() hs.eventtap.keyStroke({}, 'down') end)
hyper:bind({}, 'k', nil, function() hs.eventtap.keyStroke({}, 'up') end)
hyper:bind({}, 'h', nil, function() hs.eventtap.keyStroke({}, 'left') end)
hyper:bind({}, 'l', nil, function() hs.eventtap.keyStroke({}, 'right') end)


-- application bindings
launch = function(appname)
  hs.application.launchOrFocus(appname)
end

singleapps = {
  {'1', 'Finder'},
  {'2', 'Safari'},
  {'3', 'Google Chrome'},
  {'4', 'VimR'},
  {'5', 'Xcode'},
  {'7', 'Fork'},
  {'8', 'Preview'},
  {'9', 'Spotify'},
  {'0', 'Podcasts'},
  {'return', 'Terminal'},
  {'space', 'Mission Control'}
}

for i, app in ipairs(singleapps) do
  hyper:bind({}, app[1], function() launch(app[2]); end)
end



-- window movements

hyper:bind({}, "m", function()
      local win = hs.window.focusedWindow()
      if win:isMaximizable() then
	 win:maximize()
      end
end)
   
hyper:bind({'shift'}, "m", function()
      local win = hs.window.focusedWindow()
      if win:isMaximizable() then
	 win:toggleFullScreen()
      end
end)

hyper:bind({}, ",", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w * 0.62
  f.h = max.h
  win:setFrame(f)
end)

hyper:bind({}, ".", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.w * 0.62 
  f.y = max.y
  f.w = max.w * 0.38
  f.h = max.h
  win:setFrame(f)
end)
