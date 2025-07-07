function work
    timer 50m || return 1
    notify-send 'Work Timer is up! Take a Break 😊' -t 3000
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga
end
