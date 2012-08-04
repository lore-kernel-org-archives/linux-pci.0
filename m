Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42221 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453Ab2HDVq1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 4 Aug 2012 17:46:27 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Oliver Neukum <oliver@neukum.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pciehp: always implement resume
Date: Sat, 4 Aug 2012 23:52:18 +0200
Cc: linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>,
	linux-pci@vger.kernel.org,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <1343827778-26092-1-git-send-email-oliver@neukum.org>
In-Reply-To: <1343827778-26092-1-git-send-email-oliver@neukum.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Message-Id: <201208042352.18800.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 01, 2012, Oliver Neukum wrote:
> The driver by default ignores resume. On some laptops
> that means that interrupts are not delivered after S3.
> So card removals and insertions will not be handled. Requiring
> a forced load isn't right.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>

Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/pci/hotplug/pciehp_core.c |   28 ++++++++++++++--------------
>  1 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 365c6b9..916bf4f 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -300,24 +300,24 @@ static int pciehp_suspend (struct pcie_device *dev)
>  
>  static int pciehp_resume (struct pcie_device *dev)
>  {
> +	struct controller *ctrl;
> +	struct slot *slot;
> +	u8 status;
> +
>  	dev_info(&dev->device, "%s ENTRY\n", __func__);
> -	if (pciehp_force) {
> -		struct controller *ctrl = get_service_data(dev);
> -		struct slot *slot;
> -		u8 status;
> +	ctrl = get_service_data(dev);
>  
> -		/* reinitialize the chipset's event detection logic */
> -		pcie_enable_notification(ctrl);
> +	/* reinitialize the chipset's event detection logic */
> +	pcie_enable_notification(ctrl);
>  
> -		slot = ctrl->slot;
> +	slot = ctrl->slot;
>  
> -		/* Check if slot is occupied */
> -		pciehp_get_adapter_status(slot, &status);
> -		if (status)
> -			pciehp_enable_slot(slot);
> -		else
> -			pciehp_disable_slot(slot);
> -	}
> +	/* Check if slot is occupied */
> +	pciehp_get_adapter_status(slot, &status);
> +	if (status)
> +		pciehp_enable_slot(slot);
> +	else
> +		pciehp_disable_slot(slot);
>  	return 0;
>  }
>  #endif /* PM */
> 

