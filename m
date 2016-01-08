Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 8 Jan 2016 10:18:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] PCI: pciehp: Merge hotplug work requests
Message-ID: <20160108161846.GA31005@localhost>
References: <1446522496-21628-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446522496-21628-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Guenter,

Sorry for the delay in getting to this.

On Mon, Nov 02, 2015 at 07:48:15PM -0800, Guenter Roeck wrote:
> Some oddball devices may experience a PCIe link flap after power-on.
> This may result in the following sequence of events.
> 
> fpc0 kernel: pciehp 0000:02:08.0:pcie24: Card present on Slot(0)
> fpc0 kernel: pciehp 0000:02:08.0:pcie24: slot(0): Link Up event
> fpc0 kernel: pciehp 0000:02:08.0:pcie24:
> 	Link Up event ignored on slot(0): already powering on
> fpc0 kernel: pciehp 0000:02:08.0:pcie24: slot(0): Link Down event
> fpc0 kernel: pciehp 0000:02:08.0:pcie24:
> 	Link Down event queued on slot(0): currently getting powered on
> fpc0 kernel: pciehp 0000:02:08.0:pcie24: slot(0): Link Up event
> fpc0 kernel: pciehp 0000:02:08.0:pcie24:
> 	Link Up event queued on slot(0): currently getting powered off
> 
> This causes the driver for affected devices to be instantiated, removed,
> and re-instantiated.
> 
> An even worse problem is a device which resets itself continuously.
> This can result in the following endless sequence of messages.
> 
> pciehp 0000:02:0a.0:pcie24: Card present on Slot(10)
> pciehp 0000:02:0a.0:pcie24: Card not present on Slot(10)
> pciehp 0000:02:0a.0:pcie24: Card present on Slot(10)
> pciehp 0000:02:0a.0:pcie24: Card not present on Slot(10)
> pciehp 0000:02:0a.0:pcie24: Card present on Slot(10)
> pciehp 0000:02:0a.0:pcie24: Card not present on Slot(10)
> 
> The problem in the both cases is that all events are enqueued as hotplug
> work requests and executed in sequence, which can overwhelm the system
> and even result in "hung task" tracebacks in pciehp_power_thread().
> 
> This exposes an underlying limitation of the hotplug state machine: It
> executes all received requests, even though only the most recent request
> really needs to be handled. As a result, by the time a request is handled,
> it may well be obsolete and have been superseded by many other enable /
> disable requests which have been enqueued in the meantime.
> 
> To solve the problem, fold hotplug work requests into a single request.
> Store the request as well as the work data structure in 'struct slot',
> thus eliminating the need to allocate memory for each request.
> Handle a sequence of requests by setting a 'disable' flag when needed,
> indicating that a link needs to be disabled prior to re-enabling it.
> 
> With this change, requests and request sequences are handled as follows.
> 
> enable (single request):		enable link
> disable (single request):		disable link
> ... disable-enable-disable...disable:	disable link
> ... disable-enable-disable...enable:	disable link, then enable it

I think this is a really good idea, but I would like to understand
what the critical points are and how they affect the state machine.

I think you're basically accounting for the fact that some hotplug
controller commands are not completed instantaneously, and we might
receive more interrupts before the first command is completed.  I
suspect that your patch only makes a difference on controllers that
support Command Completed events, right?

You're not adding any timeouts, so I *think* you must be effectively
collapsing any events that occur before a Command Completed interrupt.
If that's the case, we should probably handle other events and
commands similarly.  The LED controls probably aren't important, but
what about the Electromechanical Interlock control?  Should that be
handled the same way you're handling power control?

Right now it feels a little bit ad hoc, and it would be nice if we
could make it more explicit somehow.

