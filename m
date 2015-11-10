Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:57028 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbbKJJls (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2015 04:41:48 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] drivers: pci: remove unused pci_sys_data structures
Date: Tue, 10 Nov 2015 10:39:43 +0100
Message-ID: <3909067.XQHO4zq4LS@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E162A5EC2@lhreml503-mbs>
References: <1447095459-21777-1-git-send-email-lorenzo.pieralisi@arm.com> <7247058.o5kTvZ3CSC@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E162A5EC2@lhreml503-mbs>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 10 November 2015 06:19:17 Gabriele Paoloni wrote:
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > On the downside, I just saw how b3a72384fe29 ("ARM/PCI: Replace
> > pci_sys_data->align_resource with global function pointer") manages
> > to get rid of the last user of this, and how this is not the way
> > we had planned for it to be done.
> > 
> > It doesn't matter that much, because there is only a single
> > user of hw->align_resource, but this is now unportable code and
> > cannot easily be separated from hw_pci. It also breaks if we ever
> > get a machine with two different host controllers on ARM that
> > don't use the same pointer here.
> > 
> > I really would have hoped we could put that function pointer
> > into 'struct pci_host_bridge' instead, and eventually killed
> > off the architecture specific pcibios_align_resource function
> > as well.
> 
> say we move that in pci_host_bridge struct,
> 
> Are you suggesting to modify pcibios_init_hw to assign the 
> align_resource function pointer at the end after
> pci_scan_root_bus_msi() has created the host bridge structure;
> then we can retrieve it in pcibios_align_resource using
> pci_find_host_bridge(dev->bus)....?

What I had in mind was more along the lines of removing the
any mention of the align_resource callback from the ARM bios32.c
code and to have the pci-mvebu driver set the pointer manually
at an appropriate point (I did not look what would be that
point). What you suggest above would work too, just doesn't go
as far.

In the long run, I think it would be good to migrate all drivers
in drivers/pci/host/ away from calling pcibios_init_hw() at
all, and just use architecture-independent interfaces and leave
the hw_pci/pci_sys_data based implementation for the traditional
PCI host implementations that we have in arch/arm/mach-* for
platforms that do not use devicetree. This is not something I'm
asking you to do at this point, though any help here is appreciated.

> > Any idea why it was done with a global function pointer for
> > ARM rather than a proper solution?
> 
> Well just because I didn't think about the solution above...
> 
> If you think the above one can work I can send out another
> patch to fix this...

That would be great, yes. As I said, it's currently harmless
but it would be better to get it right.

	Arnd
