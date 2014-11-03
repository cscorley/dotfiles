pid = Process.spawn("xdg-open", uri,
                    :out => '/dev/null',
                    :err => '/dev/null')

Process.detach pid

true
