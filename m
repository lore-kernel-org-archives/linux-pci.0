Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:47863 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbcKIT5J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2016 14:57:09 -0500
Date: Wed, 9 Nov 2016 20:58:12 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: linux-pci@vger.kernel.org, tbroch@google.com, rajatja@google.com,
        gwendal@google.com, bhelgaas@google.com, ravisadineni@google.com,
        keith.busch@intel.com, paul.gortmaker@windriver.com
Subject: Re: [PATCH] pciehp_resume: don't add existing device
Message-ID: <20161109195812.GA7528@wunner.de>
References: <1478714735-134347-1-git-send-email-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478714735-134347-1-git-send-email-ravisadineni@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 09, 2016 at 10:05:35AM -0800, Ravi Chandra Sadineni wrote:
> If a slot was occupied before supend, and nothing has changed after
> resume, we call pciehp_enable_slot() although it fails a little
> later with the message:
>    Device XXXX:XX:XX.X already exists at XXXX:XX:XX, cannot hot-add
>    Cannot add device at XXXX:XX:XX
> 
> This was partly discussed here: https://lkml.org/lkml/2013/7/9/452
> and I'm pulling only the part4 of that patch, since it does not change
> anything functionally (or atleast does not seem to make it worse), but
> prevents uncomfortable messages pointed above.
> ---
>  drivers/pci/hotplug/pciehp_core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 612b21a..873cff8 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -290,6 +290,7 @@ static int pciehp_resume(struct pcie_device *dev)
>  {
>  	struct controller *ctrl;
>  	struct slot *slot;
> +	struct pci_bus *pbus = dev->port->subordinate;
>  	u8 status;
>  
>  	ctrl = get_service_data(dev);
> @@ -302,10 +303,13 @@ static int pciehp_resume(struct pcie_device *dev)
>  	/* Check if slot is occupied */
>  	pciehp_get_adapter_status(slot, &status);
>  	mutex_lock(&slot->hotplug_lock);
> -	if (status)
> -		pciehp_enable_slot(slot);
> -	else
> +	if (status) {
> +		if (list_empty(&pbus->devices))
> +			pciehp_enable_slot(slot);
> +	}
> +	else {
>  		pciehp_disable_slot(slot);
> +	}

What if the device plugged in after suspend is a different one
and requires e.g. an entirely different driver or different resource
allocations?

What if the device is the same but child devices have been plugged
in during system sleep? (E.g. additional devices attached to a
Thunderbolt daisy chain.)

At the very least you need to rescan the bus here.

Thanks,

Lukas

>  	mutex_unlock(&slot->hotplug_lock);
>  	return 0;
>  }
> -- 
> 2.6.6
