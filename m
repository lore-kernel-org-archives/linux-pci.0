Return-Path: <SRS0=9zev=AV=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=9zev=AV=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH V2] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port service
 drivers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1504091375-116149-1-git-send-email-liudongdong3@huawei.com>
 <20170906000427.GD14367@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <a07b0fc5-138e-ea16-8421-0f2a6ebc884d@huawei.com>
Date: Wed, 20 Sep 2017 18:43:41 +0800
MIME-Version: 1.0
In-Reply-To: <20170906000427.GD14367@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

I reworked the patch v3 and tested ,but found an issue,
they share one msi vector although config different vectors as below.
PME/HP     Use vector 0     Interrupt Message Number(PCI Express Capabilities Register)
AER        Use vector 1     Advanced Error Interrupt Message Number(Root Error Status Register)
DPC        Use vector 2     DPC Interrupt Message Number(DPC Capability Register)

28:  1   ITS-MSI   0 Edge      PCIe PME, aerdrv, pciehp, pcie-dpc
29:  1   ITS-MSI 131072 Edge      PCIe PME, aerdrv, pciehp, pcie-dpc

Take AER for example.
Advanced Error Interrupt Message Number config to 1, but read result is 0 if MSI Multiple Message Enable is 0.
PCIe Spec 3.1 section 7.10.10.
Advanced Error Interrupt Message Number---
For MSI, the value in this register indicates the offset between the base Message Data and the interrupt message that is generated.
Hardware is required to update this field so that it is correct if the number of MSI Messages assigned to
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
the Function changes when software writes to the Multiple Message Enable field in the MSI Message Control register.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I asked our HW engineer, he told me that hardware needs to ensure that the message number is always pointing to a valid vector.
Hardware cannot allow a bad vector to be used when software changes the number of vectors available.

case 1:
The init value of MSI Multiple Message Enable is 0x0
The current code basically does this:
					     result 	
- allocate 32 vectors  ,                     Multiple Message Enable:0x5
- figure out vector used by PME and hotplug, vector=0
- figure out vector used by AER              vector=1
- figure out vector used by DPC              vector=2
- free the 32 vectors we allocated
- allocate only as many vectors (3 vectors) as we need
   9:          1   ITS-MSI   0 Edge      PCIe PME, pciehp
  10:          0   ITS-MSI   1 Edge      aerdrv
  11:          0   ITS-MSI   2 Edge      pcie-dpc
  31:          1   ITS-MSI 131072 Edge      PCIe PME, pciehp
  32:          0   ITS-MSI 131073 Edge      aerdrv
  33:          0   ITS-MSI 131074 Edge      pcie-dpc

case 2:
The init value of MSI Multiple Message Enable s 0x0
The reworked patch v3 follow is
						result
- figure out vector used by PME and hotplug     vector=0
- figure out vector used by AER                 vector=0
- figure out vector used by DPC                 vector=0
- allocate only as many vectors (1 vector) as we need
28:  1   ITS-MSI   0 Edge      PCIe PME, aerdrv, pciehp, pcie-dpc
29:  1   ITS-MSI 131072 Edge      PCIe PME, aerdrv, pciehp, pcie-dpc

case 3:
If we config MSI Multiple Message Enable to 0x5 (0x2 is ok, we use 3 vectors) in BIOS, then test with reworked patch v3.
MSI Multiple Message Enable init value is 0x5
The reworked patch v3 follow is
						result
- figure out vector used by PME and hotplug     vector=0
- figure out vector used by AER                 vector=1
- figure out vector used by DPC                 vector=2
- allocate only as many vectors (3 vectors) as we need
   9:          1   ITS-MSI   0 Edge      PCIe PME, pciehp
  10:          0   ITS-MSI   1 Edge      aerdrv
  11:          0   ITS-MSI   2 Edge      pcie-dpc
  31:          1   ITS-MSI 131072 Edge      PCIe PME, pciehp
  32:          0   ITS-MSI 131073 Edge      aerdrv
  33:          0   ITS-MSI 131074 Edge      pcie-dpc

So my question is:
Do we still need to change interrupt vector allocation strategy in pcie_port_enable_irq_vec() as patch v3 does?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If we do as patch v3 does, we need to config MSI Multiple Message Enable to 0x5 (or the fact numbers we used) in BIOS.
before we read ARE/PM/HP/DPC Interrupt Message Number.

