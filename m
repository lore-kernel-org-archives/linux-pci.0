Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 26 Sep 2017 23:02:07 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Ravi Shankar Jonnalagadda <venkata.ravi.jonnalagadda@xilinx.com>
Subject: Re: [PATCH v2 3/5] dmaengine: zynqmp_ps_pcie: Adding PS PCIe DMA
 driver
Message-ID: <20170926173207.GR30097@localhost>
References: <1504873388-29195-1-git-send-email-vjonnal@xilinx.com>
 <1504873388-29195-4-git-send-email-vjonnal@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <1504873388-29195-4-git-send-email-vjonnal@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 dmaengine@vger.kernel.org, bharat.kumar.gogada@xilinx.com,
 linux-pci@vger.kernel.org, michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org, vjonnal@xilinx.com, robh+dt@kernel.org,
 rgummal@xilinx.com, linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
 dan.j.williams@intel.com, soren.brinkmann@xilinx.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 08, 2017 at 05:53:05PM +0530, Ravi Shankar Jonnalagadda wrote:

> Adding support for ZynqmMP PS PCIe EP driver.
> Adding support for ZynqmMP PS PCIe Root DMA driver.

/s/Adding/Add/

Please descibe the dmaengines here so people can know what to expect.

> Modifying Kconfig and Makefile to add the support.

You can remobe this

> 
> Signed-off-by: Ravi Shankar Jonnalagadda <vjonnal@xilinx.com>
> Signed-off-by: RaviKiran Gummaluri <rgummal@xilinx.com>
> ---
>  drivers/dma/Kconfig               |  12 +++
>  drivers/dma/xilinx/Makefile       |   2 +
>  drivers/dma/xilinx/ps_pcie.h      |  44 +++++++++
>  drivers/dma/xilinx/ps_pcie_main.c | 200 ++++++++++++++++++++++++++++++++++++++
>  include/linux/dma/ps_pcie_dma.h   |  69 +++++++++++++
>  5 files changed, 327 insertions(+)
>  create mode 100644 drivers/dma/xilinx/ps_pcie.h
>  create mode 100644 drivers/dma/xilinx/ps_pcie_main.c
>  create mode 100644 include/linux/dma/ps_pcie_dma.h
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index fa8f9c0..e2fe4e5 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -586,6 +586,18 @@ config XILINX_ZYNQMP_DMA
>  	help
>  	  Enable support for Xilinx ZynqMP DMA controller.
>  
> +config XILINX_PS_PCIE_DMA
> +	tristate "Xilinx PS PCIe DMA support"
> +	depends on (PCI && X86_64 || ARM64)
> +	select DMA_ENGINE
> +	help
> +	  Enable support for the Xilinx PS PCIe DMA engine present
> +	  in recent Xilinx ZynqMP chipsets.
> +
> +	  Say Y here if you have such a chipset.
> +
> +	  If unsure, say N.

Can you remove last two lines, they dont convey anything useful

> +
>  config ZX_DMA
>  	tristate "ZTE ZX DMA support"
>  	depends on ARCH_ZX || COMPILE_TEST
> diff --git a/drivers/dma/xilinx/Makefile b/drivers/dma/xilinx/Makefile
> index 9e91f8f..04f6f99 100644
> --- a/drivers/dma/xilinx/Makefile
> +++ b/drivers/dma/xilinx/Makefile
> @@ -1,2 +1,4 @@
>  obj-$(CONFIG_XILINX_DMA) += xilinx_dma.o
>  obj-$(CONFIG_XILINX_ZYNQMP_DMA) += zynqmp_dma.o
> +ps_pcie_dma-objs := ps_pcie_main.o ps_pcie_platform.o
> +obj-$(CONFIG_XILINX_PS_PCIE_DMA) += ps_pcie_dma.o
> diff --git a/drivers/dma/xilinx/ps_pcie.h b/drivers/dma/xilinx/ps_pcie.h
> new file mode 100644
> index 0000000..351f051
> --- /dev/null
> +++ b/drivers/dma/xilinx/ps_pcie.h
> @@ -0,0 +1,44 @@
> +/*
> + * Xilinx PS PCIe DMA Engine platform header file
> + *
> + * Copyright (C) 2010-2017 Xilinx, Inc. All rights reserved.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation
> + */
> +
> +#ifndef __XILINX_PS_PCIE_H
> +#define __XILINX_PS_PCIE_H
> +
> +#include <linux/delay.h>
> +#include <linux/dma-direction.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <linux/irqreturn.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mempool.h>
> +#include <linux/of.h>
> +#include <linux/pci.h>
> +#include <linux/property.h>
> +#include <linux/platform_device.h>
> +#include <linux/timer.h>
> +#include <linux/dma/ps_pcie_dma.h>

