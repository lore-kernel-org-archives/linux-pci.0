Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DAB2D594F;
	Wed, 30 Sep 2026 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794213; cv=none; b=GdPyI2OfGQYusAcfmVxrkSVdN+ghCt7jiNyS5U83mTuh+ogPhpenxPj69tlI5KW/XxEbEXRODZsknzmqNuJYJ1QLKlcE6aoC9QpkHWo/w2QtxLK6zpW/gXXM0hksTmKJOuTWbmKtqGWc74UerqTp8Y/LVBMVvqbcgYF+YbD4jnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794213; c=relaxed/simple;
	bh=7lGgs+WBeNW/aYVKLcMIrTfz9B+opeT0/gtwNmhRQiQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hnbbnLqFsf0RxcdQ4UnCgXqh8mgzyUfYBx/Z+SkzgKXKKtDaDg5MU7Ye+mEhVpXugZpiLmpJncRBjw1vuh4W/28bLWg+GngMGf/VpdJ85hUhNQhnZxQwLtW/Uf08qxgEu46710AO6XSz9XZpZwzzFs5zIXgnzQm3lOEpJ9eWAqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnJqC4wl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnJqC4wl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790794211; x=1822330211;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7lGgs+WBeNW/aYVKLcMIrTfz9B+opeT0/gtwNmhRQiQ=;
  b=ZnJqC4wlLuTal4gJRPVDfqVlB2xyEAgdosbnbz83F8y05dUdDERGOVkO
   GJdb9h/gWaW6Zl+qoaSI9JnKafR0LZn6R9nTG2EsQW0VYFZSpweixEfyd
   ttiwbnecHWCQPR1jByyapQ+8U57A8s9HvteHdG7gwCo+BnaHJEAakYzJ9
   IT7dOogynOu3RJ6kPDd1koFYa3e5usyeDTgKPgQ4VTqC7hh/mZbPQzeln
   2gdSrCodqaOfwQLU68ofbjE72MfdSFKxMkeW3fbLnEedMf5OZlV2hO538
   TTYNMJAZX9vga3RTZ99L4+FwxG906ysCQ8s0QBXFqltFUT3GxRUkWtMVI
   Q==;
X-CSE-ConnectionGUID: ynKGxRX1TYGRx8cpO81duA==
X-CSE-MsgGUID: heRB2FnFTECor4hfQEwblQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90441534"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90441534"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 11:50:10 -0700
X-CSE-ConnectionGUID: +k2/Z6fLQlCuRjMhKQQ1sg==
X-CSE-MsgGUID: brsMZvsMTaCtnn8ZvOEvDQ==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 11:50:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 30 Sep 2026 21:50:05 +0300 (EEST)
To: Ard Biesheuvel <ardb+git@google.com>
cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Ard Biesheuvel <ardb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: Allow 64-bit non-prefetchable BARs in
 prefetchable windows
