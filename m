Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Oza Oza <oza.oza@broadcom.com>
References: <6c34297b77de0fc7fc4b44b17749cfd2@mail.gmail.com>
 <bddd4c81-7d71-4207-4c5f-b632403daec9@arm.com>
In-Reply-To: <bddd4c81-7d71-4207-4c5f-b632403daec9@arm.com>
MIME-Version: 1.0
Date: Sat, 25 Mar 2017 11:04:35 +0530
Message-ID: <f58a4031cade7653e136ef885286b085@mail.gmail.com>
Subject: RE: [RFC PATCH] iommu/dma/pci: account pci host bridge dma_mask for
 IOVA allocation
To: Robin Murphy <robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Robin,

I have made 3 separate patches now, which gives clear idea about the
changes.
we can have discussion there.

Regards,
Oza.

-----Original Message-----
From: Robin Murphy [mailto:robin.murphy@arm.com]
Sent: Monday, March 20, 2017 9:14 PM
To: Oza Oza
Cc: Joerg Roedel; linux-pci@vger.kernel.org;
iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
bcm-kernel-feedback-list@broadcom.com
Subject: Re: [RFC PATCH] iommu/dma/pci: account pci host bridge dma_mask for
IOVA allocation

On 20/03/17 08:57, Oza Oza wrote:
> +  linux-pci
>
> Regards,
> Oza.
>
> -----Original Message-----
> From: Oza Pawandeep [mailto:oza.oza@broadcom.com]
> Sent: Friday, March 17, 2017 11:41 AM
> To: Joerg Roedel; Robin Murphy
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> bcm-kernel-feedback-list@broadcom.com; Oza Pawandeep
> Subject: [RFC PATCH] iommu/dma: account pci host bridge dma_mask for
> IOVA allocation
>
> It is possible that PCI device supports 64-bit DMA addressing, and
> thus it's driver sets device's dma_mask to DMA_BIT_MASK(64), however
> PCI host bridge may have limitations on the inbound transaction
> addressing. As an example, consider NVME SSD device connected to
> iproc-PCIe controller.
>
> Currently, the IOMMU DMA ops only considers PCI device dma_mask when
> allocating an IOVA. This is particularly problematic on
> ARM/ARM64 SOCs where the IOMMU (i.e. SMMU) translates IOVA to PA for
> in-bound transactions only after PCI Host has forwarded these
> transactions on SOC IO bus. This means on such ARM/ARM64 SOCs the IOVA
> of in-bound transactions has to honor the addressing restrictions of the
> PCI Host.
>
> this patch is inspired by
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1306545.ht
> ml http://www.spinics.net/lists/arm-kernel/msg566947.html
>
> but above inspiraiton solves the half of the problem.
> the rest of the problem is descrbied below, what we face on iproc
> based SOCs.
>
> current pcie frmework and of framework integration assumes dma-ranges
> in a way where memory-mapped devices define their dma-ranges.
> dma-ranges: (child-bus-address, parent-bus-address, length).
>
> but iproc based SOCs and even Rcar based SOCs has PCI world dma-ranges.
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>
> of_dma_configure is specifically witten to take care of memory mapped
> devices.
> but no implementation exists for pci to take care of pcie based memory
> ranges.
> in fact pci world doesnt seem to define standard dma-ranges since
> there is an absense of the same, the dma_mask used to remain 32bit
> because of
> 0 size return (parsed by of_dma_configure())
>
> this patch also implements of_pci_get_dma_ranges to cater to pci world
> dma-ranges.
> so then the returned size get best possible (largest) dma_mask.
> for e.g.
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>; we should get
> dev->coherent_dma_mask=0x7fffffffff.
>
> conclusion: there are following problems
> 1) linux pci and iommu framework integration has glitches with respect
> to dma-ranges
> 2) pci linux framework look very uncertain about dma-ranges, rather
> binding is not defined
>    the way it is defined for memory mapped devices.
>    rcar and iproc based SOCs use their custom one dma-ranges
>    (rather can be standard)
> 3) even if in case of default parser of_dma_get_ranges,:
>    it throws and erro"
>    "no dma-ranges found for node"
>    because of the bug which exists.
>    following lines should be moved to the end of while(1)
> 	839                 node = of_get_next_parent(node);
> 	840                 if (!node)
> 	841                         break;

Right, having made sense of this and looked into things myself I think I
understand now; what this boils down to is that the existing implementation
of of_dma_get_range() expects always to be given a leaf device_node, and
doesn't cope with being given a device_node for the given device's parent
bus directly. That's really all there is; it's not specific to PCI (there
are other probeable and DMA-capable buses whose children aren't described in
DT, like the fsl-mc thing), and it definitely doesn't have anything to do
with IOMMUs.

Now, that's certainly something to fix, but AFAICS this patch doesn't do
that, only adds some PCI-specific code which is never called.

DMA mask inheritance for arm64 is another issue, which again is general, but
does tend to be more visible in the IOMMU case. That still needs some work
on the APCI side - all the DT-centric approaches so far either regress or at
best do nothing for ACPI. I've made a note to try to look into that soon,
but from what I recall I fear there is still an open question about what to
do for a default in the absence of IORT or _DMA (once the current assumption
that drivers can override our arbitrary default at will is closed down).

In the meantime, have you tried 4.11-rc1 or later on the affected system?
One of the ulterior motives behind 122fac030e91 was that in many cases it
also happens to paper over most versions of this problem for PCI devices,
and makes the IOMMU at least useable (on systems which don't need to
dma_map_*() vast amounts of RAM all at once) while we fix the underlying
things properly.

Robin.

