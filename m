Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E668CC43219
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 13:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82898216C4
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556198909;
	bh=Jx//LPAa80U2+re/jhjB0zehgO9+hTKvJM89I88XWRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wWAwD/waFoAY/uny7hqKnZ4k8meoJFDqH0lDmqfVxhnb6gkXjAb6PLGhSBRj22iKS
	 K2N3nMoCtvx9qulfPiwgaew4Ypq4Zj98J78EUyg+Z1aUUDJ+CZ4kGOVZp6msCNzuSY
	 p76Bd3N/cgnbeTwxLEo1CJtbkzd6zkFUxfPKefQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfDYN23 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbfDYN22 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Apr 2019 09:28:28 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC1C3216B7;
        Thu, 25 Apr 2019 13:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556198907;
        bh=Jx//LPAa80U2+re/jhjB0zehgO9+hTKvJM89I88XWRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZXins0D+9ugKmiza/46LNM/++tXR2EgHiycohSh9CQ/dKupUhFfQGzbdhYP5AjiK
         +mDUR4Yp8SrtltVeY1BZH+WfjNLHmsObjLSuuV9Jzs+UEwo/kbXsVhhPbQAtXDzMhE
         pSEzQMr5bksU41f8rOSRoPCES+3oxtMfRFCfNya0=
Date:   Thu, 25 Apr 2019 08:28:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v4 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Message-ID: <20190425132825.GA214428@google.com>
References: <20190417141610.6730-1-nicholas.johnson-opensource@outlook.com.au>
 <PS2P216MB06425DC2C68794039FE4100380250@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB06425DC2C68794039FE4100380250@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 17, 2019 at 02:16:36PM +0000, Nicholas Johnson wrote:
> Rewrite pci_bus_distribute_available_resources to better handle bridges
> with different resource alignment requirements. Pass more details
> arguments recursively to track the resource start and end addresses
> relative to the initial hotplug bridge. This is especially useful for
> Thunderbolt with native PCI enumeration, enabling external graphics
> cards and other devices with bridge alignment higher than 0x100000
> bytes.

It would be nice to have a concrete example including the actual
hotplug bridge windows and the resources required by a hot-added
device.  That would help show exactly what the current code is doing
wrong and how your patch fixes it.

> Change extend_bridge_window to resize the actual resource, rather than
> using add_list and dev_res->add_size. If an additional resource entry
> exists for the given resource, zero out the add_size field to avoid it
> interfering. Because add_size is considered optional when allocating,
> using add_size could cause issues in some cases, because successful
> resource distribution requires sizes to be guaranteed.

Could this be a separate patch, or is it impossible to separate from
the pci_bus_distribute_available_resources() changes?  If it could be
split, it would make it easier to review, backport, isolate problems,
etc.

> Such cases
> include hot-adding nested hotplug bridges in one enumeration, and
> potentially others which are yet to be encountered.

Obviously hot-adding nested bridges may require more resources, but
the connection to extend_bridge_window() and add_size is not obvious
to me.

> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>  drivers/pci/setup-bus.c | 203 ++++++++++++++++++++++------------------
>  1 file changed, 110 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index ec44a0f3a..a1ca8a11f 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1815,34 +1815,48 @@ void __init pci_assign_unassigned_resources(void)
>  }
>  
>  static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
> -			struct list_head *add_list, resource_size_t available)
> +			struct list_head *add_list, resource_size_t new_size)
>  {
>  	struct pci_dev_resource *dev_res;
> +	resource_size_t add_size;
>  
>  	if (res->parent)
>  		return;
>  
> -	if (resource_size(res) >= available)
> -		return;
> -
> -	dev_res = res_to_dev_res(add_list, res);
> -	if (!dev_res)
> -		return;
> +	/*
> +	 * Resources requested using add_size in additional resource lists are
> +	 * considered optional when allocated. Guaranteed size of allocation
> +	 * is required to guarantee successful resource distribution. Hence,
> +	 * the size of the actual resource must be adjusted.
> +	 */
> +	if (new_size >= resource_size(res)) {
> +		add_size = new_size - resource_size(res);
> +		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
> +			&add_size);
> +	} else {
> +		add_size = resource_size(res) - new_size;
> +		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
> +			&add_size);
> +	}
>  
> -	/* Is there room to extend the window? */
> -	if (available - resource_size(res) <= dev_res->add_size)
> -		return;
> +	res->end = res->start + new_size - 1;
>  
> -	dev_res->add_size = available - resource_size(res);
> -	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
> -		&dev_res->add_size);
> +	/*
> +	 * If a list entry exists, we need to remove any additional size
> +	 * requested because that could interfere with the alignment and
> +	 * sizing done when distributing resources, causing resources to
> +	 * fail to allocate later on.
> +	 */
> +	dev_res = res_to_dev_res(add_list, res);
> +	if (dev_res)
> +		dev_res->add_size = 0;
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
> @@ -1852,25 +1866,32 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
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
> @@ -1884,80 +1905,79 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
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
> +	if (!hotplug_bridges)
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
> +		io.end = io.start + io_per_hp - 1;
> +		mmio.end = mmio.start + mmio_per_hp - 1;
> +		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;
>  
> -		align = pci_resource_alignment(bridge, mmio_pref_res);
> -		mmio_pref = div64_ul(available_mmio_pref, hotplug_bridges);
> -		mmio_pref = min(ALIGN(mmio_pref, align), remaining_mmio_pref);
> -		remaining_mmio_pref -= mmio_pref;
> +		pci_bus_distribute_available_resources(dev->subordinate,
> +			add_list, io, mmio, mmio_pref);
>  
> -		pci_bus_distribute_available_resources(b, add_list, io, mmio,
> -						       mmio_pref);
> +		io.start = io.end + 1;
> +		mmio.start = mmio.end + 1;
> +		mmio_pref.start = mmio_pref.end + 1;
>  	}
>  }
>  
> @@ -1965,22 +1985,19 @@ static void
>  pci_bridge_distribute_available_resources(struct pci_dev *bridge,
>  					  struct list_head *add_list)
>  {
> -	resource_size_t available_io, available_mmio, available_mmio_pref;
> -	const struct resource *res;
> +	struct resource io_res, mmio_res, mmio_pref_res;
>  
>  	if (!bridge->is_hotplug_bridge)
>  		return;
>  
> +	io_res = bridge->resource[PCI_BRIDGE_RESOURCES + 0];
> +	mmio_res = bridge->resource[PCI_BRIDGE_RESOURCES + 1];
> +	mmio_pref_res = bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> +
>  	/* Take the initial extra resources from the hotplug port */
> -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
> -	available_io = resource_size(res);
> -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
> -	available_mmio = resource_size(res);
> -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> -	available_mmio_pref = resource_size(res);
>  
>  	pci_bus_distribute_available_resources(bridge->subordinate,
> -		add_list, available_io, available_mmio, available_mmio_pref);
> +		add_list, io_res, mmio_res, mmio_pref_res);
>  }
>  
>  void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
> -- 
> 2.20.1
> 
