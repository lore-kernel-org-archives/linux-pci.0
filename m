Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56693 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932566AbeCMKpk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Mar 2018 06:45:40 -0400
From: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Subject: PCI enumeration broken on Ventana gw5200
To: linux-pci@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Message-ID: <b440214a-0768-38a4-9410-9eedc7a79dca@green-communications.fr>
Date: Tue, 13 Mar 2018 11:45:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When testing v4.16-rc2 on a Ventana gw5200, the mini-PCIe cards were
not recognised.  Only the bridge was recognised.

With v4.12.10, mini-PCIe cards were recognized and worked:


pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
pci 0000:00:00.0: supports D1
pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
PCI: bus0: Fast back to back transfers disabled
pci 0000:01:00.0: [10b5:8604] type 01 class 0x060400
pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0001ffff]
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
PCI: bus1: Fast back to back transfers disabled
pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci_bus 0000:02: busn_res: can not insert [bus 02-ff] under [bus 01] (conflicts
 with (null) [bus 01])
pci 0000:02:01.0: [10b5:8604] type 01 class 0x060400
pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
pci 0000:02:04.0: [10b5:8604] type 01 class 0x060400
pci 0000:02:04.0: PME# supported from D0 D3hot D3cold
pci 0000:02:05.0: [10b5:8604] type 01 class 0x060400
pci 0000:02:05.0: PME# supported from D0 D3hot D3cold
PCI: bus2: Fast back to back transfers disabled
pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:03:00.0: [168c:0030] type 00 class 0x028000
pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
pci 0000:03:00.0: supports D1
pci 0000:03:00.0: PME# supported from D0 D1 D3hot
PCI: bus3: Fast back to back transfers disabled
pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
pci_bus 0000:03: [bus 03] partially hidden behind bridge 0000:01 [bus 01]
PCI: bus4: Fast back to back transfers enabled
pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
pci_bus 0000:04: [bus 04] partially hidden behind bridge 0000:01 [bus 01]
PCI: bus5: Fast back to back transfers enabled
pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
pci_bus 0000:05: [bus 05] partially hidden behind bridge 0000:01 [bus 01]
pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 05
pci_bus 0000:02: busn_res: can not insert [bus 02-05] under [bus 01] (conflicts
 with (null) [bus 01])
pci_bus 0000:02: [bus 02-05] partially hidden behind bridge 0000:01 [bus 01]
pci 0000:00:00.0: bridge has subordinate 01 but max busn 05
pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x012fffff]
pci 0000:00:00.0: BAR 6: assigned [mem 0x01300000-0x0130ffff pref]
pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0x01200000-0x0121ffff]
pci 0000:02:01.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
pci 0000:03:00.0: BAR 0: assigned [mem 0x01100000-0x0111ffff 64bit]
 0000:03:00.0: BAR 6: assigned [mem 0x01120000-0x0112ffff pref]
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0:   bridge window [mem 0x01100000-0x011fffff]
pci 0000:02:04.0: PCI bridge to [bus 04]
pci 0000:02:05.0: PCI bridge to [bus 05]
pci 0000:01:00.0: PCI bridge to [bus 02-05]
pci 0000:01:00.0:   bridge window [mem 0x01100000-0x011fffff]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [mem 0x01100000-0x012fffff]
pcieport 0000:00:00.0: Signaling PME with IRQ 298
pcieport 0000:01:00.0: enabling device (0140 -> 0142)
pcieport 0000:02:01.0: enabling device (0140 -> 0142)


This message:
pci 0000:00:00.0: bridge has subordinate 01 but max busn 05
Seems to indicate that Linux reconfigured the bridges incorrectly, Yet
the PCIe devices worked fine anyway.

With v4.16-rc2, 0000:01's bridge is left configured to [bus 2] only
(because first pass thinks that the configuration is valid), thus no
child busses are enumerated :


pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
pci_bus 0000:00: scanning bus
pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x54
pci 0000:00:00.0: supports D1
pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
pci 0000:00:00.0: PME# disabled
pci_bus 0000:00: fixups for bus
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
pci_bus 0000:01: scanning bus
pci 0000:01:00.0: [10b5:8604] type 01 class 0x060400
pci 0000:01:00.0: calling ventana_pciesw_early_fixup+0x0/0xb0
pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0001ffff]
pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x54
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
pci 0000:01:00.0: PME# disabled
pci_bus 0000:01: fixups for bus
PCI: bus1: Fast back to back transfers disabled
pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:02: busn_res: can not insert [bus 02-01] under [bus 01] (conflicts
 with (null) [bus 01])
pci_bus 0000:02: scanning bus
pci_bus 0000:02: fixups for bus
PCI: bus2: Fast back to back transfers enabled
pci_bus 0000:02: bus scan returning with max=02
pci_bus 0000:02: busn_res: [bus 02-01] end is updated to 02
pci_bus 0000:02: busn_res: can not insert [bus 02] under [bus 01] (conflicts
 with (null) [bus 01])
pci_bus 0000:02: [bus 02] partially hidden behind bridge 0000:01 [bus 01]
pci_bus 0000:01: bus scan returning with max=02
pci 0000:00:00.0: bridge has subordinate 01 but max busn 02
pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 1
pci_bus 0000:00: bus scan returning with max=01
pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
pci 0000:00:00.0: BAR 6: assigned [mem 0x01200000-0x0120ffff pref]
pci 0000:01:00.0: BAR 0: assigned [mem 0x01100000-0x0111ffff]
pci 0000:01:00.0: PCI bridge to [bus 02]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff]
pcieport 0000:00:00.0: assign IRQ: got 330
pcieport 0000:00:00.0: Signaling PME with IRQ 298
pcieport 0000:00:00.0: AER enabled with IRQ 298
pcieport 0000:01:00.0: assign IRQ: got 330
pcieport 0000:01:00.0: enabling device (0140 -> 0142)
pcieport 0000:01:00.0: enabling bus mastering


One change apparently made the problem worse:
a20c7f36 ("PCI: Do not allocate more buses than available in parent")
assumes that the parent's bus end is valid when setting the limit for their
childrens.  If I revert that and further hack probe.c's
pci_scan_bridge_extend() by initializing 'broken' to 1 instead of 0, then
things appear to be configured correctly:


