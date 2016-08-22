Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752364AbcHVQ7R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Aug 2016 12:59:17 -0400
Date: Mon, 22 Aug 2016 11:59:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCH] pciehp: Clear attention LED on device add
Message-ID: <20160822165912.GD18628@localhost>
References: <1470266985-28906-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470266985-28906-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 03, 2016 at 05:29:45PM -0600, Keith Busch wrote:
> This patch clears the LED attention status after a successful device
> add. It is possible the attention LED was on from a previous power fault
> or link failure, and a subsequent successful device inserted in the slot
> should clear it.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Applied to pci/hotplug for v4.9, thanks, Keith!

> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 880978b..7ea3e61 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -120,6 +120,7 @@ static int board_added(struct slot *p_slot)
>  	}
>  
>  	pciehp_green_led_on(p_slot);
> +	pciehp_set_attention_status(p_slot, 0);
>  	return 0;
>  
>  err_exit:
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
