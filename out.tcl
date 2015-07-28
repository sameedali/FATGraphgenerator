source template.tcl

# defining link properties
set edge_link 100.0Mb
set agg_link 100.0Mb
set core_link 100.0Mb

set edge_delay 0.025ms
set agg_delay  0.025ms
set core_delay 0.025ms

set num_hosts 128
set num_nodes 208

# creating nodes
for { set i 0 } { $i <= $num_nodes } { incr i } {
    set n($i) [$ns node]
}

# creating links
$ns duplex-link $n(0) $n(128) $edge_link $edge_delay DropTail
$ns duplex-link $n(1) $n(128) $edge_link $edge_delay DropTail
$ns duplex-link $n(2) $n(128) $edge_link $edge_delay DropTail
$ns duplex-link $n(3) $n(128) $edge_link $edge_delay DropTail
$ns duplex-link $n(4) $n(129) $edge_link $edge_delay DropTail
$ns duplex-link $n(5) $n(129) $edge_link $edge_delay DropTail
$ns duplex-link $n(6) $n(129) $edge_link $edge_delay DropTail
$ns duplex-link $n(7) $n(129) $edge_link $edge_delay DropTail
$ns duplex-link $n(8) $n(130) $edge_link $edge_delay DropTail
$ns duplex-link $n(9) $n(130) $edge_link $edge_delay DropTail
$ns duplex-link $n(10) $n(130) $edge_link $edge_delay DropTail
$ns duplex-link $n(11) $n(130) $edge_link $edge_delay DropTail
$ns duplex-link $n(12) $n(131) $edge_link $edge_delay DropTail
$ns duplex-link $n(13) $n(131) $edge_link $edge_delay DropTail
$ns duplex-link $n(14) $n(131) $edge_link $edge_delay DropTail
$ns duplex-link $n(15) $n(131) $edge_link $edge_delay DropTail
$ns duplex-link $n(16) $n(132) $edge_link $edge_delay DropTail
$ns duplex-link $n(17) $n(132) $edge_link $edge_delay DropTail
$ns duplex-link $n(18) $n(132) $edge_link $edge_delay DropTail
$ns duplex-link $n(19) $n(132) $edge_link $edge_delay DropTail
$ns duplex-link $n(20) $n(133) $edge_link $edge_delay DropTail
$ns duplex-link $n(21) $n(133) $edge_link $edge_delay DropTail
$ns duplex-link $n(22) $n(133) $edge_link $edge_delay DropTail
$ns duplex-link $n(23) $n(133) $edge_link $edge_delay DropTail
$ns duplex-link $n(24) $n(134) $edge_link $edge_delay DropTail
$ns duplex-link $n(25) $n(134) $edge_link $edge_delay DropTail
$ns duplex-link $n(26) $n(134) $edge_link $edge_delay DropTail
$ns duplex-link $n(27) $n(134) $edge_link $edge_delay DropTail
$ns duplex-link $n(28) $n(135) $edge_link $edge_delay DropTail
$ns duplex-link $n(29) $n(135) $edge_link $edge_delay DropTail
$ns duplex-link $n(30) $n(135) $edge_link $edge_delay DropTail
$ns duplex-link $n(31) $n(135) $edge_link $edge_delay DropTail
$ns duplex-link $n(32) $n(136) $edge_link $edge_delay DropTail
$ns duplex-link $n(33) $n(136) $edge_link $edge_delay DropTail
$ns duplex-link $n(34) $n(136) $edge_link $edge_delay DropTail
$ns duplex-link $n(35) $n(136) $edge_link $edge_delay DropTail
$ns duplex-link $n(36) $n(137) $edge_link $edge_delay DropTail
$ns duplex-link $n(37) $n(137) $edge_link $edge_delay DropTail
$ns duplex-link $n(38) $n(137) $edge_link $edge_delay DropTail
$ns duplex-link $n(39) $n(137) $edge_link $edge_delay DropTail
$ns duplex-link $n(40) $n(138) $edge_link $edge_delay DropTail
$ns duplex-link $n(41) $n(138) $edge_link $edge_delay DropTail
$ns duplex-link $n(42) $n(138) $edge_link $edge_delay DropTail
$ns duplex-link $n(43) $n(138) $edge_link $edge_delay DropTail
$ns duplex-link $n(44) $n(139) $edge_link $edge_delay DropTail
$ns duplex-link $n(45) $n(139) $edge_link $edge_delay DropTail
$ns duplex-link $n(46) $n(139) $edge_link $edge_delay DropTail
$ns duplex-link $n(47) $n(139) $edge_link $edge_delay DropTail
$ns duplex-link $n(48) $n(140) $edge_link $edge_delay DropTail
$ns duplex-link $n(49) $n(140) $edge_link $edge_delay DropTail
$ns duplex-link $n(50) $n(140) $edge_link $edge_delay DropTail
$ns duplex-link $n(51) $n(140) $edge_link $edge_delay DropTail
$ns duplex-link $n(52) $n(141) $edge_link $edge_delay DropTail
$ns duplex-link $n(53) $n(141) $edge_link $edge_delay DropTail
$ns duplex-link $n(54) $n(141) $edge_link $edge_delay DropTail
$ns duplex-link $n(55) $n(141) $edge_link $edge_delay DropTail
$ns duplex-link $n(56) $n(142) $edge_link $edge_delay DropTail
$ns duplex-link $n(57) $n(142) $edge_link $edge_delay DropTail
$ns duplex-link $n(58) $n(142) $edge_link $edge_delay DropTail
$ns duplex-link $n(59) $n(142) $edge_link $edge_delay DropTail
$ns duplex-link $n(60) $n(143) $edge_link $edge_delay DropTail
$ns duplex-link $n(61) $n(143) $edge_link $edge_delay DropTail
$ns duplex-link $n(62) $n(143) $edge_link $edge_delay DropTail
$ns duplex-link $n(63) $n(143) $edge_link $edge_delay DropTail
$ns duplex-link $n(64) $n(144) $edge_link $edge_delay DropTail
$ns duplex-link $n(65) $n(144) $edge_link $edge_delay DropTail
$ns duplex-link $n(66) $n(144) $edge_link $edge_delay DropTail
$ns duplex-link $n(67) $n(144) $edge_link $edge_delay DropTail
$ns duplex-link $n(68) $n(145) $edge_link $edge_delay DropTail
$ns duplex-link $n(69) $n(145) $edge_link $edge_delay DropTail
$ns duplex-link $n(70) $n(145) $edge_link $edge_delay DropTail
$ns duplex-link $n(71) $n(145) $edge_link $edge_delay DropTail
$ns duplex-link $n(72) $n(146) $edge_link $edge_delay DropTail
$ns duplex-link $n(73) $n(146) $edge_link $edge_delay DropTail
$ns duplex-link $n(74) $n(146) $edge_link $edge_delay DropTail
$ns duplex-link $n(75) $n(146) $edge_link $edge_delay DropTail
$ns duplex-link $n(76) $n(147) $edge_link $edge_delay DropTail
$ns duplex-link $n(77) $n(147) $edge_link $edge_delay DropTail
$ns duplex-link $n(78) $n(147) $edge_link $edge_delay DropTail
$ns duplex-link $n(79) $n(147) $edge_link $edge_delay DropTail
$ns duplex-link $n(80) $n(148) $edge_link $edge_delay DropTail
$ns duplex-link $n(81) $n(148) $edge_link $edge_delay DropTail
$ns duplex-link $n(82) $n(148) $edge_link $edge_delay DropTail
$ns duplex-link $n(83) $n(148) $edge_link $edge_delay DropTail
$ns duplex-link $n(84) $n(149) $edge_link $edge_delay DropTail
$ns duplex-link $n(85) $n(149) $edge_link $edge_delay DropTail
$ns duplex-link $n(86) $n(149) $edge_link $edge_delay DropTail
$ns duplex-link $n(87) $n(149) $edge_link $edge_delay DropTail
$ns duplex-link $n(88) $n(150) $edge_link $edge_delay DropTail
$ns duplex-link $n(89) $n(150) $edge_link $edge_delay DropTail
$ns duplex-link $n(90) $n(150) $edge_link $edge_delay DropTail
$ns duplex-link $n(91) $n(150) $edge_link $edge_delay DropTail
$ns duplex-link $n(92) $n(151) $edge_link $edge_delay DropTail
$ns duplex-link $n(93) $n(151) $edge_link $edge_delay DropTail
$ns duplex-link $n(94) $n(151) $edge_link $edge_delay DropTail
$ns duplex-link $n(95) $n(151) $edge_link $edge_delay DropTail
$ns duplex-link $n(96) $n(152) $edge_link $edge_delay DropTail
$ns duplex-link $n(97) $n(152) $edge_link $edge_delay DropTail
$ns duplex-link $n(98) $n(152) $edge_link $edge_delay DropTail
$ns duplex-link $n(99) $n(152) $edge_link $edge_delay DropTail
$ns duplex-link $n(100) $n(153) $edge_link $edge_delay DropTail
$ns duplex-link $n(101) $n(153) $edge_link $edge_delay DropTail
$ns duplex-link $n(102) $n(153) $edge_link $edge_delay DropTail
$ns duplex-link $n(103) $n(153) $edge_link $edge_delay DropTail
$ns duplex-link $n(104) $n(154) $edge_link $edge_delay DropTail
$ns duplex-link $n(105) $n(154) $edge_link $edge_delay DropTail
$ns duplex-link $n(106) $n(154) $edge_link $edge_delay DropTail
$ns duplex-link $n(107) $n(154) $edge_link $edge_delay DropTail
$ns duplex-link $n(108) $n(155) $edge_link $edge_delay DropTail
$ns duplex-link $n(109) $n(155) $edge_link $edge_delay DropTail
$ns duplex-link $n(110) $n(155) $edge_link $edge_delay DropTail
$ns duplex-link $n(111) $n(155) $edge_link $edge_delay DropTail
$ns duplex-link $n(112) $n(156) $edge_link $edge_delay DropTail
$ns duplex-link $n(113) $n(156) $edge_link $edge_delay DropTail
$ns duplex-link $n(114) $n(156) $edge_link $edge_delay DropTail
$ns duplex-link $n(115) $n(156) $edge_link $edge_delay DropTail
$ns duplex-link $n(116) $n(157) $edge_link $edge_delay DropTail
$ns duplex-link $n(117) $n(157) $edge_link $edge_delay DropTail
$ns duplex-link $n(118) $n(157) $edge_link $edge_delay DropTail
$ns duplex-link $n(119) $n(157) $edge_link $edge_delay DropTail
$ns duplex-link $n(120) $n(158) $edge_link $edge_delay DropTail
$ns duplex-link $n(121) $n(158) $edge_link $edge_delay DropTail
$ns duplex-link $n(122) $n(158) $edge_link $edge_delay DropTail
$ns duplex-link $n(123) $n(158) $edge_link $edge_delay DropTail
$ns duplex-link $n(124) $n(159) $edge_link $edge_delay DropTail
$ns duplex-link $n(125) $n(159) $edge_link $edge_delay DropTail
$ns duplex-link $n(126) $n(159) $edge_link $edge_delay DropTail
$ns duplex-link $n(127) $n(159) $edge_link $edge_delay DropTail
$ns duplex-link $n(128) $n(160) $edge_link $edge_delay DropTail
$ns duplex-link $n(128) $n(161) $edge_link $edge_delay DropTail
$ns duplex-link $n(128) $n(162) $edge_link $edge_delay DropTail
$ns duplex-link $n(128) $n(163) $edge_link $edge_delay DropTail
$ns duplex-link $n(129) $n(160) $edge_link $edge_delay DropTail
$ns duplex-link $n(129) $n(161) $edge_link $edge_delay DropTail
$ns duplex-link $n(129) $n(162) $edge_link $edge_delay DropTail
$ns duplex-link $n(129) $n(163) $edge_link $edge_delay DropTail
$ns duplex-link $n(130) $n(160) $edge_link $edge_delay DropTail
$ns duplex-link $n(130) $n(161) $edge_link $edge_delay DropTail
$ns duplex-link $n(130) $n(162) $edge_link $edge_delay DropTail
$ns duplex-link $n(130) $n(163) $edge_link $edge_delay DropTail
$ns duplex-link $n(131) $n(160) $edge_link $edge_delay DropTail
$ns duplex-link $n(131) $n(161) $edge_link $edge_delay DropTail
$ns duplex-link $n(131) $n(162) $edge_link $edge_delay DropTail
$ns duplex-link $n(131) $n(163) $edge_link $edge_delay DropTail
$ns duplex-link $n(132) $n(164) $edge_link $edge_delay DropTail
$ns duplex-link $n(132) $n(165) $edge_link $edge_delay DropTail
$ns duplex-link $n(132) $n(166) $edge_link $edge_delay DropTail
$ns duplex-link $n(132) $n(167) $edge_link $edge_delay DropTail
$ns duplex-link $n(133) $n(164) $edge_link $edge_delay DropTail
$ns duplex-link $n(133) $n(165) $edge_link $edge_delay DropTail
$ns duplex-link $n(133) $n(166) $edge_link $edge_delay DropTail
$ns duplex-link $n(133) $n(167) $edge_link $edge_delay DropTail
$ns duplex-link $n(134) $n(164) $edge_link $edge_delay DropTail
$ns duplex-link $n(134) $n(165) $edge_link $edge_delay DropTail
$ns duplex-link $n(134) $n(166) $edge_link $edge_delay DropTail
$ns duplex-link $n(134) $n(167) $edge_link $edge_delay DropTail
$ns duplex-link $n(135) $n(164) $edge_link $edge_delay DropTail
$ns duplex-link $n(135) $n(165) $edge_link $edge_delay DropTail
$ns duplex-link $n(135) $n(166) $edge_link $edge_delay DropTail
$ns duplex-link $n(135) $n(167) $edge_link $edge_delay DropTail
$ns duplex-link $n(136) $n(168) $edge_link $edge_delay DropTail
$ns duplex-link $n(136) $n(169) $edge_link $edge_delay DropTail
$ns duplex-link $n(136) $n(170) $edge_link $edge_delay DropTail
$ns duplex-link $n(136) $n(171) $edge_link $edge_delay DropTail
$ns duplex-link $n(137) $n(168) $edge_link $edge_delay DropTail
$ns duplex-link $n(137) $n(169) $edge_link $edge_delay DropTail
$ns duplex-link $n(137) $n(170) $edge_link $edge_delay DropTail
$ns duplex-link $n(137) $n(171) $edge_link $edge_delay DropTail
$ns duplex-link $n(138) $n(168) $edge_link $edge_delay DropTail
$ns duplex-link $n(138) $n(169) $edge_link $edge_delay DropTail
$ns duplex-link $n(138) $n(170) $edge_link $edge_delay DropTail
$ns duplex-link $n(138) $n(171) $edge_link $edge_delay DropTail
$ns duplex-link $n(139) $n(168) $edge_link $edge_delay DropTail
$ns duplex-link $n(139) $n(169) $edge_link $edge_delay DropTail
$ns duplex-link $n(139) $n(170) $edge_link $edge_delay DropTail
$ns duplex-link $n(139) $n(171) $edge_link $edge_delay DropTail
$ns duplex-link $n(140) $n(172) $edge_link $edge_delay DropTail
$ns duplex-link $n(140) $n(173) $edge_link $edge_delay DropTail
$ns duplex-link $n(140) $n(174) $edge_link $edge_delay DropTail
$ns duplex-link $n(140) $n(175) $edge_link $edge_delay DropTail
$ns duplex-link $n(141) $n(172) $edge_link $edge_delay DropTail
$ns duplex-link $n(141) $n(173) $edge_link $edge_delay DropTail
$ns duplex-link $n(141) $n(174) $edge_link $edge_delay DropTail
$ns duplex-link $n(141) $n(175) $edge_link $edge_delay DropTail
$ns duplex-link $n(142) $n(172) $edge_link $edge_delay DropTail
$ns duplex-link $n(142) $n(173) $edge_link $edge_delay DropTail
$ns duplex-link $n(142) $n(174) $edge_link $edge_delay DropTail
$ns duplex-link $n(142) $n(175) $edge_link $edge_delay DropTail
$ns duplex-link $n(143) $n(172) $edge_link $edge_delay DropTail
$ns duplex-link $n(143) $n(173) $edge_link $edge_delay DropTail
$ns duplex-link $n(143) $n(174) $edge_link $edge_delay DropTail
$ns duplex-link $n(143) $n(175) $edge_link $edge_delay DropTail
$ns duplex-link $n(144) $n(176) $edge_link $edge_delay DropTail
$ns duplex-link $n(144) $n(177) $edge_link $edge_delay DropTail
$ns duplex-link $n(144) $n(178) $edge_link $edge_delay DropTail
$ns duplex-link $n(144) $n(179) $edge_link $edge_delay DropTail
$ns duplex-link $n(145) $n(176) $edge_link $edge_delay DropTail
$ns duplex-link $n(145) $n(177) $edge_link $edge_delay DropTail
$ns duplex-link $n(145) $n(178) $edge_link $edge_delay DropTail
$ns duplex-link $n(145) $n(179) $edge_link $edge_delay DropTail
$ns duplex-link $n(146) $n(176) $edge_link $edge_delay DropTail
$ns duplex-link $n(146) $n(177) $edge_link $edge_delay DropTail
$ns duplex-link $n(146) $n(178) $edge_link $edge_delay DropTail
$ns duplex-link $n(146) $n(179) $edge_link $edge_delay DropTail
$ns duplex-link $n(147) $n(176) $edge_link $edge_delay DropTail
$ns duplex-link $n(147) $n(177) $edge_link $edge_delay DropTail
$ns duplex-link $n(147) $n(178) $edge_link $edge_delay DropTail
$ns duplex-link $n(147) $n(179) $edge_link $edge_delay DropTail
$ns duplex-link $n(148) $n(180) $edge_link $edge_delay DropTail
$ns duplex-link $n(148) $n(181) $edge_link $edge_delay DropTail
$ns duplex-link $n(148) $n(182) $edge_link $edge_delay DropTail
$ns duplex-link $n(148) $n(183) $edge_link $edge_delay DropTail
$ns duplex-link $n(149) $n(180) $edge_link $edge_delay DropTail
$ns duplex-link $n(149) $n(181) $edge_link $edge_delay DropTail
$ns duplex-link $n(149) $n(182) $edge_link $edge_delay DropTail
$ns duplex-link $n(149) $n(183) $edge_link $edge_delay DropTail
$ns duplex-link $n(150) $n(180) $edge_link $edge_delay DropTail
$ns duplex-link $n(150) $n(181) $edge_link $edge_delay DropTail
$ns duplex-link $n(150) $n(182) $edge_link $edge_delay DropTail
$ns duplex-link $n(150) $n(183) $edge_link $edge_delay DropTail
$ns duplex-link $n(151) $n(180) $edge_link $edge_delay DropTail
$ns duplex-link $n(151) $n(181) $edge_link $edge_delay DropTail
$ns duplex-link $n(151) $n(182) $edge_link $edge_delay DropTail
$ns duplex-link $n(151) $n(183) $edge_link $edge_delay DropTail
$ns duplex-link $n(152) $n(184) $edge_link $edge_delay DropTail
$ns duplex-link $n(152) $n(185) $edge_link $edge_delay DropTail
$ns duplex-link $n(152) $n(186) $edge_link $edge_delay DropTail
$ns duplex-link $n(152) $n(187) $edge_link $edge_delay DropTail
$ns duplex-link $n(153) $n(184) $edge_link $edge_delay DropTail
$ns duplex-link $n(153) $n(185) $edge_link $edge_delay DropTail
$ns duplex-link $n(153) $n(186) $edge_link $edge_delay DropTail
$ns duplex-link $n(153) $n(187) $edge_link $edge_delay DropTail
$ns duplex-link $n(154) $n(184) $edge_link $edge_delay DropTail
$ns duplex-link $n(154) $n(185) $edge_link $edge_delay DropTail
$ns duplex-link $n(154) $n(186) $edge_link $edge_delay DropTail
$ns duplex-link $n(154) $n(187) $edge_link $edge_delay DropTail
$ns duplex-link $n(155) $n(184) $edge_link $edge_delay DropTail
$ns duplex-link $n(155) $n(185) $edge_link $edge_delay DropTail
$ns duplex-link $n(155) $n(186) $edge_link $edge_delay DropTail
$ns duplex-link $n(155) $n(187) $edge_link $edge_delay DropTail
$ns duplex-link $n(156) $n(188) $edge_link $edge_delay DropTail
$ns duplex-link $n(156) $n(189) $edge_link $edge_delay DropTail
$ns duplex-link $n(156) $n(190) $edge_link $edge_delay DropTail
$ns duplex-link $n(156) $n(191) $edge_link $edge_delay DropTail
$ns duplex-link $n(157) $n(188) $edge_link $edge_delay DropTail
$ns duplex-link $n(157) $n(189) $edge_link $edge_delay DropTail
$ns duplex-link $n(157) $n(190) $edge_link $edge_delay DropTail
$ns duplex-link $n(157) $n(191) $edge_link $edge_delay DropTail
$ns duplex-link $n(158) $n(188) $edge_link $edge_delay DropTail
$ns duplex-link $n(158) $n(189) $edge_link $edge_delay DropTail
$ns duplex-link $n(158) $n(190) $edge_link $edge_delay DropTail
$ns duplex-link $n(158) $n(191) $edge_link $edge_delay DropTail
$ns duplex-link $n(159) $n(188) $edge_link $edge_delay DropTail
$ns duplex-link $n(159) $n(189) $edge_link $edge_delay DropTail
$ns duplex-link $n(159) $n(190) $edge_link $edge_delay DropTail
$ns duplex-link $n(159) $n(191) $edge_link $edge_delay DropTail
$ns duplex-link $n(160) $n(192) $edge_link $edge_delay DropTail
$ns duplex-link $n(160) $n(193) $edge_link $edge_delay DropTail
$ns duplex-link $n(160) $n(194) $edge_link $edge_delay DropTail
$ns duplex-link $n(160) $n(195) $edge_link $edge_delay DropTail
$ns duplex-link $n(161) $n(196) $edge_link $edge_delay DropTail
$ns duplex-link $n(161) $n(197) $edge_link $edge_delay DropTail
$ns duplex-link $n(161) $n(198) $edge_link $edge_delay DropTail
$ns duplex-link $n(161) $n(199) $edge_link $edge_delay DropTail
$ns duplex-link $n(162) $n(200) $edge_link $edge_delay DropTail
$ns duplex-link $n(162) $n(201) $edge_link $edge_delay DropTail
$ns duplex-link $n(162) $n(202) $edge_link $edge_delay DropTail
$ns duplex-link $n(162) $n(203) $edge_link $edge_delay DropTail
$ns duplex-link $n(163) $n(204) $edge_link $edge_delay DropTail
$ns duplex-link $n(163) $n(205) $edge_link $edge_delay DropTail
$ns duplex-link $n(163) $n(206) $edge_link $edge_delay DropTail
$ns duplex-link $n(163) $n(207) $edge_link $edge_delay DropTail
$ns duplex-link $n(164) $n(192) $edge_link $edge_delay DropTail
$ns duplex-link $n(164) $n(193) $edge_link $edge_delay DropTail
$ns duplex-link $n(164) $n(194) $edge_link $edge_delay DropTail
$ns duplex-link $n(164) $n(195) $edge_link $edge_delay DropTail
$ns duplex-link $n(165) $n(196) $edge_link $edge_delay DropTail
$ns duplex-link $n(165) $n(197) $edge_link $edge_delay DropTail
$ns duplex-link $n(165) $n(198) $edge_link $edge_delay DropTail
$ns duplex-link $n(165) $n(199) $edge_link $edge_delay DropTail
$ns duplex-link $n(166) $n(200) $edge_link $edge_delay DropTail
$ns duplex-link $n(166) $n(201) $edge_link $edge_delay DropTail
$ns duplex-link $n(166) $n(202) $edge_link $edge_delay DropTail
$ns duplex-link $n(166) $n(203) $edge_link $edge_delay DropTail
$ns duplex-link $n(167) $n(204) $edge_link $edge_delay DropTail
$ns duplex-link $n(167) $n(205) $edge_link $edge_delay DropTail
$ns duplex-link $n(167) $n(206) $edge_link $edge_delay DropTail
$ns duplex-link $n(167) $n(207) $edge_link $edge_delay DropTail
$ns duplex-link $n(168) $n(192) $edge_link $edge_delay DropTail
$ns duplex-link $n(168) $n(193) $edge_link $edge_delay DropTail
$ns duplex-link $n(168) $n(194) $edge_link $edge_delay DropTail
$ns duplex-link $n(168) $n(195) $edge_link $edge_delay DropTail
$ns duplex-link $n(169) $n(196) $edge_link $edge_delay DropTail
$ns duplex-link $n(169) $n(197) $edge_link $edge_delay DropTail
$ns duplex-link $n(169) $n(198) $edge_link $edge_delay DropTail
$ns duplex-link $n(169) $n(199) $edge_link $edge_delay DropTail
$ns duplex-link $n(170) $n(200) $edge_link $edge_delay DropTail
$ns duplex-link $n(170) $n(201) $edge_link $edge_delay DropTail
$ns duplex-link $n(170) $n(202) $edge_link $edge_delay DropTail
$ns duplex-link $n(170) $n(203) $edge_link $edge_delay DropTail
$ns duplex-link $n(171) $n(204) $edge_link $edge_delay DropTail
$ns duplex-link $n(171) $n(205) $edge_link $edge_delay DropTail
$ns duplex-link $n(171) $n(206) $edge_link $edge_delay DropTail
$ns duplex-link $n(171) $n(207) $edge_link $edge_delay DropTail
$ns duplex-link $n(172) $n(192) $edge_link $edge_delay DropTail
$ns duplex-link $n(172) $n(193) $edge_link $edge_delay DropTail
$ns duplex-link $n(172) $n(194) $edge_link $edge_delay DropTail
$ns duplex-link $n(172) $n(195) $edge_link $edge_delay DropTail
$ns duplex-link $n(173) $n(196) $edge_link $edge_delay DropTail
$ns duplex-link $n(173) $n(197) $edge_link $edge_delay DropTail
$ns duplex-link $n(173) $n(198) $edge_link $edge_delay DropTail
$ns duplex-link $n(173) $n(199) $edge_link $edge_delay DropTail
$ns duplex-link $n(174) $n(200) $edge_link $edge_delay DropTail
$ns duplex-link $n(174) $n(201) $edge_link $edge_delay DropTail
$ns duplex-link $n(174) $n(202) $edge_link $edge_delay DropTail
$ns duplex-link $n(174) $n(203) $edge_link $edge_delay DropTail
$ns duplex-link $n(175) $n(204) $edge_link $edge_delay DropTail
$ns duplex-link $n(175) $n(205) $edge_link $edge_delay DropTail
$ns duplex-link $n(175) $n(206) $edge_link $edge_delay DropTail
$ns duplex-link $n(175) $n(207) $edge_link $edge_delay DropTail
$ns duplex-link $n(176) $n(192) $edge_link $edge_delay DropTail
$ns duplex-link $n(176) $n(193) $edge_link $edge_delay DropTail
$ns duplex-link $n(176) $n(194) $edge_link $edge_delay DropTail
$ns duplex-link $n(176) $n(195) $edge_link $edge_delay DropTail
$ns duplex-link $n(177) $n(196) $edge_link $edge_delay DropTail
$ns duplex-link $n(177) $n(197) $edge_link $edge_delay DropTail
$ns duplex-link $n(177) $n(198) $edge_link $edge_delay DropTail
$ns duplex-link $n(177) $n(199) $edge_link $edge_delay DropTail
$ns duplex-link $n(178) $n(200) $edge_link $edge_delay DropTail
$ns duplex-link $n(178) $n(201) $edge_link $edge_delay DropTail
$ns duplex-link $n(178) $n(202) $edge_link $edge_delay DropTail
$ns duplex-link $n(178) $n(203) $edge_link $edge_delay DropTail
$ns duplex-link $n(179) $n(204) $edge_link $edge_delay DropTail
$ns duplex-link $n(179) $n(205) $edge_link $edge_delay DropTail
$ns duplex-link $n(179) $n(206) $edge_link $edge_delay DropTail
$ns duplex-link $n(179) $n(207) $edge_link $edge_delay DropTail
$ns duplex-link $n(180) $n(192) $edge_link $edge_delay DropTail
$ns duplex-link $n(180) $n(193) $edge_link $edge_delay DropTail
$ns duplex-link $n(180) $n(194) $edge_link $edge_delay DropTail
$ns duplex-link $n(180) $n(195) $edge_link $edge_delay DropTail
$ns duplex-link $n(181) $n(196) $edge_link $edge_delay DropTail
$ns duplex-link $n(181) $n(197) $edge_link $edge_delay DropTail
$ns duplex-link $n(181) $n(198) $edge_link $edge_delay DropTail
$ns duplex-link $n(181) $n(199) $edge_link $edge_delay DropTail
$ns duplex-link $n(182) $n(200) $edge_link $edge_delay DropTail
$ns duplex-link $n(182) $n(201) $edge_link $edge_delay DropTail
$ns duplex-link $n(182) $n(202) $edge_link $edge_delay DropTail
$ns duplex-link $n(182) $n(203) $edge_link $edge_delay DropTail
$ns duplex-link $n(183) $n(204) $edge_link $edge_delay DropTail
$ns duplex-link $n(183) $n(205) $edge_link $edge_delay DropTail
$ns duplex-link $n(183) $n(206) $edge_link $edge_delay DropTail
$ns duplex-link $n(183) $n(207) $edge_link $edge_delay DropTail
$ns duplex-link $n(184) $n(192) $edge_link $edge_delay DropTail
$ns duplex-link $n(184) $n(193) $edge_link $edge_delay DropTail
$ns duplex-link $n(184) $n(194) $edge_link $edge_delay DropTail
$ns duplex-link $n(184) $n(195) $edge_link $edge_delay DropTail
$ns duplex-link $n(185) $n(196) $edge_link $edge_delay DropTail
$ns duplex-link $n(185) $n(197) $edge_link $edge_delay DropTail
$ns duplex-link $n(185) $n(198) $edge_link $edge_delay DropTail
$ns duplex-link $n(185) $n(199) $edge_link $edge_delay DropTail
$ns duplex-link $n(186) $n(200) $edge_link $edge_delay DropTail
$ns duplex-link $n(186) $n(201) $edge_link $edge_delay DropTail
$ns duplex-link $n(186) $n(202) $edge_link $edge_delay DropTail
$ns duplex-link $n(186) $n(203) $edge_link $edge_delay DropTail
$ns duplex-link $n(187) $n(204) $edge_link $edge_delay DropTail
$ns duplex-link $n(187) $n(205) $edge_link $edge_delay DropTail
$ns duplex-link $n(187) $n(206) $edge_link $edge_delay DropTail
$ns duplex-link $n(187) $n(207) $edge_link $edge_delay DropTail
$ns duplex-link $n(188) $n(192) $edge_link $edge_delay DropTail
$ns duplex-link $n(188) $n(193) $edge_link $edge_delay DropTail
$ns duplex-link $n(188) $n(194) $edge_link $edge_delay DropTail
$ns duplex-link $n(188) $n(195) $edge_link $edge_delay DropTail
$ns duplex-link $n(189) $n(196) $edge_link $edge_delay DropTail
$ns duplex-link $n(189) $n(197) $edge_link $edge_delay DropTail
$ns duplex-link $n(189) $n(198) $edge_link $edge_delay DropTail
$ns duplex-link $n(189) $n(199) $edge_link $edge_delay DropTail
$ns duplex-link $n(190) $n(200) $edge_link $edge_delay DropTail
$ns duplex-link $n(190) $n(201) $edge_link $edge_delay DropTail
$ns duplex-link $n(190) $n(202) $edge_link $edge_delay DropTail
$ns duplex-link $n(190) $n(203) $edge_link $edge_delay DropTail
$ns duplex-link $n(191) $n(204) $edge_link $edge_delay DropTail
$ns duplex-link $n(191) $n(205) $edge_link $edge_delay DropTail
$ns duplex-link $n(191) $n(206) $edge_link $edge_delay DropTail
$ns duplex-link $n(191) $n(207) $edge_link $edge_delay DropTail

