Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750933AbdGLWmF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jul 2017 18:42:05 -0400
Date: Wed, 12 Jul 2017 17:42:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sadashiva Rao Pv <sadashiva.rao.pv@intel.com>,
        Naresh Solanki <naresh.solanki@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI / PM: Fix native PME handling during system
 suspend/resume
Message-ID: <20170712224202.GA4020@bhelgaas-glaptop.roam.corp.google.com>
References: <3705400.FL23FbEzsj@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3705400.FL23FbEzsj@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 06, 2017 at 02:32:02AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 76cde7e49590 (PCI / PM: Make PCIe PME interrupts wake up from
> suspend-to-idle) went too far with preventing pcie_pme_work_fn() from
> clearing the root port's PME Status and re-enabling the PME interrupt
> which should be done for PMEs to work correctly after system resume.
> 
> The failing scenario is as follows:
> 
>  1. pcie_pme_suspend() finds that the PME IRQ should be designated
>     for system wakeup, so it calls enable_irq_wake() and then sets
>     data->suspend_level to PME_SUSPEND_WAKEUP.
> 
>  2. PME interrupt happens at this point.
> 
>  3. pcie_pme_irq() runs, disables the PME interrupt and queues up
>     the execution of pcie_pme_work_fn().
> 
>  4. pcie_pme_work_fn() runs before pcie_pme_resume() and breaks out
>     of the loop right away, because data->suspend_level is not 
>     PME_SUSPEND_NONE, and it doesn't re-enable the PME interrupt
>     for the same reason.
> 
>  5. pcie_pme_resume() runs and simply calls disable_irq_wake()
>     without re-enabling the PME interrupt (because data->suspend_level
>     is not PME_SUSPEND_NONE), so the PME interrupt remains disabled
>     and the PME Status remains set.
> 
> To fix this notice that there is no reason why pcie_pme_work_fn()
> should behave in a special way during system resume if the PME
> interrupt is not disabled by pcie_pme_suspend() and partially revert
> commit 76cde7e49590 and restore the previous (and correct) behavior
> of pcie_pme_work_fn().
> 
> Fixes: 76cde7e49590 (PCI / PM: Make PCIe PME interrupts wake up from suspend-to-idle)
> Reported-by: Naresh Solanki <naresh.solanki@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume you'll apply this; let me know if you need anything else from me.

> ---
>  drivers/pci/pcie/pme.c |   35 +++++++++++++----------------------
>  1 file changed, 13 insertions(+), 22 deletions(-)
> 
> Index: linux-pm/drivers/pci/pcie/pme.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pcie/pme.c
> +++ linux-pm/drivers/pci/pcie/pme.c
> @@ -40,17 +40,11 @@ static int __init pcie_pme_setup(char *s
>  }
>  __setup("pcie_pme=", pcie_pme_setup);
>  
> -enum pme_suspend_level {
> -	PME_SUSPEND_NONE = 0,
> -	PME_SUSPEND_WAKEUP,
> -	PME_SUSPEND_NOIRQ,
> -};
> -
>  struct pcie_pme_service_data {
>  	spinlock_t lock;
>  	struct pcie_device *srv;
>  	struct work_struct work;
> -	enum pme_suspend_level suspend_level;
> +	bool noirq; /* If set, keep the PME interrupt disabled. */
>  };
>  
>  /**
> @@ -228,7 +222,7 @@ static void pcie_pme_work_fn(struct work
>  	spin_lock_irq(&data->lock);
>  
>  	for (;;) {
> -		if (data->suspend_level != PME_SUSPEND_NONE)
> +		if (data->noirq)
>  			break;
>  
>  		pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
> @@ -255,7 +249,7 @@ static void pcie_pme_work_fn(struct work
>  		spin_lock_irq(&data->lock);
>  	}
>  
> -	if (data->suspend_level == PME_SUSPEND_NONE)
> +	if (!data->noirq)
>  		pcie_pme_interrupt_enable(port, true);
>  
>  	spin_unlock_irq(&data->lock);
> @@ -378,7 +372,7 @@ static int pcie_pme_suspend(struct pcie_
>  {
>  	struct pcie_pme_service_data *data = get_service_data(srv);
>  	struct pci_dev *port = srv->port;
> -	bool wakeup, wake_irq_enabled = false;
> +	bool wakeup;
>  	int ret;
>  
>  	if (device_may_wakeup(&port->dev)) {
> @@ -388,19 +382,16 @@ static int pcie_pme_suspend(struct pcie_
>  		wakeup = pcie_pme_check_wakeup(port->subordinate);
>  		up_read(&pci_bus_sem);
>  	}
> -	spin_lock_irq(&data->lock);
>  	if (wakeup) {
>  		ret = enable_irq_wake(srv->irq);
> -		if (ret == 0) {
> -			data->suspend_level = PME_SUSPEND_WAKEUP;
> -			wake_irq_enabled = true;
> -		}
> -	}
> -	if (!wake_irq_enabled) {
> -		pcie_pme_interrupt_enable(port, false);
> -		pcie_clear_root_pme_status(port);
> -		data->suspend_level = PME_SUSPEND_NOIRQ;
> +		if (!ret)
> +			return 0;
>  	}
> +
> +	spin_lock_irq(&data->lock);
> +	pcie_pme_interrupt_enable(port, false);
> +	pcie_clear_root_pme_status(port);
> +	data->noirq = true;
>  	spin_unlock_irq(&data->lock);
>  
>  	synchronize_irq(srv->irq);
> @@ -417,15 +408,15 @@ static int pcie_pme_resume(struct pcie_d
>  	struct pcie_pme_service_data *data = get_service_data(srv);
>  
>  	spin_lock_irq(&data->lock);
> -	if (data->suspend_level == PME_SUSPEND_NOIRQ) {
> +	if (data->noirq) {
>  		struct pci_dev *port = srv->port;
>  
>  		pcie_clear_root_pme_status(port);
>  		pcie_pme_interrupt_enable(port, true);
> +		data->noirq = false;
>  	} else {
>  		disable_irq_wake(srv->irq);
>  	}
> -	data->suspend_level = PME_SUSPEND_NONE;
>  	spin_unlock_irq(&data->lock);
>  
>  	return 0;
> 
