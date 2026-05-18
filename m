Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D6396591;
	Mon, 18 May 2026 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141282; cv=none; b=UudxRBwnEVoxOYGMy699BI9JF0G6NKdqphXy0fAMGOTFzajMdLGfImWhRQbK0NpNXXEpln/z82ttgiITzGhhjCvx7rMttln8oDacrLPjqM/NynXDJjjerEU0XOIQXb4/kV2Z9C3nE6FbVuX+U/3+5yJdVmPk7P32Hs53qVT6wYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141282; c=relaxed/simple;
	bh=ki+WAIPbNAWpazR1F6aQA4RCiLjMbpvfPl2mcjH3Wi4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HVoeeY+Vvqb4fOKGiBnhVTDyhOGGIgUuWh27tF37XkJEa8Oey3dnCrr7cEHMAfFHmLU1/RaD/KmaHRkadB01g66K++bjFSrglvxX2go0snGL2Y7dDNAAyx0jlRDd8lGG4/gGzvJo9uVhp41UapVPRszZFV0oYTeFev1opmNLjLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsQ14Wha; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsQ14Wha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9D1C2BCB7;
	Mon, 18 May 2026 21:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779141282;
	bh=ki+WAIPbNAWpazR1F6aQA4RCiLjMbpvfPl2mcjH3Wi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WsQ14Whao+YjbvkEBuvLzjGzaNQsqdep0iI3lXuleKCJDGe1a1R8qsbC7ULTGAIOD
	 Wy2wCO1HEiiu7+60VNwB5tX58hBKWyWS8aOC47UFaO7QW8RtW0Zs2Zp4PxRT3wmI1y
	 grPJwd/xTHmjk/eTFoP9xwM7RyzsRrDp5rvjm7le7cRnL5lHDcM9rpk/n3n/VPB/JO
	 TPKpDj8imYzMNxmpDwXrlY0jAUd4BdsUzjwbP/blOeTqQkCbAM7l25l9htf/eM/z2y
	 snaHHBC9susfhCU6W0OmE9u/bGK4cCahtjtSUyXeKzmk2PTSi1a8+UR0y6O9E0741e
	 tFtsniosvCjQw==
Date: Mon, 18 May 2026 16:54:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	Phani R Burra <phani.r.burra@intel.com>, larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com, anjali.singhai@intel.com,
	michal.swiatkowski@linux.intel.com, maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com, madhu.chittim@intel.com,
	joshua.a.hay@intel.com, jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com, jiri@resnulli.us, horms@kernel.org,
	corbet@lwn.net, richardcochran@gmail.com, linux-doc@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Bharath R <bharath.r@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Philipp Stanner <phasta@kernel.org>
Subject: Re: [PATCH net-next v3 02/14] libie: add PCI device initialization
 helpers to libie
Message-ID: <20260518215441.GA640516@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515224443.2772147-3-anthony.l.nguyen@intel.com>

[+cc Philipp]

On Fri, May 15, 2026 at 03:44:26PM -0700, Tony Nguyen wrote:
> From: Phani R Burra <phani.r.burra@intel.com>
> 
> Add support functions for drivers to configure PCI functionality and access
> MMIO space.

This looks kind of like what pcim_iomap_range() does, i.e., a way to
ioremap (BAR-idx, offset, size) pieces of PCI BARs.  That sounds like
useful functionality.

Is there something Intel-specific or even ethernet-specific about
this?  If devm_* and pcim_* don't do what you need, maybe they should
be extended or this could be made generic so any drivers could use it?

This looks like a mix of managed (pcim_enable_device(),
pcim_request_region()), and unmanaged (ioremap(), iounmap()) things.
I haven't looked at how all this is used, but it's pretty easy to get
things wrong when mixing models.

