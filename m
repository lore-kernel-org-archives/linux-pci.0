Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0136.outbound.protection.outlook.com ([207.46.100.136]:12905
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752095AbcB2RVX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Feb 2016 12:21:23 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: Dan Carpenter <dan.carpenter@oracle.com>,
	KY Srinivasan <kys@microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [patch] PCI: hv: potential use after free
Date: Mon, 29 Feb 2016 17:21:18 +0000
Message-ID: <DM2PR0301MB1232C919B7845FAEC0B36BF3ABBA0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <20160227104357.GA14086@mwanda>
In-Reply-To: <20160227104357.GA14086@mwanda>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Saturday, February 27, 2016 2:44 AM
> To: KY Srinivasan <kys@microsoft.com>; Jake Oshins
> <jakeo@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; Bjorn Helgaas
> <bhelgaas@google.com>; devel@linuxdriverproject.org; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-
> janitors@vger.kernel.org
> Subject: [patch] PCI: hv: potential use after free
> 
> If we throw away the very last item on the list, then we could end up
> with a use after free of "dr".
> 
> Fixes: 15ca17645f19 ('PCI: hv: Add paravirtual PCI front-end for Microsoft
> Hyper-V VMs')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 9391dee..9b66ffe 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1397,6 +1397,7 @@ static void pci_devices_present_work(struct
> work_struct *work)
>  		/* Throw this away if the list still has stuff in it. */
>  		if (!list_empty(&hbus->dr_list)) {
>  			kfree(dr);
> +			dr = NULL;
>  			continue;
>  		}
>  	}

Thanks for looking at this.  I do truly appreciate it.  But the code here removes dr from the list and then, before freeing it, checks to see that it was not the last entry in the list.   The list lock is still held and the list is not empty even after removing dr from it.

(I suspect that you're going to tell me that I'm missing something here.  Please do.  I'll appreciate it even more.)

Thanks,
Jake
