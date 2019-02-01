Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9368C282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 12:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DC121872
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 12:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfBAMST (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:18:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:54417 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfBAMSS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 07:18:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 04:18:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,548,1539673200"; 
   d="scan'208";a="271733105"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga004.jf.intel.com with SMTP; 01 Feb 2019 04:18:14 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 01 Feb 2019 14:18:14 +0200
Date:   Fri, 1 Feb 2019 14:18:14 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Message-ID: <20190201121814.GN7875@lahna.fi.intel.com>
References: <PS2P216MB0642AB5973DFD5EBB5B2BBF380910@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB0642AB5973DFD5EBB5B2BBF380910@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicholas,

On Thu, Jan 31, 2019 at 09:51:05AM +0000, Nicholas Johnson wrote:
> New systems with Thunderbolt are starting to use native PCI enumeration.
> Mika Westerberg's patch "PCI: Distribute available resources to hotplug
> capable PCIe downstream ports"
> (https://patchwork.kernel.org/patch/9972155/) adds code to expand
> downstream PCI hotplug bridges to consume all remaining resource space
> in the parent bridge. It is a crucial patch for supporting Thunderbolt
> native enumeration on Linux.
> 
> However, it does not consider bridge alignment in all cases, which rules
> out hot-adding an external graphics processor at the end of a
> Thunderbolt daisy chain. Hot-adding such a device will likely fail to
> work with the existing code.

I think I tried to solve the exact issue some time ago, see:

  https://bugzilla.kernel.org/show_bug.cgi?id=199581

I verified with the same setup that with your patch applied the above
problem is gone, so your patch solves that issue :)

> It also might disrupt the operation of
> existing devices or prevent the subsequent hot-plugging of lower aligned
> devices if the kernel frees and reallocates upstream resources to
> attempt assign the resources that failed to assign in the first pass. By
> Intel's ruling, Thunderbolt external graphics processors are generally
> meant to function only as the first and only device in the chain.
> However, there is no technical reason that prevents it from being
> possible if sufficient resources are available, and people are likely to
> attempt such configurations with Thunderbolt devices if they own such
> hardware. Hence, I argue that we should improve the user experience and
> reduce the number of constraints placed on the user by always
> considering resource alignment, which will make such configurations
> possible.
> 
> The other problem with the patch is that it is incompatible with
> resources allocated by "pci=hpmemsize=nnM" due to a check which does not
> allow for dev_res->add_size to be reduced. This check also makes a big
> assumption that the hpmemsize is small but non-zero, and no action has
> been taken to ensure that. In the current state, any bridge smaller than
> hpmemsize will likely fail to size correctly, which will cause major
> issues if the default were to change, or if the user also wants to
> configure non-Thunderbolt hotplug bridges simultaneously. I argue that
> if assumptions and limitations can be removed with no risks and adverse
> effects, then it should be done.

I fully agree.

> The former problem is solved by rewriting the
> pci_bus_distribute_available_resources() function with more information
> passed in the arguments, eliminating assumptions about the initial
> bridge alignment. My patch makes no assumptions about the alignment of
> hot-added bridges, allowing for any device to be hot-added, given
> sufficient resources are available.
> 
> The latter problem is solved by removing the check preventing the
> shrinking of dev_res->add_size, which allows for the distribution of
> resources if hpmemsize is non-zero. It can be made to work with zero
> hpmemsize with two-line patches in pbus_size_mem() and pbus_size_io(),
> or by modifying extend_bridge_window() to add a new entry to the
> additional resource list if one does not exist. In theory, and by my
> testing, the removal of this check does not affect the functionality of
> the resource distribution with firmware-allocated resources. But it does
> enable the same functionality when using pci=hpmemsize=nnM, which was
> not possible prior. This may be one piece of the puzzle needed to
> support Thunderbolt add-in cards that support native PCI enumeration,
> without any platform dependencies.
> 
> I have tested this proposed patch extensively. Using Linux-allocated
> resources, it works perfectly. I have two Gigabyte GC-TITAN RIDGE
> Thunderbolt 3 add-in cards in my desktop, and a Dell XPS 9370 with the
> Dell XPS 9380 Thunderbolt NVM40 firmware flashed. My peripherals are
> three HP ZBook Thunderbolt 3 docks, two external graphics enclosures
> with AMD Fiji XT in both, a Promise SANLink3 N1 (AQC107S), and a Dell
> Thunderbolt 3 NVMe SSD. All configurations of these devices worked well,
> and I can no longer make it fail if I try to. My testing with
> firmware-allocated resources is limited due to using computers with
> Alpine Ridge BIOS support. However, I did get manage to test the patch
> with firmware-allocated resources by enabling the Alpine Ridge BIOS
> support and forcing pcie_ports=native, and the results were perfect.
> 
> Mika Westerberg has agreed to test this on an official platform with
> native enumeration firmware support to be sure that it works in this
> situation. It is also appropriate that he reviews these changes as he
> wrote the original code and any changes made to Thunderbolt-critical
> code cannot be allowed to break any of the base requirements for
> Thunderbolt. I would like to thank him for putting up with my emails and
> trying to help where he can, and for the great work he has done on
> Thunderbolt in Linux.

I tested this patch with pretty much all the native enumeration systems
I have here and I don't see any issues with it.

So feel free to add my

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I have couple of minor comments, see below.

> I have more patches in the pipeline to further improve the Thunderbolt
> experience on Linux on platforms without BIOS support. This is the most
> technical but least user-facing one planned. The most exciting changes
> are yet to come.

You may add here following line as it solves that issue:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199581

> Signed-off-by: Nicholas-Johnson-opensource <nicholas.johnson-opensource@outlook.com.au>
> ---
>  drivers/pci/setup-bus.c | 172 ++++++++++++++++++++--------------------
>  1 file changed, 88 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index ed960436df5e..5c1b6d6b386c 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1866,20 +1866,21 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
>  	if (!dev_res)
>  		return;
>  
> -	/* Is there room to extend the window? */
> -	if (available - resource_size(res) <= dev_res->add_size)
> -		return;
> -
> +	/*
> +	 * The add_size can be allowed to be shrunk, which allows for resources
> +	 * to be distributed when allocated by "pci=hpmemsize=nnM", without
> +	 * affecting the distribution of firmware-allocated resources.
> +	 */
>  	dev_res->add_size = available - resource_size(res);
>  	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
>  		&dev_res->add_size);
>  }
>  
>  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> -	struct list_head *add_list, resource_size_t available_io,
> -	resource_size_t available_mmio, resource_size_t available_mmio_pref)
> +	struct list_head *add_list, struct resource io,
> +	struct resource mmio, struct resource mmio_pref)
>  {
> -	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
> +	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
>  	unsigned int normal_bridges = 0, hotplug_bridges = 0;
>  	struct resource *io_res, *mmio_res, *mmio_pref_res;
>  	struct pci_dev *dev, *bridge = bus->self;
> @@ -1889,25 +1890,32 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  	mmio_pref_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
>  
>  	/*
> -	 * Update additional resource list (add_list) to fill all the
> -	 * extra resource space available for this port except the space
> -	 * calculated in __pci_bus_size_bridges() which covers all the
> -	 * devices currently connected to the port and below.
> +	 * The alignment of this bridge is yet to be considered, hence it must
> +	 * be done now before extending its bridge window. A single bridge
> +	 * might not be able to occupy the whole parent region if the alignment
> +	 * differs - for example, an external GPU at the end of a Thunderbolt
> +	 * daisy chain.
>  	 */
> -	extend_bridge_window(bridge, io_res, add_list, available_io);
> -	extend_bridge_window(bridge, mmio_res, add_list, available_mmio);
> -	extend_bridge_window(bridge, mmio_pref_res, add_list,
> -			     available_mmio_pref);
> +	align = pci_resource_alignment(bridge, io_res);
> +	if (!io_res->parent && align)
> +		io.start = ALIGN(io.start, align);
> +
> +	align = pci_resource_alignment(bridge, mmio_res);
> +	if (!mmio_res->parent && align)
> +		mmio.start = ALIGN(mmio.start, align);
> +
> +	align = pci_resource_alignment(bridge, mmio_pref_res);
> +	if (!mmio_pref_res->parent && align)
> +		mmio_pref.start = ALIGN(mmio_pref.start, align);
>  
>  	/*
> -	 * Calculate the total amount of extra resource space we can
> -	 * pass to bridges below this one. This is basically the
> -	 * extra space reduced by the minimal required space for the
> -	 * non-hotplug bridges.
> +	 * Update the resources to fill as much remaining resource space in the
> +	 * parent bridge as possible, while considering alignment.
>  	 */
> -	remaining_io = available_io;
> -	remaining_mmio = available_mmio;
> -	remaining_mmio_pref = available_mmio_pref;
> +	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
> +	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
> +	extend_bridge_window(bridge, mmio_pref_res, add_list,
> +		resource_size(&mmio_pref));
>  
>  	/*
>  	 * Calculate how many hotplug bridges and normal bridges there
> @@ -1921,80 +1929,79 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  			normal_bridges++;
>  	}
>  
> +	/*
> +	 * There is only one bridge on the bus so it gets all possible
> +	 * resources which it can then distribute to the possible
> +	 * hotplug bridges below.
> +	 */
> +	if (hotplug_bridges + normal_bridges == 1) {
> +		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> +		if (dev->subordinate)
> +			pci_bus_distribute_available_resources(dev->subordinate,
> +				add_list, io, mmio, mmio_pref);
> +		return;
> +	}
> +
> +	/*
> +	 * Reduce the available resource space by what the
> +	 * bridge and devices below it occupy.
> +	 */
>  	for_each_pci_bridge(dev, bus) {
> -		const struct resource *res;
> +		struct resource *res;
> +		resource_size_t used_size;
>  
>  		if (dev->is_hotplug_bridge)
>  			continue;
>  
> -		/*
> -		 * Reduce the available resource space by what the
> -		 * bridge and devices below it occupy.
> -		 */
>  		res = &dev->resource[PCI_BRIDGE_RESOURCES + 0];
> -		if (!res->parent && available_io > resource_size(res))
> -			remaining_io -= resource_size(res);
> +		align = pci_resource_alignment(dev, res);
> +		align = align ? ALIGN(io.start, align) - io.start : 0;
> +		used_size = align + resource_size(res);
> +		if (!res->parent && used_size <= resource_size(&io))
> +			io.start += used_size;
>  
>  		res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
> -		if (!res->parent && available_mmio > resource_size(res))
> -			remaining_mmio -= resource_size(res);
> +		align = pci_resource_alignment(dev, res);
> +		align = align ? ALIGN(mmio.start, align) - mmio.start : 0;
> +		used_size = align + resource_size(res);
> +		if (!res->parent && used_size <= resource_size(&mmio))
> +			mmio.start += used_size;
>  
>  		res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
> -		if (!res->parent && available_mmio_pref > resource_size(res))
> -			remaining_mmio_pref -= resource_size(res);
> +		align = pci_resource_alignment(dev, res);
> +		align = align ? ALIGN(mmio_pref.start, align) -
> +				mmio_pref.start : 0;
> +		used_size = align + resource_size(res);
> +		if (!res->parent && used_size <= resource_size(&mmio_pref))
> +			mmio_pref.start += used_size;
>  	}
>  
> -	/*
> -	 * There is only one bridge on the bus so it gets all available
> -	 * resources which it can then distribute to the possible
> -	 * hotplug bridges below.
> -	 */
> -	if (hotplug_bridges + normal_bridges == 1) {
> -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> -		if (dev->subordinate) {
> -			pci_bus_distribute_available_resources(dev->subordinate,
> -				add_list, available_io, available_mmio,
> -				available_mmio_pref);
> -		}
> +	if (hotplug_bridges == 0)

I think here you can write

	if (!hotplug_bridges)

instead.

>  		return;
> -	}
>  
>  	/*
> -	 * Go over devices on this bus and distribute the remaining
> -	 * resource space between hotplug bridges.
> +	 * Distribute any remaining resources equally between
> +	 * the hotplug-capable downstream ports.
>  	 */
> -	for_each_pci_bridge(dev, bus) {
> -		resource_size_t align, io, mmio, mmio_pref;
> -		struct pci_bus *b;
> +	io_per_hp = div64_ul(resource_size(&io), hotplug_bridges);
> +	mmio_per_hp = div64_ul(resource_size(&mmio), hotplug_bridges);
> +	mmio_pref_per_hp = div64_ul(resource_size(&mmio_pref),
> +		hotplug_bridges);
>  
> -		b = dev->subordinate;
> -		if (!b || !dev->is_hotplug_bridge)
> +	for_each_pci_bridge(dev, bus) {
> +		if (!dev->subordinate || !dev->is_hotplug_bridge)
>  			continue;
>  
> -		/*
> -		 * Distribute available extra resources equally between
> -		 * hotplug-capable downstream ports taking alignment into
> -		 * account.
> -		 *
> -		 * Here hotplug_bridges is always != 0.
> -		 */
> -		align = pci_resource_alignment(bridge, io_res);
> -		io = div64_ul(available_io, hotplug_bridges);
> -		io = min(ALIGN(io, align), remaining_io);
> -		remaining_io -= io;
> -
> -		align = pci_resource_alignment(bridge, mmio_res);
> -		mmio = div64_ul(available_mmio, hotplug_bridges);
> -		mmio = min(ALIGN(mmio, align), remaining_mmio);
> -		remaining_mmio -= mmio;
> +		       io.end =        io.start +        io_per_hp - 1;
> +		     mmio.end =      mmio.start +      mmio_per_hp - 1;
> +		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;

My preference would be to write them like this:

		io.end = io.start + io_per_hp - 1;
		mmio.end = mmio.start + mmio_per_hp - 1;
		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;

> -		align = pci_resource_alignment(bridge, mmio_pref_res);
> -		mmio_pref = div64_ul(available_mmio_pref, hotplug_bridges);
> -		mmio_pref = min(ALIGN(mmio_pref, align), remaining_mmio_pref);
> -		remaining_mmio_pref -= mmio_pref;
> +		pci_bus_distribute_available_resources(dev->subordinate,
> +			add_list, io, mmio, mmio_pref);
>  
> -		pci_bus_distribute_available_resources(b, add_list, io, mmio,
> -						       mmio_pref);
> +		       io.start =        io.end + 1;
> +		     mmio.start =      mmio.end + 1;
> +		mmio_pref.start = mmio_pref.end + 1;

Ditto.