Do you really need all these headers

> +
> +/**
> + * dma_platform_driver_register - This will be invoked by module init
> + *
> + * Return: returns status of platform_driver_register
> + */
> +int dma_platform_driver_register(void);
> +/**
> + * dma_platform_driver_unregister - This will be invoked by module exit
> + *
> + * Return: returns void after unregustering platform driver

typo, please run spell checker & checkpatch on your patches

> + */
> +void dma_platform_driver_unregister(void);
> +
> +#endif
> diff --git a/drivers/dma/xilinx/ps_pcie_main.c b/drivers/dma/xilinx/ps_pcie_main.c
> new file mode 100644
> index 0000000..4ccd8ef
> --- /dev/null
> +++ b/drivers/dma/xilinx/ps_pcie_main.c
> @@ -0,0 +1,200 @@
> +/*
> + * XILINX PS PCIe driver
> + *
> + * Copyright (C) 2017 Xilinx, Inc. All rights reserved.
> + *
> + * Description
> + * PS PCIe DMA is memory mapped DMA used to execute PS to PL transfers
> + * on ZynqMP UltraScale+ Devices.
> + * This PCIe driver creates a platform device with specific platform
> + * info enabling creation of DMA device corresponding to the channel
> + * information provided in the properties
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation
> + */
> +
> +#include "ps_pcie.h"
> +#include "../dmaengine.h"
> +
> +#define DRV_MODULE_NAME		  "ps_pcie_dma"
> +
> +static int ps_pcie_dma_probe(struct pci_dev *pdev,
> +			     const struct pci_device_id *ent);
> +static void ps_pcie_dma_remove(struct pci_dev *pdev);

why do you need fwd declarations of these?

> +
> +static u32 channel_properties_pcie_axi[] = {
> +	(u32)(PCIE_AXI_DIRECTION), (u32)(NUMBER_OF_BUFFER_DESCRIPTORS),
> +	(u32)(DEFAULT_DMA_QUEUES), (u32)(CHANNEL_COAELSE_COUNT),
> +	(u32)(CHANNEL_POLL_TIMER_FREQUENCY) };

why the casts?

> +
> +static u32 channel_properties_axi_pcie[] = {
> +	(u32)(AXI_PCIE_DIRECTION), (u32)(NUMBER_OF_BUFFER_DESCRIPTORS),
> +	(u32)(DEFAULT_DMA_QUEUES), (u32)(CHANNEL_COAELSE_COUNT),
> +	(u32)(CHANNEL_POLL_TIMER_FREQUENCY) };
> +
> +static struct property_entry generic_pcie_ep_property[] = {
> +	PROPERTY_ENTRY_U32("numchannels", (u32)MAX_NUMBER_OF_CHANNELS),
> +	PROPERTY_ENTRY_U32_ARRAY("ps_pcie_channel0",
> +				 channel_properties_pcie_axi),
> +	PROPERTY_ENTRY_U32_ARRAY("ps_pcie_channel1",
> +				 channel_properties_axi_pcie),
> +	PROPERTY_ENTRY_U32_ARRAY("ps_pcie_channel2",
> +				 channel_properties_pcie_axi),
> +	PROPERTY_ENTRY_U32_ARRAY("ps_pcie_channel3",
> +				 channel_properties_axi_pcie),
> +	{ },
> +};
> +
> +static const struct platform_device_info xlnx_std_platform_dev_info = {
> +	.name           = XLNX_PLATFORM_DRIVER_NAME,
> +	.properties     = generic_pcie_ep_property,
> +};
> +
> +/**
> + * ps_pcie_dma_probe - Driver probe function
> + * @pdev: Pointer to the pci_dev structure
> + * @ent: pci device id
> + *
> + * Return: '0' on success and failure value on error
> + */

