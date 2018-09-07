Return-Path: <SRS0=wnmn=LV=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=wnmn=LV=intel.com=keith.busch@kernel.org>
Date: Fri, 7 Sep 2018 14:18:19 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Sinan Kaya <okaya@kernel.org>, Thomas Tai <thomas.tai@oracle.com>,
	poza@codeaurora.org, Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 15/20] PCI/pciehp: Fix powerfault detection order
Message-ID: <20180907201819.GA1341@localhost.localdomain>
References: <20180905203546.21921-1-keith.busch@intel.com>
 <20180905203546.21921-16-keith.busch@intel.com>
 <20180906193657.GH214747@bhelgaas-glaptop.roam.corp.google.com>
 <20180906195047.GD31024@localhost.localdomain>
 <20180907165352.GA250890@bhelgaas-glaptop.roam.corp.google.com>
 <20180907200332.GB250890@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907200332.GB250890@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 07, 2018 at 03:03:32PM -0500, Bjorn Helgaas wrote:
> I applied this to for-linus with the following changelog.  Let me know
> if I didn't understand this correctly.  I changed the comment in
> pciehp_power_on_slot() so it doesn't say "sticky" to avoid confusion
> with the PCI spec concept of sticky register bits (ROS, RWS, RW1CS).

Perfect! Thanks for queueing this up. I'll drop this one from the rest
of the series, which will need at least a v3 to fix a dumb mistake in
pointed out in review, and I'll get the order to better sense (or maybe
split into independent patch sets).
 
> commit 342227b42fe849eb2edac38342702aff12a5491d
> Author: Keith Busch <keith.busch@intel.com>
> Date:   Wed Sep 5 14:35:41 2018 -0600
> 
>     PCI: pciehp: Fix hot-add vs powerfault detection order
>     
>     If both hot-add and power fault were observed in a single interrupt, we
>     handled the hot-add first, then the power fault, in this path:
>     
>       pciehp_ist
>         if (events & (PDC | DLLSC))
>           pciehp_handle_presence_or_link_change
>             case OFF_STATE:
>               pciehp_enable_slot
>                 __pciehp_enable_slot
>                   board_added
>                     pciehp_power_on_slot
>                       ctrl->power_fault_detected = 0
>                       pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_ON, PCI_EXP_SLTCTL_PCC)
>                     pciehp_green_led_on(p_slot)             # power LED on
>                     pciehp_set_attention_status(p_slot, 0)  # attention LED off
>         if ((events & PFD) && !ctrl->power_fault_detected)
>           ctrl->power_fault_detected = 1
>           pciehp_set_attention_status(1)                    # attention LED on
>           pciehp_green_led_off(slot)                        # power LED off
>     
>     This left the attention indicator on (even though the hot-add succeeded)
>     and the power indicator off (even though the slot power was on).
>     
>     Fix this by checking for power faults before checking for new devices.
>     
>     Fixes: 0e94916e6091 ("PCI: pciehp: Handle events synchronously")
>     Signed-off-by: Keith Busch <keith.busch@intel.com>
>     [bhelgaas: changelog]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Lukas Wunner <lukas@wunner.de>
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 7136e3430925..a938abdb41ce 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -496,7 +496,7 @@ int pciehp_power_on_slot(struct slot *slot)
>  	u16 slot_status;
>  	int retval;
>  
> -	/* Clear sticky power-fault bit from previous power failures */
> +	/* Clear power-fault bit from previous power failures */
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
>  	if (slot_status & PCI_EXP_SLTSTA_PFD)
>  		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
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