In-Reply-To: <20260930103036.248989-6-ardb+git@google.com>
Message-ID: <245de2a8-4172-b886-75d6-4d017c30672e@linux.intel.com>
References: <20260930103036.248989-4-ardb+git@google.com> <20260930103036.248989-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 30 Sep 2026, Ard Biesheuvel wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The non-prefetchable memory window of a PCI-to-PCI bridge can only
> decode 32-bit addresses, and so non-prefetchable BARs of devices below a
> bridge can only be allocated from the part of the host bridge memory
> space below 4 GB. This is the case even for 64-bit BARs, which could
> easily be placed above 4 GB if there was a bridge window to put them in,
> and on many platforms, 32-bit addressable MMIO space is scarce.
> 
> The PCIe spec addresses this in the implementation note "Additional
> Guidance on the Prefetchable Bit in Memory Space BARs" (PCIe r7.0, sec
> 7.5.1.2.1): on PCIe, setting the Prefetchable bit of a BAR still permits
> correct operation even if the range has read side effects or cannot
> tolerate write merging, as long as the entire path from the host to the
> device is PCIe, given that PCIe Memory Reads always carry an explicit
> length, and PCIe Switches never prefetch or merge writes. The same
> reasoning applies when it is the OS that places a non-prefetchable BAR
> in a prefetchable bridge window: PCIe Root Ports and Switch Ports
> forward requests that hit either window in exactly the same way. Hence,
> the prefetchable window of a PCIe Root Port or Switch Port, which may be
> 64-bit, can serve as a 64-bit window for non-prefetchable BARs too. [0]
> 
> So add pci_bus_placement_flags(), which returns the flags of a resource
> on a given bus with IORESOURCE_PREFETCH set if it is a 64-bit
> non-prefetchable memory resource, the bus is not a root bus, all bridges
> between the bus and the root bus are PCIe Root Ports or PCIe Switch
> Ports, and the host bridge has no prefetchable memory window, but does
> have one that extends above 4 GB in PCI bus address space. [1]
> 
> Evaluate the conditions on the bridges and the host bridge only once
> per bus, when it is added, and record the result in a new bus flag,
> PCI_BUS_FLAGS_NO_NP_BARS_IN_P_WINDOWS: pci_register_host_bridge() sets
> it on the root bus if the host bridge does not qualify, child buses
> inherit it, and pci_alloc_child_bus() sets it on the secondary bus of
> any bridge that is not a PCIe Root Port or Switch Port.
> 
> Use pci_bus_placement_flags() wherever the resource allocator decides
> which bridge window a device resource (including an SR-IOV VF BAR)
> belongs in:
> 
> - in pbus_select_window_for_type(), which is used when sizing bridge
>   windows, and when releasing them to retry failed assignments or to
>   resize a BAR;
> - when allocating the resource in __pci_assign_resource(), by passing
>   its result to __pci_bus_alloc_resource();
> - when claiming a resource assigned by firmware, in
>   pci_find_parent_resource();
> - when deciding which assigned resources to release after a failed
>   assignment, and which failures are relevant to a resized BAR.
> 
> As a result, an eligible 64-bit non-prefetchable BAR is handled exactly
> like a 64-bit prefetchable BAR: it is placed in the prefetchable window
> of the upstream bridge, which may be above 4 GB, and allocation falls
> back to the non-prefetchable window if the prefetchable one has no
> space. [2]
> 
> 32-bit BARs are not affected, and neither are bridge windows, as only
> prefetchable bridge windows can be 64-bit. Devices below conventional
> PCI or CardBus bridges, below PCIe to PCI/PCI-X bridges (in either
> direction), or below host bridges that have a prefetchable window or no
> window above 4 GB are not affected either, and neither are devices on a
> root bus, as there is no prefetchable window for their BARs to go to.
> 
> [0] This reasoning does not extend to the host bridge, though: how it
>     treats the windows that firmware describes as prefetchable is
>     platform specific. For instance, the V3 Semiconductor V360EPC
>     (pci-v3-semi) enables prefetching for its prefetchable window, the
>     MPC52xx uses Memory Read Multiple for it, and Freescale PCI/PCIe
>     host bridges (fsl_pci) enable relaxed ordering for it. However, if
>     the host bridge has no prefetchable windows at all (as appears to be
>     the case on many x86 PCs), all prefetchable bridge windows are
>     carved out of its non-prefetchable windows, and so the host bridge
>     does not treat them any differently.
> 
> [1] Placing non-prefetchable BARs in prefetchable bridge windows only
>     helps if one of those non-prefetchable host bridge windows extends
>     above 4 GB. Otherwise, the prefetchable bridge windows end up below
>     4 GB as well, and BARs would merely move between two bridge windows
>     that are carved out of the same 32-bit space.
> 
> [2] Note that this only concerns where a BAR is placed. How it is mapped
>     is decided by the driver and by the attributes of the BAR itself
>     (e.g., pci_iomap_wc() and the sysfs resource<N>_wc files only honour
>     IORESOURCE_PREFETCH on the BAR), and this change does not modify the
>     flags of any BAR.)
> 
> Assisted-by: LLM
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> Tested on QEMU arm64 'virt' (DT, all resources assigned by Linux) with
> a qemu-xhci below a Root Port, an NVMe below a Switch, a qemu-xhci
> below a PCIe-to-PCI bridge and another qemu-xhci on the root bus: the
> 64-bit non-prefetchable BARs of the first two (and of the PCIe-to-PCI
> bridge itself) move from the 32-bit non-prefetchable windows into the
> 64-bit prefetchable windows above 4 GB, while the others stay where
> they were. When the 64-bit host bridge window is marked prefetchable
> in the DT, or removed from it, all resources are assigned exactly as
> without this patch. Both drivers work, also after hot removal and
> rescan of the endpoints and of the Switch. Also tested on QEMU x86_64
> q35 with SeaBIOS, which assigns all resources itself: the firmware
> assignment is claimed as before, and after hot removal and rescan, the
> eligible BARs are placed in the prefetchable windows.
> ---
>  drivers/pci/pci.c       | 43 +++++++++++++++++++-
>  drivers/pci/pci.h       |  1 +
>  drivers/pci/probe.c     | 35 ++++++++++++++++
>  drivers/pci/setup-bus.c | 23 ++++++++---
>  drivers/pci/setup-res.c | 30 +++++++++-----
>  include/linux/pci.h     |  1 +
>  6 files changed, 115 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..51e96611d734 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -736,6 +736,43 @@ static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
>  	return true;
>  }
>  
> +/**
> + * pci_bus_placement_flags - Get the flags to use for placing a resource
> + * @bus: PCI bus of the device that owns the resource
> + * @flags: Resource flags
> + *
> + * The non-prefetchable window of a PCI-to-PCI bridge can only decode 32-bit
> + * addresses, so 64-bit non-prefetchable BARs of devices below a bridge have to
> + * compete for space below 4GB. However, the PCIe spec notes that setting the
> + * Prefetchable bit of a BAR permits correct operation even if the range has
> + * read side effects or cannot tolerate write merging, as long as the entire
> + * path from the host to the device is PCIe: PCIe Memory Reads always carry an
> + * explicit length, and PCIe Switches never prefetch or merge writes (PCIe
> + * r7.0, sec 7.5.1.2.1, Implementation Note "Additional Guidance on the
> + * Prefetchable Bit in Memory Space BARs").
> + *
> + * So if all bridges between @bus and the root bus are PCIe Root Ports or PCIe
> + * Switch Ports, handle 64-bit non-prefetchable resources on @bus like 64-bit
> + * prefetchable ones, so that they can be placed in the prefetchable window of
> + * the bridge above @bus, which may be above 4GB. Other bridges, such as
> + * conventional PCI bridges, may prefetch from their prefetchable window.
> + *
> + * Return: @flags, with IORESOURCE_PREFETCH set if a resource with @flags on
> + * @bus may be placed in a prefetchable bridge window.
> + */
> +unsigned long pci_bus_placement_flags(struct pci_bus *bus, unsigned long flags)
> +{
> +	if ((flags & (IORESOURCE_TYPE_BITS | IORESOURCE_PREFETCH |
> +		      IORESOURCE_MEM_64)) != (IORESOURCE_MEM | IORESOURCE_MEM_64))

PCI_RES_TYPE_MASK

> +		return flags;
> +
> +	if (pci_is_root_bus(bus) ||
> +	    (bus->bus_flags & PCI_BUS_FLAGS_NO_NP_BARS_IN_P_WINDOWS))
> +		return flags;
> +
> +	return flags | IORESOURCE_PREFETCH;
> +}
> +
>  /**
>   * pci_find_parent_resource - return resource region of parent bus of given
>   *			      region
> @@ -749,6 +786,7 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>  					  struct resource *res)
>  {
>  	const struct pci_bus *bus = dev->bus;
> +	unsigned long flags = pci_bus_placement_flags(dev->bus, res->flags);
>  	struct resource *r;
>  
>  	pci_bus_for_each_resource(bus, r) {
> @@ -758,10 +796,11 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>  
>  			/*
>  			 * If the window is prefetchable but the BAR is
> -			 * not, the allocator made a mistake.
> +			 * not (and may not be treated as such), the
> +			 * allocator made a mistake.
>  			 */
>  			if (r->flags & IORESOURCE_PREFETCH &&
> -			    !(res->flags & IORESOURCE_PREFETCH))
> +			    !(flags & IORESOURCE_PREFETCH))
>  				return NULL;
>  
>  			/*
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 8297cfb5dcd5..989b9c1f1580 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -567,6 +567,7 @@ static inline int pci_resource_num(const struct pci_dev *dev,
>  	return resno;
>  }
>  
> +unsigned long pci_bus_placement_flags(struct pci_bus *bus, unsigned long flags);
>  int __pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
>  			     unsigned long flags, resource_size_t size,
>  			     resource_size_t align, resource_size_t min,
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5af..8f00ea3321c0 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -990,6 +990,32 @@ static bool pci_preserve_config(struct pci_host_bridge *host_bridge)
>  	return false;
>  }
>  
> +/*
> + * Return true if all memory windows of @bridge are non-prefetchable, and at
> + * least one of them extends above 4GB in PCI bus address space (see
> + * pci_bus_placement_flags()).
> + */
> +static bool pci_host_np_only_with_high_window(struct pci_host_bridge *bridge)
> +{
> +	struct resource_entry *window;
> +	bool high = false;
> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		struct resource *res = window->res;
> +
> +		if (resource_type(res) != IORESOURCE_MEM)
> +			continue;
> +
> +		if (res->flags & IORESOURCE_PREFETCH)
> +			return false;
> +
> +		if (upper_32_bits(res->end - window->offset))

Should this use pcibios_resource_to_bus() for consistency with the rest of 
the code?

> +			high = true;
> +	}
> +
> +	return high;
> +}
> +
>  static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  {
>  	struct device *parent = bridge->dev.parent;
> @@ -1137,6 +1163,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  		dev_info(&bus->dev, "root bus resource %pR%s\n", res, addr);
>  	}
>  
> +	if (!pci_host_np_only_with_high_window(bridge))
> +		bus->bus_flags |= PCI_BUS_FLAGS_NO_NP_BARS_IN_P_WINDOWS;

