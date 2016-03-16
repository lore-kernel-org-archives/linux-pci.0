Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44093 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933380AbcCPSHN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Mar 2016 14:07:13 -0400
Date: Wed, 16 Mar 2016 18:09:36 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI IO resource question.
Message-ID: <20160316180936.GA7605@red-moon>
References: <56E987B8.1090904@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56E987B8.1090904@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 16, 2016 at 12:20:08PM -0400, Murali Karicheri wrote:

[...]

> However I am wondering if it is mandatory to define this range at all.
> I tried to remove the entry and I get following error then

If your PCI host controller does not support IO space the DT must not
contain a range for it, can you elaborate on "dummy IO range" please ?

If you have it in DT, the host controller driver uses it to map that
range into virtual address space, depending on which CPU physical
address you pass into the IO range this may be go totally wild
with drivers poking at random (ie your dummy range) CPU physical
addresses in the worst case.

Remove the IO range if the PCI host controller does not support it,
you must not add one to make the kernel happy, that's potentially
a very dangerous thing to do.

> [    0.448772] pci 0000:00:00.0: BAR 8: assigned [mem 0x60000000-0x600fffff]
> [    0.448783] pci 0000:00:00.0: BAR 9: assigned [mem 0x60100000-0x601fffff pref]
> [    0.448792] pci 0000:00:00.0: BAR 7: no space for [io  size 0x1000]
> [    0.448800] pci 0000:00:00.0: BAR 7: failed to assign [io  size 0x1000]
> [    0.448813] pci 0000:01:00.0: BAR 6: assigned [mem 0x60100000-0x6010ffff pref]
> [    0.448822] pci 0000:01:00.0: BAR 5: assigned [mem 0x60000000-0x600001ff]
> [    0.448834] pci 0000:01:00.0: BAR 4: no space for [io  size 0x0010]
> [    0.448841] pci 0000:01:00.0: BAR 4: failed to assign [io  size 0x0010]
> [    0.448848] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0008]
> [    0.448855] pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0008]
> [    0.448863] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0008]
> [    0.448870] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0008]
> [    0.448877] pci 0000:01:00.0: BAR 1: no space for [io  size 0x0004]
> [    0.448884] pci 0000:01:00.0: BAR 1: failed to assign [io  size 0x0004]
> [    0.448891] pci 0000:01:00.0: BAR 3: no space for [io  size 0x0004]
> [    0.448898] pci 0000:01:00.0: BAR 3: failed to assign [io  size 0x0004]
> [    0.448907] pci 0000:00:00.0: PCI bridge to [bus 01]
> 
> 
> The original log is below and even with the error, I am able to have SATA
> drive function as expected over this PCIe interface.
> 
> 
> [    0.420648] PCI host bridge /soc/pcie@21020000 ranges:
> [    0.420659]   No bus range found for /soc/pcie@21020000, using [bus 00-ff]
> [    0.420679]    IO 0x23260000..0x400023263fff -> 0x00000000
> [    0.420685] Requested IO range too big, new size set to 64K
> [    0.420702]   MEM 0x60000000..0x6fffffff -> 0x60000000
> [    0.420713] keystone-pcie 21021000.pcie: error -22: failed to map resource [io  0x0000-0x400000003fff]

This unearthed an issue that we've got to fix. If the IO space remap
fails (pci_remap_iospace()) we must remove the IO resource from the host
bridge resources list, code below shows that we end up assigning IO space
even if the remapping of the host bridge CPU physical address corresponding
to IO space fails, which is wrong.

Do you want me to fix the host bridges concerned in one go ?

Thanks,
Lorenzo

> [    0.431849] keystone-pcie 21021000.pcie: PCI host bridge to bus 0000:00
> [    0.431861] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.431870] pci_bus 0000:00: root bus resource [io  0x0000-0x400000003fff]
> [    0.431879] pci_bus 0000:00: root bus resource [mem 0x60000000-0x6fffffff]
> [    0.431906] pci 0000:00:00.0: [104c:b009] type 01 class 0x060400
> [    0.432173] PCI: bus0: Fast back to back transfers disabled
> [    0.432334] pci 0000:01:00.0: [1b4b:9182] type 00 class 0x010601
> [    0.432382] pci 0000:01:00.0: reg 0x10: [io  0x8000-0x8007]
> [    0.432402] pci 0000:01:00.0: reg 0x14: [io  0x8040-0x8043]
> [    0.432420] pci 0000:01:00.0: reg 0x18: [io  0x8100-0x8107]
> [    0.432439] pci 0000:01:00.0: reg 0x1c: [io  0x8140-0x8143]
> [    0.432457] pci 0000:01:00.0: reg 0x20: [io  0x800000-0x80000f]
> [    0.432476] pci 0000:01:00.0: reg 0x24: [mem 0x00900000-0x009001ff]
> [    0.432495] pci 0000:01:00.0: reg 0x30: [mem 0xd0000000-0xd000ffff pref]
> [    0.432561] pci 0000:01:00.0: PME# supported from D3hot
> [    0.448635] PCI: bus1: Fast back to back transfers disabled
> [    0.448717] pci 0000:00:00.0: BAR 8: assigned [mem 0x60000000-0x600fffff]
> [    0.448729] pci 0000:00:00.0: BAR 9: assigned [mem 0x60100000-0x601fffff pref]
> [    0.448738] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
> [    0.448751] pci 0000:01:00.0: BAR 6: assigned [mem 0x60100000-0x6010ffff pref]
> [    0.448760] pci 0000:01:00.0: BAR 5: assigned [mem 0x60000000-0x600001ff]
> [    0.448772] pci 0000:01:00.0: BAR 4: assigned [io  0x1000-0x100f]
> [    0.448784] pci 0000:01:00.0: BAR 0: assigned [io  0x1010-0x1017]
> [    0.448796] pci 0000:01:00.0: BAR 2: assigned [io  0x1018-0x101f]
> [    0.448808] pci 0000:01:00.0: BAR 1: assigned [io  0x1020-0x1023]
> [    0.448820] pci 0000:01:00.0: BAR 3: assigned [io  0x1024-0x1027]
> [    0.448833] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    0.448842] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> [    0.448851] pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff]
> [    0.448860] pci 0000:00:00.0:   bridge window [mem 0x60100000-0x601fffff pref]
> [    0.449077] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
> [    0.449086] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
> [    0.449095] pcie_pme 0000:00:00.0:pcie01: service driver pcie_pme loaded
> [    0.449240] aer 0000:00:00.0:pcie02: service driver aer loaded
> 
> 
> Thanks and regards,
> 
> -- 
> Murali Karicheri
> Linux Kernel, Keystone
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
