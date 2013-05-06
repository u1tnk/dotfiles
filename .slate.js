// アプリ起動or Focus
var launch_and_focus = function (target) {
    return function (win) {
        var apps = [];
        S.eachApp(function (app) { apps.push(app.name()); });
        if (! _.find(apps, function (name) { return name === target; })) {
            win.doOperation(
                S.operation('shell', {
                    command: "/usr/bin/open -a " + target,
                    waithFoeExit: true
                })
            );
        }
        win.doOperation(S.operation('focus', { app: target }));
    };
};

// キーバインドぶつかったり、Chromeで使えなかったりするので.slateでfocusのみやる
// S.bind('1:ctrl,cmd', launch_and_focus('iTerm'));
// S.bind('2:ctrl,cmd', launch_and_focus('MacVim'));
// S.bind('3:ctrl,cmd', launch_and_focus('Google Chrome'));
// S.bind('4:ctrl,cmd', launch_and_focus('Twitter'));
