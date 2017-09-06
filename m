Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753952AbdIFAEa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Sep 2017 20:04:30 -0400
Date: Tue, 5 Sep 2017 19:04:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org,
        gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH V2] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port service
 drivers
Message-ID: <20170906000427.GD14367@bhelgaas-glaptop.roam.corp.google.com>
References: <1504091375-116149-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504091375-116149-1-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 30, 2017 at 07:09:35PM +0800, Dongdong Liu wrote:
> Current code is broken as calling pci_free_irq_vectors()
> invalidates the IRQ numbers returned before by pci_irq_vectors();
> so we need to move all the assignment of the Linux IRQ numbers at
> the bottom of the function.
> 
> After removing and adding back the PCI root port device,
> we see the PCIe port service drivers request irq failed.

What exactly is the connection between the root port removal/addition
and the request IRQ failure?  The current code does:

  pci_alloc_irq_vectors(dev, ...)
  irqs[x] = pci_irq_vector(dev, entry)
  pci_free_irq_vectors(dev)
  pci_alloc_irq_vectors(dev, ...)

So I guess the problem is that the second pci_alloc_irq_vectors() call
gets different vectors than the first one?  How is this related to
removal/addition?  Is there some cleanup we're missing during the
removal?

> pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
> aer: probe of 0000:00:00.0:pcie002 failed with error -22
> pciehp 0000:00:00.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd-
> PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> pciehp 0000:00:00.0:pcie004: Cannot get irq 20 for the hotplug controller
> pciehp 0000:00:00.0:pcie004: Notification initialization failed (-1)
> dpc 0000:00:00.0:pcie010: request IRQ22 failed: -22
> dpc: probe of 0000:00:00.0:pcie010 failed with error -22
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 3674cc4 ("PCI/portdrv: Use pci_irq_alloc_vectors()")

Please use a 12-character SHA1.

> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
> v1->v2:
> - Fix comments on PATCH v1.
> - Simplify implementation.
> ---
>  drivers/pci/pcie/portdrv_core.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 313a21d..89f4cf5 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -55,7 +55,8 @@ static void release_pcie_device(struct device *dev)
>  static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  {
>  	int nr_entries, entry, nvec = 0;
> -
> +	int i;
> +	int idx[PCIE_PORT_DEVICE_MAXSERVICES];
>  	/*
>  	 * Allocate as many entries as the port wants, so that we can check
>  	 * which of them will be useful.  Moreover, if nr_entries is correctly

This is not so much a question about your patch, but about the whole
interrupt vector allocation strategy in pcie_port_enable_irq_vec().

The current code basically does this:

  - allocate 32 vectors
  - figure out vector used by PME and hotplug
  - figure out vector used by AER
  - figure out vector used by DPC
  - free the 32 vectors we allocated
  - allocate only as many vectors as we need

What's the point of allocating those 32 vectors up front?  Why can't
we first look up the interrupt message numbers used by each service
(PME, hotplut, AER, DPC), figure out how many vectors we need,
allocate them, and then fill in the slots in the irqs[] table?

For example, something like this:

  if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
    pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
    pme_msg = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
  }

  if (mask & PCIE_PORT_SERVICE_AER) {
    pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_ROOT_STATUS, &reg32);
    aer_msg = reg32 >> 27;
  }

  if (mask & PCIE_PORT_SERVICE_DPC) {
    pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
    pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP, &reg16);
    dpc_msg = reg16 & 0x1f;
  }

  nvec = max(pme_msg, max(aer_msg, dpc_msg)) + 1;
  pci_alloc_irq_vectors(dev, nvec, nvec, PCI_IRQ_MSIX | PCI_IRQ_MSI);

  if (mask & PCIE_PORT_SERVICE_PME)
    irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme_msg);
  if (mask & PCIE_PORT_SERVICE_HP)
    irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme_msg);
  if (mask & PCIE_PORT_SERVICE_AER)
    irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, aer_msg);
  if (mask & PCIE_PORT_SERVICE_DPC)
    irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, dpc_msg);

We currently only look at each service once, and what I'm proposing
would require looking at each service twice (once to read the message
number from the hardware and again (after allocating the vectors) to
fill in the irqs[] table).  But I think it would be simpler overall.

> @@ -67,6 +68,9 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  	if (nr_entries < 0)
>  		return nr_entries;
>  
> +	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
> +		idx[i] = -1;
> +
>  	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
>  		u16 reg16;
>  
> @@ -90,8 +94,8 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  		if (entry >= nr_entries)
>  			goto out_free_irqs;
>  
> -		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, entry);
> -		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, entry);
> +		idx[PCIE_PORT_SERVICE_PME_SHIFT] = entry;
> +		idx[PCIE_PORT_SERVICE_HP_SHIFT] = entry;
>  
>  		nvec = max(nvec, entry + 1);
>  	}
> @@ -118,7 +122,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  		if (entry >= nr_entries)
>  			goto out_free_irqs;
>  
> -		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, entry);
> +		idx[PCIE_PORT_SERVICE_AER_SHIFT] = entry;
>  
>  		nvec = max(nvec, entry + 1);
>  	}
> @@ -145,7 +149,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  		if (entry >= nr_entries)
>  			goto out_free_irqs;
>  
> -		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, entry);
> +		idx[PCIE_PORT_SERVICE_DPC_SHIFT] = entry;
>  
>  		nvec = max(nvec, entry + 1);
>  	}
> @@ -166,6 +170,9 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  			return nr_entries;
>  	}
>  
> +	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
> +		irqs[i] = idx[i] >= 0 ? pci_irq_vector(dev, idx[i]) : -1;
> +
>  	return 0;
>  
>  out_free_irqs:
> -- 
> 1.9.1
> 
