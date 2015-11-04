Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 4 Nov 2015 13:45:23 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
	Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH] PCI: altera: use fwnode API for
 pci_msi_create_irq_domain
In-Reply-To: <4309044.Hy8Vx01ZVW@wuerfel>
Message-ID: <alpine.DEB.2.11.1511041344370.4032@nanos>
References: <4309044.Hy8Vx01ZVW@wuerfel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 4 Nov 2015, Arnd Bergmann wrote:
> There is a new conflict between Thomas Gleixner's IRQ tree that contains
> a patch from Marc Zyngier to change the prototype for
> pci_msi_create_irq_domain, and Bjorn Helgaas' PCI tree that contains
> a new driver for the Altera PCI MSI host, with the old interface,
> as gcc now warns in linux-next:
> 
> drivers/pci/host/pcie-altera-msi.c: In function 'altera_allocate_domains':
> drivers/pci/host/pcie-altera-msi.c:191:46: warning: passing argument 1 of 'pci_msi_create_irq_domain' from incompatible pointer type [-Wincompatible-pointer-types]
>   msi->msi_domain = pci_msi_create_irq_domain(msi->pdev->dev.of_node,
> include/linux/msi.h:286:20: note: expected 'struct fwnode_handle *' but argument is of type 'struct device_node *'
> 
> This changes the new driver use the modified API.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: af1169b48b17 ("PCI: altera: Add Altera PCIe MSI driver")
> Fixes: be5436c83ac8 ("irqdomain/msi: Use fwnode instead of of_node")
> ---
> This conflict seems to be new in linux-next today. Any idea how to resolve it?
> 
> I think either Bjorn merges the msi-map-4.4 of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms and uses this
> as the resolution, or whichever pull request comes second should let Linus
> know about the conflict so he can do it when merging both.

The irq/core stuff which contains Marcs msi map stuff has hit Linus
tree already.

Thanks,

	tglx
