Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f182.google.com ([74.125.82.182]:33436 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754568AbdC2NmF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2017 09:42:05 -0400
Received: by mail-ot0-f182.google.com with SMTP id 102so10354601otv.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2017 06:42:04 -0700 (PDT)
MIME-Version: 1.0
From: Mattias Barthel <mattiasbarthel@gmail.com>
Date: Wed, 29 Mar 2017 15:42:03 +0200
Message-ID: <CAFChf7Kw5ighAMXD08tf9+jNNdkORzumGL2hO=OBO27qiaL1-g@mail.gmail.com>
Subject: IMX6SX PCIe speed change test upon link establishment
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I am working with bringing PCIe support to 4.8.
I have ported the pci phy regulator via power domain from 4.1.15_2.0.0
to  4.8. (4.8 what I was told to use by my company but I will probably
port this to 4.9 too).

The pci_imx6 driver is now loading and the link seems to come up after
some tweaks.
The link start in the 4.8 is a bit different than in 4.1,
For example the speed change test is erroneous in 4.1 since it checks
for count == 0 but since count is postdecremented it will become -1
before the check. So the speed change failure will never be detected.

tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
tmp |= PORT_LOGIC_SPEED_CHANGE;
writel(tmp, pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);

count = 2000;
while (count--) {
tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
/* Test if the speed change finished. */
if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
break;
udelay(10);
}

I found a discussion regarding the speed change test upon link establishment:
https://patchwork.kernel.org/patch/6458251/

How important is this speed change test for link establishments?

Here follows some output from pci loading in 4.8:

smartoptics-dcp:~# dmesg | grep -i pci
PCI: CLS 0 bytes, default 64
imx6_pcie_probe
OF: PCI: host bridge /soc/pcie@0x08000000 ranges:
OF: PCI:   No bus range found for /soc/pcie@0x08000000, using [bus 00-ff]
OF: PCI:    IO 0x08f80000..0x08f8ffff -> 0x00000000
OF: PCI:   MEM 0x08000000..0x08efffff -> 0x08000000
imx6q-pcie 8ffc000.pcie: link up
imx6q-pcie 8ffc000.pcie: link up
imx6q-pcie 8ffc000.pcie: Link up, Gen1
imx6q-pcie 8ffc000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x08000000-0x08efffff]
pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
pci 0000:00:00.0: supports D1
pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
PCI: bus0: Fast back to back transfers disabled
pci 0000:01:00.0: [8086:08b1] type 00 class 0x028000
pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
PCI: bus1: Fast back to back transfers disabled
pci 0000:00:00.0: BAR 0: assigned [mem 0x08000000-0x080fffff]
pci 0000:00:00.0: BAR 8: assigned [mem 0x08100000-0x081fffff]
pci 0000:00:00.0: BAR 6: assigned [mem 0x08200000-0x0820ffff pref]
pci 0000:01:00.0: BAR 0: assigned [mem 0x08100000-0x08101fff 64bit]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [mem 0x08100000-0x081fffff]
pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
pci 0000:01:00.0: Signaling PME through PCIe PME inblock ubiblock0_10:
created from ubi0:10(rootfs1)
terrupt
pcie_pme 0000:00:00.0:pcie001: service driver pcie_pme loaded
aer 0000:00:00.0:pcie002: service driver aer loaded

smartoptics-dcp:~# lspci
00:00.0 Class 0604: 16c3:abcd
01:00.0 Class 0280: 8086:08b1



Regards,

Mattias

-- 
Mattias Barthel
