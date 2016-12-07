Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933153AbcLGXlf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Dec 2016 18:41:35 -0500
Date: Wed, 7 Dec 2016 17:40:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] pciehp: Fix race condition handling surprise
 link-down
Message-ID: <20161207234054.GL22129@bhelgaas-glaptop.roam.corp.google.com>
References: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
 <1479544367-7195-4-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479544367-7195-4-git-send-email-ashok.raj@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Nov 19, 2016 at 12:32:47AM -0800, Ashok Raj wrote:
> A surprise link down may retrain very quickly, causing the same slot to
> generate a link up event before handling the link down completes.
> 
> Since the link is active, the power off work queued from the first link
> down will cause a second down event when the power is disabled. The second
> down event should be ignored because the slot is already powering off;
> however, the "link up" event sets the slot state to POWERON before the
> event to handle this is enqueued, making the second down event believe
> it needs to do something. This creates a constant link up and down
> event cycle.
> 
> This patch fixes that by setting the slot state only when the work to
> handle the power event is executing, protected by the hot plug mutex.

Please mention the mutex specifically by name, e.g.,
"p_slot->hotplug_lock".

> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Reviewed-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index ec0b4c1..7ae068c 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -182,6 +182,7 @@ static void pciehp_power_thread(struct work_struct *work)
>  	switch (info->req) {
>  	case DISABLE_REQ:
>  		mutex_lock(&p_slot->hotplug_lock);
> +		p_slot->state = POWEROFF_STATE;

It sounds right that p_slot->state should be protected.

It looks like handle_button_press_event() and
pciehp_sysfs_enable_slot() hold p_slot->lock while updating
p_slot->state.

You're setting "state = POWEROFF_STATE" while holding
p_slot->hotplug_lock (not p_slot->lock).  Four lines down, we set
"state = STATIC_STATE", but this time we're holding p_slot->lock.

What is the difference between the p_slot->lock and
p_slot->hotplug_lock?  Do we need both?  How do we know which one to
use?

I'm very confused.

>  		pciehp_disable_slot(p_slot);
>  		mutex_unlock(&p_slot->hotplug_lock);
>  		mutex_lock(&p_slot->lock);
> @@ -190,6 +191,7 @@ static void pciehp_power_thread(struct work_struct *work)
>  		break;
>  	case ENABLE_REQ:
>  		mutex_lock(&p_slot->hotplug_lock);
> +		p_slot->state = POWERON_STATE;
>  		ret = pciehp_enable_slot(p_slot);
>  		mutex_unlock(&p_slot->hotplug_lock);
>  		if (ret)
> @@ -209,8 +211,6 @@ static void pciehp_queue_power_work(struct slot *p_slot, int req)
>  {
>  	struct power_work_info *info;
>  
> -	p_slot->state = (req == ENABLE_REQ) ? POWERON_STATE : POWEROFF_STATE;
> -
>  	info = kmalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info) {
>  		ctrl_err(p_slot->ctrl, "no memory to queue %s request\n",
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
