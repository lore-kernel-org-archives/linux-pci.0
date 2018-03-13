Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932708AbeCMLgC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 07:36:02 -0400
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus infrastructure
To: Nipun Gupta <nipun.gupta@nxp.com>, hch@lst.de,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        m.szyprowski@samsung.com, bhelgaas@google.com
Cc: dmitry.torokhov@gmail.com, rafael.j.wysocki@intel.com,
        jarkko.sakkinen@linux.intel.com, linus.walleij@linaro.org,
        johan@kernel.org, msuchanek@suse.de, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a6cd83c9-d769-2994-5230-0a97de1897e5@arm.com>
Date: Tue, 13 Mar 2018 11:35:58 +0000
MIME-Version: 1.0
In-Reply-To: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/03/18 15:24, Nipun Gupta wrote:
> The change introduces 'dma_configure' & 'dma_deconfigure'as
> bus callback functions so each bus can choose to implement
> its own dma configuration function.
> This eases the addition of new busses w.r.t. adding the dma
> configuration functionality.

It's probably worth clarifying - either in the commit message, the 
kerneldoc, or both - that the bus-specific aspect is that of mapping 
between a given device on the bus and the relevant firmware description 
of its DMA configuration.

> The change also updates the PCI, Platform and ACPI bus to use
> new introduced callbacks.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>   - This patch is based on the comments on:
>     https://patchwork.kernel.org/patch/10259087/
>   - I have validated for PCI and platform, but not for AMBA as I
>     do not have infrastructure to validate it.
>     Can anyone please validate them on AMBA?
> 
>   drivers/amba/bus.c          | 38 ++++++++++++++++++++++++-----
>   drivers/base/dd.c           | 14 +++++++----
>   drivers/base/dma-mapping.c  | 41 -------------------------------
>   drivers/base/platform.c     | 36 ++++++++++++++++++++++-----
>   drivers/pci/pci-driver.c    | 59 ++++++++++++++++++++++++++++++++++++---------
>   include/linux/device.h      |  6 +++++
>   include/linux/dma-mapping.h | 12 ---------
>   7 files changed, 124 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 594c228..58241d2 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -20,6 +20,8 @@
>   #include <linux/sizes.h>
>   #include <linux/limits.h>
>   #include <linux/clk/clk-conf.h>
> +#include <linux/acpi.h>
> +#include <linux/of_device.h>
>   
>   #include <asm/irq.h>
>   
> @@ -171,6 +173,28 @@ static int amba_pm_runtime_resume(struct device *dev)
>   }
>   #endif /* CONFIG_PM */
>   
> +int amba_dma_configure(struct device *dev)
> +{
> +	enum dev_dma_attr attr;
> +	int ret = 0;
> +
> +	if (dev->of_node) {
> +		ret = of_dma_configure(dev, dev->of_node);
> +	} else if (has_acpi_companion(dev)) {
> +		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
> +		if (attr != DEV_DMA_NOT_SUPPORTED)
> +			ret = acpi_dma_configure(dev, attr);
> +	}
> +
> +	return ret;
> +}

I would be inclined to have amba_bustype just reference 
platform_dma_configure() directly rather than duplicate it like this, 
since there's no sensible reason for them to ever differ.

