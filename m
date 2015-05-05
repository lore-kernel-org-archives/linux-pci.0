Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:54453 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993487AbbEEP7M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2015 11:59:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>
Cc: Jayachandran C <jchandra@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v2 1/2] PCI: generic: remove dependency on hw_pci
Date: Tue, 05 May 2015 17:58:31 +0200
Message-ID: <7101508.6RhN5G3AIR@wuerfel>
In-Reply-To: <20150505155346.GJ1550@arm.com>
References: <1430791333-26013-1-git-send-email-jchandra@broadcom.com> <20150505155346.GJ1550@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 05 May 2015 16:53:46 Will Deacon wrote:
> On Tue, May 05, 2015 at 03:02:12AM +0100, Jayachandran C wrote:
> > The current code in pci-host-generic.c uses pci_common_init_dev()
> > from the arch/arm/ to do a part of the PCI initialization, and this
> > prevents it from being used on arm64.
> > 
> > The initialization done by pci_common_init_dev() that is really
> > needed by pci-host-generic.c can be done in the same file without
> > using the hw_pci API of ARM.
> > 
> > The ARM platform requires a pci_sys_data as sysdata for the PCI bus,
> > this is be handled by setting up 'struct gen_pci' to embed a
> > pci_sys_data variable as the first element on the ARM platform.
> > 
> > Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> > ---
> > Here's v2 of the patches, this enables use of pci-host-generic on
> > arm64.
> > 
> > This has been tested on both qemu and fast model for arm64, and on
> > qemu for arm32.
> > 
> > v1->v2
> >  - Address comments from Arnd Bergmann and Lorenzo Pieralisi
> >     - move contents of gen_pci_init to gen_pci_probe
> >     - assign resources only when !probe_only
> >  - tested on ARM32 with qemu option -M virt
> 
> I tried this with an arm64 kernel running under kvmtool, but I get the
> following errors (a 32-bit ARM kernel does seem to work):
> 
>   PCI host bridge /pci ranges:
>      IO 0x00000000..0x0000ffff -> 0x00000000
>     MEM 0x41000000..0x7fffffff -> 0x41000000
>   pci-host-generic 40000000.pci: PCI host bridge to bus 0000:00
>   pci_bus 0000:00: root bus resource [bus 00-01]
>   pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>   pci_bus 0000:00: root bus resource [mem 0x41000000-0x7fffffff]
>   pci_bus 0000:00: scanning bus
>   pci 0000:00:00.0: [1af4:1009] type 00 class 0xff0000
>   pci 0000:00:00.0: reg 0x10: [mem 0x41000000-0x410003ff]
>   pci 0000:00:00.0: reg 0x14: [io  0x6200-0x65ff]
>   pci 0000:00:00.0: reg 0x18: [mem 0x41000400-0x410005ff]
>   pci 0000:00:01.0: [1af4:1009] type 00 class 0xff0000
>   pci 0000:00:01.0: reg 0x10: [mem 0x41000800-0x41000bff]
>   pci 0000:00:01.0: reg 0x14: [io  0x6600-0x69ff]
>   pci 0000:00:01.0: reg 0x18: [mem 0x41000c00-0x41000dff]
>   pci_bus 0000:00: fixups for bus
>   pci_bus 0000:00: bus scan returning with max=00
>   pci 0000:00:00.0: fixup irq: got 10
>   pci 0000:00:00.0: assigning IRQ 10
>   pci 0000:00:01.0: fixup irq: got 11
>   pci 0000:00:01.0: assigning IRQ 11
>   virtio-pci 0000:00:00.0: can't enable device: BAR 0 [mem 0x41000000-0x410003ff] not claimed
>   virtio-pci: probe of 0000:00:00.0 failed with error -22
>   virtio-pci 0000:00:01.0: can't enable device: BAR 0 [mem 0x41000800-0x41000bff] not claimed
>   virtio-pci: probe of 0000:00:01.0 failed with error -22

What do you see in /proc/ioport and /proc/iomem, respectively?

It sounds like the memory resource of the host did not get registered right.

	Arnd
