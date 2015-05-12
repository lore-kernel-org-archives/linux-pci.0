Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:24658 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932856AbbELWSH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 May 2015 18:18:07 -0400
Message-ID: <55527C1C.7090901@broadcom.com>
Date: Tue, 12 May 2015 15:18:04 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, <bhelgaas@google.com>,
	<arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <sbranden@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>, <zajec5@gmail.com>
Subject: Re: [PATCH 2/2] PCI: iproc: add bcma pcie driver
References: <1431465781-10753-1-git-send-email-hauke@hauke-m.de> <1431465781-10753-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1431465781-10753-3-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Hauke,

On 5/12/2015 2:23 PM, Hauke Mehrtens wrote:
> This driver adds support for the PCIe 2.0 controller found on the bcma
> bus. This controller can be found on (mostly) all Broadcom BCM470X /
> BCM5301X ARM SoCs.
> 
> The driver found in the Broadcom SDK does some more stuff, like setting
> up some DMA memory areas, chaining MPS and MRRS to 512 and also some
> PHY changes like "improving" the PCIe jitter and doing some special
> initializations for the 3rd PCIe port.
> 
> This was tested on a bcm4708 board with 2 PCIe ports and wireless cards
> connected to them.
> 
> PCI_DOMAINS is needed by this driver, because normally there is more
> than one PCIe controller and without PCI_DOMAINS only the first
> controller gets registered.
> This controller gets 6 IRQs, the last one is trigged by all IRQ events.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  drivers/pci/host/Kconfig           |  11 ++++
>  drivers/pci/host/Makefile          |   1 +
>  drivers/pci/host/pcie-iproc-bcma.c | 112 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 124 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-iproc-bcma.c
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 1dfb567..f23f96d 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -125,4 +125,15 @@ config PCIE_IPROC_PLATFORM
>  	  Say Y here if you want to use the Broadcom iProc PCIe controller
>  	  through the generic platform bus interface
>  
> +config PCIE_IPROC_BCMA
> +	bool "Broadcom iProc PCIe bcma bus driver"
> +	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
> +	select PCIE_IPROC
> +	select BCMA
> +	select PCI_DOMAINS
> +	default ARCH_BCM_5301X
> +	help
> +	  Say Y here if you want to use the Broadcom iProc PCIe controller
> +	  through the bcma bus interface
> +
>  endmenu
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index f733b4e..2f7c36f 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -15,3 +15,4 @@ obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>  obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
>  obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
>  obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
> +obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
> diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
> new file mode 100644
> index 0000000..c318f19
> --- /dev/null
> +++ b/drivers/pci/host/pcie-iproc-bcma.c
> @@ -0,0 +1,112 @@
> +/* 
> + * Copyright (C) 2015 Broadcom Corporation
> + * Copyright (C) 2015 Hauke Mehrtens <hauke@hauke-m.de>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/phy/phy.h>
> +#include <linux/bcma/bcma.h>
> +#include <linux/ioport.h>
> +
> +#include "pcie-iproc.h"
> +
> +
> +/* NS: CLASS field is R/O, and set to wrong 0x200 value */
> +static void bcma_pcie2_fixup_class(struct pci_dev *dev)
> +{
> +	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8011, bcma_pcie2_fixup_class);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8012, bcma_pcie2_fixup_class);
> +
> +static int iproc_pcie_bcma_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	struct pci_sys_data *sys = dev->sysdata;
> +	struct iproc_pcie *pcie = sys->private_data;
> +	struct bcma_device *bdev = container_of(pcie->dev, struct bcma_device, dev);
> +
> +	return bcma_core_irq(bdev, 5);
> +}
> +
> +static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
> +{
> +	struct iproc_pcie *pcie;
> +	LIST_HEAD(res);
> +	struct resource res_mem;
> +	int ret;
> +
> +	pcie = devm_kzalloc(&bdev->dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pcie->dev = &bdev->dev;
> +	bcma_set_drvdata(bdev, pcie);
> +
> +	pcie->base = bdev->io_addr;
> +
> +	res_mem.start = bdev->addr_s[0];
> +	res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
> +	res_mem.name = "PCIe MEM space";
> +	res_mem.flags = IORESOURCE_MEM;
> +	pci_add_resource(&res, &res_mem);
> +
> +	pcie->resources = &res;
> +
> +	pcie->map_irq = iproc_pcie_bcma_map_irq;
> +
> +	ret = iproc_pcie_setup(pcie);
> +	if (ret) {
> +		dev_err(pcie->dev, "PCIe controller setup failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void iproc_pcie_bcma_remove(struct bcma_device *bdev)
> +{
> +	struct iproc_pcie *pcie = bcma_get_drvdata(bdev);
> +
> +	iproc_pcie_remove(pcie);
> +}
> +
> +static const struct bcma_device_id iproc_pcie_bcma_table[] = {
> +	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_NS_PCIEG2, BCMA_ANY_REV, BCMA_ANY_CLASS),
> +	{},
> +};
> +MODULE_DEVICE_TABLE(bcma, iproc_pcie_bcma_table);
> +
> +static struct bcma_driver iproc_pcie_bcma_driver = {
> +	.name		= KBUILD_MODNAME,
> +	.id_table	= iproc_pcie_bcma_table,
> +	.probe		= iproc_pcie_bcma_probe,
> +	.remove		= iproc_pcie_bcma_remove,
> +};
> +
> +static int __init iproc_pcie_bcma_init(void)
> +{
> +	return bcma_driver_register(&iproc_pcie_bcma_driver);
> +}
> +module_init(iproc_pcie_bcma_init);
> +
> +static void __exit iproc_pcie_bcma_exit(void)
> +{
> +	bcma_driver_unregister(&iproc_pcie_bcma_driver);
> +}
> +module_exit(iproc_pcie_bcma_exit);
> +
> +MODULE_AUTHOR("Hauke Mehrtens");
> +MODULE_DESCRIPTION("Broadcom iPROC PCIe bcma driver");
> +MODULE_LICENSE("GPLv2");
> 

This change looks okay to me in general. But I'm not that familiar with
BCMA, so someone else should also review this code.

Thanks,

Ray
