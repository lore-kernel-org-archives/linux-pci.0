Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0188.outbound.protection.outlook.com ([207.46.163.188]:38713
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751934AbaHDUW0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Aug 2014 16:22:26 -0400
From: Rajat Jain <rajatjain@juniper.net>
To: Sandeep Mann <sandeep@purestorage.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "rajatxjain@gmail.com" <rajatxjain@gmail.com>
Subject: RE: [PATCH] PCI: pciehp: Use ordered workqueue for HPC events
Date: Mon, 4 Aug 2014 20:22:22 +0000
Message-ID: <dc3c0a8a73734bac8b3340ed4fec4810@DM2PR05MB671.namprd05.prod.outlook.com>
References: <1406933232-1560-1-git-send-email-sandeep@purestorage.com>
In-Reply-To: <1406933232-1560-1-git-send-email-sandeep@purestorage.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Sandeep Mann
> Sent: Friday, August 01, 2014 3:47 PM
> To: bhelgaas@google.com; linux-pci@vger.kernel.org
> Subject: [PATCH] PCI: pciehp: Use ordered workqueue for HPC events
> 
> Using an ordered workqueue serializes processing of hotplug event.
> Processing an hotplug event for some devices can take a relatively "long"
> time, which means if a device is added and removed in quick succession (or
> due to flacky hardware), it can lead to multiple outstanding hotplug events.
> Processing these events concurrently can lead to unknown internal state
> and/or kernel panics.
> 
> Signed-off-by: Sandeep Mann <sandeep@purestorage.com>

Acked-by: Rajat Jain <rajatxjain@gmail.com>

Yes, this is good and needed. Sometime back I felt the need for it, but sort of assumed that the slot->wq is already ordered.

Thanks,
Rajat


> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c
> b/drivers/pci/hotplug/pciehp_hpc.c
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
