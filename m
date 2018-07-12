Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733114AbeGLWcv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Jul 2018 18:32:51 -0400
Date: Thu, 12 Jul 2018 17:21:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/32] genirq: Synchronize only with single thread on
 free_irq()
Message-ID: <20180712222109.GE28466@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1529173804.git.lukas@wunner.de>
 <83cfe0c826f1d793e2ead9032ef2109b5efa403a.1529173804.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <83cfe0c826f1d793e2ead9032ef2109b5efa403a.1529173804.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-kernel]

I assume this would need to be merged along with the rest of the
series, which should probably go through the PCI tree, but I'm
definitely not qualified to review this IRQ patch.  And it would need
an ack from Thomas in any case.

On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> When pciehp is converted to threaded IRQ handling, removal of unplugged
> devices below a PCIe hotplug port happens synchronously in the IRQ
> thread.  Removal of devices typically entails a call to free_irq() by
> their drivers.
> 
> If those devices share their IRQ with the hotplug port, free_irq()
> deadlocks because it calls synchronize_irq() to wait for all hard IRQ
> handlers as well as all threads sharing the IRQ to finish.
> 
> Actually it's sufficient to wait only for the IRQ thread of the removed
> device, so call synchronize_hardirq() to wait for all hard IRQ handlers
> to finish, but no longer for any threads.  Compensate by rearranging the
> control flow in irq_wait_for_interrupt() such that the device's thread
> is allowed to run one last time after kthread_stop() has been called.
> 
> Stack trace for posterity:
>     INFO: task irq/17-pciehp:94 blocked for more than 120 seconds.
>     schedule+0x28/0x80
>     synchronize_irq+0x6e/0xa0
>     __free_irq+0x15a/0x2b0
>     free_irq+0x33/0x70
>     pciehp_release_ctrl+0x98/0xb0
>     pcie_port_remove_service+0x2f/0x40
>     device_release_driver_internal+0x157/0x220
>     bus_remove_device+0xe2/0x150
>     device_del+0x124/0x340
>     device_unregister+0x16/0x60
>     remove_iter+0x1a/0x20
>     device_for_each_child+0x4b/0x90
>     pcie_port_device_remove+0x1e/0x30
>     pci_device_remove+0x36/0xb0
>     device_release_driver_internal+0x157/0x220
>     pci_stop_bus_device+0x7d/0xa0
>     pci_stop_bus_device+0x3d/0xa0
>     pci_stop_and_remove_bus_device+0xe/0x20
>     pciehp_unconfigure_device+0xb8/0x160
>     pciehp_disable_slot+0x84/0x130
>     pciehp_ist+0x158/0x190
>     irq_thread_fn+0x1b/0x50
>     irq_thread+0x143/0x1a0
>     kthread+0x111/0x130
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  kernel/irq/manage.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index daeabd791d58..0531f645bfea 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -790,9 +790,19 @@ static irqreturn_t irq_forced_secondary_handler(int irq, void *dev_id)
>  
>  static int irq_wait_for_interrupt(struct irqaction *action)
>  {
> -	set_current_state(TASK_INTERRUPTIBLE);
> +	for (;;) {
> +		set_current_state(TASK_INTERRUPTIBLE);
>  
> -	while (!kthread_should_stop()) {
> +		if (kthread_should_stop()) {
> +			/* may need to run one last time. */
> +			if (test_and_clear_bit(IRQTF_RUNTHREAD,
> +					       &action->thread_flags)) {
> +				__set_current_state(TASK_RUNNING);
> +				return 0;
> +			}
> +			__set_current_state(TASK_RUNNING);
> +			return -1;
> +		}
>  
>  		if (test_and_clear_bit(IRQTF_RUNTHREAD,
>  				       &action->thread_flags)) {
> @@ -800,10 +810,7 @@ static int irq_wait_for_interrupt(struct irqaction *action)
>  			return 0;
>  		}
>  		schedule();
> -		set_current_state(TASK_INTERRUPTIBLE);
>  	}
> -	__set_current_state(TASK_RUNNING);
> -	return -1;
>  }
>  
>  /*
> @@ -1024,7 +1031,7 @@ static int irq_thread(void *data)
>  	/*
>  	 * This is the regular exit path. __free_irq() is stopping the
>  	 * thread via kthread_stop() after calling
> -	 * synchronize_irq(). So neither IRQTF_RUNTHREAD nor the
> +	 * synchronize_hardirq(). So neither IRQTF_RUNTHREAD nor the
>  	 * oneshot mask bit can be set. We cannot verify that as we
>  	 * cannot touch the oneshot mask at this point anymore as
>  	 * __setup_irq() might have given out currents thread_mask
> @@ -1629,7 +1636,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
>  	unregister_handler_proc(irq, action);
>  
>  	/* Make sure it's not being used on another CPU: */
> -	synchronize_irq(irq);
> +	synchronize_hardirq(irq);
>  
>  #ifdef CONFIG_DEBUG_SHIRQ
>  	/*
> -- 
> 2.17.1
> 
