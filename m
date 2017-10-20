Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751070AbdJTUPM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Oct 2017 16:15:12 -0400
Date: Fri, 20 Oct 2017 15:15:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Quentin Lambert <lambert.quentin@gmail.com>,
        Aleksandr Bezzubikov <zuban32s@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Marcel Apfelbaum <marcel@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI Hotplug: Convert timers to use timer_setup()
Message-ID: <20171020201508.GP6332@bhelgaas-glaptop.roam.corp.google.com>
References: <20171016231802.GA100237@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171016231802.GA100237@beast>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 16, 2017 at 04:18:02PM -0700, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly. This has the result of fixing
> pushbutton_helper_thread which was truncating the event pointer to 32 bits.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Cc: Quentin Lambert <lambert.quentin@gmail.com>
> Cc: Aleksandr Bezzubikov <zuban32s@gmail.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to pci/hotplug for v4.15, thanks!

I did split this into two parts (cpqphp and shpchp) so it matches the
previous pciehp one.

> ---
>  drivers/pci/hotplug/cpqphp.h      |  2 +-
>  drivers/pci/hotplug/cpqphp_core.c |  3 +--
>  drivers/pci/hotplug/cpqphp_ctrl.c | 19 ++++++++++---------
>  drivers/pci/hotplug/shpchp_hpc.c  |  9 +++------
>  4 files changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpqphp.h b/drivers/pci/hotplug/cpqphp.h
> index 48c8a066a6b7..c2bbe6b65d06 100644
> --- a/drivers/pci/hotplug/cpqphp.h
> +++ b/drivers/pci/hotplug/cpqphp.h
> @@ -410,7 +410,7 @@ void cpqhp_create_debugfs_files(struct controller *ctrl);
>  void cpqhp_remove_debugfs_files(struct controller *ctrl);
>  
>  /* controller functions */
> -void cpqhp_pushbutton_thread(unsigned long event_pointer);
> +void cpqhp_pushbutton_thread(struct timer_list *t);
>  irqreturn_t cpqhp_ctrl_intr(int IRQ, void *data);
>  int cpqhp_find_available_resources(struct controller *ctrl,
>  				   void __iomem *rom_start);
> diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
> index 4d06b8461255..70967ac75265 100644
> --- a/drivers/pci/hotplug/cpqphp_core.c
> +++ b/drivers/pci/hotplug/cpqphp_core.c
> @@ -661,9 +661,8 @@ static int ctrl_slot_setup(struct controller *ctrl,
>  
>  		slot->p_sm_slot = slot_entry;
>  
> -		init_timer(&slot->task_event);
> +		timer_setup(&slot->task_event, cpqhp_pushbutton_thread, 0);
>  		slot->task_event.expires = jiffies + 5 * HZ;
> -		slot->task_event.function = cpqhp_pushbutton_thread;
>  
>  		/*FIXME: these capabilities aren't used but if they are
>  		 *	 they need to be correctly implemented
> diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
> index a55653b54eed..a93069e739cb 100644
> --- a/drivers/pci/hotplug/cpqphp_ctrl.c
> +++ b/drivers/pci/hotplug/cpqphp_ctrl.c
> @@ -47,7 +47,7 @@ static void interrupt_event_handler(struct controller *ctrl);
>  
>  
>  static struct task_struct *cpqhp_event_thread;
> -static unsigned long pushbutton_pending;	/* = 0 */
> +static struct timer_list *pushbutton_pending;	/* = NULL */
>  
>  /* delay is in jiffies to wait for */
>  static void long_delay(int delay)
> @@ -1732,9 +1732,10 @@ static u32 remove_board(struct pci_func *func, u32 replace_flag, struct controll
>  	return 0;
>  }
>  
> -static void pushbutton_helper_thread(unsigned long data)
> +static void pushbutton_helper_thread(struct timer_list *t)
>  {
> -	pushbutton_pending = data;
> +	pushbutton_pending = t;
> +
>  	wake_up_process(cpqhp_event_thread);
>  }
>  
> @@ -1883,13 +1884,13 @@ static void interrupt_event_handler(struct controller *ctrl)
>  					wait_for_ctrl_irq(ctrl);
>  
>  					mutex_unlock(&ctrl->crit_sect);
> -					init_timer(&p_slot->task_event);
> +					timer_setup(&p_slot->task_event,
> +						    pushbutton_helper_thread,
> +						    0);
>  					p_slot->hp_slot = hp_slot;
>  					p_slot->ctrl = ctrl;
>  /*					p_slot->physical_slot = physical_slot; */
>  					p_slot->task_event.expires = jiffies + 5 * HZ;   /* 5 second delay */
> -					p_slot->task_event.function = pushbutton_helper_thread;
> -					p_slot->task_event.data = (u32) p_slot;
>  
>  					dbg("add_timer p_slot = %p\n", p_slot);
>  					add_timer(&p_slot->task_event);
> @@ -1920,15 +1921,15 @@ static void interrupt_event_handler(struct controller *ctrl)
>   * Scheduled procedure to handle blocking stuff for the pushbuttons.
>   * Handles all pending events and exits.
>   */
> -void cpqhp_pushbutton_thread(unsigned long slot)
> +void cpqhp_pushbutton_thread(struct timer_list *t)
>  {
>  	u8 hp_slot;
>  	u8 device;
>  	struct pci_func *func;
> -	struct slot *p_slot = (struct slot *) slot;
> +	struct slot *p_slot = from_timer(p_slot, t, task_event);
>  	struct controller *ctrl = (struct controller *) p_slot->ctrl;
>  
> -	pushbutton_pending = 0;
> +	pushbutton_pending = NULL;
>  	hp_slot = p_slot->hp_slot;
>  
>  	device = p_slot->device;
> diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
> index e5824c7b7b6b..4810e9626d9f 100644
> --- a/drivers/pci/hotplug/shpchp_hpc.c
> +++ b/drivers/pci/hotplug/shpchp_hpc.c
> @@ -229,14 +229,13 @@ static inline int shpc_indirect_read(struct controller *ctrl, int index,
>  /*
>   * This is the interrupt polling timeout function.
>   */
> -static void int_poll_timeout(unsigned long data)
> +static void int_poll_timeout(struct timer_list *t)
>  {
> -	struct controller *ctrl = (struct controller *)data;
> +	struct controller *ctrl = from_timer(ctrl, t, poll_timer);
>  
>  	/* Poll for interrupt events.  regs == NULL => polling */
>  	shpc_isr(0, ctrl);
>  
> -	init_timer(&ctrl->poll_timer);
>  	if (!shpchp_poll_time)
>  		shpchp_poll_time = 2; /* default polling interval is 2 sec */
>  
> @@ -252,8 +251,6 @@ static void start_int_poll_timer(struct controller *ctrl, int sec)
>  	if ((sec <= 0) || (sec > 60))
>  		sec = 2;
>  
> -	ctrl->poll_timer.function = &int_poll_timeout;
> -	ctrl->poll_timer.data = (unsigned long)ctrl;
>  	ctrl->poll_timer.expires = jiffies + sec * HZ;
>  	add_timer(&ctrl->poll_timer);
>  }
> @@ -1054,7 +1051,7 @@ int shpc_init(struct controller *ctrl, struct pci_dev *pdev)
>  
>  	if (shpchp_poll_mode) {
>  		/* Install interrupt polling timer. Start with 10 sec delay */
> -		init_timer(&ctrl->poll_timer);
> +		timer_setup(&ctrl->poll_timer, int_poll_timeout, 0);
>  		start_int_poll_timer(ctrl, 10);
>  	} else {
>  		/* Installs the interrupt handler */
> -- 
> 2.7.4
> 
> 
> -- 
> Kees Cook
> Pixel Security
