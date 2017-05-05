Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751493AbdEEBYY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 May 2017 21:24:24 -0400
Date: Thu, 4 May 2017 20:24:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Wei Yang <weiyang@linux.vnet.ibm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] PCI: Restore pref MMIO allocation logic for host
 bridge without mmio64
Message-ID: <20170505012419.GD9648@bhelgaas-glaptop.roam.corp.google.com>
References: <20170421050500.13957-1-yinghai@kernel.org>
 <20170421050500.13957-14-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170421050500.13957-14-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 20, 2017 at 10:05:00PM -0700, Yinghai Lu wrote:
> From 5b2854155 (PCI: Restrict 64-bit prefetchable bridge windows to 64-bit
> resources), we change the logic for pref mmio allocation:
> When bridge pref support mmio64, we will only put children pref
> that support mmio64 into it, and will put children pref mmio32
> into bridge's non-pref mmio32.
> 
> That could leave bridge pref bar not used when that pref bar is mmio64,
> and children res only has mmio32.
> Also could have allocation failure when non-pref mmio32 is not big
> enough space for those children pref mmio32.
> 
> That is not rational when the host bridge does not have 64bit mmio
> above 4g at all.
> 
> The patch restore to old logic:
> when host bridge does not have has_mem64, put children pref mmio64 and
> pref mmio32 all under bridges pref bars.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  drivers/pci/bus.c       |  4 +++-
>  drivers/pci/setup-bus.c | 13 +++++++++----
>  drivers/pci/setup-res.c |  9 ++++++---
>  3 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index bc56cf1..79205fb 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -233,8 +233,10 @@ int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
>  {
>  #ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
>  	int rc;
> +	unsigned long mmio64 = pci_find_host_bridge(bus)->has_mem64 ?
> +				IORESOURCE_MEM_64 : 0;
>  
> -	if (res->flags & IORESOURCE_MEM_64) {
> +	if (res->flags & mmio64) {
>  		rc = pci_bus_alloc_from_region(bus, res, size, align, min,
>  					       type_mask, alignf, alignf_data,
>  					       &pci_high);

Why do we need this change?  This only makes a difference when
mmio64==0, i.e., when the host bridge has no windows above 4GB.
In that case, allocating from pci_high (0x100000000-0xffffffffffffffff)
should fail anyway because there are no windows up there.

When that fails, we'll try to allocate from pci_64_bit, which is the
entire 64 bit address region, which should still be OK.

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 7a0e59b..f29cf5d 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1308,7 +1308,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  		b_res = &bus->self->resource[PCI_BRIDGE_RESOURCES];
>  		mask = IORESOURCE_MEM;
>  		prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
> -		if (b_res[2].flags & IORESOURCE_MEM_64) {
> +		if ((b_res[2].flags & IORESOURCE_MEM_64) &&
> +		    pci_find_host_bridge(bus)->has_mem64) {
>  			prefmask |= IORESOURCE_MEM_64;
>  			ret = pbus_size_mem(bus, prefmask, prefmask,
>  				  prefmask, prefmask,
> @@ -1578,17 +1579,21 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
>  	 *	  io port.
>  	 *     2. if there is non pref mmio assign fail, release bridge
>  	 *	  nonpref mmio.
> -	 *     3. if there is 64bit pref mmio assign fail, and bridge pref
> +	 *     3. if there is pref mmio assign fail, and host bridge does
> +	 *	  have 64bit mmio, release bridge pref mmio.
> +	 *     4. if there is 64bit pref mmio assign fail, and bridge pref
>  	 *	  is 64bit, release bridge pref mmio.
> -	 *     4. if there is pref mmio assign fail, and bridge pref is
> +	 *     5. if there is pref mmio assign fail, and bridge pref is
>  	 *	  32bit mmio, release bridge pref mmio
> -	 *     5. if there is pref mmio assign fail, and bridge pref is not
> +	 *     6. if there is pref mmio assign fail, and bridge pref is not
>  	 *	  assigned, release bridge nonpref mmio.
>  	 */
>  	if (type & IORESOURCE_IO)
>  		idx = 0;
>  	else if (!(type & IORESOURCE_PREFETCH))
>  		idx = 1;
> +	else if (!pci_find_host_bridge(bus)->has_mem64)
> +		idx = 2;
>  	else if ((type & IORESOURCE_MEM_64) &&
>  		 (b_res[2].flags & IORESOURCE_MEM_64))
>  		idx = 2;
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 2aeb4bc..49cfb55 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -240,6 +240,8 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>  	struct resource *res = dev->resource + resno;
>  	resource_size_t min;
>  	int ret;
> +	unsigned long mmio64 = pci_find_host_bridge(bus)->has_mem64 ?
> +				IORESOURCE_MEM_64 : 0;
>  
>  	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
>  
> @@ -251,7 +253,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>  	 * things differently than they were sized, not everything will fit.
>  	 */
>  	ret = pci_bus_alloc_resource(bus, res, size, align, min,
> -				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
> +				     IORESOURCE_PREFETCH | mmio64,

It's kind of frustrating when you update the code, but not the
matching comment.  The comment just above this change says:

     * First, try exact prefetching match.  Even if a 64-bit
     * prefetchable bridge window is below 4GB, we can't put a 32-bit
     * prefetchable resource in it because pbus_size_mem() assumes a
     * 64-bit window will contain no 32-bit resources.  If we assign
     * things differently than they were sized, not everything will fit.

You changed the code so we now *do* allow a 32-bit prefetchable
resource in a 64-bit prefetchable window, as long as all the host
bridge windows are below 4GB.  Please update the comment accordingly.

The comment also says that this assignment code must match what
pbus_size_mem() does, but the only change to pbus_size_mem() is in a
separate patch.  Shouldn't they be done together so they remain in
sync?

>  				     pcibios_align_resource, dev);
>  	if (ret == 0)
>  		return 0;
> @@ -260,7 +262,8 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>  	 * If the prefetchable window is only 32 bits wide, we can put
>  	 * 64-bit prefetchable resources in it.
>  	 */
> -	if ((res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) ==
> +	if (mmio64 &&
> +	    (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) ==
>  	     (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
>  		ret = pci_bus_alloc_resource(bus, res, size, align, min,
>  					     IORESOURCE_PREFETCH,

Why do we need this change?  Please just update the comments to match
the code.

> @@ -275,7 +278,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>  	 * non-prefetchable, the first call already tried the only possibility
>  	 * so we don't need to try again.
>  	 */
> -	if (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))
> +	if (res->flags & (IORESOURCE_PREFETCH | mmio64))
>  		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
>  					     pcibios_align_resource, dev);
>  
> -- 
> 2.9.3
> 
