Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:53220 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755160AbeARPEA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jan 2018 10:04:00 -0500
Date: Thu, 18 Jan 2018 16:03:57 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: dra7xx: add back CONFIG_PCI dependency for
 endpoint
Message-ID: <20180118150357.GA7544@axis.com>
References: <20180118131612.871559-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180118131612.871559-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 18, 2018 at 02:15:54PM +0100, Arnd Bergmann wrote:
> It was a nice idea to split out the PCI host and endpoint mode configuration
> into separate options. Unfortunately it doesn't build:
> 
> drivers/pci/dwc/pci-dra7xx.c:229:11: error: 'pci_irqd_intx_xlate' undeclared here (not in a function)
> 
> This is certainly a fixable problem, but since it's clear that this
> configuration was never tested, let's maybe revert back to the
> dependency for now, until it can be done in a way that works
> better.

Hello Arnd,

That is not true :( I did test..

git checkout b052835c6385
disable CONFIG_PCI
make
works like a charm :P

Commit 524d59f6e30a ("PCI: dra7xx: Fix legacy INTD IRQ handling"),
which was merged after my commit, added a dependency towards
pci_irqd_intx_xlate.

It might be a bit unfortunately that commit 489f8fe6aa71
("PCI: dwc: dra7xx: Help compiler to remove unused code"),
a commit that you helped me with Arnd, was placed after
b052835c6385 ("PCI: dwc: dra7xx: Refactor Kconfig and Makefile
handling for host/ep mode") instead of before, in my patch
series order.

However, since pci_irqd_intx_xlate is only defined inside
CONFIG_PCI, even 489f8fe6aa71 will not help.

Not completely sure about this, but perhaps a better fix is:

+++ b/include/linux/pci.h
@@ -1686,6 +1686,12 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 #define dev_is_pf(d) (false)
 static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 { return false; }
+static inline int pci_irqd_intx_xlate(struct irq_domain *d,
+                                     struct device_node *node,
+                                     const u32 *intspec,
+                                     unsigned int intsize,
+                                     unsigned long *out_hwirq,
+                                     unsigned int *out_type) { return 0; }
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */


And a 'Fixes:' tag that references 524d59f6e30a

Regards,
Niklas

> 
> Fixes: b052835c6385 ("PCI: dwc: dra7xx: Refactor Kconfig and Makefile handling for host/ep mode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/dwc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> index 0fb96c7754de..540419527a92 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -36,7 +36,7 @@ config PCI_DRA7XX_HOST
>  config PCI_DRA7XX_EP
>  	bool "TI DRA7xx PCIe controller Endpoint Mode"
>  	depends on SOC_DRA7XX || COMPILE_TEST
> -	depends on PCI_ENDPOINT
> +	depends on PCI && PCI_ENDPOINT
>  	depends on OF && HAS_IOMEM && TI_PIPE3
>  	select PCIE_DW_EP
>  	select PCI_DRA7XX
> -- 
> 2.9.0
> 
