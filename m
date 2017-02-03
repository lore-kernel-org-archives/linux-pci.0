Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34676 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbdBCELu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2017 23:11:50 -0500
Received: by mail-vk0-f67.google.com with SMTP id r136so618069vke.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Feb 2017 20:11:50 -0800 (PST)
MIME-Version: 1.0
From: Yinghai Lu <yinghai@kernel.org>
Date: Thu, 2 Feb 2017 20:11:48 -0800
Message-ID: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com>
Subject: pciehp is broken from 4.10-rc1
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

4.9 is  working,

sca05-0a81e0db:~ # uname -a
Linux sca05-0a81e0db 4.9.0-yh #28 SMP Thu Feb 2 18:19:00 PST 2017
x86_64 x86_64 x86_64 GNU/Linux

sca05-0a81e0db:~ # echo 0 > /sys/bus/pci/slots/8/power
[  130.641527] mlx4_core 0000:65:00.0: PME# disabled
[  132.114003] iommu: Removing device 0000:65:00.0 from group 172
[  132.133504] pciehp 0000:60:03.2:pcie004: Timeout on hotplug command
0x11f1 (issued 70480 msec ago)
[  132.216228] pciehp 0000:60:03.2:pcie004: Slot(8): Link Down
[  132.222477] pciehp 0000:60:03.2:pcie004: Slot(8): Link Down event
ignored; already powering off
sca05-0a81e0db:~ # echo 1 > /sys/bus/pci/slots/8/power
[  175.771846] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up
[  175.777898] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up event
ignored; already powering on
[  175.956632] pci 0000:65:00.0: [15b3:1003] type 00 class 0x0c0600
[  175.963581] pci 0000:65:00.0: reg 0x10: [mem 0x00000000-0x000fffff 64bit]
[  175.971312] pci 0000:65:00.0: reg 0x18: [mem 0x00000000-0x07ffffff
64bit pref]
[  175.980100] pci 0000:65:00.0: calling quirk_broken_intx_masking+0x0/0x20
[  175.987590] calling  quirk_broken_intx_masking+0x0/0x20 @ 16793 for
0000:65:00.0
[  175.995855] pci fixup quirk_broken_intx_masking+0x0/0x20 returned
after 0 usecs for 0000:65:00.0
[  176.006876] pci 0000:65:00.0: reg 0x134: [mem 0x00000000-0x07ffffff
64bit pref]
[  176.015045] pci 0000:65:00.0: VF(n) BAR2 space: [mem
0x00000000-0x1ffffffff 64bit pref] (contains BAR2 for 64 VFs)
[  176.031852] iommu: Adding device 0000:65:00.0 to group 172
[  176.038263] pci 0000:65:00.0: BAR 2: assigned [mem
0x387800000000-0x387807ffffff 64bit pref]
[  176.047817] pci 0000:65:00.0: BAR 9: assigned [mem
0x387808000000-0x387a07ffffff 64bit pref]
[  176.057363] pci 0000:65:00.0: BAR 0: assigned [mem
0xc0000000-0xc00fffff 64bit]
[  176.065657] pcieport 0000:60:03.2: PCI bridge to [bus 65-67]
[  176.071983] pcieport 0000:60:03.2:   bridge window [io  0xa000-0xafff]
[  176.079277] pcieport 0000:60:03.2:   bridge window [mem
0xc0000000-0xc3ffffff]
[  176.087348] pcieport 0000:60:03.2:   bridge window [mem
0x387800000000-0x387bffffffff 64bit pref]
[  176.097267] pcieport 0000:60:03.2: Max Payload Size set to  256/
256 (was  256), Max Read Rq  128
[  176.107253] pci 0000:65:00.0: Max Payload Size set to  256/ 256
(was  128), Max Read Rq  512
[  176.116910] mlx4_core: Initializing 0000:65:00.0
[  176.122103] mlx4_core 0000:65:00.0: enabling device (0140 -> 0142)
[  176.129142] mlx4_core 0000:65:00.0: enabling bus mastering
[  182.909586] mlx4_core 0000:65:00.0: Old device ETS support detected
[  182.916585] mlx4_core 0000:65:00.0: Consider upgrading device FW.
[  183.725530] mlx4_core 0000:65:00.0: PCIe link speed is 8.0GT/s,
device supports 8.0GT/s
[  183.734471] mlx4_core 0000:65:00.0: PCIe link width is x8, device supports x8
[  184.073280] <mlx4_ib> mlx4_ib_add: counter index 0 for port 1 allocated 0
[  184.080870] <mlx4_ib> mlx4_ib_add: counter index 1 for port 2 allocated 0
[  184.202450] RDS/IB: mlx4_0: FMR supported and preferred

sca05-0a81e0db:~ # uname -a
Linux sca05-0a81e0db 4.10.0-rc1-yh #29 SMP Thu Feb 2 18:45:03 PST 2017
x86_64 x86_64 x86_64 GNU/Linux

sca05-0a81e0db:~ # echo 0 > /sys/bus/pci/slots/8/power
[  141.838027] mlx4_core 0000:65:00.0: PME# disabled
[  143.279434] iommu: Removing device 0000:65:00.0 from group 172
[  143.292329] pcieport 0000:60:03.2: PME# enabled
[  143.297431] pciehp 0000:60:03.2:pcie004: Timeout on hotplug command
0x11f1 (issued 81476 msec ago)
[  143.337545] pcieport 0000:60:03.2: PME# disabled
[  143.380359] pciehp 0000:60:03.2:pcie004: Slot(8): Link Down
[  143.386735] pciehp 0000:60:03.2:pcie004: Slot(8): Link Down event
ignored; already powering off
[  143.445483] pcieport 0000:60:03.2: PME# enabled
[  143.992915] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up
[  143.999004] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up event
queued; currently getting powered off
[  144.025590] pcieport 0000:60:03.2: PME# disabled
[  144.133548] pcieport 0000:60:03.2: PME# enabled
[  144.333603] pciehp 0000:60:03.2:pcie004: Slot(8): Already enabled
sca05-0a81e0db:~ # [  144.357483] pcieport 0000:60:03.2: PME# disabled
[  144.465566] pcieport 0000:60:03.2: PME# enabled

sca05-0a81e0db:~ # echo 1 > /sys/bus/pci/slots/8/power
[  221.041664] pciehp 0000:60:03.2:pcie004: Slot(8): Already enabled

After reverting

>From 68db9bc814362e7f24371c27d12a4f34477d9356 Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 28 Oct 2016 10:52:06 +0200
Subject: PCI: pciehp: Add runtime PM support for PCIe hotplug ports

the hotplug work again.

Thanks

Yinghai
