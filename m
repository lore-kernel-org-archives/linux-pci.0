Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
To: Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <589c04cb-061b-a453-3188-79324a02388e@arm.com>
Date: Thu, 12 Oct 2017 19:04:09 +0100
MIME-Version: 1.0
In-Reply-To: <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
 Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
 Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, Gregory Fong <gregory.0xf0@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Brian Norris <computersforpeace@gmail.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+DMA API maintainers]

On 11/10/17 23:34, Jim Quinlan wrote:
> The Broadcom STB PCIe host controller is intimately related to the
> memory subsystem.  This close relationship adds complexity to how cpu
> system memory is mapped to PCIe memory.  Ideally, this mapping is an
> identity mapping, or an identity mapping off by a constant.  Not so in
> this case.
> 
> Consider the Broadcom reference board BCM97445LCC_4X8 which has 6 GB
> of system memory.  Here is how the PCIe controller maps the
> system memory to PCIe memory:
> 
>   memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
>   memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
>   memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
>   memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
>   memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
>   memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
> 
> Although there are some "gaps" that can be added between the
> individual mappings by software, the permutation of memory regions for
> the most part is fixed by HW.  The solution of having something close
> to an identity mapping is not possible.
> 
> The idea behind this HW design is that the same PCIe module can
> act as an RC or EP, and if it acts as an EP it concatenates all
> of system memory into a BAR so anything can be accessed.  Unfortunately,
> when the PCIe block is in the role of an RC it also presents this
> "BAR" to downstream PCIe devices, rather than offering an identity map
> between its system memory and PCIe space.
> 
> Suppose that an endpoint driver allocs some DMA memory.  Suppose this
> memory is located at 0x6000_0000, which is in the middle of memc1-a.
> The driver wants a dma_addr_t value that it can pass on to the EP to
> use.  Without doing any custom mapping, the EP will use this value for
> DMA: the driver will get a dma_addr_t equal to 0x6000_0000.  But this
> won't work; the device needs a dma_addr_t that reflects the PCIe space
> address, namely 0xa000_0000.
> 
> So, essentially the solution to this problem must modify the
> dma_addr_t returned by the DMA routines routines.  There are two
> ways (I know of) of doing this:
> 
> (a) overriding/redefining the dma_to_phys() and phys_to_dma() calls
> that are used by the dma_ops routines.  This is the approach of
> 
> 	arch/mips/cavium-octeon/dma-octeon.c
> 
> In ARM and ARM64 these two routines are defiend in asm/dma-mapping.h
> as static inline functions.
> 
> (b) Subscribe to a notifier that notifies when a device is added to a
> bus.  When this happens, set_dma_ops() can be called for the device.
> This method is mentioned in:
> 
>     http://lxr.free-electrons.com/source/drivers/of/platform.c?v=3.16#L152
> 
> where it says as a comment
> 
>     "In case if platform code need to use own special DMA
>     configuration, it can use Platform bus notifier and
>     handle BUS_NOTIFY_ADD_DEVICE event to fix up DMA
>     configuration."
> 
> Solution (b) is what this commit does.  It uses the native dma_ops
> as the base set of operations, and overrides some with custom
> functions that translate the address and then call the base
> function.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/host/Makefile          |   3 +-
>  drivers/pci/host/pci-brcmstb-dma.c | 219 +++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pci-brcmstb.c     | 150 +++++++++++++++++++++++--
>  drivers/pci/host/pci-brcmstb.h     |   7 ++
>  4 files changed, 368 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/pci/host/pci-brcmstb-dma.c
> 
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 4398d2c..c283321 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -21,7 +21,8 @@ obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
>  obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
>  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
>  obj-$(CONFIG_VMD) += vmd.o
> -obj-$(CONFIG_PCI_BRCMSTB) += pci-brcmstb.o
> +obj-$(CONFIG_PCI_BRCMSTB) += brcmstb-pci.o
> +brcmstb-pci-objs := pci-brcmstb.o pci-brcmstb-dma.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/host/pci-brcmstb-dma.c b/drivers/pci/host/pci-brcmstb-dma.c
> new file mode 100644
> index 0000000..81ce122
> --- /dev/null
> +++ b/drivers/pci/host/pci-brcmstb-dma.c
> @@ -0,0 +1,219 @@
> +/*
> + * Copyright (C) 2015-2017 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + */
> +#include <linux/dma-mapping.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/smp.h>
> +
> +#include "pci-brcmstb.h"
> +
> +static const struct dma_map_ops *arch_dma_ops;
> +static struct dma_map_ops brcm_dma_ops;
> +
> +static void *brcm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> +			    gfp_t gfp, unsigned long attrs)
> +{
> +	void *ret;
> +
> +	ret = arch_dma_ops->alloc(dev, size, handle, gfp, attrs);
> +	if (ret)
> +		*handle = brcm_to_pci(*handle);
> +	return ret;
> +}
> +
> +static void brcm_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +			  dma_addr_t handle, unsigned long attrs)
> +{
> +	handle = brcm_to_cpu(handle);
> +	arch_dma_ops->free(dev, size, cpu_addr, handle, attrs);
> +}
> +
> +static int brcm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> +			 void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +			 unsigned long attrs)
> +{
> +	dma_addr = brcm_to_cpu(dma_addr);
> +	return arch_dma_ops->mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
> +}
> +
> +static int brcm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> +				void *cpu_addr, dma_addr_t handle, size_t size,
> +				unsigned long attrs)
> +{
> +	handle = brcm_to_cpu(handle);
> +	return arch_dma_ops->get_sgtable(dev, sgt, cpu_addr, handle, size,
> +				       attrs);
> +}
> +
> +static dma_addr_t brcm_dma_map_page(struct device *dev, struct page *page,
> +				    unsigned long offset, size_t size,
> +				    enum dma_data_direction dir,
> +				    unsigned long attrs)
> +{
> +	return brcm_to_pci(arch_dma_ops->map_page(dev, page, offset, size,
> +						  dir, attrs));
> +}
> +
> +static void brcm_dma_unmap_page(struct device *dev, dma_addr_t handle,
> +				size_t size, enum dma_data_direction dir,
> +				unsigned long attrs)
> +{
> +	handle = brcm_to_cpu(handle);
> +	arch_dma_ops->unmap_page(dev, handle, size, dir, attrs);
> +}
> +
> +static int brcm_dma_map_sg(struct device *dev, struct scatterlist *sgl,
> +			   int nents, enum dma_data_direction dir,
> +			   unsigned long attrs)
> +{
> +	int ret, i;
> +	struct scatterlist *sg;
> +
> +	ret = arch_dma_ops->map_sg(dev, sgl, nents, dir, attrs);
> +	/* The ARM and MIPS implementations of map_sg and unmap_sg
> +	 * make calls to ops->map_page(), which we already intercept.
> +	 * The ARM64 does not, so we must iterate through the SG list
> +	 * and  convert each dma_address to one that is compatible
> +	 * with our PCI RC implementation.
> +	 */

That's a pretty fragile assumption given that arch code is free to
change, and anyone doing so is unlikely to be aware of your driver.
You'd be better off implementing these in terms of {brcm_dma_}map_page
directly.

> +	if (IS_ENABLED(CONFIG_ARM64))
> +		for_each_sg(sgl, sg, ret, i)
> +			sg->dma_address = brcm_to_pci(sg->dma_address);
> +	return ret;
> +}
> +
> +static void brcm_dma_unmap_sg(struct device *dev,
> +			      struct scatterlist *sgl, int nents,
> +			      enum dma_data_direction dir,
> +			      unsigned long attrs)
> +{
> +	int i;
> +	struct scatterlist *sg;
> +
> +	/* The ARM and MIPS implementations of map_sg and unmap_sg
> +	 * make calls to ops->map_page(), which we already intercept.
> +	 * The ARM64 does not, so we must iterate through the SG list
> +	 * and  convert each dma_address to one that is compatible
> +	 * with our PCI RC implementation.
> +	 */
> +	if (IS_ENABLED(CONFIG_ARM64))
> +		for_each_sg(sgl, sg, nents, i)
> +			sg->dma_address = brcm_to_cpu(sg->dma_address);
> +	arch_dma_ops->map_sg(dev, sgl, nents, dir, attrs);
> +}
> +
> +static void brcm_dma_sync_single_for_cpu(struct device *dev,
> +					 dma_addr_t handle, size_t size,
> +					 enum dma_data_direction dir)
> +{
> +	handle = brcm_to_cpu(handle);
> +	arch_dma_ops->sync_single_for_cpu(dev, handle, size, dir);
> +}
> +
> +static void brcm_dma_sync_single_for_device(struct device *dev,
> +					    dma_addr_t handle, size_t size,
> +					    enum dma_data_direction dir)
> +{
> +	handle = brcm_to_cpu(handle);
> +	arch_dma_ops->sync_single_for_device(dev, handle, size, dir);
> +}

