Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37912 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeCOMF3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Mar 2018 08:05:29 -0400
Date: Thu, 15 Mar 2018 12:05:22 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Message-ID: <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 15, 2018 at 12:03:07AM +0000, Sridhar Pitchai wrote:
> Whenever PCI bus is added, HyperV guarantees the BUS id is unique. Even

"Whenever a PCI bus is added"

> with that when a first device is added to the bus, it overrides bus domain
> ID with the device serial number. Sometime this can result in BUS ID not

Define "Sometime".

> being unique. In this case, when PCI_BUS and a device to bus is added, the
> first device overwrites the bus domain ID to the device serial number,
> which is 0. Since there exsist a PCI bus with domain ID 0 already the PCI

s/exsist/exist

> bus addition fails. This patch make sure when a device is added to a bus,
> it never updated the bus domain ID. 

s/updated/updates

> Since we have the transparent SRIOV mode now, the short VF device name
> is no longer needed.

I still do not understand what this means and how it is related to the
patch below, it may be clear to you, it is not to me, at all.

> Fixes: 4a9b0933bdfc("PCI:hv:Use device serial number as PCI domain")

Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")

I asked you an explicit question. Commit above was added for a reason
I assume. This patch implies that kernel has been broken since v4.11
which is almost a year ago and nobody every noticed ? Or there are
systems where commit above is _necessary_ and this patch would break
them ?

I want a detailed explanation that highlights *why* it is safe to apply
this patch and send it to stable kernels, commit log above won't do.

Thanks,
Lorenzo

> Cc: stable@vger.kernel.org
> Signed-off-by: Sridhar Pitchai <srpitcha@microsoft.com>
> ---
> 
> Changes in v3:
> * fix the commit comment. [KY Srinivasan, Michael Kelley]
> ---
>  drivers/pci/host/pci-hyperv.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
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