# creating link arrays
array set links1 { 0 0 1 128 2 1 3 128 4 2 5 128 6 3 7 128 8 4 9 129 10 5 11 129 12 6 13 129 14 7 15 129 16 8 17 130 18 9 19 130 20 10 21 130 22 11 23 130 24 12 25 131 26 13 27 131 28 14 29 131 30 15 31 131 32 16 33 132 34 17 35 132 36 18 37 132 38 19 39 132 40 20 41 133 42 21 43 133 44 22 45 133 46 23 47 133 48 24 49 134 50 25 51 134 52 26 53 134 54 27 55 134 56 28 57 135 58 29 59 135 60 30 61 135 62 31 63 135 64 32 65 136 66 33 67 136 68 34 69 136 70 35 71 136 72 36 73 137 74 37 75 137 76 38 77 137 78 39 79 137 80 40 81 138 82 41 83 138 84 42 85 138 86 43 87 138 88 44 89 139 90 45 91 139 92 46 93 139 94 47 95 139 96 48 97 140 98 49 99 140 100 50 101 140 102 51 103 140 104 52 105 141 106 53 107 141 108 54 109 141 110 55 111 141 112 56 113 142 114 57 115 142 116 58 117 142 118 59 119 142 120 60 121 143 122 61 123 143 124 62 125 143 126 63 127 143 128 64 129 144 130 65 131 144 132 66 133 144 134 67 135 144 136 68 137 145 138 69 139 145 140 70 141 145 142 71 143 145 144 72 145 146 146 73 147 146 148 74 149 146 150 75 151 146 152 76 153 147 154 77 155 147 156 78 157 147 158 79 159 147 160 80 161 148 162 81 163 148 164 82 165 148 166 83 167 148 168 84 169 149 170 85 171 149 172 86 173 149 174 87 175 149 176 88 177 150 178 89 179 150 180 90 181 150 182 91 183 150 184 92 185 151 186 93 187 151 188 94 189 151 190 95 191 151 192 96 193 152 194 97 195 152 196 98 197 152 198 99 199 152 200 100 201 153 202 101 203 153 204 102 205 153 206 103 207 153 208 104 209 154 210 105 211 154 212 106 213 154 214 107 215 154 216 108 217 155 218 109 219 155 220 110 221 155 222 111 223 155 224 112 225 156 226 113 227 156 228 114 229 156 230 115 231 156 232 116 233 157 234 117 235 157 236 118 237 157 238 119 239 157 240 120 241 158 242 121 243 158 244 122 245 158 246 123 247 158 248 124 249 159 250 125 251 159 252 126 253 159 254 127 255 159 256 128 257 160 258 128 259 161 260 128 261 162 262 128 263 163 264 129 265 160 266 129 267 161 268 129 269 162 270 129 271 163 272 130 273 160 274 130 275 161 276 130 277 162 278 130 279 163 280 131 281 160 282 131 283 161 284 131 285 162 286 131 287 163 288 132 289 164 290 132 291 165 292 132 293 166 294 132 295 167 296 133 297 164 298 133 299 165 300 133 301 166 302 133 303 167 304 134 305 164 306 134 307 165 308 134 309 166 310 134 311 167 312 135 313 164 314 135 315 165 316 135 317 166 318 135 319 167 320 136 321 168 322 136 323 169 324 136 325 170 326 136 327 171 328 137 329 168 330 137 331 169 332 137 333 170 334 137 335 171 336 138 337 168 338 138 339 169 340 138 341 170 342 138 343 171 344 139 345 168 346 139 347 169 348 139 349 170 350 139 351 171 352 140 353 172 354 140 355 173 356 140 357 174 358 140 359 175 360 141 361 172 362 141 363 173 364 141 365 174 366 141 367 175 368 142 369 172 370 142 371 173 372 142 373 174 374 142 375 175 376 143 377 172 378 143 379 173 380 143 381 174 382 143 383 175 384 144 385 176 386 144 387 177 388 144 389 178 390 144 391 179 392 145 393 176 394 145 395 177 396 145 397 178 398 145 399 179 400 146 401 176 402 146 403 177 404 146 405 178 406 146 407 179 408 147 409 176 410 147 411 177 412 147 413 178 414 147 415 179 416 148 417 180 418 148 419 181 420 148 421 182 422 148 423 183 424 149 425 180 426 149 427 181 428 149 429 182 430 149 431 183 432 150 433 180 434 150 435 181 436 150 437 182 438 150 439 183 440 151 441 180 442 151 443 181 444 151 445 182 446 151 447 183 448 152 449 184 450 152 451 185 452 152 453 186 454 152 455 187 456 153 457 184 458 153 459 185 460 153 461 186 462 153 463 187 464 154 465 184 466 154 467 185 468 154 469 186 470 154 471 187 472 155 473 184 474 155 475 185 476 155 477 186 478 155 479 187 480 156 481 188 482 156 483 189 484 156 485 190 486 156 487 191 488 157 489 188 490 157 491 189 492 157 493 190 494 157 495 191 496 158 497 188 498 158 499 189 500 158 501 190 502 158 503 191 504 159 505 188 506 159 507 189 508 159 509 190 510 159 511 191 512 160 513 192 514 160 515 193 516 160 517 194 518 160 519 195 520 161 521 196 522 161 523 197 524 161 525 198 526 161 527 199 528 162 529 200 530 162 531 201 532 162 533 202 534 162 535 203 536 163 537 204 538 163 539 205 540 163 541 206 542 163 543 207 544 164 545 192 546 164 547 193 548 164 549 194 550 164 551 195 552 165 553 196 554 165 555 197 556 165 557 198 558 165 559 199 560 166 561 200 562 166 563 201 564 166 565 202 566 166 567 203 568 167 569 204 570 167 571 205 572 167 573 206 574 167 575 207 576 168 577 192 578 168 579 193 580 168 581 194 582 168 583 195 584 169 585 196 586 169 587 197 588 169 589 198 590 169 591 199 592 170 593 200 594 170 595 201 596 170 597 202 598 170 599 203 600 171 601 204 602 171 603 205 604 171 605 206 606 171 607 207 608 172 609 192 610 172 611 193 612 172 613 194 614 172 615 195 616 173 617 196 618 173 619 197 620 173 621 198 622 173 623 199 624 174 625 200 626 174 627 201 628 174 629 202 630 174 631 203 632 175 633 204 634 175 635 205 636 175 637 206 638 175 639 207 640 176 641 192 642 176 643 193 644 176 645 194 646 176 647 195 648 177 649 196 650 177 651 197 652 177 653 198 654 177 655 199 656 178 657 200 658 178 659 201 660 178 661 202 662 178 663 203 664 179 665 204 666 179 667 205 668 179 669 206 670 179 671 207 672 180 673 192 674 180 675 193 676 180 677 194 678 180 679 195 680 181 681 196 682 181 683 197 684 181 685 198 686 181 687 199 688 182 689 200 690 182 691 201 692 182 693 202 694 182 695 203 696 183 697 204 698 183 699 205 700 183 701 206 702 183 703 207 704 184 705 192 706 184 707 193 708 184 709 194 710 184 711 195 712 185 713 196 714 185 715 197 716 185 717 198 718 185 719 199 720 186 721 200 722 186 723 201 724 186 725 202 726 186 727 203 728 187 729 204 730 187 731 205 732 187 733 206 734 187 735 207 736 188 737 192 738 188 739 193 740 188 741 194 742 188 743 195 744 189 745 196 746 189 747 197 748 189 749 198 750 189 751 199 752 190 753 200 754 190 755 201 756 190 757 202 758 190 759 203 760 191 761 204 762 191 763 205 764 191 765 206 766 191 767 207}
array set links2 { 0 128 1 0 2 128 3 1 4 128 5 2 6 128 7 3 8 129 9 4 10 129 11 5 12 129 13 6 14 129 15 7 16 130 17 8 18 130 19 9 20 130 21 10 22 130 23 11 24 131 25 12 26 131 27 13 28 131 29 14 30 131 31 15 32 132 33 16 34 132 35 17 36 132 37 18 38 132 39 19 40 133 41 20 42 133 43 21 44 133 45 22 46 133 47 23 48 134 49 24 50 134 51 25 52 134 53 26 54 134 55 27 56 135 57 28 58 135 59 29 60 135 61 30 62 135 63 31 64 136 65 32 66 136 67 33 68 136 69 34 70 136 71 35 72 137 73 36 74 137 75 37 76 137 77 38 78 137 79 39 80 138 81 40 82 138 83 41 84 138 85 42 86 138 87 43 88 139 89 44 90 139 91 45 92 139 93 46 94 139 95 47 96 140 97 48 98 140 99 49 100 140 101 50 102 140 103 51 104 141 105 52 106 141 107 53 108 141 109 54 110 141 111 55 112 142 113 56 114 142 115 57 116 142 117 58 118 142 119 59 120 143 121 60 122 143 123 61 124 143 125 62 126 143 127 63 128 144 129 64 130 144 131 65 132 144 133 66 134 144 135 67 136 145 137 68 138 145 139 69 140 145 141 70 142 145 143 71 144 146 145 72 146 146 147 73 148 146 149 74 150 146 151 75 152 147 153 76 154 147 155 77 156 147 157 78 158 147 159 79 160 148 161 80 162 148 163 81 164 148 165 82 166 148 167 83 168 149 169 84 170 149 171 85 172 149 173 86 174 149 175 87 176 150 177 88 178 150 179 89 180 150 181 90 182 150 183 91 184 151 185 92 186 151 187 93 188 151 189 94 190 151 191 95 192 152 193 96 194 152 195 97 196 152 197 98 198 152 199 99 200 153 201 100 202 153 203 101 204 153 205 102 206 153 207 103 208 154 209 104 210 154 211 105 212 154 213 106 214 154 215 107 216 155 217 108 218 155 219 109 220 155 221 110 222 155 223 111 224 156 225 112 226 156 227 113 228 156 229 114 230 156 231 115 232 157 233 116 234 157 235 117 236 157 237 118 238 157 239 119 240 158 241 120 242 158 243 121 244 158 245 122 246 158 247 123 248 159 249 124 250 159 251 125 252 159 253 126 254 159 255 127 256 160 257 128 258 161 259 128 260 162 261 128 262 163 263 128 264 160 265 129 266 161 267 129 268 162 269 129 270 163 271 129 272 160 273 130 274 161 275 130 276 162 277 130 278 163 279 130 280 160 281 131 282 161 283 131 284 162 285 131 286 163 287 131 288 164 289 132 290 165 291 132 292 166 293 132 294 167 295 132 296 164 297 133 298 165 299 133 300 166 301 133 302 167 303 133 304 164 305 134 306 165 307 134 308 166 309 134 310 167 311 134 312 164 313 135 314 165 315 135 316 166 317 135 318 167 319 135 320 168 321 136 322 169 323 136 324 170 325 136 326 171 327 136 328 168 329 137 330 169 331 137 332 170 333 137 334 171 335 137 336 168 337 138 338 169 339 138 340 170 341 138 342 171 343 138 344 168 345 139 346 169 347 139 348 170 349 139 350 171 351 139 352 172 353 140 354 173 355 140 356 174 357 140 358 175 359 140 360 172 361 141 362 173 363 141 364 174 365 141 366 175 367 141 368 172 369 142 370 173 371 142 372 174 373 142 374 175 375 142 376 172 377 143 378 173 379 143 380 174 381 143 382 175 383 143 384 176 385 144 386 177 387 144 388 178 389 144 390 179 391 144 392 176 393 145 394 177 395 145 396 178 397 145 398 179 399 145 400 176 401 146 402 177 403 146 404 178 405 146 406 179 407 146 408 176 409 147 410 177 411 147 412 178 413 147 414 179 415 147 416 180 417 148 418 181 419 148 420 182 421 148 422 183 423 148 424 180 425 149 426 181 427 149 428 182 429 149 430 183 431 149 432 180 433 150 434 181 435 150 436 182 437 150 438 183 439 150 440 180 441 151 442 181 443 151 444 182 445 151 446 183 447 151 448 184 449 152 450 185 451 152 452 186 453 152 454 187 455 152 456 184 457 153 458 185 459 153 460 186 461 153 462 187 463 153 464 184 465 154 466 185 467 154 468 186 469 154 470 187 471 154 472 184 473 155 474 185 475 155 476 186 477 155 478 187 479 155 480 188 481 156 482 189 483 156 484 190 485 156 486 191 487 156 488 188 489 157 490 189 491 157 492 190 493 157 494 191 495 157 496 188 497 158 498 189 499 158 500 190 501 158 502 191 503 158 504 188 505 159 506 189 507 159 508 190 509 159 510 191 511 159 512 192 513 160 514 193 515 160 516 194 517 160 518 195 519 160 520 196 521 161 522 197 523 161 524 198 525 161 526 199 527 161 528 200 529 162 530 201 531 162 532 202 533 162 534 203 535 162 536 204 537 163 538 205 539 163 540 206 541 163 542 207 543 163 544 192 545 164 546 193 547 164 548 194 549 164 550 195 551 164 552 196 553 165 554 197 555 165 556 198 557 165 558 199 559 165 560 200 561 166 562 201 563 166 564 202 565 166 566 203 567 166 568 204 569 167 570 205 571 167 572 206 573 167 574 207 575 167 576 192 577 168 578 193 579 168 580 194 581 168 582 195 583 168 584 196 585 169 586 197 587 169 588 198 589 169 590 199 591 169 592 200 593 170 594 201 595 170 596 202 597 170 598 203 599 170 600 204 601 171 602 205 603 171 604 206 605 171 606 207 607 171 608 192 609 172 610 193 611 172 612 194 613 172 614 195 615 172 616 196 617 173 618 197 619 173 620 198 621 173 622 199 623 173 624 200 625 174 626 201 627 174 628 202 629 174 630 203 631 174 632 204 633 175 634 205 635 175 636 206 637 175 638 207 639 175 640 192 641 176 642 193 643 176 644 194 645 176 646 195 647 176 648 196 649 177 650 197 651 177 652 198 653 177 654 199 655 177 656 200 657 178 658 201 659 178 660 202 661 178 662 203 663 178 664 204 665 179 666 205 667 179 668 206 669 179 670 207 671 179 672 192 673 180 674 193 675 180 676 194 677 180 678 195 679 180 680 196 681 181 682 197 683 181 684 198 685 181 686 199 687 181 688 200 689 182 690 201 691 182 692 202 693 182 694 203 695 182 696 204 697 183 698 205 699 183 700 206 701 183 702 207 703 183 704 192 705 184 706 193 707 184 708 194 709 184 710 195 711 184 712 196 713 185 714 197 715 185 716 198 717 185 718 199 719 185 720 200 721 186 722 201 723 186 724 202 725 186 726 203 727 186 728 204 729 187 730 205 731 187 732 206 733 187 734 207 735 187 736 192 737 188 738 193 739 188 740 194 741 188 742 195 743 188 744 196 745 189 746 197 747 189 748 198 749 189 750 199 751 189 752 200 753 190 754 201 755 190 756 202 757 190 758 203 759 190 760 204 761 191 762 205 763 191 764 206 765 191 766 207 767 191}
set lnk_size [array size links1]

