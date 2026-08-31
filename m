Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE6541D102;
	Mon, 31 Aug 2026 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193886; cv=none; b=HLcU5Y7I8kq5nYVgnhTFGaZEBWy68wH5lr7BJ5lwAVzz5WFPjhkRSnivo7bjQ4N7SINUnndszbTCgYq7NbtMm7dV4CvtSIZJB9qE+MnGjUQCeLqIr5hd8jsgmvN1dynD4ltkFy5lcEfJcyZgOwmooHNAt9oyQgeByRdXHWiLh0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193886; c=relaxed/simple;
	bh=kuuJMihYHY0eCbXK3ZAMEY+5UR4DMbo2+SnUg/srbks=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NYRlJMZAbRAPNkvHtWBrrLCF4JSTcpp4pgh1NRazwJTghRigj9LJFbXouDPUf596qhkR8x0fcqUt7vnwvTifI1hOuFWIhhYyMigsKhNNPY6T/851wigVUooJyQqgkKxGS3PlwHiZikje1qEJRkLLUb/wzYLutzbGG/HbWLvrZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDZy7Al8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDZy7Al8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788193884; x=1819729884;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kuuJMihYHY0eCbXK3ZAMEY+5UR4DMbo2+SnUg/srbks=;
  b=gDZy7Al8fJCweEM6KIFrRIvq4XFWFeodHvPzwxyEcuKZkxAJq+3qR2pT
   yWmz+kyQgTnHoi7R0Iz8CGXa4PbqeF8SqZhqmpHbdAFfF2UbMId0wH9bf
   waTNxXfEagyfAH7CBi2OquU8sEn+9PPsSQVMRFvFFolvvYQ5r01nUwRf7
   l5eAUtEyqlPu7lc8HIIsq39sie0s/F8VI3xAfUrnGeYCtX/yvibmyVACh
   UTqJPUXOlxTCFqmU/FIwQjN6pyjhW/0q9kUIp5XWRzhV75Qp7+Yj+FK6t
   6m55e5NN1SFZDuUVmL29OuyY6C+MemcZ+DggjkvicS0cwSWqqSyae13uw
   A==;
X-CSE-ConnectionGUID: Qirv04bjQEqJM4U9jgY6Gw==
X-CSE-MsgGUID: 2gQFtynITHSxgS2v3C95uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88655572"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88655572"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 09:31:23 -0700
X-CSE-ConnectionGUID: TwbFpxzDSD2/7eSdJPUWGA==
X-CSE-MsgGUID: XKUFGUEURvmHXwPnEWyzrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="272630060"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.121])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 09:31:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 31 Aug 2026 19:31:15 +0300 (EEST)
To: Geramy Loveless <gloveless@jqluv.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, alexander.deucher@amd.com, 
    amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com, 
    nra3088@gmail.com, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    meiling.leung@embeddedllm.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Reserve prefetchable window headroom for Resizable
 BARs
In-Reply-To: <39e09dd8-f73e-4dc2-ba36-8a9228516d26@jqluv.com>
Message-ID: <fba65262-5490-4d60-d06d-9badaafc7e17@linux.intel.com>
References: <39e09dd8-f73e-4dc2-ba36-8a9228516d26@jqluv.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Aug 2026, Geramy Loveless wrote:

> Firmware typically sizes prefetchable bridge windows for the boot-time
> BAR size. Behind a fixed (non-hotplug) PCIe switch fabric, there is then
> no room for a driver to grow a Resizable BAR afterwards: every window
> from the leaf up to the root is sized for the small BAR, so
> pci_resize_resource() fails with -ENOSPC. 
> 
> Furthermore, a small prefetchable BAR (e.g., a 2 MiB doorbell) sharing a 
> bridge's single prefetchable window with a much larger one (e.g., a 32 GiB 
> VRAM BAR) pushes the required window size past the large BAR's alignment. 

> Because bridge windows round up to a power of two,

Do they??? In which kernel version I must ask??

> this forces a massive 
> alignment waste (e.g., 32 GiB + 2 MiB rounds up to a 64 GiB window, 
> wasting ~32 GiB per GPU).

The largest I've seen is 32GB + half of that. And that's not with the 
latest kernel.

> This patch solves both issues to enable ReBAR on cascaded switch fabrics:
> 
> 1. Reserve Headroom: 
> Reserve prefetchable window headroom for the maximum size of each 
> downstream Resizable BAR during the bridge sizing pass. The device BAR 
> and hardware ReBAR are left at their boot size to prevent tearing down 
> firmware-loaded state (e.g., AMD R9700 PSP) before the driver binds.

