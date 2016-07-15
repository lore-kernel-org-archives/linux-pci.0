Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38356 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbcGOUdf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2016 16:33:35 -0400
Received: by mail-wm0-f41.google.com with SMTP id o80so44285962wme.1
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2016 13:33:35 -0700 (PDT)
MIME-Version: 1.0
From: Kallol Biswas <kallol@nucleodyne.com>
Date: Fri, 15 Jul 2016 13:33:32 -0700
Message-ID: <CAH=XD5-6QXxA42ukxJ40sOzGXqScS7u3QZAwCaCYT2r3pJxdCA@mail.gmail.com>
Subject: No bus number available for hot-added bridge
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
   I have been trying to hot-add a PCIe bridge and getting the
following message in dmesg:

No bus number available for hot-added bridge 0000:06:00.

The kernel is 4.4. Do we have any patch for this?  I tried Yinghai's
for-pci-busn-alloc patch. Did not work. Not sure I picked up the right
changes.

Any input...

[  793.982780] pciehp 0000:05:00.0:pcie24: pciehp_check_link_active:
lnk_status = a103
[  793.982783] pciehp 0000:05:00.0:pcie24: slot(0-1): Link Up event
[  793.982815] pciehp 0000:05:00.0:pcie24: pciehp_get_power_status:
SLOTCTRL 80 value read 1571
[  793.982835] pciehp 0000:05:00.0:pcie24: pending interrupts 0x0010
from Slot Status
[  793.982841] pciehp 0000:05:00.0:pcie24: pciehp_power_on_slot:
SLOTCTRL 80 write cmd 0
[  793.982847] pciehp 0000:05:00.0:pcie24: __pciehp_link_set: lnk_ctrl = 0
[  793.982859] pciehp 0000:05:00.0:pcie24: pending interrupts 0x0010
from Slot Status
[  793.982865] pciehp 0000:05:00.0:pcie24: pciehp_green_led_blink:
SLOTCTRL 80 write cmd 200
[  793.982871] pciehp 0000:05:00.0:pcie24: pciehp_check_link_active:
lnk_status = a103
[  794.085818] pciehp 0000:05:00.0:pcie24: pciehp_check_link_status:
lnk_status = a103
[  794.085909] pci 0000:06:00.0: [10b5:9797] type 01 class 0x060400
[  794.086232] pci 0000:06:00.0: Max Payload Size set to 256 (was 128, max 512)
[  794.086563] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[  794.086884] iommu: Adding device 0000:06:00.0 to group 47
[  794.093797] No bus number available for hot-added bridge 0000:06:00.0
[  794.093816] pcieport 0000:05:00.0: PCI bridge to [bus 06]
[  794.093822] pcieport 0000:05:00.0:   bridge window [io  0x1000-0x1fff]
[  794.093829] pcieport 0000:05:00.0:   bridge window [mem
0xc8000000-0xc83fffff]
[  794.093835] pcieport 0000:05:00.0:   bridge window [mem
0x280000000-0x2801fffff 64bit pref]
[  794.094364] pciehp 0000:05:00.0:pcie24: pending interrupts 0x0010
from Slot Status
[  794.094369] pciehp 0000:05:00.0:pcie24: pciehp_green_led_on:
SLOTCTRL 80 write cmd 100
