Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbdH2UQd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Aug 2017 16:16:33 -0400
Date: Tue, 29 Aug 2017 15:16:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, gabriele.paoloni@huawei.com,
        charles.chenxin@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port service
 drivers
Message-ID: <20170829201631.GO8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1503654642-59977-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503654642-59977-1-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 25, 2017 at 05:50:42PM +0800, Dongdong Liu wrote:
> Current code is broken as calling pci_free_irq_vectors()
> invalidates the IRQ numbers returned before by pci_irq_vectors();
> so we need to move all the assignment of the Linux IRQ numbers at
> the bottom of the function.
> 
> After removing and adding back the PCI root port device,
> we see the PCIe port service drivers request irq failed.
> 
> root@(none)$ lspci -tv
> -[0000:00]-+-00.0-[01]----00.0  Device 19e5:0123
>            \-08.0-[02-03]--+-00.0  Device 8086:10fb
>                            \-00.1  Device 8086:10fb

It doesn't look like the hierarchy *below* the root port is relevant.

> root@(none)$ echo 1 > /sys/devices/pci0000\:00/0000\:00\:00.0/remove
> iommu: Removing device 0000:00:00.0 from group 2
> root@(none)$ echo 1 > /sys/devices/pci0000\:00/pci_bus/0000\:00/rescan
> pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it
> with 'pcie_aspm=force'
> pci 0000:00:00.0: BAR 14: assigned [mem 0xe0100000-0xe03fffff]
> pci 0000:00:00.0: BAR 15: assigned [mem 0x80000e00000-0x80000ffffff 64bit
> pref]
> pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
> pci 0000:01:00.0: BAR 0: assigned [mem 0xe0100000-0xe013ffff 64bit]
> pci 0000:01:00.0: BAR 6: assigned [mem 0xe0140000-0xe015ffff pref]
> pci 0000:00:00.0: PCI bridge to [bus 01]
> pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> pci 0000:00:00.0:   bridge window [mem 0xe0100000-0xe03fffff]
> pci 0000:00:00.0:   bridge window [mem 0x80000e00000-0x80000ffffff 64bit
> pref]
> iommu: Adding device 0000:00:00.0 to group 2
> pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
> aer: probe of 0000:00:00.0:pcie002 failed with error -22
> pciehp 0000:00:00.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd-
> PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> pciehp 0000:00:00.0:pcie004: Cannot get irq 20 for the hotplug controller
> pciehp 0000:00:00.0:pcie004: Notification initialization failed (-1)
> dpc 0000:00:00.0:pcie010: request IRQ22 failed: -22
> dpc: probe of 0000:00:00.0:pcie010 failed with error -22

I think the ASPM, iommu, BAR, and window message are irrelevant to this issue.
If so, please remove them so they aren't distractions.

This looks like it might be a fix for a regression.  Can you add any
relevant Fixes: tags and possibly stable tags?

> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  drivers/pci/pcie/portdrv_core.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 313a21d..4cac558 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -54,7 +54,10 @@ static void release_pcie_device(struct device *dev)
>   */
>  static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  {
> -	int nr_entries, entry, nvec = 0;
> +	int nr_entries, nvec = 0;
> +	int entry_hp = 0;
> +	int entry_aer = 0;
> +	int entry_dpc = 0;
>  
>  	/*
>  	 * Allocate as many entries as the port wants, so that we can check
> @@ -86,14 +89,11 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  		 * interrupt message."
>  		 */
>  		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
> -		entry = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
> -		if (entry >= nr_entries)
> +		entry_hp = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
> +		if (entry_hp >= nr_entries)
>  			goto out_free_irqs;
>  
> -		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, entry);
> -		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, entry);
> -
> -		nvec = max(nvec, entry + 1);
> +		nvec = max(nvec, entry_hp + 1);
>  	}
>  
>  	if (mask & PCIE_PORT_SERVICE_AER) {
> @@ -114,13 +114,11 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  		 */
>  		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>  		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
> -		entry = reg32 >> 27;
> -		if (entry >= nr_entries)
> +		entry_aer = reg32 >> 27;
> +		if (entry_aer >= nr_entries)
>  			goto out_free_irqs;
>  
> -		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, entry);
> -
> -		nvec = max(nvec, entry + 1);
> +		nvec = max(nvec, entry_aer + 1);
>  	}
>  
>  	if (mask & PCIE_PORT_SERVICE_DPC) {
> @@ -141,13 +139,11 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  		 */
>  		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
>  		pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP, &reg16);
> -		entry = reg16 & 0x1f;
> -		if (entry >= nr_entries)
> +		entry_dpc = reg16 & 0x1f;
> +		if (entry_dpc >= nr_entries)
>  			goto out_free_irqs;
>  
> -		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, entry);
> -
> -		nvec = max(nvec, entry + 1);
> +		nvec = max(nvec, entry_dpc + 1);
>  	}
>  
>  	/*
> @@ -166,6 +162,17 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  			return nr_entries;
>  	}
>  
> +	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
> +		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, entry_hp);
> +		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, entry_hp);
> +	}
> +
> +	if (mask & PCIE_PORT_SERVICE_AER)
> +		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, entry_aer);
> +
> +	if (mask & PCIE_PORT_SERVICE_DPC)
> +		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, entry_dpc);
> +
>  	return 0;
>  
>  out_free_irqs:
> -- 
> 1.9.1
> 
