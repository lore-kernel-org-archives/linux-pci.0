Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53276 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993AbcCWM0v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2016 08:26:51 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Lorenzo.Pieralisi@arm.com,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, linux-kernel@vger.kernel.org,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: Question about PCI I/O space in ARM64
Date: Wed, 23 Mar 2016 13:26:09 +0100
Message-ID: <8793380.nuVa09lFue@wuerfel>
In-Reply-To: <20160323101840.GA21390@e104818-lin.cambridge.arm.com>
References: <56F209A9.4040304@huawei.com> <20160323101840.GA21390@e104818-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 23 March 2016 10:18:40 Catalin Marinas wrote:
> On Wed, Mar 23, 2016 at 11:12:41AM +0800, Kefeng Wang wrote:
> > If no pci, the PCI I/O space(16M) is mapped into an irrelevant mem space(right ?),
> 
> No. It is not mapped at all.
> 
> > not a right IO space,
> > that is, no one call pci_remap_iospace() to remap the memory mapped I/O space, once driver
> > like f71805f loaded, write value to IO space(see f71805f_init->f71805f_find->superio_enter->outb),
> > we met following oops,
> > ------------------------
> > Unable to handle kernel paging request at virtual address ffffffbffee0002e
> > pgd = ffffffc1d68d4000
> > [ffffffbffee0002e] *pgd=0000000000000000, *pud=0000000000000000
> > Internal error: Oops: 94000046 [#1] PREEMPT SMP
> > Modules linked in: f71805f(+) hwmon
> > CPU: 3 PID: 1659 Comm: insmod Not tainted 4.5.0+ #88
> > Hardware name: linux,dummy-virt (DT)
> > task: ffffffc1f6665400 ti: ffffffc1d6418000 task.ti: ffffffc1d6418000
> > PC is at f71805f_find+0x6c/0x358 [f71805f]
> > ------------------------
> 
> That's caused by not having a mapped PCI I/O space.
> 
> > I am not clear about PCI I/O, but if this is indeed a bug, how to solve this issue,
> > any advice will be appreciated.
> 
> You need a PCI host controller driver (e.g.
> drivers/pci/host/pci-host-generic.c) and corresponding bindings in DT or
> ACPI.

I think getting an Oops is not the best behavior though, it would be
nice if that could be improved in some way.

Ideally, each driver that accesses PCI I/O space would call request_region()
before doing so, and it would be good if that call could be made to
return an error when asked about an address that has not been mapped.

I see that ioport_resource gets initialized to the {0, IO_SPACE_LIMIT}
range. If we could change it so that pci_remap_iospace() hooks up
to ioport_resource and extends it whenever something gets mapped
there up to IO_SPACE_LIMIT, we can change the default range to
{0,0}, which would fail for any request_region call before the
first pci_remap_iospace.

This won't help for the specific f71805f driver example, because that
does not call request_region(), but we can treat that as a driver bug
and fix it.

	Arnd
