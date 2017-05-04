Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 1/3] of/pci/dma: fix DMA configuration for PCI masters
To: Oza Pawandeep <oza.oza@broadcom.com>
References: <1493786795-28153-1-git-send-email-oza.oza@broadcom.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.pawandeep@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d7203258-e39a-a59b-d14f-c0c92a1d3f41@arm.com>
Date: Thu, 4 May 2017 19:02:17 +0100
MIME-Version: 1.0
In-Reply-To: <1493786795-28153-1-git-send-email-oza.oza@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[apologies for the silence - I've been on holiday]

On 03/05/17 05:46, Oza Pawandeep wrote:
> current device framework and of framework integration assumes
> dma-ranges in a way where memory-mapped devices define their
> dma-ranges. (child-bus-address, parent-bus-address, length).

Well, yes, that is simply the definition of dma-ranges, and remains true
regardless of the particular format of either bus address.

> of_dma_configure is specifically written to take care of memory
> mapped devices. but no implementation exists for pci to take
> care of pcie based memory ranges.

That still doesn't make sense. To repeat myself again, PCI devices *ARE*
memory-mapped devices. Yes, there do exist some platforms where I/O
space is not treated as MMIO, but config space and memory space are very
much memory-mapped however you look at them, and in the context of DMA,
only memory space is relevant anyway.

What *is* true about the current code is that of_dma_get_range() expects
to be passed an OF node representing the device itself, and doesn't work
properly when passed the node of the device's parent bus directly, which
happens to be what pci_dma_configure() currently does. That's the only
reason why it doesn't work for (single-entry) host controller dma-ranges
today. This does not mean it's a PCI problem, it is simply the case that
pci_dma_configure() is the only caller currently hitting it. Other
discoverable, DMA-capable buses like fsl-mc are still going to face the
exact same problem with or without this patch.

> for e.g. iproc based SOCs and other SOCs(suc as rcar) have PCI
> world dma-ranges.
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
> 
> this patch serves following:
> 
> 1) exposes interface to the pci host driver for their
> inbound memory ranges
> 
> 2) provide an interface to callers such as of_dma_get_ranges.
> so then the returned size get best possible (largest) dma_mask.
> because PCI RC drivers do not call APIs such as
> dma_set_coherent_mask() and hence rather it shows its addressing
> capabilities based on dma-ranges.
> for e.g.
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
> we should get dev->coherent_dma_mask=0x7fffffffff.
> 
> 3) this patch handles multiple inbound windows and dma-ranges.
> it is left to the caller, how it wants to use them.
> the new function returns the resources in a standard and unform way
> 
> 4) this way the callers of for e.g. of_dma_get_ranges
> does not need to change.
> 
> 5) leaves scope of adding PCI flag handling for inbound memory
> by the new function.

Which flags would ever actually matter? DMA windows aren't going to be
to config or I/O space, so the memory type can be assumed, and the
32/64-bit distinction is irrelevant as it's not a relocatable BAR;
DMA-able system memory isn't going to be read-sensitive, so the
prefetchable flag shouldn't matter; and not being a BAR none of the
others would be relevant either.

> 
> Bug: SOC-5216
> Change-Id: Ie045386df91e1e0587846bb147ae40d96f6d7d2e
> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-on: http://gerrit-ccxsw.broadcom.net/40428
> Reviewed-by: vpx_checkpatch status <vpx_checkpatch@broadcom.com>
> Reviewed-by: CCXSW <ccxswbuild@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Tested-by: vpx_autobuild status <vpx_autobuild@broadcom.com>
> Tested-by: vpx_smoketest status <vpx_smoketest@broadcom.com>
> Tested-by: CCXSW <ccxswbuild@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> 
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 0ee42c3..ed6e69a 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -283,6 +283,83 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
> +
> +/**
> + * of_pci_get_dma_ranges - Parse PCI host bridge inbound resources from DT
> + * @np: device node of the host bridge having the dma-ranges property
> + * @resources: list where the range of resources will be added after DT parsing
> + *
> + * It is the caller's job to free the @resources list.
> + *
> + * This function will parse the "dma-ranges" property of a
> + * PCI host bridge device node and setup the resource mapping based
> + * on its content.
> + *
> + * It returns zero if the range parsing has been successful or a standard error
> + * value if it failed.
> + */
> +
> +int of_pci_get_dma_ranges(struct device_node *np, struct list_head *resources)
> +{
> +	struct device_node *node = of_node_get(np);
> +	int rlen;
> +	int ret = 0;
> +	const int na = 3, ns = 2;
> +	struct resource *res;
> +	struct of_pci_range_parser parser;
> +	struct of_pci_range range;
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	parser.node = node;
> +	parser.pna = of_n_addr_cells(node);
> +	parser.np = parser.pna + na + ns;
> +
> +	parser.range = of_get_property(node, "dma-ranges", &rlen);
> +
> +	if (!parser.range) {
> +		pr_debug("pcie device has no dma-ranges defined for node(%s)\n",
> +			  np->full_name);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	parser.end = parser.range + rlen / sizeof(__be32);
> +
> +	for_each_of_pci_range(&parser, &range) {

This is plain wrong - of_pci_range_parser_one() will translate upwards
through parent "ranges" properties, which is completely backwards for
DMA addresses.

Robin.

> +		/*
> +		 * If we failed translation or got a zero-sized region
> +		 * then skip this range
> +		 */
> +		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
> +			continue;
> +
> +		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> +		if (!res) {
> +			ret = -ENOMEM;
> +			goto parse_failed;
> +		}
> +
> +		ret = of_pci_range_to_resource(&range, np, res);
> +		if (ret) {
> +			kfree(res);
> +			continue;
> +		}
> +
> +		pci_add_resource_offset(resources, res,
> +					res->start - range.pci_addr);
> +	}
> +
> +	return ret;
> +
> +parse_failed:
> +	pci_free_resource_list(resources);
> +out:
> +	of_node_put(node);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_get_dma_ranges);
>  #endif /* CONFIG_OF_ADDRESS */
>  
>  #ifdef CONFIG_PCI_MSI
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 0e0974e..617b90d 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -76,6 +76,7 @@ static inline void of_pci_check_probe_only(void) { }
>  int of_pci_get_host_bridge_resources(struct device_node *dev,
>  			unsigned char busno, unsigned char bus_max,
>  			struct list_head *resources, resource_size_t *io_base);
> +int of_pci_get_dma_ranges(struct device_node *np, struct list_head *resources);
>  #else
>  static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
>  			unsigned char busno, unsigned char bus_max,
> @@ -83,6 +84,12 @@ static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
>  {
>  	return -EINVAL;
>  }
> +
> +static inline int of_pci_get_dma_ranges(struct device_node *np,
> +					struct list_head *resources)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  #if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
> 