> +
> +void amba_dma_deconfigure(struct device *dev)
> +{
> +	of_dma_deconfigure(dev);
> +	acpi_dma_deconfigure(dev);
> +}
> +
>   static const struct dev_pm_ops amba_pm = {
>   	.suspend	= pm_generic_suspend,
>   	.resume		= pm_generic_resume,
> @@ -190,12 +214,14 @@ static int amba_pm_runtime_resume(struct device *dev)
>    * so we call the bus "amba".
>    */
>   struct bus_type amba_bustype = {
> -	.name		= "amba",
> -	.dev_groups	= amba_dev_groups,
> -	.match		= amba_match,
> -	.uevent		= amba_uevent,
> -	.pm		= &amba_pm,
> -	.force_dma	= true,
> +	.name			= "amba",
> +	.dev_groups		= amba_dev_groups,
> +	.match			= amba_match,
> +	.uevent			= amba_uevent,
> +	.pm			= &amba_pm,
> +	.dma_configure		= amba_dma_configure,
> +	.dma_deconfigure	= amba_dma_deconfigure,
> +	.force_dma		= true,

This patch should also be removing force_dma because it no longer makes 
sense. If DMA configuration is now done by a bus-level callback, then a 
bus which wants its children to get DMA configuration needs to implement 
that callback; there's nowhere to force a "default" global behaviour any 
more.

>   };
>   
>   static int __init amba_init(void)
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index de6fd09..f124f3f 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -421,9 +421,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>   	if (ret)
>   		goto pinctrl_bind_failed;
>   
> -	ret = dma_configure(dev);
> -	if (ret)
> -		goto dma_failed;
> +	if (dev->bus->dma_configure) {
> +		ret = dev->bus->dma_configure(dev);
> +		if (ret)
> +			goto dma_failed;
> +	}
>   
>   	if (driver_sysfs_add(dev)) {
>   		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
> @@ -486,7 +488,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>   	goto done;
>   
>   probe_failed:
> -	dma_deconfigure(dev);
> +	if (dev->bus->dma_deconfigure)
> +		dev->bus->dma_deconfigure(dev);
>   dma_failed:
>   	if (dev->bus)
>   		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> @@ -895,7 +898,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>   			drv->remove(dev);
>   
>   		device_links_driver_cleanup(dev);
> -		dma_deconfigure(dev);
> +		if (dev->bus->dma_deconfigure)
> +			dev->bus->dma_deconfigure(dev);
>   
>   		devres_release_all(dev);
>   		dev->driver = NULL;
> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
> index 3b11835..f16bd49 100644
> --- a/drivers/base/dma-mapping.c
> +++ b/drivers/base/dma-mapping.c
> @@ -6,11 +6,9 @@
>    * Copyright (c) 2006  Tejun Heo <teheo@suse.de>
>    */
>   
> -#include <linux/acpi.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/export.h>
>   #include <linux/gfp.h>
> -#include <linux/of_device.h>
>   #include <linux/slab.h>
>   #include <linux/vmalloc.h>
>   
> @@ -329,42 +327,3 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
>   	vunmap(cpu_addr);
>   }
>   #endif
> -
> -/*
> - * Common configuration to enable DMA API use for a device
> - */
> -#include <linux/pci.h>
> -
> -int dma_configure(struct device *dev)
> -{
> -	struct device *bridge = NULL, *dma_dev = dev;
> -	enum dev_dma_attr attr;
> -	int ret = 0;
> -
> -	if (dev_is_pci(dev)) {
> -		bridge = pci_get_host_bridge_device(to_pci_dev(dev));
> -		dma_dev = bridge;
> -		if (IS_ENABLED(CONFIG_OF) && dma_dev->parent &&
> -		    dma_dev->parent->of_node)
> -			dma_dev = dma_dev->parent;
> -	}
> -
> -	if (dma_dev->of_node) {
> -		ret = of_dma_configure(dev, dma_dev->of_node);
> -	} else if (has_acpi_companion(dma_dev)) {
> -		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
> -		if (attr != DEV_DMA_NOT_SUPPORTED)
> -			ret = acpi_dma_configure(dev, attr);
> -	}
> -
> -	if (bridge)
> -		pci_put_host_bridge_device(bridge);
> -
> -	return ret;
> -}
> -
> -void dma_deconfigure(struct device *dev)
> -{
> -	of_dma_deconfigure(dev);
> -	acpi_dma_deconfigure(dev);
> -}
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index f1bf7b3..adf94eb 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1130,6 +1130,28 @@ int platform_pm_restore(struct device *dev)
>   
>   #endif /* CONFIG_HIBERNATE_CALLBACKS */
>   
> +int platform_dma_configure(struct device *dev)
> +{
> +	enum dev_dma_attr attr;
> +	int ret = 0;
> +
> +	if (dev->of_node) {
> +		ret = of_dma_configure(dev, dev->of_node);
> +	} else if (has_acpi_companion(dev)) {
> +		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
> +		if (attr != DEV_DMA_NOT_SUPPORTED)
> +			ret = acpi_dma_configure(dev, attr);
> +	}
> +
> +	return ret;
> +}
> +
> +void platform_dma_deconfigure(struct device *dev)
> +{
> +	of_dma_deconfigure(dev);
> +	acpi_dma_deconfigure(dev);
> +}
> +
>   static const struct dev_pm_ops platform_dev_pm_ops = {
>   	.runtime_suspend = pm_generic_runtime_suspend,
>   	.runtime_resume = pm_generic_runtime_resume,
> @@ -1137,12 +1159,14 @@ int platform_pm_restore(struct device *dev)
>   };
>   
>   struct bus_type platform_bus_type = {
> -	.name		= "platform",
> -	.dev_groups	= platform_dev_groups,
> -	.match		= platform_match,
> -	.uevent		= platform_uevent,
> -	.pm		= &platform_dev_pm_ops,
> -	.force_dma	= true,
> +	.name			= "platform",
> +	.dev_groups		= platform_dev_groups,
> +	.match			= platform_match,
> +	.uevent			= platform_uevent,
> +	.pm			= &platform_dev_pm_ops,
> +	.dma_configure		= platform_dma_configure,
> +	.dma_deconfigure	= platform_dma_deconfigure,
> +	.force_dma		= true,
>   };
>   EXPORT_SYMBOL_GPL(platform_bus_type);
>   
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3bed6be..4a77814 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -18,6 +18,8 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/suspend.h>
>   #include <linux/kexec.h>
> +#include <linux/acpi.h>
> +#include <linux/of_device.h>
>   #include "pci.h"
>   
>   struct pci_dynid {
> @@ -1522,19 +1524,52 @@ static int pci_bus_num_vf(struct device *dev)
>   	return pci_num_vf(to_pci_dev(dev));
>   }
>   
> +int pci_dma_configure(struct device *dev)
> +{
> +	struct device *bridge, *dma_dev;

You don't need dma_dev here; see the code removed in 09515ef5ddad for 
how the logic originally worked.

> +	enum dev_dma_attr attr;
> +	int ret = 0;
> +
> +	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
> +	dma_dev = bridge;
> +	if (IS_ENABLED(CONFIG_OF) && dma_dev->parent &&
> +	    dma_dev->parent->of_node)
> +		dma_dev = dma_dev->parent;
> +
> +	if (dma_dev->of_node) {
> +		ret = of_dma_configure(dev, dma_dev->of_node);
> +	} else if (has_acpi_companion(dma_dev)) {
> +		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
> +		if (attr != DEV_DMA_NOT_SUPPORTED)
> +			ret = acpi_dma_configure(dev, attr);
> +	}
> +
> +	pci_put_host_bridge_device(bridge);
> +
> +	return ret;
> +}
> +
> +void pci_dma_deconfigure(struct device *dev)
> +{
> +	of_dma_deconfigure(dev);
> +	acpi_dma_deconfigure(dev);
> +}
> +
>   struct bus_type pci_bus_type = {
> -	.name		= "pci",
> -	.match		= pci_bus_match,
> -	.uevent		= pci_uevent,
> -	.probe		= pci_device_probe,
> -	.remove		= pci_device_remove,
> -	.shutdown	= pci_device_shutdown,
> -	.dev_groups	= pci_dev_groups,
> -	.bus_groups	= pci_bus_groups,
> -	.drv_groups	= pci_drv_groups,
> -	.pm		= PCI_PM_OPS_PTR,
> -	.num_vf		= pci_bus_num_vf,
> -	.force_dma	= true,
> +	.name			= "pci",
> +	.match			= pci_bus_match,
> +	.uevent			= pci_uevent,
> +	.probe			= pci_device_probe,
> +	.remove			= pci_device_remove,
> +	.shutdown		= pci_device_shutdown,
> +	.dev_groups		= pci_dev_groups,
> +	.bus_groups		= pci_bus_groups,
> +	.drv_groups		= pci_drv_groups,
> +	.pm			= PCI_PM_OPS_PTR,
> +	.num_vf			= pci_bus_num_vf,
> +	.dma_configure		= pci_dma_configure,
> +	.dma_deconfigure	= pci_dma_deconfigure,
> +	.force_dma		= true,
>   };
>   EXPORT_SYMBOL(pci_bus_type);
>   
> diff --git a/include/linux/device.h b/include/linux/device.h
> index b093405..9b2dcf6 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -88,6 +88,9 @@ extern int __must_check bus_create_file(struct bus_type *,
>    * @resume:	Called to bring a device on this bus out of sleep mode.
>    * @num_vf:	Called to find out how many virtual functions a device on this
>    *		bus supports.
> + * @dma_configure:	Called to setup DMA configuration on a device on
> +			this bus.
> + * @dma_deconfigure:	Called to tear down the DMA configuration.
>    * @pm:		Power management operations of this bus, callback the specific
>    *		device driver's pm-ops.
>    * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
> @@ -130,6 +133,9 @@ struct bus_type {
>   
>   	int (*num_vf)(struct device *dev);
>   
> +	int (*dma_configure)(struct device *dev);
> +	void (*dma_deconfigure)(struct device *dev);

Seeing it laid out in the patch, I really don't think we need a 
deconfigure callback like this - the fact that we're just copy-pasting 
the existing implementation everywhere is a big hint, but more 
conceptually I can't see a good reason for it to ever need bus-specific 
behaviour in the same way that configure does.

Maybe that means we keep dma_configure() around for the sake of 
symmetry, but just reduce it to:

int dma_configure(struct device *dev)
{
	if (dev->bus->dma_configure)
		return dev->bus->dma_configure(dev);
	return 0;
}

Realistically though, dma_deconfigure() only exists for the sake of 
calling arch_teardown_dma_ops(), and that only really exists for the 
sake of the old ARM IOMMU code, so I'm not inclined to pretend it's 
anywhere near as important as the dma_configure() path in design terms.

Robin.

> +
>   	const struct dev_pm_ops *pm;
>   
>   	const struct iommu_ops *iommu_ops;
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index eb9eab4..039224b 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -761,18 +761,6 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
>   }
>   #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
>   
> -#ifdef CONFIG_HAS_DMA
> -int dma_configure(struct device *dev);
> -void dma_deconfigure(struct device *dev);
> -#else
> -static inline int dma_configure(struct device *dev)
> -{
> -	return 0;
> -}
> -
> -static inline void dma_deconfigure(struct device *dev) {}
> -#endif
> -
>   /*
>    * Managed DMA API
>    */
> 
