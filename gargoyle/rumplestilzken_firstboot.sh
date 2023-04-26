#!/system/bin/sh

rumplestilzken_settings_enabled="$(settings get global persist.rumplestilzken.settings)"
if $rumplestilzken_settings_enabled == true; then
    $(echo "rumplestilzken.settings exist" > /dev/kmsg)
    return
fi

$(echo "writing rumplestilzken.settings" > /dev/kmsg)
settings put global persist.restricted_networking_mode 0
#LTE
settings put system persist.dbg.ims_volte_enable 1 
settings put system persist.dbg.volte_avail_ovr 1 
settings put system persist.dbg.vt_avail_ovr 1
settings put system persist.dbg.wfc_avail_ovr 1
settings put system persist.radio.rat_on combine
settings put system persist.radio.data_ltd_sys_ind 1
settings put system persist.radio.data_con_rprt 1
settings put system persist.radio.calls.on.ims 1

settings put system screen_off_timeout 600000
settings put system display_density_forced 400
settings put system navigation_mode 2
settings put system --lineage navigation_bar_hint 0
settings put secure show_ime_with_hard_keyboard 1
settings put global persist.rumplestilzken.settings true
