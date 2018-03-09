Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbeCIPjU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Mar 2018 10:39:20 -0500
Date: Fri, 9 Mar 2018 15:39:11 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: fix bus domain ID corruption
Message-ID: <20180309153911.GA20693@e107981-ln.cambridge.arm.com>
References: <A9BC9573-36AA-4493-A086-F99F9204BEC9@microsoft.com>
 <19EE9647-AE9B-443E-ADBD-51CCEFC3EDEA@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19EE9647-AE9B-443E-ADBD-51CCEFC3EDEA@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 09, 2018 at 05:02:34AM +0000, Sridhar Pitchai wrote:
> When PCI BUS is added, PCI_BUS domain ID is set. When PCI_BUS and a device
> added to the bus is racing against each other, the first device tends to
> overwrite the domain ID. In order to avoid the race, this patch make sure
> when a device is added to a bus, it never updated the bus domain ID. Since
> we have the transparent SRIOV mode now, the short VF device name is no
> longer needed.

This commit log may be clear to you, it is not clear to me at all so
you will have to improve it and explain why it is safe to apply this
patch.

> Fixes: 4a9b0933bdfc("PCI:hv:Use device serial number as PCI domain")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sridhar Pitchai <srpitcha@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 11 -----------
>  1 file changed, 11 deletions(-)

Are you 100% sure this patch won't trigger a regression on current
systems ? I need ACKs/reviews from hyperv maintainers to apply it.

Lorenzo

> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 2faf38e..ac67e56 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
>  	get_pcichild(hpdev, hv_pcidev_ref_childlist);
>  	spin_lock_irqsave(&hbus->device_list_lock, flags);
>  
> -	/*
> -	 * When a device is being added to the bus, we set the PCI domain
> -	 * number to be the device serial number, which is non-zero and
> -	 * unique on the same VM.  The serial numbers start with 1, and
> -	 * increase by 1 for each device.  So device names including this
> -	 * can have shorter names than based on the bus instance UUID.
> -	 * Only the first device serial number is used for domain, so the
> -	 * domain number will not change after the first device is added.
> -	 */
> -	if (list_empty(&hbus->children))
> -		hbus->sysdata.domain = desc->ser;
>  	list_add_tail(&hpdev->list_entry, &hbus->children);
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  	return hpdev;
> -- 
> 2.7.4
>  
> 
