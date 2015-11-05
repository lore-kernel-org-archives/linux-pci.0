Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4309044.Hy8Vx01ZVW@wuerfel>
References: <4309044.Hy8Vx01ZVW@wuerfel>
Date: Thu, 5 Nov 2015 09:55:48 +0800
Message-ID: <CAFiDJ592xoLFK74JbFh60tYtLQcc=XtJw2u=4+mFmVsODCcMkQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: altera: use fwnode API for pci_msi_create_irq_domain
From: Ley Foon Tan <lftan@altera.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 4, 2015 at 8:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
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

Acked-by: Ley Foon Tan <lftan@altera.com>

Thanks for the fix.

Regards
Ley Foon
