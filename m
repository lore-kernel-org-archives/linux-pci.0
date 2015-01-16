Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:55709 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbbAPUdd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jan 2015 15:33:33 -0500
Received: by mail-oi0-f54.google.com with SMTP id u20so19052005oif.13
        for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2015 12:33:33 -0800 (PST)
Date: Fri, 16 Jan 2015 14:33:30 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH] pci: Use hot-plug capable for testing presence on
Message-ID: <20150116203330.GJ29776@google.com>
References: <1419275223-14602-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419275223-14602-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rajat]

On Mon, Dec 22, 2014 at 12:07:03PM -0700, Keith Busch wrote:
> The PCI-e Base specifically says Hot-Plug Surprise capability is for
> removal only, but pciehp checked this to determine if it should handle a
> slot event on device add. Lots of platform's pcie slots don't advertise
> support for surprise removal, but are perfectly capable of handling
> hot-add, so checking surprise removal is not appropriate.
> 
> This patch checks the Hot-Plug Capable bit in the slot capabilities to
> determine if the detected presence on is a reliable event instead of
> Hot-Plug Surprise.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

This seems reasonable to me, and I applied it to pci/hotplug for v3.20.

Does this fix a bug you've observed?  If so, I'll include details or a
pointer in the changelog.

2b3940b60626 ("PCI: pciehp: Remove a non-existent card, regardless of
"surprise" capability") made it so we handle unexpected loss of presence
detect even if the slot doesn't advertise Hot-Plug Surprise.  I suppose we
could make a similar argument that if a card shows up, maybe we should do
something with it regardless of what the slot advertises for Hot-Plug
Capable.

> ---
>  drivers/pci/hotplug/pciehp.h      |    1 +
>  drivers/pci/hotplug/pciehp_ctrl.c |    2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index b115219..b91eefb 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -126,6 +126,7 @@ struct controller {
>  #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
>  #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
>  #define HP_SUPR_RM(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
> +#define HP_CAP(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPC)
>  #define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
>  #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
>  #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index ff32e85..996c313 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -532,7 +532,7 @@ static void interrupt_event_handler(struct work_struct *work)
>  		pciehp_green_led_off(p_slot);
>  		break;
>  	case INT_PRESENCE_ON:
> -		if (!HP_SUPR_RM(ctrl))
> +		if (!HP_CAP(ctrl))
>  			break;
>  		ctrl_dbg(ctrl, "Surprise Insertion\n");
>  		handle_surprise_event(p_slot);
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
