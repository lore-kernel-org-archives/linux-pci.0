Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nm8.bullet.mail.bf1.yahoo.com ([98.139.212.167]:39070 "HELO
	nm8.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759822Ab1LOXuD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Dec 2011 18:50:03 -0500
Message-ID: <1323992633.79169.YahooMailNeo@web162006.mail.bf1.yahoo.com>
Date: Thu, 15 Dec 2011 15:43:53 -0800 (PST)
From: vick <weasalandme@yahoo.com>
Reply-To: vick <weasalandme@yahoo.com>
Subject: Thuderbolt/Light Peak hotplug/pci errors
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I have a Sony Vaio Z laptop that has an external media dock that connects to the laptop via a light peak port. The media dock has a video card, dvd, network adapter and a USB 3.0 hub in it. 

When I boot the laptop with the media dock connected everything but the video card works, when I plug the media dock when the laptop is already running I get a bunch of errors and the USB hub does not work.
Below is the dmesg output with USB_DEBUG enabled from when I plug the media dock in.
This is vanilla 3.2.0-rc5 kernel from kernel.org and acpiphp module is loaded. The issue us with the usb hub on 1b:00.0 but can somebody look at the rest of the errors as well and see if something stands out?
I've also attempted to get the video card working and there's something very weird going on there. When the media dock was plugged in while booting there are 2 video cards shown by lspci - an Intel card at 2:00.0 and a radeon card at 16:00.0. However all of the xorg and proprietary ati drivers I have tried do not seem to find anything on 16:00.0 but do find video devices on 22:00.0 and 22:00.1 which does not show in lspci.

Full dmesg output can be seen here: http://www.mediafire.com/?7cc2jkx21gjxnhy,2axd6hurku3mypd
working.txt is when the media dock was connected prior to booting, nonworking1.txt is the one where the media dock was connected around the 26th second.

Thanks for the help!


[   26.714909] ACPI: \_SB_.DOCK - docking
[   26.717134] pci 0000:08:00.0: [8086:151b] type 1 class 0x000604
[   26.717227] pci 0000:08:00.0: supports D1 D2
[   26.717228] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.717234] pci 0000:08:00.0: PME# disabled
[   26.717351] pci 0000:0a:00.0: [8086:151b] type 1 class 0x000604
[   26.717442] pci 0000:0a:00.0: supports D1 D2
[   26.717443] pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.717449] pci 0000:0a:00.0: PME# disabled
[   26.717508] pci 0000:0a:03.0: [8086:151b] type 1 class 0x000604
[   26.717604] pci 0000:0a:03.0: supports D1 D2
[   26.717605] pci 0000:0a:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.717610] pci 0000:0a:03.0: PME# disabled
[   26.717660] pci 0000:0a:04.0: [8086:151b] type 1 class 0x000604
[   26.717751] pci 0000:0a:04.0: supports D1 D2
[   26.717752] pci 0000:0a:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.717757] pci 0000:0a:04.0: PME# disabled
[   26.717831] pci 0000:08:00.0: PCI bridge to [bus 0a-1d]
[   26.719281] pci 0000:08:00.0:   bridge window [io  0x3000-0x5fff]
[   26.719287] pci 0000:08:00.0:   bridge window [mem 0xb0000000-0xc03fffff]
[   26.719296] pci 0000:08:00.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
[   26.719363] pci 0000:0a:00.0: PCI bridge to [bus 0b-0b]
[   26.720785] pci 0000:0a:00.0:   bridge window [mem 0xc0300000-0xc03fffff]
[   26.720861] pci 0000:0a:03.0: PCI bridge to [bus 0c-0c]
[   26.722375] pci 0000:14:00.0: [8086:151b] type 1 class 0x000604
[   26.722529] pci 0000:14:00.0: supports D1 D2
[   26.722531] pci 0000:14:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.722538] pci 0000:14:00.0: PME# disabled
[   26.722593] pci 0000:0a:04.0: PCI bridge to [bus 14-1d]
[   26.723991] pci 0000:0a:04.0:   bridge window [io  0x3000-0x5fff]
[   26.723996] pci 0000:0a:04.0:   bridge window [mem 0xb0000000-0xc02fffff]
[   26.724005] pci 0000:0a:04.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
[   26.724162] pci 0000:15:03.0: [8086:151b] type 1 class 0x000604
[   26.724318] pci 0000:15:03.0: supports D1 D2
[   26.724319] pci 0000:15:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.724327] pci 0000:15:03.0: PME# disabled
[   26.724407] pci 0000:15:04.0: [8086:151b] type 1 class 0x000604
[   26.724563] pci 0000:15:04.0: supports D1 D2
[   26.724564] pci 0000:15:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.724572] pci 0000:15:04.0: PME# disabled
[   26.724697] pci 0000:14:00.0: PCI bridge to [bus 15-1d]
[   26.726080] pci 0000:14:00.0:   bridge window [io  0x3000-0x5fff]
[   26.726088] pci 0000:14:00.0:   bridge window [mem 0xb0000000-0xc02fffff]
[   26.726101] pci 0000:14:00.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
[   26.726252] pci 0000:16:00.0: [1002:6740] type 0 class 0x000300
[   26.726308] pci 0000:16:00.0: reg 10: [mem 0x00000000-0x0fffffff 64bit pref]
[   26.726352] pci 0000:16:00.0: reg 18: [mem 0x00000000-0x0001ffff 64bit]
[   26.726381] pci 0000:16:00.0: reg 20: [io  0x0000-0x00ff]
[   26.726437] pci 0000:16:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
[   26.726513] pci 0000:16:00.0: supports D1 D2
[   26.726602] pci 0000:16:00.1: [1002:aa90] type 0 class 0x000403
[   26.726661] pci 0000:16:00.1: reg 10: [mem 0x00000000-0x00003fff 64bit]
[   26.726871] pci 0000:16:00.1: supports D1 D2
[   26.726942] pci 0000:15:03.0: PCI bridge to [bus 16-16]
[   26.728314] pci 0000:15:03.0:   bridge window [io  0x5000-0x5fff]
[   26.728322] pci 0000:15:03.0:   bridge window [mem 0xc0200000-0xc02fffff]
[   26.728335] pci 0000:15:03.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
[   26.728501] pci 0000:17:00.0: [8086:151b] type 1 class 0x000604
[   26.728719] pci 0000:17:00.0: supports D1 D2
[   26.728721] pci 0000:17:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.728731] pci 0000:17:00.0: PME# disabled
[   26.728810] pci 0000:15:04.0: PCI bridge to [bus 17-1d]
[   26.730163] pci 0000:15:04.0:   bridge window [io  0x3000-0x4fff]
[   26.730171] pci 0000:15:04.0:   bridge window [mem 0xc0000000-0xc01fffff]
[   26.730185] pci 0000:15:04.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
[   26.730392] pci 0000:18:00.0: [8086:151b] type 1 class 0x000604
[   26.730619] pci 0000:18:00.0: supports D1 D2
[   26.730620] pci 0000:18:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.730631] pci 0000:18:00.0: PME# disabled
[   26.730765] pci 0000:18:01.0: [8086:151b] type 1 class 0x000604
[   26.730986] pci 0000:18:01.0: supports D1 D2
[   26.730988] pci 0000:18:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.730998] pci 0000:18:01.0: PME# disabled
[   26.731115] pci 0000:18:02.0: [8086:151b] type 1 class 0x000604
[   26.731337] pci 0000:18:02.0: supports D1 D2
[   26.731338] pci 0000:18:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.731349] pci 0000:18:02.0: PME# disabled
[   26.731470] pci 0000:18:03.0: [8086:151b] type 1 class 0x000604
[   26.731692] pci 0000:18:03.0: supports D1 D2
[   26.731693] pci 0000:18:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.731704] pci 0000:18:03.0: PME# disabled
[   26.731829] pci 0000:18:04.0: [8086:151b] type 1 class 0x000604
[   26.732051] pci 0000:18:04.0: supports D1 D2
[   26.732052] pci 0000:18:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.732062] pci 0000:18:04.0: PME# disabled
[   26.732252] pci 0000:17:00.0: PCI bridge to [bus 18-1d]
[   26.733602] pci 0000:17:00.0:   bridge window [io  0x3000-0x4fff]
[   26.733613] pci 0000:17:00.0:   bridge window [mem 0xc0000000-0xc01fffff]
[   26.733631] pci 0000:17:00.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
[   26.733851] pci 0000:19:00.0: [10ec:8168] type 0 class 0x000200
[   26.733905] pci 0000:19:00.0: reg 10: [io  0x0000-0x00ff]
[   26.734000] pci 0000:19:00.0: reg 18: [mem 0x00000000-0x00000fff 64bit pref]
[   26.734059] pci 0000:19:00.0: reg 20: [mem 0x00000000-0x00003fff 64bit pref]
[   26.734228] pci 0000:19:00.0: supports D1 D2
[   26.734230] pci 0000:19:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.734242] pci 0000:19:00.0: PME# disabled
[   26.734336] pci 0000:18:00.0: PCI bridge to [bus 19-19]
[   26.735646] pci 0000:18:00.0:   bridge window [io  0x4000-0x4fff]
[   26.735674] pci 0000:18:00.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
[   26.735897] pci 0000:1a:00.0: [11ab:6121] type 0 class 0x000101
[   26.735951] pci 0000:1a:00.0: reg 10: [io  0x8000-0x8007]
[   26.735989] pci 0000:1a:00.0: reg 14: [io  0x8040-0x8043]
[   26.736027] pci 0000:1a:00.0: reg 18: [io  0x8200-0x8207]
[   26.736065] pci 0000:1a:00.0: reg 1c: [io  0x8800-0x8803]
[   26.736103] pci 0000:1a:00.0: reg 20: [io  0x900000-0x90000f]
[   26.736142] pci 0000:1a:00.0: reg 24: [mem 0x00800000-0x008003ff]
[   26.736294] pci 0000:1a:00.0: supports D1
[   26.736295] pci 0000:1a:00.0: PME# supported from D0 D1 D3hot
[   26.736307] pci 0000:1a:00.0: PME# disabled
[   26.736365] pci 0000:1a:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[   26.737704] pci 0000:18:01.0: PCI bridge to [bus 1a-1a]
[   26.739075] pci 0000:18:01.0:   bridge window [io  0x3000-0x3fff]
[   26.739085] pci 0000:18:01.0:   bridge window [mem 0xc0100000-0xc01fffff]
[   26.739334] pci 0000:1b:00.0: [1033:0194] type 0 class 0x000c03
[   26.739405] pci 0000:1b:00.0: reg 10: [mem 0x00000000-0x00001fff 64bit]
[   26.739706] pci 0000:1b:00.0: PME# supported from D0 D3hot D3cold
[   26.739717] pci 0000:1b:00.0: PME# disabled
[   26.739802] pci 0000:18:02.0: PCI bridge to [bus 1b-1b]
[   26.741179] pci 0000:18:02.0:   bridge window [mem 0xc0000000-0xc00fffff]
[   26.741360] pci 0000:18:03.0: PCI bridge to [bus 1c-1c]
[   26.742925] pci 0000:18:04.0: PCI bridge to [bus 1d-1d]
[   26.745179] ACPI: Delete PCI Interrupt Routing Table for 0000:0a
[   26.745497] [Firmware Bug]: ACPI(GFXA) defines _DOD but not _DOS
[   26.747443] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:1f/device:4d/device:50/device:51/device:52/LNXVIDEO:0a/input/input8
[   26.749281] ACPI: Video Device [GFXA] (multi-head: yes  rom: no  post: no)
[   26.750838] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[   26.752790] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[   26.754290] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[   26.755769] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[   26.757225] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[   26.758682] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[   26.760112] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[   26.762090] pci 0000:08:00.0: BAR 15: assigned [mem 0xb0000000-0xcbffffff pref]
[   26.763835] pci 0000:08:00.0: BAR 14: can't assign mem (size 0x10400000)
[   26.765355] pci 0000:08:00.0: BAR 13: assigned [io  0x3000-0x5fff]
[   26.766702] pci 0000:0a:04.0: BAR 15: assigned [mem 0xb0000000-0xcbffffff pref]
[   26.768037] pci 0000:0a:00.0: BAR 14: can't assign mem (size 0x100000)
[   26.769372] pci 0000:0a:04.0: BAR 14: can't assign mem (size 0x10300000)
[   26.770672] pci 0000:0a:04.0: BAR 13: assigned [io  0x3000-0x5fff]
[   26.771932] pci 0000:0a:00.0: PCI bridge to [bus 0b-0b]
[   26.773203] pci 0000:0a:03.0: PCI bridge to [bus 0c-0c]
[   26.774463] pci 0000:14:00.0: BAR 15: assigned [mem 0xb0000000-0xcbffffff pref]
[   26.775729] pci 0000:14:00.0: BAR 14: can't assign mem (size 0x10300000)
[   26.776986] pci 0000:14:00.0: BAR 13: assigned [io  0x3000-0x5fff]
[   26.778253] pci 0000:15:03.0: BAR 15: assigned [mem 0xb0000000-0xc7ffffff pref]
[   26.779533] pci 0000:15:03.0: BAR 14: can't assign mem (size 0x100000)
[   26.780812] pci 0000:15:04.0: BAR 14: can't assign mem (size 0x200000)
[   26.782086] pci 0000:15:04.0: BAR 15: assigned [mem 0xc8000000-0xc80fffff 64bit pref]
[   26.783356] pci 0000:15:03.0: BAR 13: assigned [io  0x3000-0x3fff]
[   26.784600] pci 0000:15:04.0: BAR 13: assigned [io  0x4000-0x5fff]
[   26.785829] pci 0000:16:00.0: BAR 0: assigned [mem 0xb0000000-0xbfffffff 64bit pref]
[   26.787098] pci 0000:16:00.0: BAR 0: set to [mem 0xb0000000-0xbfffffff 64bit pref] (PCI address [0xb0000000-0xbfffffff])
[   26.788379] pci 0000:16:00.0: BAR 2: can't assign mem (size 0x20000)
[   26.789661] pci 0000:16:00.0: BAR 6: assigned [mem 0xc0000000-0xc001ffff pref]
[   26.790950] pci 0000:16:00.1: BAR 0: can't assign mem (size 0x4000)
[   26.792240] pci 0000:16:00.0: BAR 4: assigned [io  0x3000-0x30ff]
[   26.793535] pci 0000:16:00.0: BAR 4: set to [io  0x3000-0x30ff] (PCI address [0x3000-0x30ff])
[   26.794841] pci 0000:15:03.0: PCI bridge to [bus 16-16]
[   26.796135] pci 0000:15:03.0:   bridge window [io  0x3000-0x3fff]
[   26.797446] pci 0000:15:03.0:   bridge window [mem 0xb0000000-0xc7ffffff pref]
[   26.798767] pci 0000:17:00.0: BAR 14: can't assign mem (size 0x200000)
[   26.800078] pci 0000:17:00.0: BAR 15: assigned [mem 0xc8000000-0xc80fffff 64bit pref]
[   26.801389] pci 0000:17:00.0: BAR 13: assigned [io  0x4000-0x5fff]
[   26.802689] pci 0000:18:00.0: BAR 15: assigned [mem 0xc8000000-0xc80fffff 64bit pref]
[   26.803985] pci 0000:18:01.0: BAR 14: can't assign mem (size 0x100000)
[   26.805290] pci 0000:18:02.0: BAR 14: can't assign mem (size 0x100000)
[   26.806570] pci 0000:18:00.0: BAR 13: assigned [io  0x4000-0x4fff]
[   26.807842] pci 0000:18:01.0: BAR 13: assigned [io  0x5000-0x5fff]
[   26.809111] pci 0000:19:00.0: BAR 4: assigned [mem 0xc8000000-0xc8003fff 64bit pref]
[   26.810423] pci 0000:19:00.0: BAR 4: set to [mem 0xc8000000-0xc8003fff 64bit pref] (PCI address [0xc8000000-0xc8003fff])
[   26.811725] pci 0000:19:00.0: BAR 2: assigned [mem 0xc8004000-0xc8004fff 64bit pref]
[   26.813040] pci 0000:19:00.0: BAR 2: set to [mem 0xc8004000-0xc8004fff 64bit pref] (PCI address [0xc8004000-0xc8004fff])
[   26.814344] pci 0000:19:00.0: BAR 0: assigned [io  0x4000-0x40ff]
[   26.815647] pci 0000:19:00.0: BAR 0: set to [io  0x4000-0x40ff] (PCI address [0x4000-0x40ff])
[   26.816940] pci 0000:18:00.0: PCI bridge to [bus 19-19]
[   26.818232] pci 0000:18:00.0:   bridge window [io  0x4000-0x4fff]
[   26.819553] pci 0000:18:00.0:   bridge window [mem 0xc8000000-0xc80fffff 64bit pref]
[   26.820885] pci 0000:1a:00.0: BAR 5: can't assign mem (size 0x400)
[   26.822207] pci 0000:1a:00.0: BAR 4: assigned [io  0x5000-0x500f]
[   26.823549] pci 0000:1a:00.0: BAR 4: set to [io  0x5000-0x500f] (PCI address [0x5000-0x500f])
[   26.824904] pci 0000:1a:00.0: BAR 0: assigned [io  0x5010-0x5017]
[   26.826276] pci 0000:1a:00.0: BAR 0: set to [io  0x5010-0x5017] (PCI address [0x5010-0x5017])
[   26.827669] pci 0000:1a:00.0: BAR 2: assigned [io  0x5018-0x501f]
[   26.829073] pci 0000:1a:00.0: BAR 2: set to [io  0x5018-0x501f] (PCI address [0x5018-0x501f])
[   26.830462] pci 0000:1a:00.0: BAR 1: assigned [io  0x5020-0x5023]
[   26.831850] pci 0000:1a:00.0: BAR 1: set to [io  0x5020-0x5023] (PCI address [0x5020-0x5023])
[   26.833243] pci 0000:1a:00.0: BAR 3: assigned [io  0x5024-0x5027]
[   26.834665] pci 0000:1a:00.0: BAR 3: set to [io  0x5024-0x5027] (PCI address [0x5024-0x5027])
[   26.836092] pci 0000:18:01.0: PCI bridge to [bus 1a-1a]
[   26.837511] pci 0000:18:01.0:   bridge window [io  0x5000-0x5fff]
[   26.838937] pci 0000:1b:00.0: BAR 0: can't assign mem (size 0x2000)
[   26.840290] pci 0000:18:02.0: PCI bridge to [bus 1b-1b]
[   26.841634] pci 0000:18:03.0: PCI bridge to [bus 1c-1c]
[   26.842987] pci 0000:18:04.0: PCI bridge to [bus 1d-1d]
[   26.844341] pci 0000:17:00.0: PCI bridge to [bus 18-1d]
[   26.845663] pci 0000:17:00.0:   bridge window [io  0x4000-0x5fff]
[   26.847023] pci 0000:17:00.0:   bridge window [mem 0xc8000000-0xc80fffff 64bit pref]
[   26.848390] pci 0000:15:04.0: PCI bridge to [bus 17-1d]
[   26.849757] pci 0000:15:04.0:   bridge window [io  0x4000-0x5fff]
[   26.851098] pci 0000:15:04.0:   bridge window [mem 0xc8000000-0xc80fffff 64bit pref]
[   26.852434] pci 0000:14:00.0: PCI bridge to [bus 15-1d]
[   26.853759] pci 0000:14:00.0:   bridge window [io  0x3000-0x5fff]
[   26.855101] pci 0000:14:00.0:   bridge window [mem 0xb0000000-0xcbffffff pref]
[   26.856433] pci 0000:0a:04.0: PCI bridge to [bus 14-1d]
[   26.857767] pci 0000:0a:04.0:   bridge window [io  0x3000-0x5fff]
[   26.859113] pci 0000:0a:04.0:   bridge window [mem 0xb0000000-0xcbffffff pref]
[   26.860458] pci 0000:08:00.0: PCI bridge to [bus 0a-1d]
[   26.861803] pci 0000:08:00.0:   bridge window [io  0x3000-0x5fff]
[   26.863159] pci 0000:08:00.0:   bridge window [mem 0xb0000000-0xcbffffff pref]
[   26.864512] pci 0000:08:00.0: no hotplug settings from platform
[   26.865856] pci 0000:0a:00.0: no hotplug settings from platform
[   26.867190] pci 0000:0a:03.0: no hotplug settings from platform
[   26.868503] pci 0000:0a:04.0: no hotplug settings from platform
[   26.869820] pci 0000:14:00.0: no hotplug settings from platform
[   26.871123] pci 0000:15:03.0: no hotplug settings from platform
[   26.872412] pci 0000:16:00.0: no hotplug settings from platform
[   26.873698] pci 0000:16:00.1: no hotplug settings from platform
[   26.874972] pci 0000:15:04.0: no hotplug settings from platform
[   26.876222] pci 0000:17:00.0: no hotplug settings from platform
[   26.877442] pci 0000:18:00.0: no hotplug settings from platform
[   26.878650] pci 0000:19:00.0: no hotplug settings from platform
[   26.879841] pci 0000:18:01.0: no hotplug settings from platform
[   26.881025] pci 0000:1a:00.0: no hotplug settings from platform
[   26.882189] pci 0000:18:02.0: no hotplug settings from platform
[   26.883336] pci 0000:1b:00.0: no hotplug settings from platform
[   26.884471] pci 0000:18:03.0: no hotplug settings from platform
[   26.885597] pci 0000:18:04.0: no hotplug settings from platform
[   26.886717] pci 0000:08:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.887831] pci 0000:08:00.0: setting latency timer to 64
[   26.887840] pci 0000:0a:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.888944] pci 0000:0a:00.0: setting latency timer to 64
[   26.888953] pci 0000:0a:03.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   26.890045] pci 0000:0a:03.0: setting latency timer to 64
[   26.890053] pci 0000:0a:04.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.891132] pci 0000:0a:04.0: setting latency timer to 64
[   26.891142] pci 0000:14:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.892220] pci 0000:14:00.0: setting latency timer to 64
[   26.892232] pci 0000:15:03.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   26.893297] pci 0000:15:03.0: setting latency timer to 64
[   26.893309] pci 0000:15:04.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.894377] pci 0000:15:04.0: setting latency timer to 64
[   26.894391] pci 0000:17:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.895448] pci 0000:17:00.0: setting latency timer to 64
[   26.895464] pci 0000:18:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.896493] pci 0000:18:00.0: setting latency timer to 64
[   26.896509] pci 0000:18:01.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[   26.897510] pci 0000:18:01.0: setting latency timer to 64
[   26.897526] pci 0000:18:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   26.898503] pci 0000:18:02.0: setting latency timer to 64
[   26.898519] pci 0000:18:03.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   26.899480] pci 0000:18:03.0: setting latency timer to 64
[   26.899496] pci 0000:18:04.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.900432] pci 0000:18:04.0: setting latency timer to 64
[   26.900504] pcieport 0000:08:00.0: setting latency timer to 64
[   26.900569] pcieport 0000:08:00.0: irq 48 for MSI/MSI-X
[   26.900738] pcieport 0000:0a:00.0: setting latency timer to 64
[   26.900799] pcieport 0000:0a:00.0: irq 49 for MSI/MSI-X
[   26.900959] pcieport 0000:0a:03.0: setting latency timer to 64
[   26.901021] pcieport 0000:0a:03.0: irq 50 for MSI/MSI-X
[   26.901180] pcieport 0000:0a:04.0: setting latency timer to 64
[   26.901241] pcieport 0000:0a:04.0: irq 51 for MSI/MSI-X
[   26.901425] pcieport 0000:14:00.0: setting latency timer to 64
[   26.901526] pcieport 0000:14:00.0: irq 52 for MSI/MSI-X
[   26.901742] pcieport 0000:15:03.0: setting latency timer to 64
[   26.901845] pcieport 0000:15:03.0: irq 53 for MSI/MSI-X
[   26.902113] pcieport 0000:15:04.0: setting latency timer to 64
[   26.902224] pcieport 0000:15:04.0: irq 54 for MSI/MSI-X
[   26.902446] vgaarb: device added: PCI:0000:16:00.0,decodes=io+mem,owns=none,locks=none
[   26.903397] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=none:owns=io+mem
[   26.904512] vgaarb: transferring owner from PCI:0000:00:02.0 to PCI:0000:16:00.0
[   26.905754] pcieport 0000:17:00.0: setting latency timer to 64
[   26.905901] pcieport 0000:17:00.0: irq 55 for MSI/MSI-X
[   26.906263] pcieport 0000:18:00.0: setting latency timer to 64
[   26.906415] pcieport 0000:18:00.0: irq 56 for MSI/MSI-X
[   26.906753] pcieport 0000:18:01.0: setting latency timer to 64
[   26.906900] pcieport 0000:18:01.0: irq 57 for MSI/MSI-X
[   26.907205] pcieport 0000:18:02.0: setting latency timer to 64
[   26.907349] pcieport 0000:18:02.0: irq 58 for MSI/MSI-X
[   26.907666] pcieport 0000:18:03.0: setting latency timer to 64
[   26.907819] pcieport 0000:18:03.0: irq 59 for MSI/MSI-X
[   26.908174] pcieport 0000:18:04.0: setting latency timer to 64
[   26.908323] pcieport 0000:18:04.0: irq 60 for MSI/MSI-X
[   26.908631] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   26.909687] r8169 0000:19:00.0: enabling device (0000 -> 0003)
[   26.910678] r8169 0000:19:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.911866] r8169 0000:19:00.0: setting latency timer to 64
[   26.912049] r8169 0000:19:00.0: irq 61 for MSI/MSI-X
[   26.912467] r8169 0000:19:00.0: eth1: RTL8168evl/8111evl at 0xffffc90000c3e000, 54:42:49:97:a2:64, XID 0c900800 IRQ 61
[   26.913617] r8169 0000:19:00.0: eth1: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[   26.914976] xhci_hcd 0000:1b:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   26.916313] xhci_hcd 0000:1b:00.0: controller already in use
[   26.916351] xhci_hcd 0000:1b:00.0: PCI INT A disabled
[   26.917766] xhci_hcd 0000:1b:00.0: init 0000:1b:00.0 fail, -16
[   26.919149] xhci_hcd: probe of 0000:1b:00.0 failed with error -16
[   26.920364] acpiphp: Slot [1-1] registered
[   26.921538] acpiphp: Slot [2] registered
[   26.922522] acpiphp: Slot [3] registered
[   26.923541] acpiphp: Slot [1-2] registered
[   26.924485] acpiphp_glue: sibling found, but _SUN doesn't match!
[   26.925541] pata_marvell 0000:1a:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[   26.925604] acpiphp: Slot [1-3] registered
[   26.925659] acpiphp: Slot [1-4] registered
[   26.925710] acpiphp: Slot [1-5] registered
[   26.929479] pata_marvell 0000:1a:00.0: setting latency timer to 64
[   26.929983] scsi6 : pata_marvell
[   26.931004] scsi7 : pata_marvell
[   26.931981] ata7: PATA max UDMA/100 cmd 0x5010 ctl 0x5020 bmdma 0x5000 irq 19
[   26.932980] ata8: PATA max UDMA/133 cmd 0x5018 ctl 0x5024 bmdma 0x5008 irq 19
[   27.295886] ata8.00: ATAPI: Optiarc DVD RW AD-7690H, 1.70, max UDMA/100
[   27.311893] ata8.00: configured for UDMA/100
[   27.316989] scsi 7:0:0:0: CD-ROM            Optiarc  DVD RW AD-7690H  1.70 PQ: 0 ANSI: 5
[   27.334382] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda caddy
[   27.335401] cdrom: Uniform CD-ROM driver Revision: 3.20
[   27.336636] sr 7:0:0:0: Attached scsi CD-ROM sr0
