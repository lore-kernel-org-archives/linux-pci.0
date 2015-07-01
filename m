Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36081 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbbGAQpZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jul 2015 12:45:25 -0400
Received: by igrv9 with SMTP id v9so78231079igr.1
        for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2015 09:45:24 -0700 (PDT)
Date: Wed, 1 Jul 2015 11:45:20 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: wdavis@nvidia.com
Cc: Joerg Roedel <joro@8bytes.org>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Mark Hounschell <markh@compro.net>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Yijing Wang <wangyijing@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 7/7] x86: add pci-nommu implementation of map_resource
Message-ID: <20150701164520.GC13409@google.com>
References: <1432919686-32306-1-git-send-email-wdavis@nvidia.com>
 <1432919686-32306-8-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432919686-32306-8-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 29, 2015 at 12:14:46PM -0500, wdavis@nvidia.com wrote:
> From: Will Davis <wdavis@nvidia.com>
> 
> Lookup the bus address of the resource by finding the parent host bridge,
> which may be different than the parent host bridge of the target device.
> 
> Signed-off-by: Will Davis <wdavis@nvidia.com>
> ---
>  arch/x86/kernel/pci-nommu.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
> index da15918..6384482 100644
> --- a/arch/x86/kernel/pci-nommu.c
> +++ b/arch/x86/kernel/pci-nommu.c
> @@ -38,6 +38,37 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
>  	return bus;
>  }
>  
> +static dma_addr_t nommu_map_resource(struct device *dev, struct resource *res,
> +				     unsigned long offset, size_t size,
> +				     enum dma_data_direction dir,
> +				     struct dma_attrs *attrs)
> +{
> +	struct pci_bus *bus;
> +	struct pci_host_bridge *bridge;
> +	struct resource_entry *window;
> +	resource_size_t bus_offset = 0;
> +	dma_addr_t dma_address;
> +
> +	/* Find the parent host bridge of the resource, and determine the
> +	 * relative offset.
> +	 */
> +	list_for_each_entry(bus, &pci_root_buses, node) {
> +		bridge = to_pci_host_bridge(bus->bridge);
> +		resource_list_for_each_entry(window, &bridge->windows) {
> +			if (resource_contains(window->res, res))
> +				bus_offset = window->offset;
> +		}
> +	}

I don't think this is safe.  Assume we have the following topology, and
we want to set it up so 0000:00:00.0 can perform peer-to-peer DMA to
0001:00:01.0:

  pci_bus 0000:00: root bus resource [mem 0x80000000-0xffffffff] (bus address [0x80000000-0xffffffff])
  pci 0000:00:00.0: ...
  pci_bus 0001:00: root bus resource [mem 0x180000000-0x1ffffffff] (bus address [0x80000000-0xffffffff])
  pci 0001:00:01.0: reg 0x10: [mem 0x180000000-0x1803fffff 64bit]

I assume the way this works is that the driver for 0000:00:00.0 would call
this function with 0001:00:01.0 and [mem 0x180000000-0x1803fffff 64bit].

We'll figure out that the resource belongs to 0001:00, so we return a
dma_addr of 0x80000000, which is the bus address as seen by 0001:00:01.0.
But if 0000:00:00.0 uses that address, it refers to something in the
0000:00 hierarchy, not the 0001:00 hierarchy.

We talked about pci_bus_address() and pcibios_resource_to_bus() earlier.
What's the subtlety that makes them unusable here?  I'd rather not add more
uses of the pci_root_buses list if we can avoid it.

> +	dma_address = (res->start - bus_offset) + offset;
> +	WARN_ON(size == 0);
> +	if (!check_addr("map_resource", dev, dma_address, size))
> +		return DMA_ERROR_CODE;
> +	flush_write_buffers();
> +	return dma_address;
> +}
> +
> +

You added an extra blank line here (there was already an extra one before
nommu_sync_sg_for_device(), which is probably what you copied).

>  /* Map a set of buffers described by scatterlist in streaming
>   * mode for DMA.  This is the scatter-gather version of the
>   * above pci_map_single interface.  Here the scatter gather list
> @@ -93,6 +124,7 @@ struct dma_map_ops nommu_dma_ops = {
>  	.free			= dma_generic_free_coherent,
>  	.map_sg			= nommu_map_sg,
>  	.map_page		= nommu_map_page,
> +	.map_resource		= nommu_map_resource,
>  	.sync_single_for_device = nommu_sync_single_for_device,
>  	.sync_sg_for_device	= nommu_sync_sg_for_device,
>  	.is_phys		= 1,
> -- 
> 2.4.0
> 
