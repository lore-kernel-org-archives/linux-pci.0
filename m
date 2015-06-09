Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35376 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbbFIPuN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2015 11:50:13 -0400
Received: by iesa3 with SMTP id a3so17165272ies.2
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2015 08:50:13 -0700 (PDT)
Date: Tue, 9 Jun 2015 10:49:49 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	mstowe@redhat.com
Subject: Re: [PATCH] PCI: pciehp: Wait for hotplug command completion where
 necessary
Message-ID: <20150609154949.GA23119@google.com>
References: <20150608230833.18712.45528.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150608230833.18712.45528.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 08, 2015 at 05:10:50PM -0600, Alex Williamson wrote:
> The commit referenced below deferred waiting for command completion
> until the start of the next command, allowing hardware to do the
> latching asynchronously.  Unfortunately, being ready to accept a new
> command is the only indication we have that the previous command is
> completed.  In cases where we need that state change to be enabled, we
> must still wait for completion.  For instance, pciehp_reset_slot()
> attempts to disable anything that might generate a surprise hotplug on
> slots that support presence detection.  If we don't wait for those
> settings to latch before the secondary bus reset, we negate any value
> in attempting to prevent the spurious hotplug.
> 
> Create a base function with optional wait and helper functions so that
> pcie_write_cmd() turns back into the "safe" interface which waits
> before and after issuing a command and add pcie_write_cmd_nowait(),
> which eliminates the trailing wait for asynchronous completion.  The
> following functions are returned to their previous behavior:
> 
>  pciehp_power_on_slot
>  pciehp_power_off_slot
>  pcie_disable_notification
>  pciehp_reset_slot
> 
> The rationale is that pciehp_power_on_slot() enables the link and
> therefore relies on completion of power-on.  pciehp_power_off_slot()
> and pcie_disable_notification() need a wait because data structures
> may be freed after these calls and continued signaling from the device
> would be unexpected.  And, of course, pciehp_reset_slot() needs to
> wait for the scenario outlined above.
> 
> Fixes: 3461a068661c ("PCI: pciehp: Wait for hotplug command completion lazily")
> Cc: stable@vger.kernel.org # v3.17+
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/hotplug for v4.2, thanks!

> ---
>  drivers/pci/hotplug/pciehp_hpc.c |   52 ++++++++++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 0ebf754..6d68688 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -176,20 +176,17 @@ static void pcie_wait_cmd(struct controller *ctrl)
>  			  jiffies_to_msecs(jiffies - ctrl->cmd_started));
>  }
>  
> -/**
> - * pcie_write_cmd - Issue controller command
> - * @ctrl: controller to which the command is issued
> - * @cmd:  command value written to slot control register
> - * @mask: bitmask of slot control register to be modified
> - */
> -static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
> +static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
> +			      u16 mask, bool wait)
>  {
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	u16 slot_ctrl;
>  
>  	mutex_lock(&ctrl->ctrl_lock);
>  
> -	/* Wait for any previous command that might still be in progress */
> +	/*
> +	 * Always wait for any previous command that might still be in progress
> +	 */
>  	pcie_wait_cmd(ctrl);
>  
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
> @@ -201,9 +198,33 @@ static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
>  	ctrl->cmd_started = jiffies;
>  	ctrl->slot_ctrl = slot_ctrl;
>  
> +	/*
> +	 * Optionally wait for the hardware to be ready for a new command,
> +	 * indicating completion of the above issued command.
> +	 */
> +	if (wait)
> +		pcie_wait_cmd(ctrl);
> +
>  	mutex_unlock(&ctrl->ctrl_lock);
>  }
>  
> +/**
> + * pcie_write_cmd - Issue controller command
> + * @ctrl: controller to which the command is issued
> + * @cmd:  command value written to slot control register
> + * @mask: bitmask of slot control register to be modified
> + */
> +static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
> +{
> +	pcie_do_write_cmd(ctrl, cmd, mask, true);
> +}
> +
> +/* Same as above without waiting for the hardware to latch */
> +static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
> +{
> +	pcie_do_write_cmd(ctrl, cmd, mask, false);
> +}
> +
>  bool pciehp_check_link_active(struct controller *ctrl)
>  {
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
> @@ -422,7 +443,7 @@ void pciehp_set_attention_status(struct slot *slot, u8 value)
>  	default:
>  		return;
>  	}
> -	pcie_write_cmd(ctrl, slot_cmd, PCI_EXP_SLTCTL_AIC);
> +	pcie_write_cmd_nowait(ctrl, slot_cmd, PCI_EXP_SLTCTL_AIC);
>  	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
>  		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
>  }
> @@ -434,7 +455,8 @@ void pciehp_green_led_on(struct slot *slot)
>  	if (!PWR_LED(ctrl))
>  		return;
>  
> -	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON, PCI_EXP_SLTCTL_PIC);
> +	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
> +			      PCI_EXP_SLTCTL_PIC);
>  	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
>  		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
>  		 PCI_EXP_SLTCTL_PWR_IND_ON);
> @@ -447,7 +469,8 @@ void pciehp_green_led_off(struct slot *slot)
>  	if (!PWR_LED(ctrl))
>  		return;
>  
> -	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF, PCI_EXP_SLTCTL_PIC);
> +	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
> +			      PCI_EXP_SLTCTL_PIC);
>  	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
>  		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
>  		 PCI_EXP_SLTCTL_PWR_IND_OFF);
> @@ -460,7 +483,8 @@ void pciehp_green_led_blink(struct slot *slot)
>  	if (!PWR_LED(ctrl))
>  		return;
>  
> -	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK, PCI_EXP_SLTCTL_PIC);
> +	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
> +			      PCI_EXP_SLTCTL_PIC);
>  	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
>  		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
>  		 PCI_EXP_SLTCTL_PWR_IND_BLINK);
> @@ -613,7 +637,7 @@ void pcie_enable_notification(struct controller *ctrl)
>  		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
>  		PCI_EXP_SLTCTL_DLLSCE);
>  
> -	pcie_write_cmd(ctrl, cmd, mask);
> +	pcie_write_cmd_nowait(ctrl, cmd, mask);
>  	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
>  		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
>  }
> @@ -664,7 +688,7 @@ int pciehp_reset_slot(struct slot *slot, int probe)
>  	pci_reset_bridge_secondary_bus(ctrl->pcie->port);
>  
>  	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
> -	pcie_write_cmd(ctrl, ctrl_mask, ctrl_mask);
> +	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
>  	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
>  		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
>  	if (pciehp_poll_mode)
> 