And sync_sg_*()? They might not be that commonly used by in-tree
drivers, but who knows what lurks beyond?

> +
> +static dma_addr_t brcm_dma_map_resource(struct device *dev, phys_addr_t phys,
> +					size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs)
> +{
> +	return brcm_to_pci(arch_dma_ops->map_resource
> +			   (dev, phys, size, dir, attrs));
> +}
> +
> +static void brcm_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> +				    size_t size, enum dma_data_direction dir,
> +				    unsigned long attrs)
> +{
> +	handle = brcm_to_cpu(handle);
> +	arch_dma_ops->unmap_resource(dev, handle, size, dir, attrs);
> +}
> +
> +static int brcm_mapping_error(struct device *dev, dma_addr_t dma_addr)
> +{
> +	return dma_addr == BRCMSTB_ERROR_CODE;

Huh? How do you know this will work correctly with every platform's
->map_page implementation (hint: it doesn't).

> +}
> +
> +static const struct dma_map_ops *brcm_get_arch_dma_ops(struct device *dev)
> +{
> +#if defined(CONFIG_MIPS)
> +	return mips_dma_map_ops;
> +#elif defined(CONFIG_ARM)
> +	return &arm_dma_ops;
> +#elif defined(CONFIG_ARM64)
> +	/* swiotlb_dma_ops is a static var, so we get ahold
> +	 * of it by calling arch_setup_dma_ops(...).
> +	 */
> +	arch_setup_dma_ops(dev, 0, 0, NULL, false);
> +	return dev->dma_ops;
> +#endif
> +	return 0;
> +}

As mentioned earlier, no. There are theoretical cases where it might not
be true, but in practice you can assume all PCI devices are going to get
the same DMA ops as their associated host controller (and that's still a
better assumption that what you have here), so you can just grab those
at the point you install the notifier.

> +
> +static void brcm_set_dma_ops(struct device *dev)
> +{
> +	arch_dma_ops = brcm_get_arch_dma_ops(dev);
> +	if (!arch_dma_ops)
> +		return;
> +
> +	/* Set all of the base operations; some will be overridden */
> +	brcm_dma_ops = *arch_dma_ops;
> +
> +	/* Insert the Brcm-specific override operations */
> +	brcm_dma_ops.alloc = brcm_dma_alloc;
> +	brcm_dma_ops.free = brcm_dma_free;
> +	brcm_dma_ops.mmap = brcm_dma_mmap;
> +	brcm_dma_ops.get_sgtable = brcm_dma_get_sgtable;
> +	brcm_dma_ops.map_page = brcm_dma_map_page;
> +	brcm_dma_ops.unmap_page = brcm_dma_unmap_page;
> +	brcm_dma_ops.sync_single_for_cpu = brcm_dma_sync_single_for_cpu;
> +	brcm_dma_ops.sync_single_for_device = brcm_dma_sync_single_for_device;
> +	brcm_dma_ops.map_sg = brcm_dma_map_sg;
> +	brcm_dma_ops.unmap_sg = brcm_dma_unmap_sg;
> +	if (arch_dma_ops->map_resource)
> +		brcm_dma_ops.map_resource = brcm_dma_map_resource;
> +	if (arch_dma_ops->unmap_resource)
> +		brcm_dma_ops.unmap_resource = brcm_dma_unmap_resource;
> +	brcm_dma_ops.mapping_error = brcm_mapping_error;
> +
> +	/* Use our brcm_dma_ops for this driver */
> +	set_dma_ops(dev, &brcm_dma_ops);
> +}

Just have a static const set of ops like everyone else - you can handle
the conditionality of ->{map,unmap}_resource inside the brcm_* wrappers.

> +
> +static int brcmstb_platform_notifier(struct notifier_block *nb,
> +				     unsigned long event, void *__dev)
> +{
> +	struct device *dev = __dev;
> +
> +	if (event != BUS_NOTIFY_ADD_DEVICE)
> +		return NOTIFY_DONE;
> +
> +	brcm_set_dma_ops(dev);
> +	return NOTIFY_OK;
> +}
> +
> +struct notifier_block brcmstb_platform_nb = {
> +	.notifier_call = brcmstb_platform_notifier,
> +};
> +EXPORT_SYMBOL(brcmstb_platform_nb);
> diff --git a/drivers/pci/host/pci-brcmstb.c b/drivers/pci/host/pci-brcmstb.c
> index f4cd6e7..03c0da9 100644
> --- a/drivers/pci/host/pci-brcmstb.c
> +++ b/drivers/pci/host/pci-brcmstb.c
> @@ -343,6 +343,8 @@ struct brcm_pcie {
>  
>  static struct list_head brcm_pcie = LIST_HEAD_INIT(brcm_pcie);
>  static phys_addr_t scb_size[BRCM_MAX_SCB];
> +static struct of_pci_range *dma_ranges;
> +static int num_dma_ranges;
>  static int num_memc;
>  static DEFINE_MUTEX(brcm_pcie_lock);
>  
> @@ -362,6 +364,8 @@ static int brcm_pcie_add_controller(struct brcm_pcie *pcie)
>  {
>  	mutex_lock(&brcm_pcie_lock);
>  	snprintf(pcie->name, sizeof(pcie->name) - 1, "PCIe%d", pcie->id);
> +	if (list_empty(&brcm_pcie))
> +		bus_register_notifier(&pci_bus_type, &brcmstb_platform_nb);
>  	list_add_tail(&pcie->list, &brcm_pcie);
>  	mutex_unlock(&brcm_pcie_lock);
>  
> @@ -378,8 +382,14 @@ static void brcm_pcie_remove_controller(struct brcm_pcie *pcie)
>  		tmp = list_entry(pos, struct brcm_pcie, list);
>  		if (tmp == pcie) {
>  			list_del(pos);
> -			if (list_empty(&brcm_pcie))
> +			if (list_empty(&brcm_pcie)) {
> +				bus_unregister_notifier(&pci_bus_type,
> +							&brcmstb_platform_nb);
> +				kfree(dma_ranges);
> +				dma_ranges = NULL;
> +				num_dma_ranges = 0;
>  				num_memc = 0;
> +			}
>  			break;
>  		}
>  	}
> @@ -403,6 +413,35 @@ int encode_ibar_size(u64 size)
>  	return 0;
>  }
>  
> +dma_addr_t brcm_to_pci(dma_addr_t addr)
> +{
> +	struct of_pci_range *p;
> +
> +	if (!num_dma_ranges)
> +		return addr;
> +
> +	for (p = dma_ranges; p < &dma_ranges[num_dma_ranges]; p++)
> +		if (addr >= p->cpu_addr && addr < (p->cpu_addr + p->size))
> +			return addr - p->cpu_addr + p->pci_addr;
> +
> +	return BRCMSTB_ERROR_CODE;
> +}
> +EXPORT_SYMBOL(brcm_to_pci);

AFAICS it doesn't make much sense for anyone outside this driver to ever
be calling these.

> +dma_addr_t brcm_to_cpu(dma_addr_t addr)
> +{
> +	struct of_pci_range *p;
> +
> +	if (!num_dma_ranges)
> +		return addr;
> +	for (p = dma_ranges; p < &dma_ranges[num_dma_ranges]; p++)
> +		if (addr >= p->pci_addr && addr < (p->pci_addr + p->size))
> +			return addr - p->pci_addr + p->cpu_addr;
> +
> +	return addr;
> +}
> +EXPORT_SYMBOL(brcm_to_cpu);
> +
>  static u32 mdio_form_pkt(int port, int regad, int cmd)
>  {
>  	u32 pkt = 0;
> @@ -652,6 +691,74 @@ static int brcm_parse_ranges(struct brcm_pcie *pcie)
>  	return 0;
>  }
>  
> +static int brcm_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> +					  struct device_node *node)
> +{
> +	const int na = 3, ns = 2;
> +	int rlen;
> +
> +	parser->node = node;
> +	parser->pna = of_n_addr_cells(node);
> +	parser->np = parser->pna + na + ns;
> +
> +	parser->range = of_get_property(node, "dma-ranges", &rlen);
> +	if (!parser->range)
> +		return -ENOENT;
> +
> +	parser->end = parser->range + rlen / sizeof(__be32);
> +
> +	return 0;
> +}

