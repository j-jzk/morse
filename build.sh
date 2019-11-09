#!/usr/bin/bash
haxe -main Morse.hx -neko morse.n
haxe -main Morse.hx -cpp bin
cp bin/Morse ./morse
