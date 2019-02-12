Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0EDC282CA
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 12:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61341214DA
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 12:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfBLMM4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:12:56 -0500
Received: from foss.arm.com ([217.140.101.70]:36586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBLMMy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Feb 2019 07:12:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2A8780D;
        Tue, 12 Feb 2019 04:12:53 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1C6E3F589;
        Tue, 12 Feb 2019 04:12:51 -0800 (PST)
Date:   Tue, 12 Feb 2019 12:12:42 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] PCI: hv: Add hv_pci_remove_slots() when we unload the
 driver
Message-ID: <20190212121235.GA23166@e107981-ln.cambridge.arm.com>
References: <PU1P153MB0169F06340FC519C2802C5CFBF680@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169F06340FC519C2802C5CFBF680@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 07, 2019 at 08:36:32PM +0000, Dexuan Cui wrote:
> 
> When we unload pci-hyperv, the host doesn't send us a PCI_EJECT message.
> In this case we also need to make sure the sysfs pci slot directory
> is removed, otherwise "cat /sys/bus/pci/slots/2/address" will trigger
> "BUG: unable to handle kernel paging request". And, if we unload/reload
> the driver several times, we'll have multiple pci slot directories in
> /sys/bus/pci/slots/ like this:
> 
> root@localhost:~# ls -rtl  /sys/bus/pci/slots/
> total 0
> drwxr-xr-x 2 root root 0 Feb  7 10:49 2
> drwxr-xr-x 2 root root 0 Feb  7 10:49 2-1
> drwxr-xr-x 2 root root 0 Feb  7 10:51 2-2
> 
> The patch adds the missing code, and in hv_eject_device_work() it also
> moves pci_destroy_slot() to an earlier place where we hold the pci lock.

This patch fixes three bugs:

1) set hpdev->pci_slot to NULL
2) move code destroying the slot inside a locked region in
   hv_eject_device_work()
3) Add missing slots removal code in hv_pci_remove()

We need three patches, not one.

(1) and (2), I am not entirely sure we want them in stable kernels,
since they are potential bugs, waiting for your input.

Lorenzo

> Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot information")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 9ba4d12c179c..6b4773727525 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1491,6 +1491,21 @@ static void hv_pci_assign_slots(struct hv_pcibus_device *hbus)
>  	}
>  }
>  
> +/*
> + * Remove entries in sysfs pci slot directory.
> + */
> +static void hv_pci_remove_slots(struct hv_pcibus_device *hbus)
> +{
> +	struct hv_pci_dev *hpdev;
> +
> +	list_for_each_entry(hpdev, &hbus->children, list_entry) {
> +		if (!hpdev->pci_slot)
> +			continue;
> +		pci_destroy_slot(hpdev->pci_slot);
> +		hpdev->pci_slot = NULL;
> +	}
> +}
> +
>  /**
>   * create_root_hv_pci_bus() - Expose a new root PCI bus
>   * @hbus:	Root PCI bus, as understood by this driver
> @@ -1887,6 +1902,10 @@ static void hv_eject_device_work(struct work_struct *work)
>  		pci_lock_rescan_remove();
>  		pci_stop_and_remove_bus_device(pdev);
>  		pci_dev_put(pdev);
> +		if (hpdev->pci_slot) {
> +			pci_destroy_slot(hpdev->pci_slot);
> +			hpdev->pci_slot = NULL;
> +		}
>  		pci_unlock_rescan_remove();
>  	}
>  
> @@ -1894,9 +1913,6 @@ static void hv_eject_device_work(struct work_struct *work)
>  	list_del(&hpdev->list_entry);
>  	spin_unlock_irqrestore(&hpdev->hbus->device_list_lock, flags);
>  
> -	if (hpdev->pci_slot)
> -		pci_destroy_slot(hpdev->pci_slot);
> -
>  	memset(&ctxt, 0, sizeof(ctxt));
>  	ejct_pkt = (struct pci_eject_response *)&ctxt.pkt.message;
>  	ejct_pkt->message_type.type = PCI_EJECTION_COMPLETE;
> @@ -2682,6 +2698,7 @@ static int hv_pci_remove(struct hv_device *hdev)
>  		pci_lock_rescan_remove();
>  		pci_stop_root_bus(hbus->pci_bus);
>  		pci_remove_root_bus(hbus->pci_bus);
> +		hv_pci_remove_slots(hbus);
>  		pci_unlock_rescan_remove();
>  		hbus->state = hv_pcibus_removed;
>  	}
> -- 
> 2.19.1
> 