Could this be simplified, e.g. to PCI_BUS_FLAGS_PREF_WIN_ANY_BAR.

> +
>  	of_pci_make_host_bridge_node(bridge);
>  
>  	down_write(&pci_bus_sem);
> @@ -1256,6 +1285,12 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  		pci_info(child, "extended config space not accessible\n");
>  	}
>  
> +	if (!pci_is_pcie(bridge) ||
> +	    (pci_pcie_type(bridge) != PCI_EXP_TYPE_ROOT_PORT &&
> +	     pci_pcie_type(bridge) != PCI_EXP_TYPE_UPSTREAM &&
> +	     pci_pcie_type(bridge) != PCI_EXP_TYPE_DOWNSTREAM))
> +		child->bus_flags |= PCI_BUS_FLAGS_NO_NP_BARS_IN_P_WINDOWS;
> +
>  	/* Set up default resource pointers and names */
>  	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
>  		child->resource[i] = &bridge->resource[PCI_BRIDGE_RESOURCES+i];
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e8c94aa1d3c1..64826d8504c7 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -184,7 +184,9 @@ static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
>   *
>   * For memory resources, the selection is done as follows:
>   *
> - * Any non-prefetchable resource is put into the non-prefetchable window.
> + * Any non-prefetchable resource is put into the non-prefetchable window,
> + * except for 64-bit ones that may be placed like prefetchable resources on
> + * @bus (see pci_bus_placement_flags()).
>   *
>   * If there is no prefetchable MMIO window, put all memory resources into the
>   * non-prefetchable window.
> @@ -203,6 +205,7 @@ static struct resource *pbus_select_window_for_type(struct pci_bus *bus,
>  	int iores_type = type & IORESOURCE_TYPE_BITS;	/* w/o 64bit & pref */
>  	struct resource *mmio, *mmio_pref, *win;
>  
> +	type = pci_bus_placement_flags(bus, type);
>  	type &= PCI_RES_TYPE_MASK;			/* with 64bit & pref */
>  
>  	if ((iores_type != IORESOURCE_IO) && (iores_type != IORESOURCE_MEM))
> @@ -261,7 +264,9 @@ static struct resource *pbus_select_window_for_type(struct pci_bus *bus,
>   *
>   * For memory resources, the selection is done as follows:
>   *
> - * Any non-prefetchable resource is put into the non-prefetchable window.
> + * Any non-prefetchable resource is put into the non-prefetchable window,
> + * except for 64-bit ones that may be placed like prefetchable resources on
> + * @bus (see pci_bus_placement_flags()).
>   *
>   * If there is no prefetchable MMIO window, put all memory resources into the
>   * non-prefetchable window.
> @@ -520,8 +525,11 @@ static unsigned long pci_fail_res_type_mask(struct list_head *fail_head)
>  	unsigned long mask = 0;
>  
>  	/* Check failed type */
> -	list_for_each_entry(fail_res, fail_head, list)
> -		mask |= fail_res->flags;
> +	list_for_each_entry(fail_res, fail_head, list) {
> +		struct pci_bus *bus = fail_res->dev->bus;
> +
> +		mask |= pci_bus_placement_flags(bus, fail_res->flags);
> +	}
>  
>  	/*
>  	 * One pref failed resource will set IORESOURCE_MEM, as we can
> @@ -564,8 +572,11 @@ static bool pci_required_resource_failed(struct list_head *fail_head,
>  
>  	list_for_each_entry(fail_res, fail_head, list) {
>  		int idx = pci_resource_num(fail_res->dev, fail_res->res);
> +		unsigned long flags;
>  
> -		if (type && (fail_res->flags & PCI_RES_TYPE_MASK) != type)
> +		flags = pci_bus_placement_flags(fail_res->dev->bus,
> +						fail_res->flags);
> +		if (type && (flags & PCI_RES_TYPE_MASK) != type)
>  			continue;
>  
>  		if (!pci_resource_is_optional(fail_res->dev, idx))
> @@ -2308,7 +2319,7 @@ EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
>  static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res,
>  					  struct list_head *saved)
>  {
> -	unsigned long type = res->flags;
> +	unsigned long type = pci_bus_placement_flags(bus, res->flags);
>  	struct pci_dev_resource *dev_res;
>  	struct pci_dev *bridge = NULL;
>  	LIST_HEAD(add_list);
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 376f09630a4a..78b7df0eee94 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -315,11 +315,20 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>  		int resno, resource_size_t size, resource_size_t align)
>  {
>  	struct resource *res = pci_resource_n(dev, resno);
> +	unsigned long flags;
>  	resource_size_t min;
>  	int ret;
>  
>  	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
>  
> +	/*
> +	 * A 64-bit non-prefetchable BAR may be placed as if it were
> +	 * prefetchable (see pci_bus_placement_flags()), in which case the
> +	 * upstream bridge window was sized accordingly, so use the same flags
> +	 * here.
> +	 */
> +	flags = pci_bus_placement_flags(dev->bus, res->flags);
> +
>  	/*
>  	 * First, try exact prefetching match.  Even if a 64-bit
>  	 * prefetchable bridge window is below 4GB, we can't put a 32-bit
> @@ -327,9 +336,9 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>  	 * 64-bit window will contain no 32-bit resources.  If we assign
>  	 * things differently than they were sized, not everything will fit.
>  	 */
> -	ret = pci_bus_alloc_resource(bus, res, size, align, min,
> -				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
> -				     pcibios_align_resource, dev);
> +	ret = __pci_bus_alloc_resource(bus, res, flags, size, align, min,
> +				       IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
> +				       pcibios_align_resource, dev);
>  	if (ret == 0)
>  		return 0;
>  
> @@ -337,11 +346,11 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>  	 * If the prefetchable window is only 32 bits wide, we can put
>  	 * 64-bit prefetchable resources in it.
>  	 */
> -	if ((res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) ==
> +	if ((flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) ==
>  	     (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
> -		ret = pci_bus_alloc_resource(bus, res, size, align, min,
> -					     IORESOURCE_PREFETCH,
> -					     pcibios_align_resource, dev);
> +		ret = __pci_bus_alloc_resource(bus, res, flags, size, align,
> +					       min, IORESOURCE_PREFETCH,
> +					       pcibios_align_resource, dev);
>  		if (ret == 0)
>  			return 0;
>  	}
> @@ -352,9 +361,10 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>  	 * non-prefetchable, the first call already tried the only possibility
>  	 * so we don't need to try again.
>  	 */
> -	if (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))
> -		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
> -					     pcibios_align_resource, dev);
> +	if (flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))
> +		ret = __pci_bus_alloc_resource(bus, res, flags, size, align,
> +					       min, 0, pcibios_align_resource,
> +					       dev);
>  
>  	return ret;
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1e..ba22caba51f1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -279,6 +279,7 @@ enum pci_bus_flags {
>  	PCI_BUS_FLAGS_NO_MMRBC	= (__force pci_bus_flags_t) 2,
>  	PCI_BUS_FLAGS_NO_AERSID	= (__force pci_bus_flags_t) 4,
>  	PCI_BUS_FLAGS_NO_EXTCFG	= (__force pci_bus_flags_t) 8,
> +	PCI_BUS_FLAGS_NO_NP_BARS_IN_P_WINDOWS = (__force pci_bus_flags_t) 16,
>  };
>  
>  /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
> 

-- 
 i.

