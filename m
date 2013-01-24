Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:51900 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623Ab3AXWua (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2013 17:50:30 -0500
Received: by mail-vb0-f51.google.com with SMTP id fq11so7988249vbb.10
        for <linux-pci@vger.kernel.org>; Thu, 24 Jan 2013 14:50:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1358219542-16880-1-git-send-email-wangyijing@huawei.com>
References: <1358219542-16880-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 24 Jan 2013 15:45:02 -0700
Message-ID: <CAErSpo6NaQK-BcoadBbVS4LTFzDdDu_JWWGpb8QAFUJ0aU3+gw@mail.gmail.com>
Subject: Re: [PATCH -v3 0/7] ARI device hotplug support
To: Yijing Wang <wangyijing@huawei.com>
Cc: Yu Zhao <yu.zhao@intel.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Scott Murray <scott@spiteful.org>,
	Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com,
	Jack Steiner <steiner@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jack]

On Mon, Jan 14, 2013 at 8:12 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> This patchset mainly to fix pcie ari device hotplug bug.
> The last four based on the comment Bjorn suggested at
> http://marc.info/?l=linux-pci&m=135766710910208&w=2
>
> v1: Oct 9  2012 add disable ari forwarding in pci hotplug drivers
> v2: Oct 16 2012 update ari forwarding in pci_init_capabilities() and
>                                 rework pciehp_configure_device(),pciehp_unconfigure_device
>                                 to traverse all ari function devices.
> v3: Jan 15 2013 use bus->devices list instead of pci_next_fn to traverse
>                                 all pci fun devices.
>
> Commit 58c3a727cb(PCI: support PCIe ARI capability) introduced PCIe ARI
> capability support. pci_enable_ari() was introduced to enable ari forwarding
> bit in pcie port device when a connected pcie ari device was found in pci scan
> path. But system never clear ari forwarding bit regardless of a new non-ari pci
> device hot-inserted in the slot.
>
> PCIe Spec 2.0(6.13/441) recommends:
> "Following a hot-plug event below a Downstream Port, it is strongly recommended
> that software Clear the ARI Forwarding Enable bit in the Downstream Port until
> software determines that a newly added component is in fact an ARI Device"
>
> Following log described The ari device hotplug bug:
> Intel 82576 is PCIe ARI device and Qlogic HBA is non-ari device.
> "hot-remove Intel 82576(slot 201) NIC and Qlogic HBA card(slot 212)"
> pciehp 0000:08:14.0:pcie24: Button pressed on Slot(212)
> pciehp 0000:08:14.0:pcie24: PCI slot #212 - powering off due to button press.
> pciehp 0000:08:09.0:pcie24: Button pressed on Slot(201)
> pciehp 0000:08:09.0:pcie24: PCI slot #201 - powering off due to button press.
> igb 0000:0b:00.0: removed PHC on eth0
> igb 0000:0b:00.1: removed PHC on eth1
> GSI 39 (level, low) -> CPU 16 (0x0200) vector 85 unregistered
> pciehp 0000:08:14.0:pcie24: Latch open on Slot(212)
> pciehp 0000:08:14.0:pcie24: Latch close on Slot(212)
> pciehp 0000:08:14.0:pcie24: Latch open on Slot(212)
> pciehp 0000:08:09.0:pcie24: Latch open on Slot(201)
> pciehp 0000:08:14.0:pcie24: Latch close on Slot(212)
> pciehp 0000:08:09.0:pcie24: Latch close on Slot(201)
>
> "Inserted Intel 82576 in slot 212(originally HBA slot) and insert HBA in slot 201(insertd 82576)"
> pciehp 0000:08:14.0:pcie24: Button pressed on Slot(212)
> pciehp 0000:08:14.0:pcie24: PCI slot #212 - powering on due to button press.
> pciehp 0000:08:09.0:pcie24: Button pressed on Slot(201)
> pciehp 0000:08:09.0:pcie24: PCI slot #201 - powering on due to button press.
> pci 0000:0e:00.0: [8086:10c9] type 00 class 0x020000
> pci 0000:0e:00.0: reg 10: [mem 0x00000000-0x0001ffff]
> pci 0000:0e:00.0: reg 14: [mem 0x00000000-0x0001ffff]
> pci 0000:0e:00.0: reg 18: [io  0x0000-0x001f]
> pci 0000:0e:00.0: reg 1c: [mem 0x00000000-0x00003fff]
> pci 0000:0e:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
> pci 0000:0e:00.0: calling pci_fixup_video+0x0/0x300
> pci 0000:0e:00.0: PME# supported from D0 D3hot D3cold
> pci 0000:0e:00.0: PME# disabled
> pci 0000:0e:00.1: [8086:10c9] type 00 class 0x020000
> pci 0000:0e:00.1: reg 10: [mem 0x00000000-0x0001ffff]
> pci 0000:0e:00.1: reg 14: [mem 0x00000000-0x0001ffff]
> pci 0000:0e:00.1: reg 18: [io  0x0000-0x001f]
> pci 0000:0e:00.1: reg 1c: [mem 0x00000000-0x00003fff]
> pci 0000:0e:00.1: reg 30: [mem 0x00000000-0x0001ffff pref]
> pci 0000:0e:00.1: calling pci_fixup_video+0x0/0x300
> pci 0000:0e:00.1: PME# supported from D0 D3hot D3cold
> pci 0000:0e:00.1: PME# disabled
> pcieport 0000:08:14.0: bridge window [mem 0x00100000-0x001fffff pref] to [bus 0e] add_size 200000
> pcieport 0000:08:14.0: res[9]=[mem 0x00100000-0x001fffff pref] get_res_add_size add_size 200000
> pcieport 0000:08:14.0: BAR 9: can't assign mem pref (size 0x300000)
> pcieport 0000:08:14.0: BAR 7: can't assign io (size 0x1000)
> pcieport 0000:08:14.0: BAR 9: can't assign mem pref (size 0x100000)
> pcieport 0000:08:14.0: BAR 7: can't assign io (size 0x1000)
> pci 0000:0e:00.0: BAR 0: assigned [mem 0x56c00000-0x56c1ffff]
> pci 0000:0e:00.0: BAR 0: set to [mem 0x56c00000-0x56c1ffff] (PCI address [0x56c00000-0x56c1ffff])
> pci 0000:0e:00.0: BAR 1: assigned [mem 0x56c20000-0x56c3ffff]
> pci 0000:0e:00.0: BAR 1: set to [mem 0x56c20000-0x56c3ffff] (PCI address [0x56c20000-0x56c3ffff])
> pci 0000:0e:00.0: BAR 6: assigned [mem 0x56c40000-0x56c5ffff pref]
> pci 0000:0e:00.1: BAR 0: assigned [mem 0x56c60000-0x56c7ffff]
> pci 0000:0e:00.1: BAR 0: set to [mem 0x56c60000-0x56c7ffff] (PCI address [0x56c60000-0x56c7ffff])
> pci 0000:0e:00.1: BAR 1: assigned [mem 0x56c80000-0x56c9ffff]
> pci 0000:0e:00.1: BAR 1: set to [mem 0x56c80000-0x56c9ffff] (PCI address [0x56c80000-0x56c9ffff])
> pci 0000:0e:00.1: BAR 6: assigned [mem 0x56ca0000-0x56cbffff pref]
> pci 0000:0e:00.0: BAR 3: assigned [mem 0x56cc0000-0x56cc3fff]
> pci 0000:0e:00.0: BAR 3: set to [mem 0x56cc0000-0x56cc3fff] (PCI address [0x56cc0000-0x56cc3fff])
> pci 0000:0e:00.1: BAR 3: assigned [mem 0x56cc4000-0x56cc7fff]
> pci 0000:0e:00.1: BAR 3: set to [mem 0x56cc4000-0x56cc7fff] (PCI address [0x56cc4000-0x56cc7fff])
> pci 0000:0e:00.0: BAR 2: can't assign io (size 0x20)
> pci 0000:0e:00.1: BAR 2: can't assign io (size 0x20)
> pcieport 0000:08:14.0: PCI bridge to [bus 0e]
> pcieport 0000:08:14.0:   bridge window [mem 0x56c00000-0x56efffff]
> PCI: No. 2 try to assign unassigned res
> pcieport 0000:08:14.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 0e] add_size 200000
> pcieport 0000:08:14.0: res[9]=[mem 0x00100000-0x001fffff 64bit pref] get_res_add_size add_size 200000
> pcieport 0000:08:14.0: BAR 9: can't assign mem pref (size 0x300000)
> pcieport 0000:08:14.0: BAR 7: can't assign io (size 0x1000)
> pcieport 0000:08:14.0: BAR 9: can't assign mem pref (size 0x100000)
> pcieport 0000:08:14.0: BAR 7: can't assign io (size 0x1000)
> pci 0000:0e:00.0: BAR 2: can't assign io (size 0x20)
> pci 0000:0e:00.1: BAR 2: can't assign io (size 0x20)
> pcieport 0000:08:14.0: PCI bridge to [bus 0e]
> pcieport 0000:08:14.0:   bridge window [mem 0x56c00000-0x56efffff]
> pci 0000:0e:00.0: no hotplug settings from platform
> pci 0000:0e:00.1: no hotplug settings from platform
> pci 0000:0e:00.0: calling quirk_e100_interrupt+0x0/0x500
> igb 0000:0e:00.0: enabling device (0000 -> 0002)
> igb 0000:0e:00.0: enabling bus mastering
> igb 0000:0e:00.0: added PHC on eth0
> igb 0000:0e:00.0: Intel(R) Gigabit Ethernet Network Connection
> igb 0000:0e:00.0: eth0: (PCIe:2.5Gb/s:Width x4) 90:e2:ba:1e:59:8c
> igb 0000:0e:00.0: eth0: PBA No: FFFFFF-0FF
> igb 0000:0e:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> pci 0000:0e:00.1: calling quirk_e100_interrupt+0x0/0x500
> igb 0000:0e:00.1: enabling device (0000 -> 0002)
> igb 0000:0e:00.1: enabling bus mastering
> igb 0000:0e:00.1: added PHC on eth1
> igb 0000:0e:00.1: Intel(R) Gigabit Ethernet Network Connection
> igb 0000:0e:00.1: eth1: (PCIe:2.5Gb/s:Width x4) 90:e2:ba:1e:59:8d
> igb 0000:0e:00.1: eth1: PBA No: FFFFFF-0FF
> igb 0000:0e:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> pci 0000:0b:00.0: [1077:2532] type 00 class 0x0c0400
> pci 0000:0b:00.0: reg 10: [io  0x0000-0x00ff]
> pci 0000:0b:00.0: reg 14: [mem 0x00000000-0x00003fff 64bit]
> pci 0000:0b:00.0: reg 30: [mem 0x00000000-0x0003ffff pref]
> pci 0000:0b:00.0: calling pci_fixup_video+0x0/0x300
> pcieport 0000:08:09.0: bridge window [mem 0x00100000-0x001fffff pref] to [bus 0b] add_size 200000
> pcieport 0000:08:09.0: res[9]=[mem 0x00100000-0x001fffff pref] get_res_add_size add_size 200000
> pcieport 0000:08:09.0: BAR 9: can't assign mem pref (size 0x300000)
> pcieport 0000:08:09.0: BAR 7: can't assign io (size 0x1000)
> pcieport 0000:08:09.0: BAR 9: can't assign mem pref (size 0x100000)
> pcieport 0000:08:09.0: BAR 7: can't assign io (size 0x1000)
> pci 0000:0b:00.0: BAR 6: assigned [mem 0x57300000-0x5733ffff pref]
> pci 0000:0b:00.0: BAR 1: assigned [mem 0x57340000-0x57343fff 64bit]
> pci 0000:0b:00.0: BAR 1: set to [mem 0x57340000-0x57343fff 64bit] (PCI address [0x57340000-0x57343fff])
> pci 0000:0b:00.0: BAR 0: can't assign io (size 0x100)
> pcieport 0000:08:09.0: PCI bridge to [bus 0b]
> pcieport 0000:08:09.0:   bridge window [mem 0x57300000-0x575fffff]
> PCI: No. 2 try to assign unassigned res
> pcieport 0000:08:09.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 0b] add_size 200000
> pcieport 0000:08:09.0: res[9]=[mem 0x00100000-0x001fffff 64bit pref] get_res_add_size add_size 200000
> pcieport 0000:08:09.0: BAR 9: can't assign mem pref (size 0x300000)
> pcieport 0000:08:09.0: BAR 7: can't assign io (size 0x1000)
> pcieport 0000:08:09.0: BAR 9: can't assign mem pref (size 0x100000)
> pcieport 0000:08:09.0: BAR 7: can't assign io (size 0x1000)
> pci 0000:0b:00.0: BAR 0: can't assign io (size 0x100)
> pcieport 0000:08:09.0: PCI bridge to [bus 0b]
> pcieport 0000:08:09.0:   bridge window [mem 0x57300000-0x575fffff]
> pci 0000:0b:00.0: no hotplug settings from platform
> qla2xxx 0000:0b:00.0: enabling device (0000 -> 0002)
> qla2xxx [0000:0b:00.0]-001d: : Found an ISP2532 irq 68 iobase 0xc000000057340000.
> qla2xxx 0000:0b:00.0: enabling bus mastering
> qla2xxx 0000:0b:00.0: enabling Mem-Wr-Inval
> scsi6 : qla2xxx
> qla2xxx [0000:0b:00.0]-00fb:6: QLogic QLE2562 - PCI-Express Dual Channel 8Gb Fibre Channel HBA.
> qla2xxx [0000:0b:00.0]-00fc:6: ISP2532: PCIe (5.0GT/s x8) @ 0000:0b:00.0 hdma+ host#=6 fw=5.03.02 (d5).
> qla2xxx [0000:0b:00.0]-8038:6: Cable is unplugged...
>
> From the dmesg log, Qlogic HBA card can only find function device 0 after inserted this card in
> Intel 82576 slot, because ARI device set the ari forwarding of the pcie port device 0000:08:09.0.
>
> The first four patches have been tested in IA64 hotplug machine. The last three patches have not been tested
> because my hotplug machine don't support cpcihp,sgihp and shpchp.
>
> Bjorn Helgaas (4):
>   PCI,pciehp: use bus->devices list intead of traditional traversal
>   PCI,cpcihp: use bus->devices list instead of traditional traversal
>   PCI,sgihp: use bus->devices list intead of traditional traversal
>   PCI,shpchp: use bus->devices list instead of traditional traversal
>
> Yijing Wang (3):
>   PCI: rework pci_enable_ari to support disable ari forwarding
>   PCI: Rename pci_enable_ari to pci_configure_ari
>   PCI: introduce pci_next_fn to simplify code
>
>  drivers/pci/hotplug/cpci_hotplug_pci.c |   13 +-----
>  drivers/pci/hotplug/pciehp_pci.c       |   46 ++++++++--------------
>  drivers/pci/hotplug/sgi_hotplug.c      |   40 ++++++++-----------
>  drivers/pci/hotplug/shpchp_pci.c       |   16 +------
>  drivers/pci/pci.c                      |   20 ++++++----
>  drivers/pci/pci.h                      |    2 +-
>  drivers/pci/probe.c                    |   67 +++++++++++++++++---------------
>  7 files changed, 89 insertions(+), 115 deletions(-)

I applied this series on the pci/yijing-ari branch in my git tree,
with the following changes:

  - Updated changelogs for readability
  - Reworked next_fn() and made it static
  - Updated the unconfigure/disable paths for cpcihp, sgihp, shpchp
  - Check PCI_SLOT for non-PCIe drivers in case a bus has several slots
  - Reset "Author:" to Yijing (since you wrote the original patches)

Please review the changes I made and test the parts you can.  I need
your acknowledgement before putting these in "next" with  your
Signed-off-by because I changed them so much.

I think there are really two defects you're fixing here:

  (1) If you hot-remove an ARI device and replace it with a non-ARI
multi-function device, we find only function 0 of the new device
because the upstream bridge still has ARI enabled, and next_ari_fn()
only returns function 0 for non-ARI devices.  Patch [1/7] fixes this.
I think this is the issue shown by your dmesg quotes above.

  (2) If you hot-add an ARI device, the PCI core enumerates all the
functions, but pciehp only initializes functions 0-7, and other
functions don't work correctly.  Additionally, if you hot-remove the
device, pciehp only removes functions 0-7, leaving stale pci_dev
structures around.  Patch [4/7] fixes this.

If my understanding is correct, I'll update the commit logs to mention
these scenarios explicitly.

Bjorn
