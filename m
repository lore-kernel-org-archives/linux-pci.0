Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750937AbeEKTAP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 May 2018 15:00:15 -0400
Date: Fri, 11 May 2018 14:00:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci/aer: Get rid of aer_recover_work_func() forward
 declaration
Message-ID: <20180511190013.GI190385@bhelgaas-glaptop.roam.corp.google.com>
References: <20180511163923.22116-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180511163923.22116-1-bp@alien8.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2018 at 06:39:23PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Just move the actual function up so that it is visible to its user
> aer_recover_queue().

Good idea.

Not *directly* related, but I'm really tired of the clutter of all these
separate files, and I'm thinking of squashing

  drivers/pci/pcie/aer/*       => drivers/pci/pcie/aer.c
  drivers/pci/pcie/portdrv*    => drivers/pci/pcie/portdrv.c
  drivers/pci/hotplug/pciehp*  => drivers/pci/hotplug/pciehp.c
  drivers/pci/hotplug/shpchp*  => drivers/pci/hotplug/shpchp.c
  etc.

That would let us make many more things static and (more importantly,
IMO), make it easier to browse the code.

> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  drivers/pci/pcie/aer/aerdrv_core.c | 45 +++++++++++++++---------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 0ea5acc40323..a9e575189571 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -567,8 +567,6 @@ static void handle_error_source(struct pcie_device *aerdev,
>  }
>  
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
> -static void aer_recover_work_func(struct work_struct *work);
> -
>  #define AER_RECOVER_RING_ORDER		4
>  #define AER_RECOVER_RING_SIZE		(1 << AER_RECOVER_RING_ORDER)
>  
> @@ -582,6 +580,28 @@ struct aer_recover_entry {
>  
>  static DEFINE_KFIFO(aer_recover_ring, struct aer_recover_entry,
>  		    AER_RECOVER_RING_SIZE);
> +
> +static void aer_recover_work_func(struct work_struct *work)
> +{
> +	struct aer_recover_entry entry;
> +	struct pci_dev *pdev;
> +
> +	while (kfifo_get(&aer_recover_ring, &entry)) {
> +		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
> +						   entry.devfn);
> +		if (!pdev) {
> +			pr_err("AER recover: Can not find pci_dev for %04x:%02x:%02x:%x\n",
> +			       entry.domain, entry.bus,
> +			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
> +			continue;
> +		}
> +		cper_print_aer(pdev, entry.severity, entry.regs);
> +		if (entry.severity != AER_CORRECTABLE)
> +			do_recovery(pdev, entry.severity);
> +		pci_dev_put(pdev);
> +	}
> +}
> +
>  /*
>   * Mutual exclusion for writers of aer_recover_ring, reader side don't
>   * need lock, because there is only one reader and lock is not needed
> @@ -611,27 +631,6 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  	spin_unlock_irqrestore(&aer_recover_ring_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(aer_recover_queue);
> -
> -static void aer_recover_work_func(struct work_struct *work)
> -{
> -	struct aer_recover_entry entry;
> -	struct pci_dev *pdev;
> -
> -	while (kfifo_get(&aer_recover_ring, &entry)) {
> -		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
> -						   entry.devfn);
> -		if (!pdev) {
> -			pr_err("AER recover: Can not find pci_dev for %04x:%02x:%02x:%x\n",
> -			       entry.domain, entry.bus,
> -			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
> -			continue;
> -		}
> -		cper_print_aer(pdev, entry.severity, entry.regs);
> -		if (entry.severity != AER_CORRECTABLE)
> -			do_recovery(pdev, entry.severity);
> -		pci_dev_put(pdev);
> -	}
> -}
>  #endif
>  
>  /**
> -- 
> 2.17.0.391.g1f1cddd558b5
> 
