function rest
    timer 10m || return 1
    notify-send 'Break is over! Get back to work 😬' -t 3000
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga
end