# monitoring links
for { set i 0 } { $i < [expr $lnk_size] } { incr i } {
	set qmon_ab($i) [$ns monitor-queue $n($links1($i)) $n($links2($i)) ""]
	set bing_ab($i) [$qmon_ab($i) get-bytes-integrator];
	set ping_ab($i) [$qmon_ab($i) get-pkts-integrator];
	set fileq($i) "qmon.trace"
	set futil_name($i) "qmon.util"
	
    append fileq($i) "$links1($i)"
	append fileq($i) "$links2($i)"
	append futil_name($i) "$links1($i)"
	append futil_name($i) "$links2($i)"
	
    set fq_mon($i) [open $fileq($i) w]
	set f_util($i) [open $futil_name($i) w]


    $ns at $STATS_START  "$qmon_ab($i) reset"
	$ns at $STATS_START  "$bing_ab($i) reset"
	$ns at $STATS_START  "$ping_ab($i) reset"
	set buf_bytes [expr 0.00025 * 1000 / 1 ]
    $ns at [expr $STATS_START+$STATS_INTR] "linkDump [$ns link $n($links1($i)) $n($links2($i))] $bing_ab($i) $ping_ab($i) $qmon_ab($i) $STATS_INTR A-B $fq_mon($i) $f_util($i) $buf_bytes"
}


