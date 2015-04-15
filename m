Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55870 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbbDOKRc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Apr 2015 06:17:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>,
	linux-pci@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/3] arm/pci: Add support architecture-independent PCIe driver
Date: Wed, 15 Apr 2015 12:16:53 +0200
Message-ID: <143536414.FRhgn8p3gq@wuerfel>
In-Reply-To: <1429091315-31891-2-git-send-email-Minghuan.Lian@freescale.com>
References: <1429091315-31891-1-git-send-email-Minghuan.Lian@freescale.com> <1429091315-31891-2-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 15 April 2015 17:48:33 Minghuan Lian wrote:
> PCIe common driver of arm architecture uses private structure
> pci_sys_data and hw_pci to associate with specific PCIe controller
> ops which results in the PCIe controller driver not compatible
> with other architectures. This patch provides another approach
> to support architecture-independent PCIe driver which does not
> need to use pci_sys_data and hw_pci and call pci_common_init_dev().
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>

This looks ok in principle, but I think we already have plans to
fix this up in a better way.

Your code is broken in the theoretical case where you'd have
two PCI host bridges, and only one of them uses pci_common_init_dev.

> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index ab19b7c0..8820ed5 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -7,6 +7,7 @@
>   */
>  #include <linux/export.h>
>  #include <linux/kernel.h>
> +#include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/init.h>
> @@ -17,12 +18,16 @@
>  #include <asm/mach/pci.h>
>  
>  static int debug_pci;
> +static int pci_commont_init_enable;
>  
>  #ifdef CONFIG_PCI_MSI
>  struct msi_controller *pcibios_msi_controller(struct pci_dev *dev)
>  {
>  	struct pci_sys_data *sysdata = dev->bus->sysdata;
>  
> +	if (!pci_commont_init_enable)
> +		return NULL;
> +
>  	return sysdata->msi_ctrl;
>  }
>  #endif
> @@ -508,6 +513,8 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
>  	struct pci_sys_data *sys;
>  	LIST_HEAD(head);
>  
> +	pci_commont_init_enable = 1;
> +
>  	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
>  	if (hw->preinit)
>  		hw->preinit();

A simpler hack to achieve the same thing is to add an empty pci_sys_data
member to the designware pcie_port:

+++ b/drivers/pci/host/pcie-designware.h
@@ -23,6 +23,15 @@
 #define MAX_MSI_CTRLS                  (MAX_MSI_IRQS / 32)
 
 struct pcie_port {
+#ifdef CONFIG_ARM
+       /*
+        * this is a temporary hack to let the driver work on
+        * both arm32 and arm64. it can be removed after the
+        * arm32 cleanup is complete and bios32.c has stopped
+        * referencing host->pci_sys_data.
+        */
+       struct pci_sys_data     dummy;
+#endif
        struct device           *dev;
        u8                      root_bus_nr;
        void __iomem            *dbi_base;

I've just drafted a patch in reply to the hisilicon patch that tries to
achieve the same thing as yours, see "Re: [RFC PATCH 1/3] PCI: host:
designware: support ARM64".


> @@ -651,3 +658,13 @@ void __init pci_map_io_early(unsigned long pfn)
>  	pci_io_desc.pfn = pfn;
>  	iotable_init(&pci_io_desc, 1);
>  }
> +
> +/*
> + * Try to assign the IRQ number from DT when adding a new device
> + */
> +int pcibios_add_device(struct pci_dev *dev)
> +{
> +	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> +
> +	return 0;
> +}

I don't see why this is required here. Doesn't this break platforms
that get their IRQ in some other way?

	Arnd
