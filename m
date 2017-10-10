Return-Path: <SRS0=jDHQ=BJ=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=jDHQ=BJ=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH V3] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port service
 drivers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1507553167-27833-1-git-send-email-liudongdong3@huawei.com>
 <20171009233029.GA6094@bhelgaas-glaptop.roam.corp.google.com>
CC: <hch@lst.de>, <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <b25f980f-bafb-527d-ac8a-1849739df380@huawei.com>
Date: Tue, 10 Oct 2017 20:13:53 +0800
MIME-Version: 1.0
In-Reply-To: <20171009233029.GA6094@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Many thanks for your review.

在 2017/10/10 7:30, Bjorn Helgaas 写道:
> On Mon, Oct 09, 2017 at 08:46:07PM +0800, Dongdong Liu wrote:
>> Current code is broken as calling pci_free_irq_vectors()
>> invalidates the IRQ numbers returned before by pci_irq_vectors();
>> so we need to move all the assignment of the Linux IRQ numbers at
>> the bottom of the function.
>>
>> After removing and adding back the PCI root port device,
>> we see the PCIe port service drivers request irq failed.
>>
>> pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
>> aer: probe of 0000:00:00.0:pcie002 failed with error -22
>> pciehp 0000:00:00.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd-
>> PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
>> pciehp 0000:00:00.0:pcie004: Cannot get irq 20 for the hotplug controller
>> pciehp 0000:00:00.0:pcie004: Notification initialization failed (-1)
>> dpc 0000:00:00.0:pcie010: request IRQ22 failed: -22
>> dpc: probe of 0000:00:00.0:pcie010 failed with error -22
>
> Here's my understanding of how the hardware works:
>
>   - PME and hotplug use the Interrupt Message Number from the PCIe
>     Capability register.
>
>   - AER uses the AER Interrupt Message Number from the AER Root Error
>     Status register.
>
>   - DPC uses the DPC Interrupt Message Number from the DPC Capability
>     register.
>
>   - FRS (not supported by Linux yet) uses the FRS Interrupt Message
>     Number from the FRS Queuing Capability register.
>
>   - That's a total of 4 possible MSI/MSI-X vectors used for PME,
>     hotplug, AER, DPC, and FRS, so there's no point in trying to
>     allocate more than 4 vectors (we currently start with 32).
>
>   - All these Interrupt Message Numbers are read-only to software but
>     are updated by hardware when software writes the Multiple Message
>     Enable field of the MSI Message Control register.  Thanks for
>     pointing this out; I didn't realize this before.
>
>   - Therefore, we must read the Interrupt Message Numbers *after* we
>     write Multiple Message Enable.

Yes, thanks for explaining this, very clear.

>
> The patch below contains this sequence:
>
>   pci_alloc_irq_vectors(32)
>     ...
>      write Multiple Message Enable   <-- Interrupt Message Numbers change
>   idx[x] = PME/hotplug Interrupt Message Number
>   idx[y] = AER Interrupt Message Number
>   idx[z] = DPC Interrupt Message Number
>   pci_free_irq_vectors()
>   pci_alloc_irq_vectors()
>     ...
>      write Multiple Message Enable   <-- Interrupt Message Numbers change
>   for (i = 0; ...)
>     irqs[i] = pci_irq_vector(idx[i])
>
> This incorrectly assumes the Interrupt Message Numbers remain the same
> after we write Multiple Message Enable.

Here should be the same, as the second pci_alloc_irq_vectors() allocate only as many vectors as we need.

