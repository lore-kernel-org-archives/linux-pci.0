Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:43824 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbaIDVKu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 17:10:50 -0400
Received: by mail-pd0-f174.google.com with SMTP id v10so1048725pde.5
        for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2014 14:10:48 -0700 (PDT)
Date: Thu, 4 Sep 2014 15:10:42 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sandeep Mann <sandeep@purestorage.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Use ordered workqueue for HPC events
Message-ID: <20140904211042.GD17125@google.com>
References: <1406933232-1560-1-git-send-email-sandeep@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406933232-1560-1-git-send-email-sandeep@purestorage.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 01, 2014 at 03:47:12PM -0700, Sandeep Mann wrote:
> Using an ordered workqueue serializes processing of hotplug event. Processing
> an hotplug event for some devices can take a relatively "long" time, which
> means if a device is added and removed in quick succession (or due to flacky
> hardware), it can lead to multiple outstanding hotplug events. Processing
> these events concurrently can lead to unknown internal state and/or kernel
> panics.
> 
> Signed-off-by: Sandeep Mann <sandeep@purestorage.com>

What's the status of this?  I see Rajat's ack, but there was a lot of
subsequent discussion, and I'm not sure whether there was a conclusion.

Given that, I'd like to see a bugzilla with the relevant background
(lspci -vv, dmesg log).  Also, shpchp_core.c has similar code, so I'd like
to see either a similar patch for it or an explanation of why that driver
doesn't need it.

So I'll drop this for now, pending these updates.

Bjorn

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
