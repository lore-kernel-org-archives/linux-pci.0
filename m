Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755504AbdDRTo3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Apr 2017 15:44:29 -0400
Date: Tue, 18 Apr 2017 14:44:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [patch 17/20] PCI: Use cpu_hotplug_disable() instead of
 get_online_cpus()
Message-ID: <20170418194425.GH25295@bhelgaas-glaptop.roam.corp.google.com>
References: <20170415170107.643253702@linutronix.de>
 <20170415171652.675049942@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170415171652.675049942@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 15, 2017 at 07:01:24PM +0200, Thomas Gleixner wrote:
> Converting the hotplug locking, i.e. get_online_cpus(), to a percpu rwsem
> unearthed a circular lock dependency which was hidden from lockdep due to
> the lockdep annotation of get_online_cpus() which prevents lockdep from
> creating full dependency chains. There are several variants of this. And
> example is:
> 
> Chain exists of:
> 
> cpu_hotplug_lock.rw_sem --> drm_global_mutex --> &item->mutex
> 
> CPU0                    CPU1
> ----                    ----
> lock(&item->mutex);
>                         lock(drm_global_mutex);
>                         lock(&item->mutex);
> lock(cpu_hotplug_lock.rw_sem);
> 
> because there are dependencies through workqueues. The call chain is:
> 
> 	get_online_cpus
> 	apply_workqueue_attrs
> 	__alloc_workqueue_key
> 	ttm_mem_global_init
> 	ast_ttm_mem_global_init
> 	drm_global_item_ref
> 	ast_mm_init
> 	ast_driver_load
> 	drm_dev_register
> 	drm_get_pci_dev
> 	ast_pci_probe
> 	local_pci_probe
> 	work_for_cpu_fn
> 	process_one_work
> 	worker_thread
> 
> This is not a problem of get_online_cpus() recursion, it's a possible
> deadlock undetected by lockdep so far.
> 
> The cure is to use cpu_hotplug_disable() instead of get_online_cpus() to
> protect the PCI probing.
> 
> There is a side effect to this: cpu_hotplug_disable() makes a concurrent
> cpu hotplug attempt via the sysfs interfaces fail with -EBUSY, but PCI
> probing usually happens during the boot process where no interaction is
> possible. Any later invocations are infrequent enough and concurrent
> hotplug attempts are so unlikely that the danger of user space visible
> regressions is very close to zero. Anyway, thats preferrable over a real
> deadlock.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/pci-driver.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -320,10 +320,19 @@ static long local_pci_probe(void *_ddi)
>  	return 0;
>  }
>  
> +static bool pci_physfn_is_probed(struct pci_dev *dev)
> +{
> +#ifdef CONFIG_ATS

I think this was intended to be CONFIG_PCI_ATS, not CONFIG_ATS.

But I think CONFIG_PCI_IOV would be more appropriate.  With that, and
squashing this into the next patch,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I expect you'll merge this along with the rest of the series.  Let me
know if you need anything else from me.

> +	return dev->physfn->is_probed;
> +#else
> +	return false;
> +#endif
> +}
> +
>  static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  			  const struct pci_device_id *id)
>  {
> -	int error, node;
> +	int error, node, cpu;
>  	struct drv_dev_and_id ddi = { drv, dev, id };
>  
>  	/*
> @@ -349,13 +358,13 @@ static int pci_call_probe(struct pci_dri
>  	if (node >= 0 && node != numa_node_id()) {
>  		int cpu;
>  
> -		get_online_cpus();
> +		cpu_hotplug_disable();
>  		cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
>  		if (cpu < nr_cpu_ids)
>  			error = work_on_cpu(cpu, local_pci_probe, &ddi);
>  		else
>  			error = local_pci_probe(&ddi);
> -		put_online_cpus();
> +		cpu_hotplug_enable();
>  	} else
>  		error = local_pci_probe(&ddi);
>  
> 
> 
