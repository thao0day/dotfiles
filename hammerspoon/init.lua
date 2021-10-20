--- A closure function
function open(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == 'Finder' then
            hs.appfinder.appFromName(name):activate()
        end
    end
end
-- chrome with tab
function chrome_active_tab_with_name(name)
    return function()
        hs.osascript.javascript([[
            // below is javascript code
            var chrome = Application('Google Chrome');
            chrome.activate();
            var wins = chrome.windows;

            // loop tabs to find a web page with a title of <name>
            function main() {
                for (var i = 0; i < wins.length; i++) {
                    var win = wins.at(i);
                    var tabs = win.tabs;
                    for (var j = 0; j < tabs.length; j++) {
                    var tab = tabs.at(j);
                    tab.title(); j;
                    if (tab.title().indexOf(']] .. name .. [[') > -1) {
                            win.activeTabIndex = j + 1;
                            return;
                        }
                    }
                }
            }
            main();
            // end of javascript
        ]])
    end
end
-- support quick coding time

function keyStrokes(str)
    return function()
        hs.eventtap.keyStrokes(str)
    end
end


--- quick open applications
hs.hotkey.bind({"alt"}, "E", open("Finder"))
hs.hotkey.bind({"alt"}, "1", open("Google Chrome"))
hs.hotkey.bind({"alt"}, "2", open("Visual Studio Code"))
hs.hotkey.bind({"alt"}, "3", open("iTerm"))
hs.hotkey.bind({"alt"}, "4", open("Postman"))
hs.hotkey.bind({"alt"}, "5", open("Sequel Ace"))

--- Use
hs.hotkey.bind({"alt"}, "Z", chrome_active_tab_with_name("Zalo Web"))

hs.hotkey.bind({"ctrl", "alt", "cmd"}, "L", keyStrokes("console.log("))
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "D", keyStrokes("print_r();die();"))