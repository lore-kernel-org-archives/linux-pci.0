Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36454 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbdBDVof (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Feb 2017 16:44:35 -0500
Received: by mail-ua0-f196.google.com with SMTP id f2so4293848uaf.3
        for <linux-pci@vger.kernel.org>; Sat, 04 Feb 2017 13:44:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170204185607.GA29957@wunner.de>
References: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com>
 <20170203055200.GA29413@wunner.de> <CAE9FiQWs0H9vqEo2ZYnWWBW0Ao-hx4WYHQ69cyR32nFQ9yV9rw@mail.gmail.com>
 <20170204081254.GA29595@wunner.de> <20170204185607.GA29957@wunner.de>
From: Yinghai Lu <yinghai@kernel.org>
Date: Sat, 4 Feb 2017 13:44:34 -0800
Message-ID: <CAE9FiQUuFJHMScyFgnHbs5r-SzTiRiBZ2JcpUYJhg0ft75-OBQ@mail.gmail.com>
Subject: Re: pciehp is broken from 4.10-rc1
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 4, 2017 at 10:56 AM, Lukas Wunner <lukas@wunner.de> wrote:
> On Sat, Feb 04, 2017 at 09:12:54AM +0100, Lukas Wunner wrote:
>
> Section 6.7.3.4 of the PCIe Base spec seems to support the theory above,
> so here's a tentative patch.
>
>
> -- >8 --
> Subject: [PATCH] PCI: pciehp: Don't enable PME on runtime suspend

it works:
sca05-0a81e0bc:~ # echo 0 > /sys/bus/pci/slots/8/power
[  176.983229] pci_hotplug: power_write_file: power = 0
[  176.988945] pciehp 0000:60:03.2:pcie004: pciehp_get_power_status:
SLOTCTRL a8 value read 11f1
[  176.998482] pciehp 0000:60:03.2:pcie004: pciehp_unconfigure_device:
domain:bus:dev = 0000:65:00
[  177.008215] mlx4_core 0000:65:00.0: PME# disabled
[  178.817209] iommu: Removing device 0000:65:00.0 from group 172
[  178.829869] pcieport 0000:60:03.2:   root_bridge ACPI_HANDLE
ffff9059bb00ce88 : pci0000:60
[  178.839114] pcieport 0000:60:03.2:  pciehp is native
[  178.844717] pci 0000:65:00.0: freeing pci_dev info
[  178.854842] pciehp 0000:60:03.2:pcie004: Timeout on hotplug command
0x11f1 (issued 97032 msec ago)
[  178.865199] pciehp 0000:60:03.2:pcie004: pending interrupts 0x0010
from Slot Status
[  178.873890] pciehp 0000:60:03.2:pcie004: pciehp_power_off_slot:
SLOTCTRL a8 write cmd 400
[  178.937499] pciehp 0000:60:03.2:pcie004: pending interrupts 0x0100
from Slot Status
[  178.946052] pciehp 0000:60:03.2:pcie004: Slot(8): Link Down
[  178.952422] pciehp 0000:60:03.2:pcie004: Slot(8): Link Down event
ignored; already powering off
[  179.894895] pciehp 0000:60:03.2:pcie004: pciehp_green_led_off:
SLOTCTRL a8 write cmd 300
[  179.903941] pciehp 0000:60:03.2:pcie004: pending interrupts 0x0010
from Slot Status

sca05-0a81e0bc:~ #
sca05-0a81e0bc:~ #
sca05-0a81e0bc:~ # echo 1 > /sys/bus/pci/slots/8/power
[  222.136244] pci_hotplug: power_write_file: power = 1
[  222.141818] pciehp 0000:60:03.2:pcie004: pciehp_get_power_status:
SLOTCTRL a8 value read 17f1
[  222.151710] pciehp 0000:60:03.2:pcie004: pending interrupts 0x0010
from Slot Status
[  222.160303] pciehp 0000:60:03.2:pcie004: pciehp_power_on_slot:
SLOTCTRL a8 write cmd 0
[  222.169156] pciehp 0000:60:03.2:pcie004: pciehp_green_led_blink:
SLOTCTRL a8 write cmd 200
[  222.178395] pciehp 0000:60:03.2:pcie004: pending interrupts 0x0010
from Slot Status
[  222.204325] pciehp 0000:60:03.2:pcie004: pending interrupts 0x0010
from Slot Status
[  222.784102] pciehp 0000:60:03.2:pcie004: pciehp_check_link_active:
lnk_status = f083
[  222.792750] pciehp 0000:60:03.2:pcie004: pending interrupts 0x0100
from Slot Status
[  222.801297] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up
[  222.807358] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up event
ignored; already powering on
[  222.807409] pciehp 0000:60:03.2:pcie004: pciehp_check_link_active:
lnk_status = f083
[  222.968062] pciehp 0000:60:03.2:pcie004: pciehp_check_link_status:
lnk_status = f083
[  222.976922] pci 0000:65:00.0: [15b3:1003] type 00 class 0x0c0600
[  222.983864] pci 0000:65:00.0: reg 0x10: [mem 0x00000000-0x000fffff 64bit]
[  222.991598] pci 0000:65:00.0: reg 0x18: [mem 0x00000000-0x07ffffff
64bit pref]
[  222.999979] pci_bus 0000:65:   bridge ACPI_HANDLE ffff9019bb0d0438
: 0000:60:03.2
[  223.010044] pci 0000:65:00.0: reg 0x134: [mem 0x00000000-0x07ffffff
64bit pref]
[  223.018214] pci 0000:65:00.0: VF(n) BAR2 space: [mem
0x00000000-0x1ffffffff 64bit pref] (contains BAR2 for 64 VFs)
[  223.033412] pci 0000:65:00.0: on_all_pcie_path: 1
[  223.040666] iommu: Adding device 0000:65:00.0 to group 172
[  223.047042] pci 0000:65:00.0: BAR 2: assigned [mem
0x387bf8000000-0x387bffffffff 64bit pref]
[  223.056589] pci 0000:65:00.0: BAR 9: assigned [mem
0x3879f8000000-0x387bf7ffffff 64bit pref]
[  223.066068] pci 0000:65:00.0: BAR 0: [mem size 0x00100000 64bit] + pref
[  223.073464] pci 0000:65:00.0: BAR 0: assigned [mem
0x3879f7f00000-0x3879f7ffffff 64bit]
[  223.082527] pcieport 0000:60:03.2: PCI bridge to [bus 65-67]
[  223.088864] pcieport 0000:60:03.2:   bridge window [io  0xa000-0xafff]
[  223.096161] pcieport 0000:60:03.2:   bridge window [mem
0xc0000000-0xc3ffffff]
[  223.104229] pcieport 0000:60:03.2:   bridge window [mem
0x387800000000-0x387bffffffff 64bit pref]
[  223.114152] pcieport 0000:60:03.2: Max Payload Size set to  256/
256 (was  256), Max Read Rq  128
[  223.124152] pci 0000:65:00.0: Max Payload Size set to  256/ 256
(was  128), Max Read Rq  512
[  223.133597] pci 0000:65:00.0: calling
mellanox_check_broken_intx_masking+0x0/0x130
[  223.142055] calling  mellanox_check_broken_intx_masking+0x0/0x130 @
16969 for 0000:65:00.0
[  223.151291] pci fixup mellanox_check_broken_intx_masking+0x0/0x130
returned after 0 usecs for 0000:65:00.0
[  223.162157] pcieport 0000:60:03.2:   root_bridge ACPI_HANDLE
ffff9059bb00ce88 : pci0000:60
[  223.171395] pcieport 0000:60:03.2:  pciehp is native
[  223.177183] mlx4_core: Initializing 0000:65:00.0
[  223.182374] mlx4_core 0000:65:00.0: enabling device (0140 -> 0142)
...
[  231.714671] pciehp 0000:60:03.2:pcie004: pciehp_green_led_on:
SLOTCTRL a8 write cmd 100
[  232.728377] pciehp 0000:60:03.2:pcie004: Timeout on hotplug command
0x11f1 (issued 1016 msec ago)
[  232.738298] pciehp 0000:60:03.2:pcie004:
pciehp_set_attention_status: SLOTCTRL a8 write cmd c0