set num_nodes 208;
set num_agents 0
for { set i 0 } { $i < $num_nodes } { incr i } {
	for {set j 0} {$j < $num_nodes} {incr j} {
		set p($num_agents) [new Agent/Ping]
		$ns attach-agent $n($i) $p($num_agents)
		incr num_agents
	}
}


set ite 0
set jStart 0
for { set i 0 } { $i < 208 } { incr i } {
	for { set j $jStart } { $j < 209 } { incr j } {
		if { $j == 208 } {
			set ite [expr $ite + $i + 1]
			continue
		}

		$ns connect $p($ite) $p([expr 208*$j + $i])
		incr ite
	}
	incr jStart
}

set num_agents1 $num_agents
for { set i 0 } { $i < $num_nodes } { incr i } {
	for {set j 0} {$j < $num_nodes} {incr j} {
		set p($num_agents) [new Agent/Raza]
		$ns attach-agent $n($i) $p($num_agents)
		incr num_agents
	}
}

set ite $num_agents1
set jStart 0
for { set i 0 } { $i < 208 } { incr i } {
	for { set j $jStart } { $j < 209 } { incr j } {
		if { $j == 208 } {
			set ite [expr $ite + $i + 1]
			continue
		}
		$ns connect $p($ite) $p([expr 208*$j + $i + $num_agents1])
		incr ite
	}
	incr jStart
}


puts "running ns"
$ns run