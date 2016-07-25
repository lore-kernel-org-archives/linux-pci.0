Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58320 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611AbcGYRh4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Jul 2016 13:37:56 -0400
Date: Mon, 25 Jul 2016 12:37:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Cathy Avery <cavery@redhat.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, jakeo@microsoft.com,
	bhelgaas@google.com, vkuznets@redhat.com,
	devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Fix interrupt cleanup path
Message-ID: <20160725173750.GD12484@localhost>
References: <1468337484-16074-1-git-send-email-cavery@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468337484-16074-1-git-send-email-cavery@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 12, 2016 at 11:31:24AM -0400, Cathy Avery wrote:
> SR-IOV disabled from the host causes a memory leak.
> pci-hyperv usually first receives a PCI_EJECT notification
> and then proceeds to delete the hpdev list entry in
> hv_eject_device_work(). Later in hv_msi_free() since the
> device is no longer on the device list hpdev is NULL
> and hv_msi_free returns without freeing int_desc as part of
> hv_int_desc_free().
> 
> Signed-off-by: Cathy Avery <cavery@redhat.com>

Applied with Jake's ack to pci/host-hv for v4.8, thanks!

For some reason, Jake's ack appears in patchwork and in my personal
email, but I don't see it on the mailing list.  Maybe something in
http://vger.kernel.org/majordomo-info.html#taboo is relevant.

> ---
>  drivers/pci/host/pci-hyperv.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 7e9b2de..449d053 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -732,16 +732,18 @@ static void hv_msi_free(struct irq_domain *domain, struct msi_domain_info *info,
>  
>  	pdev = msi_desc_to_pci_dev(msi);
>  	hbus = info->data;
> -	hpdev = get_pcichild_wslot(hbus, devfn_to_wslot(pdev->devfn));
> -	if (!hpdev)
> +	int_desc = irq_data_get_irq_chip_data(irq_data);
> +	if (!int_desc)
>  		return;
>  
> -	int_desc = irq_data_get_irq_chip_data(irq_data);
> -	if (int_desc) {
> -		irq_data->chip_data = NULL;
> -		hv_int_desc_free(hpdev, int_desc);
> +	irq_data->chip_data = NULL;
> +	hpdev = get_pcichild_wslot(hbus, devfn_to_wslot(pdev->devfn));
> +	if (!hpdev) {
> +		kfree(int_desc);
> +		return;
>  	}
>  
> +	hv_int_desc_free(hpdev, int_desc);
>  	put_pcichild(hpdev, hv_pcidev_ref_by_slot);
>  }
>  
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