I didnt get any useful info from this, pls get rid of these where they dont
help anyone...

> +static int ps_pcie_dma_probe(struct pci_dev *pdev,
> +			     const struct pci_device_id *ent)
> +{
> +	int err;
> +	struct platform_device *platform_dev;
> +	struct platform_device_info platform_dev_info;

helps reading if these are reverse christmas tree!

> +
> +	dev_info(&pdev->dev, "PS PCIe DMA Driver probe\n");

useless, pls remove

> +
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Cannot enable PCI device, aborting\n");
> +		return err;
> +	}
> +
> +	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	if (err) {
> +		dev_info(&pdev->dev, "Cannot set 64 bit DMA mask\n");
> +		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +		if (err) {
> +			dev_err(&pdev->dev, "DMA mask set error\n");

no disable device on err?

> +			return err;
> +		}
> +	}
> +
> +	err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> +	if (err) {
> +		dev_info(&pdev->dev, "Cannot set 64 bit consistent DMA mask\n");
> +		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> +		if (err) {
> +			dev_err(&pdev->dev, "Cannot set consistent DMA mask\n");
> +			return err;
> +		}
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	/* For Root DMA platform device will be created through device tree */
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX &&
> +	    pdev->device == ZYNQMP_RC_DMA_DEVID)
> +		return 0;

the indentations are terrible!

Why regiser for this ID then? Return 0 would be success, so not sure what
you are trying to do here?


> +
> +	memcpy(&platform_dev_info, &xlnx_std_platform_dev_info,
> +	       sizeof(xlnx_std_platform_dev_info));
> +
> +	/* Do device specific channel configuration changes to
> +	 * platform_dev_info.properties if required
> +	 * More information on channel properties can be found
> +	 * at Documentation/devicetree/bindings/dma/xilinx/ps-pcie-dma.txt
> +	 */

/*
 * kernel code expects multiline
 * comments like this
 */

> +
> +	platform_dev_info.parent = &pdev->dev;
> +	platform_dev_info.data = &pdev;
> +	platform_dev_info.size_data = sizeof(struct pci_dev **);

??