> +++ b/drivers/net/ethernet/intel/libie/pci.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#include <linux/intel/libie/pci.h>
> +
> +/**
> + * libie_find_mmio_region - find MMIO region containing a range
> + * @mmio_list: list that contains MMIO region info
> + * @offset: range start offset
> + * @size: range size
> + * @bar_idx: BAR index containing the range to search
> + *
> + * Return: pointer to a MMIO region overlapping with the range in any way or
> + *	   NULL if no such region is mapped.
> + */
> +static struct libie_pci_mmio_region *
> +libie_find_mmio_region(const struct list_head *mmio_list,
> +		       resource_size_t offset, resource_size_t size,
> +		       int bar_idx)
> +{
> +	resource_size_t end_offset = offset + size;
> +	struct libie_pci_mmio_region *mr;
> +
> +	list_for_each_entry(mr, mmio_list, list) {
> +		resource_size_t mr_end = mr->offset + mr->size;
> +		resource_size_t mr_start = mr->offset;
> +
> +		if (mr->bar_idx != bar_idx)
> +			continue;
> +		if (offset < mr_end && end_offset > mr_start)
> +			return mr;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * __libie_pci_get_mmio_addr - get the MMIO virtual address
> + * @mmio_info: contains list of MMIO regions
> + * @offset: register offset to find
> + * @num_args: number of additional arguments present
> + *
> + * This function finds the virtual address of a register offset by iterating
> + * through the non-linear MMIO regions that are mapped by the driver.
> + *
> + * Return: valid MMIO virtual address or NULL.
> + */
> +void __iomem *__libie_pci_get_mmio_addr(struct libie_mmio_info *mmio_info,
> +					resource_size_t offset,
> +					int num_args, ...)
> +{
> +	struct libie_pci_mmio_region *mr;
> +	int bar_idx = 0;
> +	va_list args;
> +
> +	if (num_args) {
> +		va_start(args, num_args);
> +		bar_idx = va_arg(args, int);
> +		va_end(args);
> +	}
> +
> +	list_for_each_entry(mr, &mmio_info->mmio_list, list)
> +		if (bar_idx == mr->bar_idx && offset >= mr->offset &&
> +		    offset < mr->offset + mr->size) {
> +			offset -= mr->offset;
> +
> +			return mr->addr + offset;
> +		}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(__libie_pci_get_mmio_addr, "LIBIE_PCI");
> +
> +/**
> + * __libie_pci_map_mmio_region - map PCI device MMIO region
> + * @mmio_info: struct to store the mapped MMIO region
> + * @offset: MMIO region start offset
> + * @size: MMIO region size
> + * @num_args: number of additional arguments present
> + *
> + * Return: true on success, false on memory map failure.
> + */
> +bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
> +				 resource_size_t offset,
> +				 resource_size_t size, int num_args, ...)
> +{
> +	struct pci_dev *pdev = mmio_info->pdev;
> +	struct libie_pci_mmio_region *mr;
> +	resource_size_t pa;
> +	void __iomem *va;
> +	int bar_idx = 0;
> +	va_list args;
> +
> +	if (num_args) {
> +		va_start(args, num_args);
> +		bar_idx = va_arg(args, int);
> +		va_end(args);
> +	}
> +
> +	if (offset + size > pci_resource_len(pdev, bar_idx))
> +		return false;
> +
> +	mr = libie_find_mmio_region(&mmio_info->mmio_list, offset, size,
> +				    bar_idx);
> +	if (mr) {
> +		pci_warn(pdev,
> +			 "Mapping of BAR%u (offset=%llu, size=%llu) intersecting region (offset=%llu, size=%llu) already exists\n",
> +			 bar_idx, (unsigned long long)mr->offset,
> +			 (unsigned long long)mr->size,
> +			 (unsigned long long)offset, (unsigned long long)size);
> +		return mr->offset <= offset &&
> +		       mr->offset + mr->size >= offset + size;
> +	}
> +
> +	pa = pci_resource_start(pdev, bar_idx) + offset;
> +	va = ioremap(pa, size);
> +	if (!va) {
> +		pci_err(pdev, "Failed to map BAR%u region\n", bar_idx);
> +		return false;
> +	}
> +
> +	mr = kvzalloc_obj(*mr);
> +	if (!mr) {
> +		iounmap(va);
> +		return false;
> +	}
> +
> +	mr->addr = va;
> +	mr->offset = offset;
> +	mr->size = size;
> +	mr->bar_idx = bar_idx;
> +
> +	list_add_tail(&mr->list, &mmio_info->mmio_list);
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_NS_GPL(__libie_pci_map_mmio_region, "LIBIE_PCI");
> +
> +/**
> + * libie_pci_unmap_fltr_regs - unmap selected PCI device MMIO regions
> + * @mmio_info: contains list of MMIO regions to unmap
> + * @fltr: returns true, if region is to be unmapped
> + */
> +void libie_pci_unmap_fltr_regs(struct libie_mmio_info *mmio_info,
> +			       bool (*fltr)(struct libie_mmio_info *mmio_info,
> +					    struct libie_pci_mmio_region *reg))
> +{
> +	struct libie_pci_mmio_region *mr, *tmp;
> +
> +	list_for_each_entry_safe(mr, tmp, &mmio_info->mmio_list, list) {
> +		if (!fltr(mmio_info, mr))
> +			continue;
> +		iounmap(mr->addr);
> +		list_del(&mr->list);
> +		kvfree(mr);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_pci_unmap_fltr_regs, "LIBIE_PCI");
> +
> +/**
> + * libie_pci_unmap_all_mmio_regions - unmap all PCI device MMIO regions
> + * @mmio_info: contains list of MMIO regions to unmap
> + */
> +void libie_pci_unmap_all_mmio_regions(struct libie_mmio_info *mmio_info)
> +{
> +	struct libie_pci_mmio_region *mr, *tmp;
> +
> +	list_for_each_entry_safe(mr, tmp, &mmio_info->mmio_list, list) {
> +		iounmap(mr->addr);
> +		list_del(&mr->list);
> +		kvfree(mr);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_pci_unmap_all_mmio_regions, "LIBIE_PCI");
> +
> +/**
> + * libie_pci_init_dev - enable and reserve PCI regions of the device
> + * @pdev: PCI device information
> + *
> + * Return: %0 on success, -%errno on failure.
> + */
> +int libie_pci_init_dev(struct pci_dev *pdev)
> +{
> +	int err;
> +
> +	err = pcim_enable_device(pdev);
> +	if (err)
> +		return err;
> +
> +	for (int bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> +		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
> +			err = pcim_request_region(pdev, bar, pci_name(pdev));
> +			if (err)
> +				return err;
> +		}
> +
> +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (err)
> +		return err;
> +
> +	pci_set_master(pdev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_pci_init_dev, "LIBIE_PCI");
> +
> +MODULE_DESCRIPTION("Common Ethernet PCI library");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/intel/libie/pci.h b/include/linux/intel/libie/pci.h
> new file mode 100644
> index 000000000000..effd072c55c8
> --- /dev/null
> +++ b/include/linux/intel/libie/pci.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#ifndef __LIBIE_PCI_H
> +#define __LIBIE_PCI_H
> +
> +#include <linux/pci.h>
> +
> +/**
> + * struct libie_pci_mmio_region - structure for MMIO region info
> + * @list: used to add a MMIO region to the list of MMIO regions in
> + *	  libie_mmio_info
> + * @addr: virtual address of MMIO region start
> + * @offset: start offset of the MMIO region
> + * @size: size of the MMIO region
> + * @bar_idx: BAR index to which the MMIO region belongs to
> + */
> +struct libie_pci_mmio_region {
> +	struct list_head	list;
> +	void __iomem		*addr;
> +	resource_size_t		offset;
> +	resource_size_t		size;
> +	u16			bar_idx;
> +};
> +
> +/**
> + * struct libie_mmio_info - contains list of MMIO regions
> + * @pdev: PCI device pointer
> + * @mmio_list: list of MMIO regions
> + */
> +struct libie_mmio_info {
> +	struct pci_dev		*pdev;
> +	struct list_head	mmio_list;
> +};
> +
> +#define libie_pci_map_mmio_region(mmio_info, offset, size, ...)	\
> +	__libie_pci_map_mmio_region(mmio_info, offset, size,		\
> +				     COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
> +
> +#define libie_pci_get_mmio_addr(mmio_info, offset, ...)		\
> +	__libie_pci_get_mmio_addr(mmio_info, offset,			\
> +				   COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
> +
> +bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
> +				 resource_size_t offset, resource_size_t size,
> +				 int num_args, ...);
> +void __iomem *__libie_pci_get_mmio_addr(struct libie_mmio_info *mmio_info,
> +					resource_size_t offset,
> +					int num_args, ...);
> +void libie_pci_unmap_all_mmio_regions(struct libie_mmio_info *mmio_info);
> +void libie_pci_unmap_fltr_regs(struct libie_mmio_info *mmio_info,
> +			       bool (*fltr)(struct libie_mmio_info *mmio_info,
> +					    struct libie_pci_mmio_region *reg));
> +int libie_pci_init_dev(struct pci_dev *pdev);
> +
> +#endif /* __LIBIE_PCI_H */
> -- 
> 2.47.1
> 
