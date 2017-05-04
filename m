Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbdEDXE3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 May 2017 19:04:29 -0400
Date: Thu, 4 May 2017 18:04:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Wei Yang <weiyang@linux.vnet.ibm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Subject: Re: [PATCH 11/13] PCI: Add has_mem64 for struct host_bridge
Message-ID: <20170504230425.GC9648@bhelgaas-glaptop.roam.corp.google.com>
References: <20170421050500.13957-1-yinghai@kernel.org>
 <20170421050500.13957-12-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170421050500.13957-12-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Christian]

On Thu, Apr 20, 2017 at 10:04:58PM -0700, Yinghai Lu wrote:
> Add has_mem64 for struct host_bridge, on root bus that does not support
> mmio64 above 4g, will not set that.
> 
> We will use that info next two following patches:
> 1. Don't treat non-pref mmio64 as pref mmio, so will not put
>    it under bridge's pref range when rescan the devices
> 2. will keep pref mmio64 and pref mmio32 under bridge pref bar.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  drivers/pci/probe.c | 7 +++++++
>  include/linux/pci.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 676b55f..8f439e0 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -818,6 +818,13 @@ int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  			addr[0] = '\0';
>  
>  		dev_info(&bus->dev, "root bus resource %pR%s\n", res, addr);
> +
> +		if (resource_type(res) == IORESOURCE_MEM) {
> +			if ((res->end - offset) > 0xffffffff)
> +				bridge->has_mem64 = 1;

This part makes sense -- if any part of the window extends above 4G,
only a 64-bit BAR can use the part above 4G.

> +			if ((res->start - offset) > 0xffffffff)
> +				res->flags |= IORESOURCE_MEM_64;

But I don't understand this part.  You only set IORESOURCE_MEM_64 if
the *start* is above 4G?  If the window started at 2GB and ended at
6GB, you wouldn't set IORESOURCE_MEM_64?

And I don't understand where this IORESOURCE_MEM_64 in res->flags is
used.  It seems like the only possible place is this test added by the
last patch:

  int pci_bus_alloc_resource(bus, res, ...)
  {
    if (res->flags & mmio64) {

but this patch is setting IORESOURCE_MEM_64 in the host bridge window,
i.e., the bus resource, and pci_bus_alloc_resource() is testing the
flags of the resource we're allocating *from* the bus resource.

> +		}

I *think* this will be broken by the current implementation of
Christian's patch to enable a 64-bit host bridge window:

  https://lkml.kernel.org/r/1493890270-1188-5-git-send-email-deathsimple@vodafone.de

because pci_register_host_bridge() runs before we scan the bus, and
Christian's patch adds a quirk that runs when we enumerate the AMD
host bridge device.

If we apply this and Christian's patch, I think we could end up with
a host bridge window above 4G, but with bridge->has_mem64 not set.

>  	}
>  
>  	down_write(&pci_bus_sem);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b14dd94..a3693ef 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -436,6 +436,7 @@ struct pci_host_bridge {
>  	void *release_data;
>  	struct msi_controller *msi;
>  	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
> +	unsigned int has_mem64:1;
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
>  			const struct resource *res,
> -- 
> 2.9.3
> 
