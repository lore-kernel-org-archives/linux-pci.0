Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:56605 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755106AbdAKTFo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Jan 2017 14:05:44 -0500
Date: Wed, 11 Jan 2017 11:04:42 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        ashok.raj@intel.com
Subject: Re: [PATCH] pciehp: Fix race condition handling surprise link-down
Message-ID: <20170111190442.GA74162@otc-nc-03>
References: <1481317564-18045-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481317564-18045-1-git-send-email-ashok.raj@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith

did you have a chance to look at this?

Cheers,
Ashok

On Fri, Dec 09, 2016 at 01:06:04PM -0800, Ashok Raj wrote:
> Changes from v1:
> 	Address comments from Bjorn:
> 		Added p_slot->lock mutex around changes to p_slot->state
> 		Updated commit message to call out mutex names
> 
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
> This patch fixes that by setting the p_slot->state only when the work to
> handle the power event is executing, protected by the p_slot->hotplug_lock.
> 
> To: Bjorn Helgass <bhelgaas@google.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Keith Busch <keith.busch@intel.com>
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Reviewed-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index ec0b4c1..4cf4772 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -182,6 +182,9 @@ static void pciehp_power_thread(struct work_struct *work)
>  	switch (info->req) {
>  	case DISABLE_REQ:
>  		mutex_lock(&p_slot->hotplug_lock);
> +		mutex_lock(&p_slot->lock);
> +		p_slot->state = POWEROFF_STATE;
> +		mutex_unlock(&p_slot->lock);
>  		pciehp_disable_slot(p_slot);
>  		mutex_unlock(&p_slot->hotplug_lock);
>  		mutex_lock(&p_slot->lock);
> @@ -190,6 +193,9 @@ static void pciehp_power_thread(struct work_struct *work)
>  		break;
>  	case ENABLE_REQ:
>  		mutex_lock(&p_slot->hotplug_lock);
> +		mutex_lock(&p_slot->lock);
> +		p_slot->state = POWERON_STATE;
> +		mutex_unlock(&p_slot->lock);
>  		ret = pciehp_enable_slot(p_slot);
>  		mutex_unlock(&p_slot->hotplug_lock);
>  		if (ret)
> @@ -209,8 +215,6 @@ static void pciehp_queue_power_work(struct slot *p_slot, int req)
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
