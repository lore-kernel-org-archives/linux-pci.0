Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:54458 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751734AbbKQPAh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 Nov 2015 10:00:37 -0500
Subject: Re: [PATCH V5 8/9] PCI: OF: Move of_pci_dma_configure() to
 pci_dma_configure()
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
	catalin.marinas@arm.com, will.deacon@arm.com
References: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1446072654-5608-9-git-send-email-Suravee.Suthikulpanit@amd.com>
Cc: thomas.lendacky@amd.com, herbert@gondor.apana.org.au,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, hanjun.guo@linaro.org,
	davem@davemloft.net, linux-arm-kernel@lists.infradead.org
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <564B4111.6010805@arm.com>
Date: Tue, 17 Nov 2015 15:00:33 +0000
MIME-Version: 1.0
In-Reply-To: <1446072654-5608-9-git-send-email-Suravee.Suthikulpanit@amd.com>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Suravee,

On 28/10/15 22:50, Suravee Suthikulpanit wrote:
> This patch move of_pci_dma_configure() to a more generic
> pci_dma_configure(), which can be extended by non-OF code (e.g. ACPI).
>
> This has no functional change.

Unfortunately, it appears that it does...

> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Acked-by: Rob Herring <robh+dt@kernel.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> ---
>   drivers/of/of_pci.c    | 19 -------------------
>   drivers/pci/probe.c    | 23 +++++++++++++++++++++--
>   include/linux/of_pci.h |  3 ---
>   3 files changed, 21 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index a2f510c..b66ee4e 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -117,25 +117,6 @@ int of_get_pci_domain_nr(struct device_node *node)
>   }
>   EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
>
> -/**
> - * of_pci_dma_configure - Setup DMA configuration
> - * @dev: ptr to pci_dev struct of the PCI device
> - *
> - * Function to update PCI devices's DMA configuration using the same
> - * info from the OF node of host bridge's parent (if any).
> - */
> -void of_pci_dma_configure(struct pci_dev *pci_dev)
> -{
> -	struct device *dev = &pci_dev->dev;
> -	struct device *bridge = pci_get_host_bridge_device(pci_dev);
> -
> -	if (bridge->parent)
> -		of_dma_configure(dev, bridge->parent->of_node);
> -
> -	pci_put_host_bridge_device(bridge);
> -}
> -EXPORT_SYMBOL_GPL(of_pci_dma_configure);
> -
>   #if defined(CONFIG_OF_ADDRESS)
>   /**
>    * of_pci_get_host_bridge_resources - Parse PCI host bridge resources from DT
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8361d27..31e3eef 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -6,7 +6,7 @@
>   #include <linux/delay.h>
>   #include <linux/init.h>
>   #include <linux/pci.h>
> -#include <linux/of_pci.h>
> +#include <linux/of_device.h>
>   #include <linux/pci_hotplug.h>
>   #include <linux/slab.h>
>   #include <linux/module.h>
> @@ -1633,6 +1633,25 @@ static void pci_set_msi_domain(struct pci_dev *dev)
>   				   dev_get_msi_domain(&dev->bus->dev));
>   }
>
> +/**
> + * pci_dma_configure - Setup DMA configuration
> + * @dev: ptr to pci_dev struct of the PCI device
> + *
> + * Function to update PCI devices's DMA configuration using the same
> + * info from the OF node of host bridge's parent (if any).
> + */
> +static void pci_dma_configure(struct pci_dev *dev)
> +{
> +	struct device *bridge = pci_get_host_bridge_device(dev);
> +
> +	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {

Previously I was seeing of_dma_configure, and thus of_iommu_configure, 
called for every PCI device on Juno. The check above now prevents this 
happening, since the PCI devices are probed directly from the bus and 
don't have OF nodes of their own. They now get left in some 
half-configured state where arch_setup_dma_ops isn't called either.

Should this be checking bridge->parent->of_node rather than 
dev->dev.of_node (which seems to work), or am I missing something?

Sorry I don't really have the bandwidth to look into this in detail 
myself, right now I'm just trying to get my magic hacks rebased ;)

Robin.

> +		if (bridge->parent)
> +			of_dma_configure(&dev->dev, bridge->parent->of_node);
> +	}
> +
> +	pci_put_host_bridge_device(bridge);
> +}
> +
>   void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>   {
>   	int ret;
> @@ -1646,7 +1665,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>   	dev->dev.dma_mask = &dev->dma_mask;
>   	dev->dev.dma_parms = &dev->dma_parms;
>   	dev->dev.coherent_dma_mask = 0xffffffffull;
> -	of_pci_dma_configure(dev);
> +	pci_dma_configure(dev);
>
>   	pci_set_dma_max_seg_size(dev, 65536);
>   	pci_set_dma_seg_boundary(dev, 0xffffffff);
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 29fd3fe..ce0e5ab 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -16,7 +16,6 @@ int of_pci_get_devfn(struct device_node *np);
>   int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
>   int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
>   int of_get_pci_domain_nr(struct device_node *node);
> -void of_pci_dma_configure(struct pci_dev *pci_dev);
>   #else
>   static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
>   {
> @@ -51,8 +50,6 @@ of_get_pci_domain_nr(struct device_node *node)
>   {
>   	return -1;
>   }
> -
> -static inline void of_pci_dma_configure(struct pci_dev *pci_dev) { }
>   #endif
>
>   #if defined(CONFIG_OF_ADDRESS)
>

