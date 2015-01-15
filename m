Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28104 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468AbbAOWRY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Jan 2015 17:17:24 -0500
Date: Thu, 15 Jan 2015 22:17:23 +0000 (UTC)
From: Keith Busch <keith.busch@intel.com>
To: Keith Busch <keith.busch@intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: Use hot-plug capable for testing presence on
In-Reply-To: <1419275223-14602-1-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.LNX.2.00.1501152203360.4026@localhost.lm.intel.com>
References: <1419275223-14602-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Any thoughts on this? I've read old threads on the pci lists regarding
the HPS slot capability usage being wrong for hot-add, but it didn't
seem like it was closed.

Right now there are customers reporting hot-add doesn't work on Linux
for this reason, and I'm struggling to come up with a rebuttal to the
other OS developers claiming superiority over Linux for PCI-e hotplug
on popular platforms.

On Mon, 22 Dec 2014, Keith Busch wrote:
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
> ---
> drivers/pci/hotplug/pciehp.h      |    1 +
> drivers/pci/hotplug/pciehp_ctrl.c |    2 +-
> 2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index b115219..b91eefb 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -126,6 +126,7 @@ struct controller {
> #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
> #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
> #define HP_SUPR_RM(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
> +#define HP_CAP(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPC)
> #define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
> #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
> #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index ff32e85..996c313 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -532,7 +532,7 @@ static void interrupt_event_handler(struct work_struct *work)
> 		pciehp_green_led_off(p_slot);
> 		break;
> 	case INT_PRESENCE_ON:
> -		if (!HP_SUPR_RM(ctrl))
> +		if (!HP_CAP(ctrl))
> 			break;
> 		ctrl_dbg(ctrl, "Surprise Insertion\n");
> 		handle_surprise_event(p_slot);
> -- 
> 1.7.10.4