Bjorn

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> This is a different approach to solve the problem I tried to address
> earlier with with "PCI: pciehp: Add support for delayed power-on" [1].
> 
> While the earlier patch implemented an additional state in the hotplug
> state machine to solve the problem, the approach taken here is a bit
> simpler and more straightfoward. By folding multiple requests into one,
> the follow-up patch can use delayed work to implement power-on delays.
> An additional advantage is that this patch can be applied separately
> to simplify the state machine.
> 
> While working on this patch, I also tried to drop multiple "disable"
> requests, and only disable a slot if it was already disabled, to reduce
> overhead. Unfortunately, this did not always work. In some instances,
> I ended up in a situation where a device could not be enabled
> because the system thought that it already existed. I don't know
> if this is a weakness in this patch or some state change I did not catch. 
> This may be left for further study.
> 
> [1] https://lkml.org/lkml/2015/10/12/686
> 
>  drivers/pci/hotplug/pciehp.h      |  4 +++
>  drivers/pci/hotplug/pciehp_ctrl.c | 52 ++++++++++++++++++---------------------
>  drivers/pci/hotplug/pciehp_hpc.c  |  1 +
>  3 files changed, 29 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 62d6fe6c3714..364b6fa32978 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -78,6 +78,9 @@ struct slot {
>  	struct mutex lock;
>  	struct mutex hotplug_lock;
>  	struct workqueue_struct *wq;
> +	struct work_struct hotplug_work;
> +	u32 hotplug_req;
> +	bool disable;			/* true to disable before enable */
>  };
>  
>  struct event_info {
> @@ -130,6 +133,7 @@ void pciehp_queue_interrupt_event(struct slot *slot, u32 event_type);
>  int pciehp_configure_device(struct slot *p_slot);
>  int pciehp_unconfigure_device(struct slot *p_slot);
>  void pciehp_queue_pushbutton_work(struct work_struct *work);
> +void pciehp_power_thread(struct work_struct *work);
>  struct controller *pcie_init(struct pcie_device *dev);
>  int pcie_init_notification(struct controller *ctrl);
>  int pciehp_enable_slot(struct slot *p_slot);
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 880978b6d534..ad1321e91546 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -156,13 +156,9 @@ static int remove_board(struct slot *p_slot)
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
> +/* Hotplug work requests */
> +#define DISABLE_REQ	0
> +#define ENABLE_REQ	1
>  
>  /**
>   * pciehp_power_thread - handle pushbutton events
> @@ -171,14 +167,19 @@ struct power_work_info {
>   * Scheduled procedure to handle blocking stuff for the pushbuttons.
>   * Handles all pending events and exits.
>   */
> -static void pciehp_power_thread(struct work_struct *work)
> +void pciehp_power_thread(struct work_struct *work)
>  {
> -	struct power_work_info *info =
> -		container_of(work, struct power_work_info, work);
> -	struct slot *p_slot = info->p_slot;
> -	int ret;
> +	struct slot *p_slot = container_of(work, struct slot, hotplug_work);
> +	int ret, req;
> +	bool disable;
> +
> +	mutex_lock(&p_slot->lock);
> +	req = p_slot->hotplug_req;
> +	disable = p_slot->disable;
> +	p_slot->disable = false;
> +	mutex_unlock(&p_slot->lock);
>  
> -	switch (info->req) {
> +	switch (req) {
>  	case DISABLE_REQ:
>  		mutex_lock(&p_slot->hotplug_lock);
>  		pciehp_disable_slot(p_slot);
> @@ -189,6 +190,8 @@ static void pciehp_power_thread(struct work_struct *work)
>  		break;
>  	case ENABLE_REQ:
>  		mutex_lock(&p_slot->hotplug_lock);
> +		if (disable)
> +			pciehp_disable_slot(p_slot);
>  		ret = pciehp_enable_slot(p_slot);
>  		mutex_unlock(&p_slot->hotplug_lock);
>  		if (ret)
> @@ -200,26 +203,19 @@ static void pciehp_power_thread(struct work_struct *work)
>  	default:
>  		break;
>  	}
> -
> -	kfree(info);
>  }
>  
>  static void pciehp_queue_power_work(struct slot *p_slot, int req)
>  {
> -	struct power_work_info *info;
> -
> -	p_slot->state = (req == ENABLE_REQ) ? POWERON_STATE : POWEROFF_STATE;
> -
> -	info = kmalloc(sizeof(*info), GFP_KERNEL);
> -	if (!info) {
> -		ctrl_err(p_slot->ctrl, "no memory to queue %s request\n",
> -			 (req == ENABLE_REQ) ? "poweron" : "poweroff");
> -		return;
> +	if (req == ENABLE_REQ) {
> +		p_slot->state = POWERON_STATE;
> +	} else {
> +		p_slot->state = POWEROFF_STATE;
> +		p_slot->disable = true;
>  	}
> -	info->p_slot = p_slot;
> -	INIT_WORK(&info->work, pciehp_power_thread);
> -	info->req = req;
> -	queue_work(p_slot->wq, &info->work);
> +	p_slot->hotplug_req = req;
> +
> +	queue_work(p_slot->wq, &p_slot->hotplug_work);
>  }
>  
>  void pciehp_queue_pushbutton_work(struct work_struct *work)
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 5c24e938042f..e4e6fcbe1e20 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -755,6 +755,7 @@ static int pcie_init_slot(struct controller *ctrl)
>  	mutex_init(&slot->lock);
>  	mutex_init(&slot->hotplug_lock);
>  	INIT_DELAYED_WORK(&slot->work, pciehp_queue_pushbutton_work);
> +	INIT_WORK(&slot->hotplug_work, pciehp_power_thread);
>  	ctrl->slot = slot;
>  	return 0;
>  abort:
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