PCI: OF: host bridge /soc/pcie@1ffc000 ranges:
PCI: OF: Parsing ranges property...
PCI: OF:    IO 0x01f80000..0x01f8ffff -> 0x00000000
PCI: OF:   MEM 0x01000000..0x01efffff -> 0x01000000
imx6q-pcie 1ffc000.pcie: link up
imx6q-pcie 1ffc000.pcie: link up
imx6q-pcie 1ffc000.pcie: Link up, Gen2
imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
pci_bus 0000:00: scanning bus
pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x54
pci 0000:00:00.0: supports D1
pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
pci 0000:00:00.0: PME# disabled
pci_bus 0000:00: fixups for bus
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:01: scanning bus
pci 0000:01:00.0: [10b5:8604] type 01 class 0x060400
pci 0000:01:00.0: calling ventana_pciesw_early_fixup+0x0/0xb0
pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0001ffff]
pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x54
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
pci 0000:01:00.0: PME# disabled
pci_bus 0000:01: fixups for bus
PCI: bus1: Fast back to back transfers disabled
pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:02: scanning bus
pci 0000:02:01.0: [10b5:8604] type 01 class 0x060400
pci 0000:02:01.0: calling ventana_pciesw_early_fixup+0x0/0xb0
pci 0000:02:01.0: calling pci_fixup_ide_bases+0x0/0x54
pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
pci 0000:02:01.0: PME# disabled
pci 0000:02:04.0: [10b5:8604] type 01 class 0x060400
pci 0000:02:04.0: calling ventana_pciesw_early_fixup+0x0/0xb0
pci 0000:02:04.0: calling pci_fixup_ide_bases+0x0/0x54
pci 0000:02:04.0: PME# supported from D0 D3hot D3cold
pci 0000:02:04.0: PME# disabled
pci 0000:02:05.0: [10b5:8604] type 01 class 0x060400
pci 0000:02:05.0: calling ventana_pciesw_early_fixup+0x0/0xb0
pci 0000:02:05.0: calling pci_fixup_ide_bases+0x0/0x54
pci 0000:02:05.0: PME# supported from D0 D3hot D3cold
pci 0000:02:05.0: PME# disabled
pci_bus 0000:02: fixups for bus
PCI: bus2: Fast back to back transfers disabled
pci 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:04.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:02:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:05.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:02:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:03: scanning bus
pci_bus 0000:03: fixups for bus
PCI: bus3: Fast back to back transfers enabled
pci_bus 0000:03: bus scan returning with max=03
pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
pci 0000:02:04.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:04: scanning bus
pci_bus 0000:04: fixups for bus
PCI: bus4: Fast back to back transfers enabled
pci_bus 0000:04: bus scan returning with max=04
pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
pci 0000:02:05.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:05: scanning bus
pci 0000:05:00.0: [168c:0030] type 00 class 0x028000
pci 0000:05:00.0: reg 0x10: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:05:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
pci 0000:05:00.0: calling pci_fixup_ide_bases+0x0/0x54
pci 0000:05:00.0: calling quirk_no_bus_reset+0x0/0x20
pci 0000:05:00.0: supports D1
pci 0000:05:00.0: PME# supported from D0 D1 D3hot
pci 0000:05:00.0: PME# disabled
pci_bus 0000:05: fixups for bus
PCI: bus5: Fast back to back transfers disabled
pci_bus 0000:05: bus scan returning with max=05
pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
pci_bus 0000:02: bus scan returning with max=05
pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 05
pci_bus 0000:01: bus scan returning with max=05
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 05
pci_bus 0000:00: bus scan returning with max=05
pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x012fffff]
pci 0000:00:00.0: BAR 6: assigned [mem 0x01300000-0x0130ffff pref]
pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0x01200000-0x0121ffff]
pci 0000:02:05.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:04.0: PCI bridge to [bus 04]
pci 0000:05:00.0: BAR 0: assigned [mem 0x01100000-0x0111ffff 64bit]
pci 0000:05:00.0: BAR 6: assigned [mem 0x01120000-0x0112ffff pref]
pci 0000:02:05.0: PCI bridge to [bus 05]
pci 0000:02:05.0:   bridge window [mem 0x01100000-0x011fffff]
pci 0000:01:00.0: PCI bridge to [bus 02-05]
pci 0000:01:00.0:   bridge window [mem 0x01100000-0x011fffff]
pci 0000:00:00.0: PCI bridge to [bus 01-05]
pci 0000:00:00.0:   bridge window [mem 0x01100000-0x012fffff]
pcieport 0000:00:00.0: assign IRQ: got 330
pcieport 0000:00:00.0: Signaling PME with IRQ 298
pcieport 0000:00:00.0: AER enabled with IRQ 298
pcieport 0000:01:00.0: assign IRQ: got 330
pcieport 0000:01:00.0: enabling device (0140 -> 0142)
pcieport 0000:01:00.0: enabling bus mastering
pcieport 0000:02:01.0: assign IRQ: got 331
pcieport 0000:02:01.0: enabling bus mastering
pcieport 0000:02:04.0: assign IRQ: got 330
pcieport 0000:02:04.0: enabling bus mastering
pcieport 0000:02:05.0: assign IRQ: got 331
pcieport 0000:02:05.0: enabling device (0140 -> 0142)
pcieport 0000:02:05.0: enabling bus mastering


I don't know much about PCI or the PCI subsystem, so i do not know what
would be a proper solution.  Maybe a minimal change would be to add a
command line option that would tell pci_scan_bridge_extend() that
everything is broken ?
