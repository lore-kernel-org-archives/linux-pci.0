Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752200AbdBCC7G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Feb 2017 21:59:06 -0500
Date: Thu, 2 Feb 2017 20:59:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] pciehp: Fix race condition handling surprise link-down
Message-ID: <20170203025901.GA15080@bhelgaas-glaptop.roam.corp.google.com>
References: <1481317564-18045-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481317564-18045-1-git-send-email-ashok.raj@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ashok,

Sorry it took me so long to review this.  I never felt like I really
understood it, and it took me a long time to try to figure out a more
useful response.

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

What I don't like about this patch is that I can't figure out what
we're fixing from the patch.  That's not your fault; it's just a
symptom of the convoluted logic in pciehp.  But if we can fix the
problem by simplifying that logic, I'd rather do that than patch up
the holes.

So let me first try to understand what's going on with the current
code.  In the normal case where a device is removed or turned off and
pciehp can complete everything before another device appears, I think
the flow is like this:

      p_slot->state == STATIC_STATE (powered on, link up)

                        <-- surprise link down interrupt
      pciehp_isr()
        queue INT_LINK_DOWN work

      interrupt_event_handler(INT_LINK_DOWN)
        set p_slot->state = POWEROFF_STATE
        queue DISABLE_REQ work

      pciehp_power_thread(DISABLE_REQ)
        send PCI_EXP_SLTCTL_PWR_OFF command
        wait for power-off to complete
        set p_slot->state = STATIC_STATE

      p_slot->state == STATIC_STATE (powered off)

In the problem case, the link goes down, and while pciehp is still
dealing with that, the link comes back up.  So I think one possible
sequence is like this:

      p_slot->state == STATIC_STATE (powered on, link up)

                        <-- surprise link down interrupt
  1a  pciehp_isr()
        queue INT_LINK_DOWN work                     # queued: 1-LD

  1b  interrupt_event_handler(INT_LINK_DOWN)         # process 1-LD
        # handle_link_event() sees case STATIC_STATE
        set p_slot->state = POWEROFF_STATE
        queue DISABLE_REQ work                       # queued: 1-DR

                        <-- surprise link up interrupt
  2a  pciehp_isr()
        queue INT_LINK_UP work                       # queued: 1-DR 2-LU

  1c  pciehp_power_thread(DISABLE_REQ)               # process 1-DR
        send PCI_EXP_SLTCTL_PWR_OFF command
        wait for power-off to complete
        set p_slot->state = STATIC_STATE

                        <-- link down interrupt (result of PWR_OFF)
  3a  pciehp_isr()
        queue INT_LINK_DOWN work                     # queued: 2-LU 3-LD

  2b  interrupt_event_handler(INT_LINK_UP)           # process 2-LU
        # handle_link_event() sees case STATIC_STATE
        set p_slot->state = POWERON_STATE
        queue ENABLE_REQ work                        # queued: 3-LD 2-ER

  3b  interrupt_event_handler(INT_LINK_DOWN)         # process 3-LD
        # handle_link_event() sees case POWERON_STATE, so we emit
        # "Link Down event queued; currently getting powered on"
        set p_slot->state = POWEROFF_STATE
        queue DISABLE_REQ work                       # queued: 2-ER 3-DR

  2c  pciehp_power_thread(ENABLE_REQ)                # process 2-ER
        send PCI_EXP_SLTCTL_PWR_ON command
        wait for power-on to complete
        set p_slot->state = STATIC_STATE

                        <-- link up interrupt (result of PWR_ON)
  4a  pciehp_isr()
        queue INT_LINK_UP work                       # queued: 3-DR 4-LU

  3c  pciehp_power_thread(DISABLE_REQ)               # process 3-DR
        send PCI_EXP_SLTCTL_PWR_OFF command
        wait for power-off to complete
        set p_slot->state = STATIC_STATE

                        <-- link down interrupt (result of PWR_OFF)
  5a  pciehp_isr()
        queue INT_LINK_DOWN work                     # queued: 4-LU 5-LD

