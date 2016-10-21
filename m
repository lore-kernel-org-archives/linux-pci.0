Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754833AbcJUVWZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Oct 2016 17:22:25 -0400
Date: Fri, 21 Oct 2016 16:22:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: keith.busch@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCHv2] PCI/Hotplug: Schedule device add retries
Message-ID: <20161021212212.GG9007@localhost>
References: <1474485155-10822-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474485155-10822-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 21, 2016 at 01:12:35PM -0600, Jon Derrick wrote:
> If a device fails to be added after being hot inserted, it could be due
> to a power fault seen during the insertion or a failure to configure the
> new device. The devices are then removed from the tree and the slot
> disabled. Many times the devices are working as expected, but the slot
> could not tolerate the add without a power fault. A user then has to
> issue a sysfs rescan to re-add the slot and pick up the new devices.

Are we missing a delay somewhere that's required by the spec?  Is the
device out of spec somehow by causing a transient power fault?

If we're doing something wrong in pciehp, we should fix it, of course.
I'm a little uncomfortable with the "it didn't work, let's try the
same thing again" style.  It seems like that might cover up software
issues or encourage sloppy hardware.

If we do add retries, it seems like we should add a fixed delay in
between, so the overall retry time doesn't completely depend on the
speed of the hardware we're on.

> This patch detects the failure during slot enabling and attempts to
> re-enable the slot a few more times before failing the slot. This fixes
> an issue where a power fault is seen during hot insertion, but the slot
> itself just needed some time for the power faults to quiesce before the
> device was ready to be used.

Reading PCIe r3.0, sec 6.7.1.8, it sounds like the hardware is
supposed to automatically remove main power when it "sets its internal
main power fault latch."  I don't know if that is specifically
referring to the Power Fault Detected bit in Slot Status or not.

It goes on to say that "The main power fault latch is cleared when
software turns off power to the hot-plug slot."  I don't see where we
are turning power off, then back on; should we be doing that?

Another comment below...

> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
> Applies against helgaas/pci/hotplug
> 
> v1->v2: Consolidated the clearing of the retry count into the slot's
> disable and enable functions.
> 
>  drivers/pci/hotplug/pciehp.h      |  2 ++
>  drivers/pci/hotplug/pciehp_ctrl.c | 61 +++++++++++++++++++++++++++++++--------
>  2 files changed, 51 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index e764918..55abbc5 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -93,6 +93,7 @@ struct controller {
>  	wait_queue_head_t queue;	/* sleep & wake process */
>  	u32 slot_cap;
>  	u16 slot_ctrl;
> +	u8 slot_retries;
>  	struct timer_list poll_timer;
>  	unsigned long cmd_started;	/* jiffies */
>  	unsigned int cmd_busy:1;
> @@ -133,6 +134,7 @@ void pciehp_queue_pushbutton_work(struct work_struct *work);
>  struct controller *pcie_init(struct pcie_device *dev);
>  int pcie_init_notification(struct controller *ctrl);
>  int pciehp_enable_slot(struct slot *p_slot);
> +int pciehp_enable_slot_retry(struct slot *p_slot);
>  int pciehp_disable_slot(struct slot *p_slot);
>  void pcie_enable_notification(struct controller *ctrl);
>  int pciehp_power_on_slot(struct slot *slot);
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index efe69e8..6470627 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -35,7 +35,19 @@
>  #include "../pci.h"
>  #include "pciehp.h"
>  
> +#define DEVICE_ADD_RETRIES 5
> +
>  static void interrupt_event_handler(struct work_struct *work);
> +static void pciehp_queue_power_work(struct slot *p_slot, int req);
> +
> +struct power_work_info {
> +       struct slot *p_slot;
> +       struct work_struct work;
> +       unsigned int req;
> +#define DISABLE_REQ 0
> +#define ENABLE_REQ 1
> +#define ENABLE_RETRY_REQ 2
> +};
>  
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

I think this retries on pciehp_check_link_status() and
pciehp_configure_device() failures as well as power faults.  It might
be worth retrying for power faults, but I do we want to for these
other errors as well?  I don't want to add duplicate messages and
useless retries if we can avoid it.

> +	ctrl_err(ctrl, "Failed to add device at %04x:%02x:00\n",
> +		 pci_domain_nr(parent), parent->number);
>  	set_slot_off(ctrl, p_slot);
>  	return retval;
>  }
> @@ -157,14 +184,6 @@ static int remove_board(struct slot *p_slot)
>  	return 0;
>  }
>  
> -struct power_work_info {
> -	struct slot *p_slot;
> -	struct work_struct work;
> -	unsigned int req;
> -#define DISABLE_REQ 0
> -#define ENABLE_REQ  1
> -};
> -
>  /**
>   * pciehp_power_thread - handle pushbutton events
>   * @work: &struct work_struct describing work to be done
> @@ -189,8 +208,13 @@ static void pciehp_power_thread(struct work_struct *work)
>  		mutex_unlock(&p_slot->lock);
>  		break;
>  	case ENABLE_REQ:
> +		/* fall through */
> +	case ENABLE_RETRY_REQ:
>  		mutex_lock(&p_slot->hotplug_lock);
> -		ret = pciehp_enable_slot(p_slot);
> +		if (info->req == ENABLE_RETRY_REQ)
> +			ret = pciehp_enable_slot_retry(p_slot);
> +		else
> +			ret = pciehp_enable_slot(p_slot);
>  		mutex_unlock(&p_slot->hotplug_lock);
>  		if (ret)
>  			pciehp_green_led_off(p_slot);
> @@ -208,13 +232,14 @@ static void pciehp_power_thread(struct work_struct *work)
>  static void pciehp_queue_power_work(struct slot *p_slot, int req)
>  {
>  	struct power_work_info *info;
> +	bool enabling = (req == ENABLE_REQ || req == ENABLE_RETRY_REQ);
>  
> -	p_slot->state = (req == ENABLE_REQ) ? POWERON_STATE : POWEROFF_STATE;
> +	p_slot->state = enabling ? POWERON_STATE : POWEROFF_STATE;
>  
>  	info = kmalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info) {
>  		ctrl_err(p_slot->ctrl, "no memory to queue %s request\n",
> -			 (req == ENABLE_REQ) ? "poweron" : "poweroff");
> +			 enabling ? "poweron" : "poweroff");
>  		return;
>  	}
>  	info->p_slot = p_slot;
> @@ -386,7 +411,7 @@ static void interrupt_event_handler(struct work_struct *work)
>  /*
>   * Note: This function must be called with slot->hotplug_lock held
>   */
> -int pciehp_enable_slot(struct slot *p_slot)
> +static int __pciehp_enable_slot(struct slot *p_slot)
>  {
>  	u8 getstatus = 0;
>  	struct controller *ctrl = p_slot->ctrl;
> @@ -417,6 +442,17 @@ int pciehp_enable_slot(struct slot *p_slot)
>  	return board_added(p_slot);
>  }
>  
> +int pciehp_enable_slot(struct slot *p_slot)
> +{
> +	p_slot->ctrl->slot_retries = 0;
> +	return __pciehp_enable_slot(p_slot);
> +}
> +
> +int pciehp_enable_slot_retry(struct slot *p_slot)
> +{
> +	return __pciehp_enable_slot(p_slot);
> +}
> +
>  /*
>   * Note: This function must be called with slot->hotplug_lock held
>   */
> @@ -428,6 +464,7 @@ int pciehp_disable_slot(struct slot *p_slot)
>  	if (!p_slot->ctrl)
>  		return 1;
>  
> +	ctrl->slot_retries = 0;
>  	if (POWER_CTRL(p_slot->ctrl)) {
>  		pciehp_get_power_status(p_slot, &getstatus);
>  		if (!getstatus) {
> -- 
> 1.8.3.1
> 