The reworked patch v3 is as below.
commit a57b4f6a0d38747300fad33db75e4769297e171a
Author: Dongdong Liu <liudongdong3@huawei.com>
Date:   Wed Aug 30 16:05:25 2017 +0800

     PCI/portdrv: Fix MSI/MSI-X bug for PCIe port service drivers

     Current code is broken as calling pci_free_irq_vectors()
     invalidates the IRQ numbers returned before by pci_irq_vectors().
     After removing and adding back the PCI root port device,
     we see the PCIe port service drivers request irq failed.

     pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
     aer: probe of 0000:00:00.0:pcie002 failed with error -22
     pciehp 0000:00:00.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd-
     PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
     pciehp 0000:00:00.0:pcie004: Cannot get irq 20 for the hotplug controller
     pciehp 0000:00:00.0:pcie004: Notification initialization failed (-1)
     dpc 0000:00:00.0:pcie010: request IRQ22 failed: -22
     dpc: probe of 0000:00:00.0:pcie010 failed with error -22

     The current code basically does this:
       - allocate 32 vectors
       - figure out vector used by PME and hotplug
       - figure out vector used by AER
       - figure out vector used by DPC
       - free the 32 vectors we allocated
       - allocate only as many vectors as we need

     There is no point of allocating those 32 vectors up front,
     It is better to first look up the interrupt message numbers used by each
     service (PME, hotplut, AER, DPC), figure out how many vectors we need,
     allocate them, and then fill in the slots in the irqs[] table

     Cc: <stable@vger.kernel.org>
     Fixes: 3674cc49da9a ("PCI/portdrv: Use pci_irq_alloc_vectors()")
     Suggested-by:  Bjorn Helgaas <bhelgaas@google.com>
     Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
     Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 313a21d..67dd5e7 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -54,18 +54,10 @@ static void release_pcie_device(struct device *dev)
   */
  static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
  {
-   int nr_entries, entry, nvec = 0;
-
-   /*
-    * Allocate as many entries as the port wants, so that we can check
-    * which of them will be useful.  Moreover, if nr_entries is correctly
-    * equal to the number of entries this port actually uses, we'll happily
-    * go through without any tricks.
-    */
-   nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
-                   PCI_IRQ_MSIX | PCI_IRQ_MSI);
-   if (nr_entries < 0)
-           return nr_entries;
+ int nr_entries, nvec = 0;
+ int pme_msg;
+ int aer_msg;
+ int dpc_msg;

         if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
                 u16 reg16;
@@ -86,14 +78,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
                  * interrupt message."
                  */
                 pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
-           entry = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
-           if (entry >= nr_entries)
-                   goto out_free_irqs;
-
-           irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, entry);
-           irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, entry);
-
-           nvec = max(nvec, entry + 1);
+         pme_msg = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
         }

         if (mask & PCIE_PORT_SERVICE_AER) {
@@ -114,13 +99,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
                  */
                 pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
                 pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
-           entry = reg32 >> 27;
-           if (entry >= nr_entries)
-                   goto out_free_irqs;
-
-           irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, entry);
-
-           nvec = max(nvec, entry + 1);
+         aer_msg = reg32 >> 27;
         }

         if (mask & PCIE_PORT_SERVICE_DPC) {
@@ -141,36 +120,25 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
                  */
                 pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
                 pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP, &reg16);
-           entry = reg16 & 0x1f;
-           if (entry >= nr_entries)
-                   goto out_free_irqs;
-
-           irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, entry);
-
-           nvec = max(nvec, entry + 1);
+         dpc_msg = reg16 & 0x1f;
         }

-   /*
-    * If nvec is equal to the allocated number of entries, we can just use
-    * what we have.  Otherwise, the port has some extra entries not for the
-    * services we know and we need to work around that.
-    */
-   if (nvec != nr_entries) {
-           /* Drop the temporary MSI-X setup */
-           pci_free_irq_vectors(dev);
-
-           /* Now allocate the MSI-X vectors for real */
-           nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
-                           PCI_IRQ_MSIX | PCI_IRQ_MSI);
-           if (nr_entries < 0)
-                   return nr_entries;
-   }
+ nvec = max(pme_msg, max(aer_msg, dpc_msg)) + 1;
+ nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
+                                 PCI_IRQ_MSIX | PCI_IRQ_MSI);
+ if (nr_entries < 0)
+         return nr_entries;

