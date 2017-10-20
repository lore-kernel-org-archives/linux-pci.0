Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752418AbdJTVpq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Oct 2017 17:45:46 -0400
Date: Fri, 20 Oct 2017 16:45:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pcmcia@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] pcmcia: convert to use for_each_pci_bridge() helper
Message-ID: <20171020214544.GT6332@bhelgaas-glaptop.roam.corp.google.com>
References: <20171013165352.25550-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171013165352.25550-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 13, 2017 at 07:53:52PM +0300, Andy Shevchenko wrote:
> ...which makes code slightly cleaner.
> 
> Requires: d43f59ce6c50 ("PCI: Add for_each_pci_bridge() helper")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I folded this into the original commit, since it hasn't been merged
anywhere.  Note that I moved that commit from pci/misc to pci/hotplug
since Mika's series depends on it.  Thanks!

> ---
>  drivers/pcmcia/cardbus.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
> index 4fe4cc4ae19a..5c0170597037 100644
> --- a/drivers/pcmcia/cardbus.c
> +++ b/drivers/pcmcia/cardbus.c
> @@ -77,9 +77,8 @@ int __ref cb_alloc(struct pcmcia_socket *s)
>  
>  	max = bus->busn_res.start;
>  	for (pass = 0; pass < 2; pass++)
> -		list_for_each_entry(dev, &bus->devices, bus_list)
> -			if (pci_is_bridge(dev))
> -				max = pci_scan_bridge(bus, dev, max, pass);
> +		for_each_pci_bridge(dev, bus)
> +			max = pci_scan_bridge(bus, dev, max, pass);
>  
>  	/*
>  	 * Size all resources below the CardBus controller.
> -- 
> 2.14.2
> 
