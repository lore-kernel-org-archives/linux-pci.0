Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49422 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947AbbIOJKe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Sep 2015 05:10:34 -0400
Date: Tue, 15 Sep 2015 10:10:47 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ray Jui <rjui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	yinghai@kernel.org
Subject: Re: iProc PCI issue with Linux v4.3-rc1
Message-ID: <20150915091046.GB11199@red-moon>
References: <55F75BB8.4070405@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55F75BB8.4070405@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ray,

[+Yinghai]

On Tue, Sep 15, 2015 at 12:43:52AM +0100, Ray Jui wrote:
> Hi,
> 
> I started trying out the kernel v4.3-rc1 on Broadcom iProc ARM32 based
> platform (Cygnus) today and found PCIe is broken.
> 
> A quick binary search shows that the following patch *causes* the issue:
> 
> Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Date:   Thu Jul 9 11:59:16 2015 +0100
> 
>     PCI: Call pci_read_bridge_bases() from core instead of arch code
> 
>     When we scan a PCI bus, we read PCI-PCI bridge window registers with
>     pci_read_bridge_bases() so we can validate the resource hierarchy.  Most
>     architectures call pci_read_bridge_bases() from pcibios_fixup_bus(), but
>     PCI-PCI bridges are not arch-specific, so this doesn't need to be in
>     arch-specific code.
> 
>     Call pci_read_bridge_bases() directly from the PCI core instead of from
>     arch code.
> 
>     For alpha and mips, we now call pci_read_bridge_bases() always;
> previously
>     we only called it if PCI_PROBE_ONLY was set.
> 
> Note I haven't looked this issue deeply since I haven't had much time.
> But it could be either 1) the patch itself that breaks PCIe on our
> platform; or 2) the patch is fine but it triggers previous hidden bug
> caused by incorrect configuration in our PCIe driver.

Same problem already reported here.

http://www.spinics.net/lists/linux-pci/msg44311.html

