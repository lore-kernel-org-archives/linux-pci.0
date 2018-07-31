Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbeGaULB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Jul 2018 16:11:01 -0400
Date: Tue, 31 Jul 2018 13:29:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: pciehp: Avoid implicit fallthroughs in switch
 statements
Message-ID: <20180731182925.GM45322@bhelgaas-glaptop.roam.corp.google.com>
References: <92c3c456edb461494d5c44e1ff6bab2711228ff1.1532754355.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <92c3c456edb461494d5c44e1ff6bab2711228ff1.1532754355.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 28, 2018 at 07:22:00AM +0200, Lukas Wunner wrote:
> Per Mika's request, add an explicit break to the last case of switch
> statements everywhere in pciehp to be more defensive towards future
> amendments.
> 
> Per Gustavo's request, mark all non-empty implicit fallthroughs with a
> comment to silence warnings triggered by -Wimplicit-fallthrough=2.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Both applied, with Mika's reviewed-by on both and Gustavo's ack on the
first, to pci/hotplug for v4.19, thanks!

> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 6855933ab372..da7c72372ffc 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -211,6 +211,7 @@ void pciehp_handle_disable_request(struct slot *slot)
>  	case BLINKINGON_STATE:
>  	case BLINKINGOFF_STATE:
>  		cancel_delayed_work(&slot->work);
> +		break;
>  	}
>  	slot->state = POWEROFF_STATE;
>  	mutex_unlock(&slot->lock);
> @@ -232,6 +233,7 @@ void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
>  	switch (slot->state) {
>  	case BLINKINGOFF_STATE:
>  		cancel_delayed_work(&slot->work);
> +		/* fall through */
>  	case ON_STATE:
>  		slot->state = POWEROFF_STATE;
>  		mutex_unlock(&slot->lock);
> @@ -245,6 +247,7 @@ void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
>  		break;
>  	default:
>  		mutex_unlock(&slot->lock);
> +		break;
>  	}
>  
>  	/* Turn the slot on if it's occupied or link is up */
> @@ -259,6 +262,7 @@ void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
>  	switch (slot->state) {
>  	case BLINKINGON_STATE:
>  		cancel_delayed_work(&slot->work);
> +		/* fall through */
>  	case OFF_STATE:
>  		slot->state = POWERON_STATE;
>  		mutex_unlock(&slot->lock);
> @@ -272,6 +276,7 @@ void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
>  		break;
>  	default:
>  		mutex_unlock(&slot->lock);
> +		break;
>  	}
>  }
>  
> -- 
> 2.18.0
> 