... reorganizing ...

> Fallback / Alignment logic:
> If the 32-bit space is exhausted, small BARs remain in the prefetchable 
> window. The alignment logic gracefully handles this by rounding the bridge 
> window up to the next power of two (e.g., growing to 64 GiB to fit a 32 GiB 
> BAR + BAR2) to maintain PCIe compatibility, ensuring sibling GPUs land in 
> properly aligned slots.
> 
> Reserving is safe by default: __assign_resources_sorted() satisfies all
> required resources first. Use pci=no_rebar_reserve and pci=no_bar_demote 
> to restore previous behaviours.

And how does this fallback, if the largest size doesn't fit? What are the 
failure modes?

It's correct that the sizing decision should be done in pbus_size_mem() 
but it must not result in breaking things which a naive approach like 
this will surely do.

Without proper fallbacks done, there will be too much breakage it's a 
showstopper for a naive patch like this.

Basically, what we'd want to do is try with the largest size, then reduce 
it one step at a time (because it's 2^n -> 2^(n-1) even one step saves 
quite much so one might not need to reduce that many steps). But also, in 
some IOV enabled cases the oversubscription of the space is very 
substantial and you'd still want to maximize the BAR sizes to what is 
allowed by the available space.

Fallback is hard to implement, because sizing and assignment are quite far 
from each other codewise and there are no structures to carry information 
over to the next retry phase.

> 2. Pack Oversized Windows (BAR Demotion): 
> The PCI-to-PCI Bridge spec (r1.2, sec 3.2.5) permits a prefetchable BAR 
> to be assigned from the non-prefetchable window. By clearing the PREFETCH 
> flag on small control BARs during enumeration, they are placed below 4 GiB. 
> The prefetchable window is then cleanly sized to the large BAR alone.
>
> Why this is safe for 32-bit (< 4G) MMIO space:
> To prevent exhausting legacy < 4G space, demotion is strictly bounded. It 
> only triggers beside a massive prefetchable BAR (>= 64 MiB), and the demoted 
> BAR is strictly capped at 16 MiB (PCI_BAR_PACK_CAP). Even on an 8x GPU 
> system, this consumes at most 128 MiB of < 4G space.  

I'm not entirely sure I agree with this, at least it shouldn't be the 
default configuration.

This would also break setups where the GPU has large BARs that do not 
share the alignment.

It might be workable as very targetted instruction to put a particular BAR 
into non-prefetchable window. For that, one needs to write a parser for 
giving them on cmdline though but that might end up being generally 
useful for avoiding some hotplug cannot-predict-the-future problems 
(the current memsize controls are too coarse-grained to be useful in many 
hotplug scenarios).


A somewhat related problem currently is that more and more devices are 
taking the liberty of not setting PREFETCH because recent PCIe spec made 
the bridge window difference be 32/64-bit based. This results in very 
suboptimal placement for such BARs.