State 5a is the same as 3a (we're in STATIC_STATE with Link Up and
Link Down work items queued), so the whole cycle can repeat.

Now let's assume we apply this patch and see what changes.  The patch
changes where we set p_slot->state.  Currently we set POWEROFF_STATE
or POWERON_STATE in the interrupt_event_handler() work item.  The
patch moves that to the pciehp_power_thread() work item, where the
power commands are actually sent.

      p_slot->state == STATIC_STATE (powered on, link up)

                        <-- surprise link down interrupt
  1A  pciehp_isr()
        queue INT_LINK_DOWN work                     # queued: 1-LD

  1B  interrupt_event_handler(INT_LINK_DOWN)         # process 1-LD
        # handle_link_event() sees case STATIC_STATE
        # set p_slot->state = POWEROFF_STATE         # (removed by patch)
        queue DISABLE_REQ work                       # queued: 1-DR

                        <-- surprise link up interrupt
  2A  pciehp_isr()
        queue INT_LINK_UP work                       # queued: 1-DR 2-LU

  1C  pciehp_power_thread(DISABLE_REQ)               # process 1-DR
        set p_slot->state = POWEROFF_STATE           # (added by patch)
        send PCI_EXP_SLTCTL_PWR_OFF command
        wait for power-off to complete
        set p_slot->state = STATIC_STATE

                        <-- link down interrupt (result of PWR_OFF)
  3A  pciehp_isr()
        queue INT_LINK_DOWN work                     # queued: 2-LU 3-LD

  2B  interrupt_event_handler(INT_LINK_UP)           # process 2-LU
        # handle_link_event() sees case STATIC_STATE
        # set p_slot->state = POWERON_STATE          # (removed by patch)
        queue ENABLE_REQ work                        # queued: 3-LD 2-ER

  3B  interrupt_event_handler(INT_LINK_DOWN)         # process 3-LD
        # handle_link_event() sees case STATIC_STATE,
        # unlike 3b above, which saw POWERON_STATE;
        # doesn't emit a message, but still queues DISABLE_REQ
        # set p_slot->state = POWEROFF_STATE         # (removed by patch)
        queue DISABLE_REQ work                       # queued: 2-ER 3-DR

  2C  pciehp_power_thread(ENABLE_REQ)                # process 2-ER
        set p_slot->state = POWERON_STATE            # (added by patch)
        send PCI_EXP_SLTCTL_PWR_ON command
        wait for power-on to complete
        set p_slot->state = STATIC_STATE

                        <-- link up interrupt (result of PWR_ON)
  4A  pciehp_isr()
        queue INT_LINK_UP work                       # queued: 3-DR 4-LU

  3C  pciehp_power_thread(DISABLE_REQ)               # process 3-DR
        set p_slot->state = POWEROFF_STATE           # (added by patch)
        send PCI_EXP_SLTCTL_PWR_OFF command
        wait for power-off to complete
        set p_slot->state = STATIC_STATE

                        <-- link down interrupt (result of PWR_OFF)
  5A  pciehp_isr()
        queue INT_LINK_DOWN work                     # queued: 4-LU 5-LD

With this particular ordering, I think we still have the same problem:
5A is the same as 3A, so I think the cycle could repeat.

Obviously many other orderings are possible.  Since the patch fixes
your system, I suspect you're seeing an ordering where at 3B,
handle_link_event() sees POWEROFF_STATE.  In that case, you probably
see the "Link Down event ignored" message, but we don't queue the
DISABLE_REQ work, and there is no cycle.

This all makes me a little bleary-eyed, so maybe I'm missing
something, but it looks to me like we could still hit the same problem
even with this patch.

I really think the only way to make this all intelligible and reliable
is to rework this to use ordered workqueues so we only have one thing
at a time going on.  That wouldn't be a panacea, but I think it would
make things a lot simpler.

Bjorn

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