>
> Since we can use at most 4 vectors, I'm not sure it's worth trying to
> optimize this too much, but it seems like we could do this:
>
>   nvec = 0;
>   if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP))
>     nvec++;
>   if (mask & PCIE_PORT_SERVICE_AER)
>     nvec++;
>   if (mask & PCIE_PORT_SERVICE_DPC)
>     nvec++;
>
>   pci_alloc_irq_vectors(dev, 1, nvec, PCI_IRQ_MSIX | PCI_IRQ_MSI);
>
>   if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
>     pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
>     pme_msg = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
>     if (mask & PCIE_PORT_SERVICE_PME)
>       irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme_msg);
>     if (mask & PCIE_PORT_SERVICE_HP)
>       irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme_msg);
>   }
>
>   if (mask & PCIE_PORT_SERVICE_AER) {
>     pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_ROOT_STATUS, &reg32);
>     aer_msg = reg32 >> 27;
>     irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, aer_msg);
>   }
>
>   if (mask & PCIE_PORT_SERVICE_DPC) {
>     pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
>     pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP, &reg16);
>     dpc_msg = reg16 & 0x1f;
>     irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, dpc_msg);
>   }


The above code is different from current patch in below case.
HP/PME --- vector 0
AER --- vector 2
DPC--- vector 6
Sure, this case is not common.
Current patch still works ok on such case.
But above code , DPC maybe not work as we expect.
It maybe still work ok, but the vector is not 6.
So how about we accept the patch firstly, then we can add a separate patch if we still think it is worth.
>
> Also, can you please make a separate patch to add #defines for the AER
> and DPC Interrupt Message Number masks?  In the AER case, the mask
> isn't strictly necessary because there are no higher-order bits above
> the Interrupt Message Number, but using a #define will make it
> possible to grep for it.
It looks ok to me, will do.

Thanks,
Dongdong
>
> Bjorn
>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 3674cc49da9a ("PCI/portdrv: Use pci_irq_alloc_vectors()")
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> ---
>> v2->v3:
>> - Use a 12-character SHA1 commit id.
>> - Rebase on v4.14-rc4.
>> v1->v2:
>> - Fix comments on PATCH v1.
>> - Simplify implementation.
>> ---
>>  drivers/pci/pcie/portdrv_core.c | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index 313a21d..89f4cf5b 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -55,7 +55,8 @@ static void release_pcie_device(struct device *dev)
>>  static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>>  {
>>  	int nr_entries, entry, nvec = 0;
>> -
>> +	int i;
>> +	int idx[PCIE_PORT_DEVICE_MAXSERVICES];
>>  	/*
>>  	 * Allocate as many entries as the port wants, so that we can check
>>  	 * which of them will be useful.  Moreover, if nr_entries is correctly
>> @@ -67,6 +68,9 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>>  	if (nr_entries < 0)
>>  		return nr_entries;
>>
>> +	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
>> +		idx[i] = -1;
>> +
>>  	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
>>  		u16 reg16;
>>
>> @@ -90,8 +94,8 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>>  		if (entry >= nr_entries)
>>  			goto out_free_irqs;
>>
>> -		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, entry);
>> -		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, entry);
>> +		idx[PCIE_PORT_SERVICE_PME_SHIFT] = entry;
>> +		idx[PCIE_PORT_SERVICE_HP_SHIFT] = entry;
>>
>>  		nvec = max(nvec, entry + 1);
>>  	}
>> @@ -118,7 +122,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>>  		if (entry >= nr_entries)
>>  			goto out_free_irqs;
>>
>> -		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, entry);
>> +		idx[PCIE_PORT_SERVICE_AER_SHIFT] = entry;
>>
>>  		nvec = max(nvec, entry + 1);
>>  	}
>> @@ -145,7 +149,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>>  		if (entry >= nr_entries)
>>  			goto out_free_irqs;
>>
>> -		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, entry);
>> +		idx[PCIE_PORT_SERVICE_DPC_SHIFT] = entry;
>>
>>  		nvec = max(nvec, entry + 1);
>>  	}
>> @@ -166,6 +170,9 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>>  			return nr_entries;
>>  	}
>>
>> +	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
>> +		irqs[i] = idx[i] >= 0 ? pci_irq_vector(dev, idx[i]) : -1;
>> +
>>  	return 0;
>>
>>  out_free_irqs:
>> --
>> 1.9.1
>>
>
> .
>