BTW, why you're not sending the patches as a proper series but merging 
them into a single email??? It makes things harder for the reviewers. :-(


Also, I note you sent multiple versions within a day. Please give some 
time for commenting the first version. You should also list the changes 
you've made in each version (the patch history).

-- 
 i.

> Testing Context:
> - ASUS K14PG-D24
> - 2x EPYC 9354
> - 8x Radeon AI PRO R9700 (Navi 48, 1002:7551)
> - Broadcom PEX890xx switches
> - Kernel base: 45c13f3f9e3b (tested with SEV-SNP passthrough=1)
> 
> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   8 ++
>  drivers/pci/pci.c                             |  10 ++
>  drivers/pci/pci.h                             |   1 +
>  drivers/pci/setup-bus.c                       | 118 ++++++++++++++++++
>  4 files changed, 137 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 37006fc3eac3..82d2b340fb98 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5246,6 +5246,14 @@ Kernel parameters
>  		hpbussize=nn	The minimum amount of additional bus numbers
>  				reserved for buses below a hotplug bridge.
>  				Default is 1.
> +		no_rebar_reserve	Do not reserve prefetchable bridge-window
> +				space for the maximum size of downstream Resizable
> +				BARs. By default such space is reserved so a driver
> +				can grow a BAR later (e.g. GPU VRAM BAR) even behind
> +				fixed PCIe switch fabrics that firmware sized for the
> +				boot-time BAR; the device BAR is left at its boot size
> +				for the driver to resize and only bridge windows are
> +				enlarged. Use this to restore the old behaviour.
>  		realloc=	Enable/disable reallocating PCI bridge resources
>  				if allocations done by BIOS are too small to
>  				accommodate resources required by all child
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..c9901b15432a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -120,6 +120,14 @@ unsigned long pci_hotplug_mmio_pref_size =
> DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
>  #define DEFAULT_HOTPLUG_BUS_SIZE	1
>  unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
> 
> +/*
> + * Prefetchable bridge-window headroom is reserved for the maximum size of
> + * downstream Resizable BARs by default, so a driver can grow one later
> + * (e.g. amdgpu VRAM BAR) even behind fixed PCIe switch fabrics.
> + * pci=no_rebar_reserve disables this.
> + */
> +bool pci_rebar_no_reserve;
> +
> 
>  /* PCIe MPS/MRRS strategy; can be overridden by kernel command-line
> param */
>  enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
> @@ -6840,6 +6848,8 @@ static int __init pci_setup(char *str)
>  					simple_strtoul(str + 10, &str, 0);
>  				if (pci_hotplug_bus_size > 0xff)
>  					pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
> +			} else if (!strncmp(str, "no_rebar_reserve", 16)) {
> +				pci_rebar_no_reserve = true;
>  			} else if (!strncmp(str, "pcie_bus_tune_off", 17)) {
>  				pcie_bus_config = PCIE_BUS_TUNE_OFF;
>  			} else if (!strncmp(str, "pcie_bus_safe", 13)) {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc2..6eddcb492425 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -409,6 +409,7 @@ extern unsigned long pci_hotplug_io_size;
>  extern unsigned long pci_hotplug_mmio_size;
>  extern unsigned long pci_hotplug_mmio_pref_size;
>  extern unsigned long pci_hotplug_bus_size;
> +extern bool pci_rebar_no_reserve;
> 
>  static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
>  {
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e8c94aa1d3c1..aa02b8454269 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -19,6 +19,7 @@
>  #include <linux/bug.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/log2.h>
>  #include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -1258,6 +1259,53 @@ static bool pbus_size_mem_optional(struct pci_dev
> *dev, int resno,
>  	return true;
>  }
> 
> +/*
> + * pci_rebar_reserve_size - prefetchable window headroom to reserve for
> a BAR
> + *
> + * Reserve enough prefetchable window space to later grow @resno of @dev to
> + * its maximum Resizable BAR size. This is done for every ReBAR-capable
> device
> + * by default (disable with pci=no_rebar_reserve). Only the optional
> (add_size)
> + * part of the enclosing window is inflated here; the device BAR
> resource and
> + * the hardware ReBAR are left at their boot size, so the driver still
> performs
> + * the actual resize into the reserved window. Reserving the window up
> front
> + * avoids -ENOSPC in pci_resize_resource() on fixed switch fabrics, where a
> + * window shared with a sibling's still-assigned BAR cannot be released and
> + * regrown at resize time.
> + *
> + * The reservation is strictly optional: __assign_resources_sorted()
> satisfies
> + * all required resources first and only then places add_size on leftover
> + * space, so reserving by default cannot make a required BAR or window
> fail.
> + *
> + * Return the extra bytes to reserve and raise *add_align to the BAR's
> + * alignment so the reserved space can actually hold the grown BAR.
> + */
> +static resource_size_t pci_rebar_reserve_size(struct pci_dev *dev, int
> resno,
> +					      resource_size_t *add_align)
> +{
> +	struct resource *res = pci_resource_n(dev, resno);
> +	resource_size_t max_size, cur_size;
> +	int max;
> +
> +	if (pci_rebar_no_reserve || resno >= PCI_STD_NUM_BARS)
> +		return 0;
> +
> +	if ((res->flags & (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH)) !=
> +	    (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH))
> +		return 0;
> +
> +	max = pci_rebar_get_max_size(dev, resno);
> +	if (max < 0)
> +		return 0;
> +
> +	max_size = pci_rebar_size_to_bytes(max);
> +	cur_size = resource_size(res);
> +	if (max_size <= cur_size)
> +		return 0;
> +
> +	*add_align = max(*add_align, max_size);
> +	return max_size - cur_size;
> +}
> +
>  /**
>   * pbus_size_mem() - Size the memory window of a given bus
>   *
> @@ -1285,6 +1333,7 @@ static void pbus_size_mem(struct pci_bus *bus,
> struct resource *b_res,
>  	int order, max_order;
>  	resource_size_t children_add_size = 0;
>  	resource_size_t add_align = 0;
> +	resource_size_t rebar_align = 0;
> 
>  	if (!b_res)
>  		return;
> @@ -1343,15 +1392,29 @@ static void pbus_size_mem(struct pci_bus *bus,
> struct resource *b_res,
>  				aligns[order] += align;
>  			if (order > max_order)
>  				max_order = order;
> +
> +			size += pci_rebar_reserve_size(dev, i, &rebar_align);
>  		}
>  	}
> 
>  	win_align = pci_min_window_alignment(bus, b_res->flags);
>  	min_align = calculate_head_align(aligns, max_order);
>  	min_align = max(min_align, win_align);
> +	min_align = max(min_align, rebar_align);
>  	size0 = calculate_memsize(size, realloc_head ? 0 : add_size,
>  				  0, win_align);
> 
> +	/*
> +	 * A window that reserves ReBAR headroom is larger than its own
> +	 * alignment (e.g. 32 GiB BAR + doorbell => 33 GiB > 32 GiB). The
> +	 * parent only reserves alignment padding for a child window when
> +	 * its size <= its alignment, so round such a window's alignment up
> +	 * to a power of two >= its size; sibling 32 GiB BARs behind one
> +	 * switch then each land in a properly aligned slot.
> +	 */
> +	if (rebar_align && size0)
> +		min_align = max(min_align, roundup_pow_of_two(size0));
> +
>  	if (size0) {
>  		resource_set_range(b_res, min_align, size0);
>  		b_res->flags &= ~IORESOURCE_DISABLED;
> @@ -2179,6 +2242,52 @@ static void pci_prepare_next_assign_round(struct
> list_head *fail_head,
>   * Second and later try will clear small leaf bridge res.
>   * Will stop till to the max depth if can not find good one.
>   */
> +/*
> + * Release the 64-bit prefetchable BARs of resizable-BAR display
> devices so the
> + * windows enclosing them empty out and can be re-sized. The BAR *size*
> is left
> + * untouched (only released and re-placed), so the hardware ReBAR is never
> + * programmed here - the driver still owns the actual resize.
> + */
> +static int pci_release_rebar_bars_cb(struct pci_dev *dev, void *data)
> +{
> +	struct resource *r;
> +	unsigned int i;
> +
> +	if ((dev->class >> 16) != PCI_BASE_CLASS_DISPLAY)
> +		return 0;
> +	if (pci_rebar_get_max_size(dev, 0) <= pci_rebar_get_current_size(dev, 0))
> +		return 0;
> +	pci_dev_for_each_resource(dev, r, i) {
> +		if (i >= PCI_BRIDGE_RESOURCES)
> +			break;
> +		if (r->parent && (r->flags & IORESOURCE_MEM_64) &&
> +		    (r->flags & IORESOURCE_PREFETCH))
> +			pci_release_resource(dev, i);
> +	}
> +	return 0;
> +}
> +/*
> + * Release the now-empty prefetchable bridge windows bottom-up so the
> sizing
> + * pass re-sizes them (with pci_rebar_pref_reserve() reservation) to
> fit the
> + * BARs a driver will later grow.
> + */
> +static void pci_release_rebar_windows(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +	struct resource *w;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list)
> +		if (dev->subordinate)
> +			pci_release_rebar_windows(dev->subordinate);
> +
> +	if (!bus->self)
> +		return;
> +	w = &bus->self->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> +	if (w->parent && (w->flags & IORESOURCE_MEM_64) && !w->child)
> +		pci_release_resource(bus->self, PCI_BRIDGE_PREF_MEM_WINDOW);
> +}
> +
>  void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>  {
>  	LIST_HEAD(realloc_head);
> @@ -2190,6 +2299,15 @@ void
> pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>  	int pci_try_num = 1;
>  	enum enable_type enable_local;
> 
> +	/*
> +	 * Release resizable device BARs and their prefetchable windows so the
> +	 * sizing pass re-sizes those windows large enough
> (pci_rebar_pref_reserve)
> +	 * for the BARs a driver will later grow. Only released and re-placed
> - the
> +	 * BAR size is left untouched, so the hardware ReBAR is never programmed.
> +	 */
> +	pci_walk_bus(bus, pci_release_rebar_bars_cb, NULL);
> +	pci_release_rebar_windows(bus);
> +
>  	/* Don't realloc if asked to do so */
>  	enable_local = pci_realloc_detect(bus, pci_realloc_enable);
>  	if (pci_realloc_enabled(enable_local)) {
> 
> base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
> 