> Reviewed-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index
> 8c7c244..20cfff7 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -217,6 +217,9 @@ config NEED_DMA_MAP_STATE  config NEED_SG_DMA_LENGTH
>  	def_bool y
>
> +config ARCH_HAS_DMA_SET_COHERENT_MASK
> +	def_bool y
> +
>  config SMP
>  	def_bool y
>
> diff --git a/arch/arm64/include/asm/device.h
> b/arch/arm64/include/asm/device.h index 73d5bab..64b4dc3 100644
> --- a/arch/arm64/include/asm/device.h
> +++ b/arch/arm64/include/asm/device.h
> @@ -20,6 +20,7 @@ struct dev_archdata {  #ifdef CONFIG_IOMMU_API
>  	void *iommu;			/* private IOMMU data */
>  #endif
> +	u64 parent_dma_mask;
>  	bool dma_coherent;
>  };
>
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 81cdb2e..5845ecd 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -564,6 +564,7 @@ static void flush_page(struct device *dev, const
> void *virt, phys_addr_t phys)
>  	__dma_flush_area(virt, PAGE_SIZE);
>  }
>
> +
>  static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>  				 dma_addr_t *handle, gfp_t gfp,
>  				 unsigned long attrs)
> @@ -795,6 +796,20 @@ static void __iommu_unmap_sg_attrs(struct device
> *dev,
>  	iommu_dma_unmap_sg(dev, sgl, nelems, dir, attrs);  }
>
> +static int __iommu_set_dma_mask(struct device *dev, u64 mask) {
> +	/* device is not DMA capable */
> +	if (!dev->dma_mask)
> +		return -EIO;
> +
> +	if (mask > dev->archdata.parent_dma_mask)
> +		mask = dev->archdata.parent_dma_mask;
> +
> +	*dev->dma_mask = mask;
> +
> +	return 0;
> +}
> +
>  static const struct dma_map_ops iommu_dma_ops = {
>  	.alloc = __iommu_alloc_attrs,
>  	.free = __iommu_free_attrs,
> @@ -811,8 +826,21 @@ static void __iommu_unmap_sg_attrs(struct device
> *dev,
>  	.map_resource = iommu_dma_map_resource,
>  	.unmap_resource = iommu_dma_unmap_resource,
>  	.mapping_error = iommu_dma_mapping_error,
> +	.set_dma_mask = __iommu_set_dma_mask,
>  };
>
> +int dma_set_coherent_mask(struct device *dev, u64 mask) {
> +	if (get_dma_ops(dev) == &iommu_dma_ops &&
> +	    mask > dev->archdata.parent_dma_mask)
> +		mask = dev->archdata.parent_dma_mask;
> +
> +	dev->coherent_dma_mask = mask;
> +	return 0;
> +}
> +EXPORT_SYMBOL(dma_set_coherent_mask);
> +
> +
>  /*
>   * TODO: Right now __iommu_setup_dma_ops() gets called too early to do
>   * everything it needs to - the device is only partially created and
> the @@ -975,6 +1003,8 @@ void arch_setup_dma_ops(struct device *dev,
> u64 dma_base, u64 size,
>  	if (!dev->dma_ops)
>  		dev->dma_ops = &swiotlb_dma_ops;
>
> +	dev->archdata.parent_dma_mask = size - 1;
> +
>  	dev->archdata.dma_coherent = coherent;
>  	__iommu_setup_dma_ops(dev, dma_base, size, iommu);  } diff --git
> a/drivers/of/of_pci.c b/drivers/of/of_pci.c index 0ee42c3..5804717
> 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -283,6 +283,51 @@ int of_pci_get_host_bridge_resources(struct
> device_node *dev,
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
> +
> +int of_pci_get_dma_ranges(struct device_node *np, u64 *dma_addr, u64
> +*paddr, u64 *size) {
> +	struct device_node *node = of_node_get(np);
> +	int rlen, naddr, nsize, pna;
> +	int ret = 0;
> +	const int na = 3, ns = 2;
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
> +		pr_debug("pcie device has no dma-ranges defined for
> node(%s)\n", np->full_name);
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	parser.end = parser.range + rlen / sizeof(__be32);
> +
> +	/* how do we take care of multiple dma windows ?. */
> +	for_each_of_pci_range(&parser, &range) {
> +		*dma_addr = range.pci_addr;
> +		*size = range.size;
> +		*paddr = range.cpu_addr;
> +	}
> +
> +	pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
> +		 *dma_addr, *paddr, *size);
> +		 *dma_addr = range.pci_addr;
> +		 *size = range.size;
> +
> +out:
> +	of_node_put(node);
> +	return ret;
> +
> +}
> +EXPORT_SYMBOL_GPL(of_pci_get_dma_ranges);
>  #endif /* CONFIG_OF_ADDRESS */
>
>  #ifdef CONFIG_PCI_MSI
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h index
> 0e0974e..907ace0 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -76,6 +76,7 @@ static inline void of_pci_check_probe_only(void) { }
> int of_pci_get_host_bridge_resources(struct device_node *dev,
>  			unsigned char busno, unsigned char bus_max,
>  			struct list_head *resources, resource_size_t *io_base);
> +int of_pci_get_dma_ranges(struct device_node *np, u64 *dma_addr, u64
> +*paddr, u64 *size);
>  #else
>  static inline int of_pci_get_host_bridge_resources(struct device_node
> *dev,
>  			unsigned char busno, unsigned char bus_max, @@
> -83,6 +84,11 @@ static inline int
> of_pci_get_host_bridge_resources(struct
> device_node *dev,  {
>  	return -EINVAL;
>  }
> +
> +static inline int of_pci_get_dma_ranges(struct device_node *np, u64
> +*dma_addr, u64 *paddr, u64 *size) {
> +	return -EINVAL;
> +}
>  #endif
>
>  #if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