Note that we've got a factored-out helper for this queued in -next
already - see here:

https://patchwork.kernel.org/patch/9927541/

> +
> +static int brcm_parse_dma_ranges(struct brcm_pcie *pcie)
> +{
> +	int i, ret = 0;
> +	struct of_pci_range_parser parser;
> +	struct device_node *dn = pcie->dn;
> +
> +	mutex_lock(&brcm_pcie_lock);
> +	if (dma_ranges)
> +		goto done;
> +
> +	/* Parse dma-ranges property if present.  If there are multiple
> +	 * PCI controllers, we only have to parse from one of them since
> +	 * the others will have an identical mapping.
> +	 */
> +	if (!brcm_pci_dma_range_parser_init(&parser, dn)) {
> +		unsigned int max_ranges
> +			= (parser.end - parser.range) / parser.np;
> +
> +		dma_ranges = kcalloc(max_ranges, sizeof(struct of_pci_range),
> +				     GFP_KERNEL);
> +		if (!dma_ranges) {
> +			ret =  -ENOMEM;
> +			goto done;
> +		}
> +		for (i = 0; of_pci_range_parser_one(&parser, dma_ranges + i);
> +		     i++)
> +			num_dma_ranges++;
> +	}
> +
> +	for (i = 0, num_memc = 0; i < BRCM_MAX_SCB; i++) {
> +		u64 size = brcmstb_memory_memc_size(i);
> +
> +		if (size == (u64)-1) {
> +			dev_err(pcie->dev, "cannot get memc%d size", i);
> +			ret = -EINVAL;
> +			goto done;
> +		} else if (size) {
> +			scb_size[i] = roundup_pow_of_two_64(size);
> +			num_memc++;
> +		} else {
> +			break;
> +		}
> +	}
> +
> +done:
> +	mutex_unlock(&brcm_pcie_lock);
> +	return ret;
> +}
> +
>  static void set_regulators(struct brcm_pcie *pcie, bool on)
>  {
>  	struct list_head *pos;
> @@ -728,10 +835,34 @@ static void brcm_pcie_setup_prep(struct brcm_pcie *pcie)
>  	 */
>  	rc_bar2_size = roundup_pow_of_two_64(total_mem_size);
>  
> -	/* Set simple configuration based on memory sizes
> -	 * only.  We always start the viewport at address 0.
> -	 */
> -	rc_bar2_offset = 0;
> +	if (dma_ranges) {
> +		/* The best-case scenario is to place the inbound
> +		 * region in the first 4GB of pci-space, as some
> +		 * legacy devices can only address 32bits.
> +		 * We would also like to put the MSI under 4GB
> +		 * as well, since some devices require a 32bit
> +		 * MSI target address.
> +		 */
> +		if (total_mem_size <= 0xc0000000ULL &&
> +		    rc_bar2_size <= 0x100000000ULL) {
> +			rc_bar2_offset = 0;
> +		} else {
> +			/* The system memory is 4GB or larger so we
> +			 * cannot start the inbound region at location
> +			 * 0 (since we have to allow some space for
> +			 * outbound memory @ 3GB).  So instead we
> +			 * start it at the 1x multiple of its size
> +			 */
> +			rc_bar2_offset = rc_bar2_size;
> +		}
> +
> +	} else {
> +		/* Set simple configuration based on memory sizes
> +		 * only.  We always start the viewport at address 0,
> +		 * and set the MSI target address accordingly.
> +		 */
> +		rc_bar2_offset = 0;
> +	}
>  
>  	tmp = lower_32_bits(rc_bar2_offset);
>  	tmp = INSERT_FIELD(tmp, PCIE_MISC_RC_BAR2_CONFIG_LO, SIZE,
> @@ -1040,11 +1171,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	if (of_property_read_u32(dn, "dma-ranges", &tmp) == 0) {
> -		pr_err("cannot yet handle dma-ranges\n");
> -		return -EINVAL;
> -	}
> -
>  	data = of_id->data;
>  	pcie->reg_offsets = data->offsets;
>  	pcie->reg_field_info = data->reg_field_info;
> @@ -1113,6 +1239,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = brcm_parse_dma_ranges(pcie);
> +	if (ret)
> +		return ret;
> +
>  	ret = clk_prepare_enable(pcie->clk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "could not enable clock\n");
> diff --git a/drivers/pci/host/pci-brcmstb.h b/drivers/pci/host/pci-brcmstb.h
> index 86f9cd1..4851be8 100644
> --- a/drivers/pci/host/pci-brcmstb.h
> +++ b/drivers/pci/host/pci-brcmstb.h
> @@ -21,6 +21,13 @@
>  /* Broadcom PCIE Offsets */
>  #define PCIE_INTR2_CPU_BASE		0x4300
>  
> +dma_addr_t brcm_to_pci(dma_addr_t addr);
> +dma_addr_t brcm_to_cpu(dma_addr_t addr);
> +
> +extern struct notifier_block brcmstb_platform_nb;

It seems a bit weird to have the notifier code split across two
compilation units in the way which requires this - it seems more
reasonable to have it all together on one side or the other, with the
common interface being either the callback for setting the ops or a
function for installing the notifier, depending on where things fall.

Robin.

> +
> +#define BRCMSTB_ERROR_CODE	(~(dma_addr_t)0x0)
> +
>  #if defined(CONFIG_MIPS)
>  /* Broadcom MIPs HW implicitly does the swapping if necessary */
>  #define bcm_readl(a)		__raw_readl(a)
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
