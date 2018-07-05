Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753323AbeGEOVe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Jul 2018 10:21:34 -0400
Message-ID: <1530800046.3840.12.camel@suse.com>
Subject: insufficient IO space on laptop with two type C connectors for
 Thunderbolt
From: Oliver Neukum <oneukum@suse.com>
To: linux-pci@vger.kernel.org
Cc: mika.westerberg@linux.intel.com
Date: Thu, 05 Jul 2018 16:14:06 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I have a laptop with two type C connectors. If I boot with a device
attached to a type C port, the firmware will assign 8K io space to the
bridge (v4.18-rc3):

  6088-608b : 0000:00:17.0
    6088-608b : ahci
  7000-8fff : PCI Bus 0000:04
    7000-8fff : PCI Bus 0000:05
      7000-7fff : PCI Bus 0000:07
      8000-8fff : PCI Bus 0000:3b
  efa0-efbf : 0000:00:1f.4
    efa0-efbf : i801_smbus

If however, I boot without a device, the allocation is less generous:

  6088-608b : 0000:00:17.0
    6088-608b : ahci
  7000-7fff : PCI Bus 0000:04
  efa0-efbf : 0000:00:1f.4
    efa0-efbf : i801_smbus

Which leads to failures when something is plugged in:

[  300.312233] pci 0000:04:00.0: [8086:1578] type 01 class 0x060400
[  300.312286] pci 0000:04:00.0: enabling Extended Tags
[  300.312356] pci 0000:04:00.0: supports D1 D2
[  300.312358] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[  300.312676] pci 0000:05:00.0: [8086:1578] type 01 class 0x060400
[  300.312733] pci 0000:05:00.0: enabling Extended Tags
[  300.312825] pci 0000:05:00.0: supports D1 D2
[  300.312827] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[  300.312923] pci 0000:05:01.0: [8086:1578] type 01 class 0x060400
[  300.312987] pci 0000:05:01.0: enabling Extended Tags
[  300.313061] pci 0000:05:01.0: supports D1 D2
[  300.313063] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[  300.313153] pci 0000:05:02.0: [8086:1578] type 01 class 0x060400
[  300.313226] pci 0000:05:02.0: enabling Extended Tags
[  300.313317] pci 0000:05:02.0: supports D1 D2
[  300.313319] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[  300.313398] pci 0000:05:04.0: [8086:1578] type 01 class 0x060400
[  300.313451] pci 0000:05:04.0: enabling Extended Tags
[  300.313522] pci 0000:05:04.0: supports D1 D2
[  300.313524] pci 0000:05:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[  300.313615] pci 0000:04:00.0: PCI bridge to [bus 05-6e]
[  300.313623] pci 0000:04:00.0:   bridge window [mem 0xac000000-0xda0fffff]
[  300.313629] pci 0000:04:00.0:   bridge window [mem 0x60000000-0xa9ffffff 64bit pref]
[  300.313673] pci 0000:05:00.0: PCI bridge to [bus 06]
[  300.313681] pci 0000:05:00.0:   bridge window [mem 0xda000000-0xda0fffff]
[  300.313726] pci 0000:05:01.0: PCI bridge to [bus 07-39]
[  300.313734] pci 0000:05:01.0:   bridge window [mem 0xac000000-0xc3efffff]
[  300.313740] pci 0000:05:01.0:   bridge window [mem 0x60000000-0x7fffffff 64bit pref]
[  300.313797] pci 0000:3a:00.0: [8086:15b6] type 00 class 0x0c0330
[  300.313831] pci 0000:3a:00.0: reg 0x10: [mem 0xc3f00000-0xc3f0ffff]
[  300.313903] pci 0000:3a:00.0: enabling Extended Tags
[  300.313993] pci 0000:3a:00.0: supports D1 D2
[  300.313995] pci 0000:3a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[  300.314126] pci 0000:05:02.0: PCI bridge to [bus 3a]
[  300.314134] pci 0000:05:02.0:   bridge window [mem 0xc3f00000-0xc3ffffff]
[  300.314178] pci 0000:05:04.0: PCI bridge to [bus 3b-6e]
[  300.314186] pci 0000:05:04.0:   bridge window [mem 0xc4000000-0xd9ffffff]
[  300.314192] pci 0000:05:04.0:   bridge window [mem 0x80000000-0xa9ffffff 64bit pref]
[  300.314218] pci_bus 0000:05: Allocating resources
[  300.314270] pci 0000:05:01.0: bridge window [io  0x1000-0x0fff] to [bus 07-39] add_size 1000
[  300.314285] pci 0000:05:04.0: bridge window [io  0x1000-0x0fff] to [bus 3b-6e] add_size 1000
[  300.314294] pci 0000:04:00.0: bridge window [io  0x1000-0x0fff] to [bus 05-6e] add_size 2000
[  300.314297] pci 0000:04:00.0: BAR 13: no space for [io  size 0x2000]
[  300.314299] pci 0000:04:00.0: BAR 13: failed to assign [io  size 0x2000]
[  300.314301] pci 0000:04:00.0: BAR 13: no space for [io  size 0x2000]
[  300.314303] pci 0000:04:00.0: BAR 13: failed to assign [io  size 0x2000]
[  300.314305] pci 0000:05:01.0: BAR 13: no space for [io  size 0x1000]
[  300.314307] pci 0000:05:01.0: BAR 13: failed to assign [io  size 0x1000]
[  300.314308] pci 0000:05:04.0: BAR 13: no space for [io  size 0x1000]
[  300.314310] pci 0000:05:04.0: BAR 13: failed to assign [io  size 0x1000]
[  300.314312] pci 0000:05:04.0: BAR 13: no space for [io  size 0x1000]
[  300.314313] pci 0000:05:04.0: BAR 13: failed to assign [io  size 0x1000]
[  300.314315] pci 0000:05:01.0: BAR 13: no space for [io  size 0x1000]
[  300.314317] pci 0000:05:01.0: BAR 13: failed to assign [io  size 0x1000]
[  300.314319] pci 0000:05:00.0: PCI bridge to [bus 06]
[  300.314324] pci 0000:05:00.0:   bridge window [mem 0xda000000-0xda0fffff]

