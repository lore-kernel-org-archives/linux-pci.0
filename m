Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965954AbcIWOc2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Sep 2016 10:32:28 -0400
Date: Fri, 23 Sep 2016 09:32:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCHv4] pciehp: Let user control LED status
Message-ID: <20160923143222.GE1514@localhost>
References: <1473784319-6137-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473784319-6137-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 13, 2016 at 10:31:59AM -0600, Keith Busch wrote:
> This patch adds a new flag to the pci_dev structure instructing pciehp
> to not interpret PCIe slot LED indicators. The pciehp driver will instead
> allow all LED control from the user by setting the slot control indicators
> as the user requested through sysfs. This is preparing for domain devices
> that repurpose these control bits for non-standard use.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

BTW, I think this turned out really well.  It's small and clean and I
think it's safe in terms of races and so on.  Thanks a lot for pushing
on this!

> ---
> v3 -> v4:
> 
>   Fixing symbol usage by generating patch from the tree that compiles
>   correctly.
> 
>  drivers/pci/hotplug/pciehp.h      |  5 +++++
>  drivers/pci/hotplug/pciehp_core.c |  3 +++
>  drivers/pci/hotplug/pciehp_hpc.c  | 27 +++++++++++++++++++++++++++
>  include/linux/pci.h               |  1 +
>  4 files changed, 36 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index e764918..725078d 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -152,6 +152,11 @@ bool pciehp_check_link_active(struct controller *ctrl);
>  void pciehp_release_ctrl(struct controller *ctrl);
>  int pciehp_reset_slot(struct slot *slot, int probe);
>  
> +int pciehp_set_raw_attention_status(struct hotplug_slot *hotplug_slot,
> +								u8 status);
> +int pciehp_get_raw_attention_status(struct hotplug_slot *hotplug_slot,
> +								u8 *status);
> +
>  static inline const char *slot_name(struct slot *slot)
>  {
>  	return hotplug_slot_name(slot->hotplug_slot);
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index fb0f863..68b7aeb 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -113,6 +113,9 @@ static int init_slot(struct controller *ctrl)
>  	if (ATTN_LED(ctrl)) {
>  		ops->get_attention_status = get_attention_status;
>  		ops->set_attention_status = set_attention_status;
> +	} else if (ctrl->pcie->port->user_leds) {
> +		ops->get_attention_status = pciehp_get_raw_attention_status;
> +		ops->set_attention_status = pciehp_set_raw_attention_status;
>  	}
>  
>  	/* register this slot with the hotplug pci core */
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 08e84d6..5ab8604 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -355,6 +355,18 @@ static int pciehp_link_enable(struct controller *ctrl)
>  	return __pciehp_link_set(ctrl, true);
>  }
>  
> +int pciehp_get_raw_attention_status(struct hotplug_slot *hotplug_slot,
> +								u8 *status)
> +{
> +	struct slot *slot = hotplug_slot->private;
> +	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
> +	u16 slot_ctrl;
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
> +	*status = (slot_ctrl & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
> +	return 0;
> +}
> +
>  void pciehp_get_attention_status(struct slot *slot, u8 *status)
>  {
>  	struct controller *ctrl = slot->ctrl;
> @@ -431,6 +443,17 @@ int pciehp_query_power_fault(struct slot *slot)
>  	return !!(slot_status & PCI_EXP_SLTSTA_PFD);
>  }
>  
> +int pciehp_set_raw_attention_status(struct hotplug_slot *hotplug_slot,
> +								u8 status)
> +{
> +	struct slot *slot = hotplug_slot->private;
> +	struct controller *ctrl = slot->ctrl;
> +
> +	pcie_write_cmd_nowait(ctrl, status << 6,
> +			      PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC);
> +	return 0;
> +}
> +
>  void pciehp_set_attention_status(struct slot *slot, u8 value)
>  {
>  	struct controller *ctrl = slot->ctrl;
> @@ -804,6 +827,10 @@ struct controller *pcie_init(struct pcie_device *dev)
>  	}
>  	ctrl->pcie = dev;
>  	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
> +
> +	if (pdev->user_leds)
> +		slot_cap &= ~(PCI_EXP_SLTCAP_AIP | PCI_EXP_SLTCAP_PIP);
> +
>  	ctrl->slot_cap = slot_cap;
>  	mutex_init(&ctrl->ctrl_lock);
>  	init_waitqueue_head(&ctrl->queue);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 7256f33..f41bbca 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -308,6 +308,7 @@ struct pci_dev {
>  						   powered on/off by the
>  						   corresponding bridge */
>  	unsigned int	ignore_hotplug:1;	/* Ignore hotplug events */
> +	unsigned int	user_leds:1;		/* User excluse LED SlotCtl */
>  	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
>  	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
>  
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
