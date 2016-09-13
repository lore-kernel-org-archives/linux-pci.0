Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760049AbcIMUB6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 16:01:58 -0400
Date: Tue, 13 Sep 2016 15:01:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        cov@codeaurora.org, alex.williamson@redhat.com,
        vikrams@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: add CRS support to error handling path
Message-ID: <20160913200152.GE4138@localhost>
References: <1472770801-30671-1-git-send-email-okaya@codeaurora.org>
 <1472770801-30671-2-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472770801-30671-2-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 01, 2016 at 07:00:01PM -0400, Sinan Kaya wrote:
> The PCIE spec allows an endpoint device to extend the initialization time
> beyond 1 second by issuing Configuration Request Retry Status (CRS) for a
> vendor ID read request.
> 
> This basically means "I'm busy now, please call me back later".
> 
> There are two moving parts to CRS support from the SW perspective. One part
> is to determine if CRS is supported or not. The second part is to set the
> CRS visibility register.
> 
> As part of the probe, the Linux kernel sets the above two conditions in
> pci_enable_crs function. The kernel is also honoring the returned CRS in
> pci_bus_read_dev_vendor_id function if supported. The function will poll up
> to specified amount of time while endpoint is returning CRS response.
> 
> The PCIe spec also allows CRS to be issued during cold, warm, hot and FLR
> resets.
> 
> The hot reset is initiated by starting a secondary bus reset. This patch is
> adding vendor ID read immediately after a bus reset so that the
> initialization procedure can be extended by the amount of time endpoint
> requires.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pci.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b209378..ebd0fc6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3829,6 +3829,44 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>  	return 0;
>  }
>  
> +/*
> + * Mostly copy paste from pci_walk_bus with the exceptions of hard coded
> + * work and removed locks.
> + */
> +static void pci_bus_probe_crs(struct pci_bus *top)
> +{
> +	struct pci_dev *dev;
> +	struct pci_bus *bus;
> +	struct list_head *next;
> +	int retval;
> +	u32 l;
> +
> +	bus = top;
> +	next = top->devices.next;
> +	for (;;) {
> +		if (next == &bus->devices) {
> +			/* end of this bus, go up or finish */
> +			if (bus == top)
> +				break;
> +			next = bus->self->bus_list.next;
> +			bus = bus->self->bus;
> +			continue;
> +		}
> +		dev = list_entry(next, struct pci_dev, bus_list);
> +		if (dev->subordinate) {
> +			/* this is a pci-pci bridge, do its devices next */
> +			next = dev->subordinate->devices.next;
> +			bus = dev->subordinate;
> +		} else
> +			next = dev->bus_list.next;
> +
> +		retval = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &l,
> +						    60 * 1000);
> +		if (retval)
> +			break;
> +	}
> +}

Sigh.  Man, this is ugly.  Maybe we're locked into the current
strategy and don't really have a choice, but I really don't like it.

> +
>  void pci_reset_secondary_bus(struct pci_dev *dev)
>  {
>  	u16 ctrl;
> @@ -4361,6 +4399,7 @@ void pci_reset_bridge_secondary_bus(struct pci_dev *dev)
>  	pci_bus_save_and_disable(dev->bus);
>  	pcibios_reset_secondary_bus(dev);
>  	pci_bus_restore(dev->bus);
> +	pci_bus_probe_crs(dev->subordinate);

This looks backwards -- pci_bus_restore() uses config accesses, so surely
you want to do the CRS check *before* that, right?  Oh, never mind, I see
you already caught this.

You mentioned several kinds of reset where CRS is allowed.  Doesn't this
fix only one of them?  I know we support at least FLR reset also.

>  }
>  EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