-   return 0;
+ if (mask & PCIE_PORT_SERVICE_PME)
+         irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme_msg);
+ if (mask & PCIE_PORT_SERVICE_HP)
+         irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme_msg);
+ if (mask & PCIE_PORT_SERVICE_AER)
+         irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, aer_msg);
+ if (mask & PCIE_PORT_SERVICE_DPC)
+         irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, dpc_msg);

-out_free_irqs:
-   pci_free_irq_vectors(dev);
-   return -EIO;
+ return 0;
  }

  /**

Thanks
Dongdong
在 2017/9/6 8:04, Bjorn Helgaas 写道:
> On Wed, Aug 30, 2017 at 07:09:35PM +0800, Dongdong Liu wrote:
>> Current code is broken as calling pci_free_irq_vectors()
>> invalidates the IRQ numbers returned before by pci_irq_vectors();
>> so we need to move all the assignment of the Linux IRQ numbers at
>> the bottom of the function.
>>
>> After removing and adding back the PCI root port device,
>> we see the PCIe port service drivers request irq failed.
>
> What exactly is the connection between the root port removal/addition
> and the request IRQ failure?  The current code does:
>
>   pci_alloc_irq_vectors(dev, ...)
>   irqs[x] = pci_irq_vector(dev, entry)
>   pci_free_irq_vectors(dev)
>   pci_alloc_irq_vectors(dev, ...)
>
> So I guess the problem is that the second pci_alloc_irq_vectors() call
> gets different vectors than the first one?  How is this related to
> removal/addition?  Is there some cleanup we're missing during the
> removal?
>
>> pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
>> aer: probe of 0000:00:00.0:pcie002 failed with error -22
>> pciehp 0000:00:00.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd-
>> PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
>> pciehp 0000:00:00.0:pcie004: Cannot get irq 20 for the hotplug controller
>> pciehp 0000:00:00.0:pcie004: Notification initialization failed (-1)
>> dpc 0000:00:00.0:pcie010: request IRQ22 failed: -22
>> dpc: probe of 0000:00:00.0:pcie010 failed with error -22
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 3674cc4 ("PCI/portdrv: Use pci_irq_alloc_vectors()")
>
> Please use a 12-character SHA1.
>
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> ---
>> v1->v2:
>> - Fix comments on PATCH v1.
>> - Simplify implementation.
>> ---
>>  drivers/pci/pcie/portdrv_core.c | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index 313a21d..89f4cf5 100644
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
>
> This is not so much a question about your patch, but about the whole
> interrupt vector allocation strategy in pcie_port_enable_irq_vec().
>
> The current code basically does this:
>
>   - allocate 32 vectors
>   - figure out vector used by PME and hotplug
>   - figure out vector used by AER
>   - figure out vector used by DPC
>   - free the 32 vectors we allocated
>   - allocate only as many vectors as we need
>
> What's the point of allocating those 32 vectors up front?  Why can't
> we first look up the interrupt message numbers used by each service
> (PME, hotplut, AER, DPC), figure out how many vectors we need,
> allocate them, and then fill in the slots in the irqs[] table?
>
> For example, something like this:
>
>   if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
>     pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
>     pme_msg = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
>   }
>
>   if (mask & PCIE_PORT_SERVICE_AER) {
>     pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_ROOT_STATUS, &reg32);
>     aer_msg = reg32 >> 27;
>   }
>
>   if (mask & PCIE_PORT_SERVICE_DPC) {
>     pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
>     pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP, &reg16);
>     dpc_msg = reg16 & 0x1f;
>   }
>
>   nvec = max(pme_msg, max(aer_msg, dpc_msg)) + 1;
>   pci_alloc_irq_vectors(dev, nvec, nvec, PCI_IRQ_MSIX | PCI_IRQ_MSI);
>
>   if (mask & PCIE_PORT_SERVICE_PME)
>     irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme_msg);
>   if (mask & PCIE_PORT_SERVICE_HP)
>     irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme_msg);
>   if (mask & PCIE_PORT_SERVICE_AER)
>     irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, aer_msg);
>   if (mask & PCIE_PORT_SERVICE_DPC)
>     irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, dpc_msg);
>
> We currently only look at each service once, and what I'm proposing
> would require looking at each service twice (once to read the message
> number from the hardware and again (after allocating the vectors) to
> fill in the irqs[] table).  But I think it would be simpler overall.
>
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
