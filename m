Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:61984 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965355AbbKDNgJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 08:36:09 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
	Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH] PCI: altera: use fwnode API for pci_msi_create_irq_domain
Date: Wed, 04 Nov 2015 14:35:56 +0100
Message-ID: <5938100.cg9CTxQKZA@wuerfel>
In-Reply-To: <alpine.DEB.2.11.1511041344370.4032@nanos>
References: <4309044.Hy8Vx01ZVW@wuerfel> <alpine.DEB.2.11.1511041344370.4032@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 04 November 2015 13:45:23 Thomas Gleixner wrote:
> On Wed, 4 Nov 2015, Arnd Bergmann wrote:
> > There is a new conflict between Thomas Gleixner's IRQ tree that contains
> > a patch from Marc Zyngier to change the prototype for
> > pci_msi_create_irq_domain, and Bjorn Helgaas' PCI tree that contains
> > a new driver for the Altera PCI MSI host, with the old interface,
> > as gcc now warns in linux-next:
> > 
> > drivers/pci/host/pcie-altera-msi.c: In function 'altera_allocate_domains':
> > drivers/pci/host/pcie-altera-msi.c:191:46: warning: passing argument 1 of 'pci_msi_create_irq_domain' from incompatible pointer type [-Wincompatible-pointer-types]
> >   msi->msi_domain = pci_msi_create_irq_domain(msi->pdev->dev.of_node,
> > include/linux/msi.h:286:20: note: expected 'struct fwnode_handle *' but argument is of type 'struct device_node *'
> > 
> > This changes the new driver use the modified API.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: af1169b48b17 ("PCI: altera: Add Altera PCIe MSI driver")
> > Fixes: be5436c83ac8 ("irqdomain/msi: Use fwnode instead of of_node")
> > ---
> > This conflict seems to be new in linux-next today. Any idea how to resolve it?
> > 
> > I think either Bjorn merges the msi-map-4.4 of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms and uses this
> > as the resolution, or whichever pull request comes second should let Linus
> > know about the conflict so he can do it when merging both.
> 
> The irq/core stuff which contains Marcs msi map stuff has hit Linus
> tree already.
> 

Ah, I see. Maybe that's why it showed up now, when Stephen had a fixup
for it in linux-next and that got dropped after the merge. I guess
Bjorn can pick either approach then, to get the correct merge done.

Thanks,

	Arnd