What is to be done?

	Regards
		Oliver


JFYI, a boot with devices plugged in:

[    3.972037] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    3.972042] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.972248] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug PME]
[    3.972443] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability LTR]
[    3.972444] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    3.974162] PCI host bridge to bus 0000:00
[    3.974164] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    3.974165] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    3.974166] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    3.974167] pci_bus 0000:00: root bus resource [mem 0x3e800000-0xefffffff window]
[    3.974168] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    3.974169] pci_bus 0000:00: root bus resource [bus 00-7e]
[    3.974176] pci 0000:00:00.0: [8086:1910] type 00 class 0x060000
[    3.974797] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
[    3.974831] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    3.975516] pci 0000:00:02.0: [8086:191b] type 00 class 0x030000
[    3.975524] pci 0000:00:02.0: reg 0x10: [mem 0xdb000000-0xdbffffff 64bit]
[    3.975529] pci 0000:00:02.0: reg 0x18: [mem 0x50000000-0x5fffffff 64bit pref]
[    3.975532] pci 0000:00:02.0: reg 0x20: [io  0x6000-0x603f]
[    3.975544] pci 0000:00:02.0: BAR 2: assigned to efifb
[    3.976225] pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
[    3.976245] pci 0000:00:14.0: reg 0x10: [mem 0xdc320000-0xdc32ffff 64bit]
[    3.976302] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    3.976941] pci 0000:00:14.2: [8086:a131] type 00 class 0x118000
[    3.976959] pci 0000:00:14.2: reg 0x10: [mem 0xdc34a000-0xdc34afff 64bit]
[    3.977626] pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
[    3.977649] pci 0000:00:16.0: reg 0x10: [mem 0xdc34b000-0xdc34bfff 64bit]
[    3.977715] pci 0000:00:16.0: PME# supported from D3hot
[    3.978367] pci 0000:00:17.0: [8086:a102] type 00 class 0x010601
[    3.978382] pci 0000:00:17.0: reg 0x10: [mem 0xdc348000-0xdc349fff]
[    3.978388] pci 0000:00:17.0: reg 0x14: [mem 0xdc34e000-0xdc34e0ff]
[    3.978394] pci 0000:00:17.0: reg 0x18: [io  0x6080-0x6087]
[    3.978400] pci 0000:00:17.0: reg 0x1c: [io  0x6088-0x608b]
[    3.978406] pci 0000:00:17.0: reg 0x20: [io  0x6040-0x605f]
[    3.978413] pci 0000:00:17.0: reg 0x24: [mem 0xdc34c000-0xdc34c7ff]
[    3.978447] pci 0000:00:17.0: PME# supported from D3hot
[    3.979093] pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400
[    3.979151] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    3.979819] pci 0000:00:1c.1: [8086:a111] type 01 class 0x060400
[    3.979878] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    3.980531] pci 0000:00:1c.4: [8086:a114] type 01 class 0x060400
[    3.980588] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    3.981268] pci 0000:00:1f.0: [8086:a150] type 00 class 0x060100
[    3.981958] pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
[    3.981970] pci 0000:00:1f.2: reg 0x10: [mem 0xdc340000-0xdc343fff]
[    3.982631] pci 0000:00:1f.3: [8086:a170] type 00 class 0x040380
[    3.982654] pci 0000:00:1f.3: reg 0x10: [mem 0xdc344000-0xdc347fff 64bit]
[    3.982677] pci 0000:00:1f.3: reg 0x20: [mem 0xdc330000-0xdc33ffff 64bit]
[    3.982719] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    3.983382] pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
[    3.983435] pci 0000:00:1f.4: reg 0x10: [mem 0xdc34d000-0xdc34d0ff 64bit]
[    3.983484] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    3.984226] pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
[    3.984252] pci 0000:00:1f.6: reg 0x10: [mem 0xdc300000-0xdc31ffff]
[    3.984355] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    3.985035] pci 0000:01:00.0: [1002:6820] type 00 class 0x030000
[    3.985055] pci 0000:01:00.0: reg 0x10: [mem 0x40000000-0x4fffffff 64bit pref]
[    3.985065] pci 0000:01:00.0: reg 0x18: [mem 0xdc000000-0xdc03ffff 64bit]
[    3.985072] pci 0000:01:00.0: reg 0x20: [io  0x3000-0x30ff]
[    3.985084] pci 0000:01:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
[    3.985130] pci 0000:01:00.0: supports D1 D2
[    3.985131] pci 0000:01:00.0: PME# supported from D1 D2 D3hot
[    3.985190] pci 0000:01:00.1: [1002:aab0] type 00 class 0x040300
[    3.985208] pci 0000:01:00.1: reg 0x10: [mem 0xdc040000-0xdc043fff 64bit]
[    3.985272] pci 0000:01:00.1: supports D1 D2
[    3.985336] pci 0000:00:01.0: PCI bridge to [bus 01]
[    3.985338] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
[    3.985339] pci 0000:00:01.0:   bridge window [mem 0xdc000000-0xdc0fffff]
[    3.985342] pci 0000:00:01.0:   bridge window [mem 0x40000000-0x4fffffff 64bit pref]
[    3.985645] pci 0000:02:00.0: [8086:24f3] type 00 class 0x028000
[    3.985737] pci 0000:02:00.0: reg 0x10: [mem 0xdc100000-0xdc101fff 64bit]
[    3.985943] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    3.986498] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    3.986501] pci 0000:00:1c.0:   bridge window [mem 0xdc100000-0xdc1fffff]
[    3.986558] pci 0000:03:00.0: [10ec:525a] type 00 class 0xff0000
[    3.986588] pci 0000:03:00.0: reg 0x14: [mem 0xdc200000-0xdc200fff]
[    3.986686] pci 0000:03:00.0: supports D1 D2
[    3.986687] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    3.986834] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    3.986837] pci 0000:00:1c.1:   bridge window [io  0x4000-0x5fff]
[    3.986839] pci 0000:00:1c.1:   bridge window [mem 0xdc200000-0xdc2fffff]
[    3.986893] pci 0000:04:00.0: [8086:1578] type 01 class 0x060400
[    3.986942] pci 0000:04:00.0: enabling Extended Tags
[    3.987008] pci 0000:04:00.0: supports D1 D2
[    3.987009] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.987133] pci 0000:00:1c.4: PCI bridge to [bus 04-6e]
[    3.987136] pci 0000:00:1c.4:   bridge window [mem 0xac000000-0xda0fffff]
[    3.987139] pci 0000:00:1c.4:   bridge window [mem 0x60000000-0xa9ffffff 64bit pref]
[    3.987188] pci 0000:05:00.0: [8086:1578] type 01 class 0x060400
[    3.987238] pci 0000:05:00.0: enabling Extended Tags
[    3.987307] pci 0000:05:00.0: supports D1 D2
[    3.987308] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.987377] pci 0000:05:01.0: [8086:1578] type 01 class 0x060400
[    3.987429] pci 0000:05:01.0: enabling Extended Tags
[    3.987497] pci 0000:05:01.0: supports D1 D2
[    3.987498] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.987564] pci 0000:05:02.0: [8086:1578] type 01 class 0x060400
[    3.987615] pci 0000:05:02.0: enabling Extended Tags
[    3.987682] pci 0000:05:02.0: supports D1 D2
[    3.987683] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.987750] pci 0000:05:04.0: [8086:1578] type 01 class 0x060400
[    3.987803] pci 0000:05:04.0: enabling Extended Tags
[    3.987871] pci 0000:05:04.0: supports D1 D2
[    3.987871] pci 0000:05:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.987954] pci 0000:04:00.0: PCI bridge to [bus 05-6e]
[    3.987961] pci 0000:04:00.0:   bridge window [mem 0xac000000-0xda0fffff]
[    3.987966] pci 0000:04:00.0:   bridge window [mem 0x60000000-0xa9ffffff 64bit pref]
[    3.988003] pci 0000:05:00.0: PCI bridge to [bus 06]
[    3.988011] pci 0000:05:00.0:   bridge window [mem 0xda000000-0xda0fffff]
[    3.988052] pci 0000:05:01.0: PCI bridge to [bus 07-39]
[    3.988059] pci 0000:05:01.0:   bridge window [mem 0xac000000-0xc3efffff]
[    3.988065] pci 0000:05:01.0:   bridge window [mem 0x60000000-0x7fffffff 64bit pref]
[    3.988116] pci 0000:3a:00.0: [8086:15b6] type 00 class 0x0c0330
[    3.988148] pci 0000:3a:00.0: reg 0x10: [mem 0xc3f00000-0xc3f0ffff]
[    3.988220] pci 0000:3a:00.0: enabling Extended Tags
[    3.988310] pci 0000:3a:00.0: supports D1 D2
[    3.988311] pci 0000:3a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.988434] pci 0000:05:02.0: PCI bridge to [bus 3a]
[    3.988441] pci 0000:05:02.0:   bridge window [mem 0xc3f00000-0xc3ffffff]
[    3.988482] pci 0000:05:04.0: PCI bridge to [bus 3b-6e]
[    3.988489] pci 0000:05:04.0:   bridge window [mem 0xc4000000-0xd9ffffff]
[    3.988494] pci 0000:05:04.0:   bridge window [mem 0x80000000-0xa9ffffff 64bit pref]
