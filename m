Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:3979 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933130AbeFUL60 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jun 2018 07:58:26 -0400
Date: Thu, 21 Jun 2018 14:58:19 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 17/32] PCI: pciehp: Enable/disable exclusively from IRQ
 thread
Message-ID: <20180621115819.GX2558@lahna.fi.intel.com>
References: <cover.1529173804.git.lukas@wunner.de>
 <ad8ef05242c00ce95aae64ca983cb3152cc8eb70.1529173804.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ad8ef05242c00ce95aae64ca983cb3152cc8eb70.1529173804.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> @@ -240,13 +240,19 @@ static int pciehp_probe(struct pcie_device *dev)
>  	}
>  
>  	/* Check if slot is occupied */
> +	mutex_lock(&slot->lock);
>  	pciehp_get_adapter_status(slot, &occupied);
>  	pciehp_get_power_status(slot, &poweron);
> -	if (occupied && pciehp_force)
> -		pciehp_enable_slot(slot);
> +	if (pciehp_force &&
> +	    ((occupied && (slot->state == OFF_STATE ||
> +			   slot->state == BLINKINGON_STATE)) ||
> +	     (!occupied && (slot->state == ON_STATE ||
> +			    slot->state == BLINKINGOFF_STATE))))
> +		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);

This...

>  	/* If empty slot's power status is on, turn power off */
>  	if (!occupied && poweron && POWER_CTRL(ctrl))
>  		pciehp_power_off_slot(slot);
> +	mutex_unlock(&slot->lock);
>  
>  	return 0;
>  
> @@ -290,10 +296,14 @@ static int pciehp_resume(struct pcie_device *dev)
>  
>  	/* Check if slot is occupied */
>  	pciehp_get_adapter_status(slot, &status);
> -	if (status)
> -		pciehp_enable_slot(slot);
> -	else
> -		pciehp_disable_slot(slot);
> +	mutex_lock(&slot->lock);
> +	if ((status && (slot->state == OFF_STATE ||
> +			slot->state == BLINKINGON_STATE)) ||
> +	    (!status && (slot->state == ON_STATE ||
> +			 slot->state == BLINKINGOFF_STATE)))
> +		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);

... and this look the same (I think there are other places as well).
Perhaps you could factor this to a helper function?


> +	mutex_unlock(&slot->lock);
> +
>  	return 0;
>  }
>  #endif /* PM */
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 627e846df802..70bad847a450 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -122,22 +122,26 @@ static void remove_board(struct slot *p_slot)
>  	pciehp_green_led_off(p_slot);
>  }
>  
> +void pciehp_request(struct controller *ctrl, int action)
> +{
> +	atomic_or(action, &ctrl->pending_events);
> +	if (!pciehp_poll_mode)
> +		irq_wake_thread(ctrl->pcie->irq, ctrl);
> +}
> +
>  void pciehp_queue_pushbutton_work(struct work_struct *work)
>  {
>  	struct slot *p_slot = container_of(work, struct slot, work.work);
> +	struct controller *ctrl = p_slot->ctrl;
>  
>  	mutex_lock(&p_slot->lock);
>  	switch (p_slot->state) {
>  	case BLINKINGOFF_STATE:
> -		p_slot->state = POWEROFF_STATE;
> -		mutex_unlock(&p_slot->lock);
> -		pciehp_disable_slot(p_slot);
> -		return;
> +		pciehp_request(ctrl, DISABLE_SLOT);
> +		break;
>  	case BLINKINGON_STATE:
> -		p_slot->state = POWERON_STATE;
> -		mutex_unlock(&p_slot->lock);
> -		pciehp_enable_slot(p_slot);
> -		return;
> +		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -186,16 +190,6 @@ void pciehp_handle_button_press(struct slot *p_slot)
>  		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
>  			  slot_name(p_slot));
>  		break;
> -	case POWEROFF_STATE:
> -	case POWERON_STATE:
> -		/*
> -		 * Ignore if the slot is on power-on or power-off state;
> -		 * this means that the previous attention button action
> -		 * to hot-add or hot-remove is undergoing
> -		 */
> -		ctrl_info(ctrl, "Slot(%s): Button ignored\n",
> -			  slot_name(p_slot));
> -		break;
>  	default:
>  		ctrl_err(ctrl, "Slot(%s): Ignoring invalid state %#x\n",
>  			 slot_name(p_slot), p_slot->state);
> @@ -204,6 +198,22 @@ void pciehp_handle_button_press(struct slot *p_slot)
>  	mutex_unlock(&p_slot->lock);
>  }
>  
> +void pciehp_handle_disable_request(struct slot *slot)
> +{
> +	struct controller *ctrl = slot->ctrl;
> +
> +	mutex_lock(&slot->lock);
> +	switch (slot->state) {
> +	case BLINKINGON_STATE:
> +	case BLINKINGOFF_STATE:
> +		cancel_delayed_work(&slot->work);

Missing break here (even though it does nothing) but if someone extends
this in future it may cause problems.

> +	}
> +	slot->state = POWEROFF_STATE;
> +	mutex_unlock(&slot->lock);
> +
> +	ctrl->request_result = pciehp_disable_slot(slot);
> +}
> +
>  void pciehp_handle_link_change(struct slot *p_slot)
>  {
>  	struct controller *ctrl = p_slot->ctrl;
> @@ -232,32 +242,6 @@ void pciehp_handle_link_change(struct slot *p_slot)
>  		}
>  		return;
>  		break;
> -	case POWERON_STATE:
> -		if (link_active) {
> -			ctrl_info(ctrl, "Slot(%s): Link Up event ignored; already powering on\n",
> -				  slot_name(p_slot));
> -		} else {
> -			p_slot->state = POWEROFF_STATE;
> -			mutex_unlock(&p_slot->lock);
> -			ctrl_info(ctrl, "Slot(%s): Link Down event queued; currently getting powered on\n",
> -				  slot_name(p_slot));
> -			pciehp_disable_slot(p_slot);
> -			return;
> -		}
> -		break;
> -	case POWEROFF_STATE:
> -		if (link_active) {
> -			p_slot->state = POWERON_STATE;
> -			mutex_unlock(&p_slot->lock);
> -			ctrl_info(ctrl, "Slot(%s): Link Up event queued; currently getting powered off\n",
> -				  slot_name(p_slot));
> -			pciehp_enable_slot(p_slot);
> -			return;
> -		} else {
> -			ctrl_info(ctrl, "Slot(%s): Link Down event ignored; already powering off\n",
> -				  slot_name(p_slot));
> -		}
> -		break;
>  	default:
>  		ctrl_err(ctrl, "Slot(%s): Ignoring invalid state %#x\n",
>  			 slot_name(p_slot), p_slot->state);
> @@ -272,6 +256,12 @@ void pciehp_handle_presence_change(struct slot *slot)
>  	u8 present;
>  
>  	mutex_lock(&slot->lock);
> +	switch (slot->state) {
> +	case BLINKINGON_STATE:
> +	case BLINKINGOFF_STATE:
> +		cancel_delayed_work(&slot->work);

Ditto.