> +
> +	platform_dev = platform_device_register_full(&platform_dev_info);
> +	if (IS_ERR(platform_dev)) {
> +		dev_err(&pdev->dev,
> +			"Cannot create platform device, aborting\n");
> +		return PTR_ERR(platform_dev);
> +	}
> +
> +	pci_set_drvdata(pdev, platform_dev);
> +
> +	dev_info(&pdev->dev, "PS PCIe DMA driver successfully probed\n");
> +
> +	return 0;
> +}
> +
> +static struct pci_device_id ps_pcie_dma_tbl[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, ZYNQMP_DMA_DEVID) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, ZYNQMP_RC_DMA_DEVID) },
> +	{ }
> +};
> +
> +static struct pci_driver ps_pcie_dma_driver = {
> +	.name     = DRV_MODULE_NAME,
> +	.id_table = ps_pcie_dma_tbl,
> +	.probe    = ps_pcie_dma_probe,
> +	.remove   = ps_pcie_dma_remove,
> +};
> +
> +/**
> + * ps_pcie_init - Driver init function
> + *
> + * Return: 0 on success. Non zero on failure
> + */
> +static int __init ps_pcie_init(void)
> +{
> +	int ret;
> +
> +	pr_info("%s init()\n", DRV_MODULE_NAME);
> +
> +	ret = pci_register_driver(&ps_pcie_dma_driver);
> +	if (ret)
> +		return ret;
> +
> +	ret = dma_platform_driver_register();
> +	if (ret)
> +		pci_unregister_driver(&ps_pcie_dma_driver);
> +
> +	return ret;
> +}
> +
> +/**
> + * ps_pcie_dma_remove - Driver remove function
> + * @pdev: Pointer to the pci_dev structure
> + *
> + * Return: void
> + */
> +static void ps_pcie_dma_remove(struct pci_dev *pdev)
> +{
> +	struct platform_device *platform_dev;
> +
> +	platform_dev = (struct platform_device *)pci_get_drvdata(pdev);

no need to cast from void

> +
> +	if (platform_dev)
> +		platform_device_unregister(platform_dev);
> +}
> +
> +/**
> + * ps_pcie_exit - Driver exit function
> + *
> + * Return: void
> + */
> +static void __exit ps_pcie_exit(void)
> +{
> +	pr_info("%s exit()\n", DRV_MODULE_NAME);
> +
> +	dma_platform_driver_unregister();
> +	pci_unregister_driver(&ps_pcie_dma_driver);
> +}
> +
> +module_init(ps_pcie_init);
> +module_exit(ps_pcie_exit);
> +
> +MODULE_AUTHOR("Xilinx Inc");
> +MODULE_DESCRIPTION("Xilinx PS PCIe DMA Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/dma/ps_pcie_dma.h b/include/linux/dma/ps_pcie_dma.h
> new file mode 100644
> index 0000000..d11323a
> --- /dev/null
> +++ b/include/linux/dma/ps_pcie_dma.h
> @@ -0,0 +1,69 @@
> +/*
> + * Xilinx PS PCIe DMA Engine support header file
> + *
> + * Copyright (C) 2017 Xilinx, Inc. All rights reserved.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation
> + */
> +
> +#ifndef __DMA_XILINX_PS_PCIE_H
> +#define __DMA_XILINX_PS_PCIE_H
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +
> +#define XLNX_PLATFORM_DRIVER_NAME "xlnx-platform-dma-driver"
> +
> +#define ZYNQMP_DMA_DEVID	(0xD024)
> +#define ZYNQMP_RC_DMA_DEVID	(0xD021)
> +
> +#define MAX_ALLOWED_CHANNELS_IN_HW	4
> +
> +#define MAX_NUMBER_OF_CHANNELS	MAX_ALLOWED_CHANNELS_IN_HW
> +
> +#define DEFAULT_DMA_QUEUES	4
> +#define TWO_DMA_QUEUES		2
> +
> +#define NUMBER_OF_BUFFER_DESCRIPTORS	1999
> +#define MAX_DESCRIPTORS			65536
> +
> +#define CHANNEL_COAELSE_COUNT		0
> +
> +#define CHANNEL_POLL_TIMER_FREQUENCY	1000 /* in milli seconds */
> +
> +#define PCIE_AXI_DIRECTION	DMA_TO_DEVICE
> +#define AXI_PCIE_DIRECTION	DMA_FROM_DEVICE
> +
> +/**
> + * struct BAR_PARAMS - PCIe Bar Parameters
> + * @BAR_PHYS_ADDR: PCIe BAR Physical address
> + * @BAR_LENGTH: Length of PCIe BAR
> + * @BAR_VIRT_ADDR: Virtual Address to access PCIe BAR
> + */
> +struct BAR_PARAMS {
> +	dma_addr_t BAR_PHYS_ADDR; /**< Base physical address of BAR memory */
> +	unsigned long BAR_LENGTH; /**< Length of BAR memory window */
> +	void *BAR_VIRT_ADDR;      /**< Virtual Address of mapped BAR memory */

okay you have same comment twice. What is with DAMN UPPER CASE

If you cannot do basic checks for patches, I also refuse to waste my time
and review this any further!

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
