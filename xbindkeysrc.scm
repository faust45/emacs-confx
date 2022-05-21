


;;(xbindkey-function '(control "c:65")
;;    (lambda ()
;;        (run-command "icecat")))

;; (xbindkey '(control alt m) "icecat")
(xbindkey '(control bracketleft) "xsel | xclip -selection clipboard")
(xbindkey '(alt apostrophe) "xsel | xclip -selection clipboard")
;;(xbindkey '(alt apostrophe) "icecat")


;;(xbindkey '(control bracketleft) "icecat")
;; st -f"JetBrains Mono:style=Medium:size=15"
;;  brightnessctl -d intel_backlight set 30%
;;  xkbcomp -I$HOME/.config/xkb -w 0 ~/.config/keyboard $DISPLAY
;;  xcape -e 'Control_L=BackSpace'