Either we revert dff22d2054b5 (" PCI: Call pci_read_bridge_bases() from
core instead of arch code") or I zero the bridge apertures in ARM
pcibios_fixup_bus() arch code (or we explain why core PCI code cares about
the bridge aperture on first bridge scan in __pci_bus_size_bridges()).

All ARM platforms can be broken at present (they ALL reassign resources)
and again, I think the same goes for Alpha and MIPS, I can't test them.

It is a shame to revert dff22d2054b5 in my opinion but I think that
options are limited anyway, it is impossible to fix it in a way
that is not arch specific, so either we accept the ARM arch fixup
(that just zeroes the bridge bases because there is 0 chance they are
correct) or we revert dff22d2054b5, time to make a decision.

Thanks,
Lorenzo

> I thought I'd share some information here, before I have time to look
> into this more closely, in case this issue may seem very obvious to some
> of you.
> 
> PCIe enumeration log that's working before this patch:
> [    0.263354] PCI host bridge /pcie@18013000 ranges:
> [    0.263366]    IO 0x48000000..0x4800ffff -> 0x00000000
> [    0.263374]   MEM 0x40000000..0x43ffffff -> 0x40000000
> [    0.318058] cygnus-pcie-phy 301d0a0.pcie_phy: PCIe PHY enabled
> [    0.423136] iproc-pcie 18013000.pcie: PCI host bridge to bus 0001:00
> [    0.423145] pci_bus 0001:00: root bus resource [bus 00-ff]
> [    0.423153] pci_bus 0001:00: root bus resource [io  0x10000-0x1ffff]
> (bus address [0x0000-0xffff])
> [    0.423159] pci_bus 0001:00: root bus resource [mem
> 0x40000000-0x43ffffff]
> [    0.423171] iproc-pcie 18013000.pcie: link: UP
> [    0.423337] pci 0001:00:00.0: IOMMU is currently not supported for PCI
> [    0.423529] PCI: bus0: Fast back to back transfers disabled
> [    0.423765] pci 0001:01:00.0: IOMMU is currently not supported for PCI
> [    0.433078] PCI: bus1: Fast back to back transfers disabled
> [    0.433107] pci 0001:00:00.0: BAR 8: assigned [mem 0x40000000-0x400fffff]
> [    0.433117] pci 0001:01:00.0: BAR 1: assigned [mem 0x40000000-0x4007ffff]
> [    0.433129] pci 0001:01:00.0: BAR 6: assigned [mem
> 0x40080000-0x400bffff pref]
> [    0.433137] pci 0001:01:00.0: BAR 0: assigned [mem 0x400c0000-0x400dffff]
> [    0.433147] pci 0001:01:00.0: BAR 3: assigned [mem 0x400e0000-0x400e3fff]
> [    0.433157] pci 0001:01:00.0: BAR 2: no space for [io  size 0x0020]
> [    0.433164] pci 0001:01:00.0: BAR 2: failed to assign [io  size 0x0020]
> [    0.433171] pci 0001:00:00.0: PCI bridge to [bus 01-04]
> [    0.433179] pci 0001:00:00.0:   bridge window [mem 0x40000000-0x400fffff]
> [    0.433259] pcieport 0001:00:00.0: enabling device (0140 -> 0142)
> 
> PCIe enumeration that is broken after this patch:
> [    0.358241] PCI host bridge /pcie@18013000 ranges:
> [    0.358252]    IO 0x48000000..0x4800ffff -> 0x00000000
> [    0.358260]   MEM 0x40000000..0x43ffffff -> 0x40000000
> [    0.613034] iproc-pcie 18013000.pcie: PCI host bridge to bus 0001:00
> [    0.613045] pci_bus 0001:00: root bus resource [bus 00-ff]
> [    0.613054] pci_bus 0001:00: root bus resource [io  0x10000-0x1ffff]
> (bus address [0x0000-0xffff])
> [    0.613060] pci_bus 0001:00: root bus resource [mem
> 0x40000000-0x43ffffff]
> [    0.613071] iproc-pcie 18013000.pcie: link: UP
> [    0.613292] PCI: bus0: Fast back to back transfers disabled
> [    0.613366] pci 0001:00:00.0: PCI bridge to [bus 01-04]
> [    0.622963] PCI: bus1: Fast back to back transfers disabled
> [    0.622995] pci 0001:00:00.0: BAR 8: no space for [mem size 0x08100000]
> [    0.623003] pci 0001:00:00.0: BAR 8: failed to assign [mem size
> 0x08100000]
> [    0.623012] pci 0001:00:00.0: BAR 9: assigned [mem
> 0x40000000-0x400fffff 64bit pref]
> [    0.623019] pci 0001:00:00.0: BAR 7: assigned [io  0x10000-0x10fff]
> [    0.623028] pci 0001:01:00.0: BAR 1: no space for [mem size 0x00080000]
> [    0.623033] pci 0001:01:00.0: BAR 1: failed to assign [mem size
> 0x00080000]
> [    0.623040] pci 0001:01:00.0: BAR 6: assigned [mem
> 0x40000000-0x4003ffff pref]
> [    0.623047] pci 0001:01:00.0: BAR 0: no space for [mem size 0x00020000]
> [    0.623053] pci 0001:01:00.0: BAR 0: failed to assign [mem size
> 0x00020000]
> [    0.623059] pci 0001:01:00.0: BAR 3: no space for [mem size 0x00004000]
> [    0.623064] pci 0001:01:00.0: BAR 3: failed to assign [mem size
> 0x00004000]
> [    0.623071] pci 0001:01:00.0: BAR 2: assigned [io  0x10000-0x1001f]
> [    0.623081] pci 0001:00:00.0: PCI bridge to [bus 01-04]
> [    0.623088] pci 0001:00:00.0:   bridge window [io  0x10000-0x10fff]
> [    0.623096] pci 0001:00:00.0:   bridge window [mem
> 0x40000000-0x400fffff 64bit pref]
> [    0.623200] pcieport 0001:00:00.0: enabling device (0146 -> 0147)
> 
> On the broken log, mem size of 0x08100000 for BAR 8 appears to be way
> too big.
> 
> Thanks,
> 
> Ray
> 
