Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53117 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253AbcCXRy6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Mar 2016 13:54:58 -0400
Date: Thu, 24 Mar 2016 17:57:28 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, linux-kernel@vger.kernel.org,
	Zhou Wang <wangzhou1@hisilicon.com>, jdelvare@suse.de
Subject: Re: Question about PCI I/O space in ARM64
Message-ID: <20160324175728.GC21749@red-moon>
References: <56F209A9.4040304@huawei.com>
 <20160323101840.GA21390@e104818-lin.cambridge.arm.com>
 <8793380.nuVa09lFue@wuerfel>
 <56F35BAA.50800@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56F35BAA.50800@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+ Jean]

On Thu, Mar 24, 2016 at 11:14:50AM +0800, Kefeng Wang wrote:

[...]

> >> You need a PCI host controller driver (e.g.
> >> drivers/pci/host/pci-host-generic.c) and corresponding bindings in DT or
> >> ACPI.
> 
> In our inner test, there are some board without pcie host driver(even
> without pci host controller).

So I guess those drivers are for devices that are attached to an LPC
controller that is not part of a PCI host controller, right ?

BTW, what happened to this (not that I particularly like this patchset) ?

https://lkml.org/lkml/2015/12/29/154

> > I think getting an Oops is not the best behavior though, it would be
> > nice if that could be improved in some way.
> > 
> > Ideally, each driver that accesses PCI I/O space would call request_region()
> > before doing so, and it would be good if that call could be made to
> > return an error when asked about an address that has not been mapped.
> > 
> > I see that ioport_resource gets initialized to the {0, IO_SPACE_LIMIT}
> > range. If we could change it so that pci_remap_iospace() hooks up
> > to ioport_resource and extends it whenever something gets mapped
> > there up to IO_SPACE_LIMIT, we can change the default range to
> > {0,0}, which would fail for any request_region call before the
> > first pci_remap_iospace.
> > 
> > This won't help for the specific f71805f driver example, because that
> > does not call request_region(), but we can treat that as a driver bug
> > and fix it.
> 
> Yes, we met same error with several modules(at least 8+), so it's
> better to find a good way to avoid it, change modules one by one maybe
> not a good choice.

But that's the right thing to do :)

The problem with those drivers is that IIUC they use ISA IO port space to
detect if the devices they manage are actually present, it does not
look that correct to me, at least not on !X86 (IA64 ?) systems.

Those drivers can't be built on PPC for a reason (?), I found these threads
which might be telling:

http://www.spinics.net/lists/lm-sensors/msg43868.html
http://comments.gmane.org/gmane.linux.drivers.sensors/17290

I agree with Arnd on this and we need to patch the eg f71805f driver too
(or we just do not build on ARM) to make it request the IO port region it
needs to actually probe the device, it is not correct to assume IO space
is available and mapped, I think that's a driver bug rather than anything
else, Jean can certainly shed some light here.

> Define some arch in/out func instead of generic ops? when in/out vals, check
> whether or not the pci_iobase is mapped.

I do not think the problem should be solved in the IO accessors
implementation, see above.

Lorenzo
