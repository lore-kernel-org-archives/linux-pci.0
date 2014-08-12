Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:51230 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbaHLWBD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Aug 2014 18:01:03 -0400
Received: by mail-ig0-f182.google.com with SMTP id c1so8170193igq.3
        for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 15:01:01 -0700 (PDT)
Date: Tue, 12 Aug 2014 16:00:58 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sandeep Mann <sandeep@purestorage.com>
Cc: linux-pci@vger.kernel.org, Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Use ordered workqueue for HPC events
Message-ID: <20140812213626.GA6333@google.com>
References: <1406933232-1560-1-git-send-email-sandeep@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406933232-1560-1-git-send-email-sandeep@purestorage.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rajat]

On Fri, Aug 01, 2014 at 03:47:12PM -0700, Sandeep Mann wrote:
> Using an ordered workqueue serializes processing of hotplug event. Processing
> an hotplug event for some devices can take a relatively "long" time, which
> means if a device is added and removed in quick succession (or due to flacky
> hardware), it can lead to multiple outstanding hotplug events. Processing
> these events concurrently can lead to unknown internal state and/or kernel
> panics.

Did you find this by code inspection, or did you actually observe a
problem?  If the latter, what were the symptoms?

shpchp does the same thing, so I assume it requires the same fix.

> Signed-off-by: Sandeep Mann <sandeep@purestorage.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 42914e0..c4eedab 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -681,7 +681,7 @@ static int pcie_init_slot(struct controller *ctrl)
>  	if (!slot)
>  		return -ENOMEM;
>  
> -	slot->wq = alloc_workqueue("pciehp-%u", 0, 0, PSN(ctrl));
> +	slot->wq = alloc_ordered_workqueue("pciehp-%u", 0, PSN(ctrl));
>  	if (!slot->wq)
>  		goto abort;
>  
> -- 
> 1.8.3.2
> 
