Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Thu, 22 Sep 2016 11:18:11 -0400
From: Keith Busch <keith.busch@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCHv2] PCI/Hotplug: Schedule device add retries
Message-ID: <20160922151811.GA14301@keith>
References: <1474485155-10822-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474485155-10822-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 21, 2016 at 01:12:35PM -0600, Jon Derrick wrote:
>  void pciehp_queue_interrupt_event(struct slot *p_slot, u32 event_type)
>  {
> @@ -121,9 +133,24 @@ static int board_added(struct slot *p_slot)
>  
>  	pciehp_green_led_on(p_slot);
>  	pciehp_set_attention_status(p_slot, 0);
> +	if (ctrl->slot_retries)
> +		ctrl_dbg(ctrl, "Device added at %04x:%02x:00 after retry %d/%d\n",
> +			 pci_domain_nr(parent), parent->number,
> +			 ctrl->slot_retries, DEVICE_ADD_RETRIES);
> +
>  	return 0;
>  
>  err_exit:
> +	if (ctrl->slot_retries++ < DEVICE_ADD_RETRIES) {
> +		ctrl_dbg(ctrl, "Retrying (%d/%d) device add at %04x:%02x:00\n",
> +			ctrl->slot_retries, DEVICE_ADD_RETRIES,
> +			pci_domain_nr(parent), parent->number);
> +		pciehp_queue_power_work(p_slot, ENABLE_RETRY_REQ);
> +		return retval;
> +	}

Does the retry need to be requeued instead of just doing this in a loop?
