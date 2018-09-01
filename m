Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:60847 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeIATbA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Sep 2018 15:31:00 -0400
Date: Sat, 1 Sep 2018 17:18:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org
Subject: Re: [PATCH 12/16] PCI/pciehp: Fix powerfault detection order
Message-ID: <20180901151836.oceptz267wy33bes@wunner.de>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-13-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831212639.10196-13-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 31, 2018 at 03:26:35PM -0600, Keith Busch wrote:
> A device add in a power controller controlled slot will power on and
> clear power fault slot events, but this was happening before the interrupt
> handler attempted to set the sticky status and attention indicators. The
> wrong status will be set if a hot-add and power fault are handled in
> one interrupt. This patch fixes that by checking for power faults before
> checking for new devices.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

I think this should go in as a fix for v4.19, right?

Thanks for catching this, I missed it during my pciehp refactoring
because Thunderbolt doesn't have a power controller.

Actually I have further power controller related questions, maybe you
can help me out there:

* In pcie_enable_notification() there's a code comment:
  "TBD: Power fault detected software notification support"
  Is there really anything left to be done or can this code comment be
  deleted?  AFAICS, a power fault *is* detected and acted upon, then
  has to be cleared by the user, either through enablement via sysfs
  or by physically replacing the card.

* In pciehp_ist(), the if-condition to check for a power fault also
  checks for "&& !ctrl->power_fault_detected".  The check seems
  superfluous to me because pciehp_isr() clears the PCI_EXP_SLTSTA_PFD
  bit in the pending events if ctrl->power_fault_detected is true.
  Can the additional check be removed from the if-condition in
  pciehp_ist()?

* In pciehp_ist(), we call pciehp_green_led_off() if a power fault is
  detected.  However my (limited) understanding is that a power fault
  always results in a Link Down, and when bringing down the slot in
  response to that, we already call pciehp_green_led_off() in
  remove_board().  Can the call to pciehp_green_led_off() be removed
  from pciehp_ist()?  Or does the link not necessarily go down on a
  power fault and we should rather bring the slot down when a power
  fault is detected?  Is that the "TBD" mentioned in the code comment?
  Or is this just an intentional cosmetic behavior that we turn off
  the green LED as early as possible once we detect the slot is off?

Thanks,

Lukas

> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 7136e3430925..c6116e516e1e 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -646,6 +646,14 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  		pciehp_handle_button_press(slot);
>  	}
>  
> +	/* Check Power Fault Detected */
> +	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
> +		ctrl->power_fault_detected = 1;
> +		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(slot));
> +		pciehp_set_attention_status(slot, 1);
> +		pciehp_green_led_off(slot);
> +	}
> +
>  	/*
>  	 * Disable requests have higher priority than Presence Detect Changed
>  	 * or Data Link Layer State Changed events.
> @@ -657,14 +665,6 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  		pciehp_handle_presence_or_link_change(slot, events);
>  	up_read(&ctrl->reset_lock);
>  
> -	/* Check Power Fault Detected */
> -	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
> -		ctrl->power_fault_detected = 1;
> -		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(slot));
> -		pciehp_set_attention_status(slot, 1);
> -		pciehp_green_led_off(slot);
> -	}
> -
>  	pci_config_pm_runtime_put(pdev);
>  	wake_up(&ctrl->requester);
>  	return IRQ_HANDLED;
> -- 
> 2.14.4
> 
