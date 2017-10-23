Return-Path: <SRS0=L8SO=BW=nvidia.com=vidyas@kernel.org>
Return-Path: <SRS0=L8SO=BW=nvidia.com=vidyas@kernel.org>
Subject: Re: [PATCH 1/6] PCI: tegra: refactor config space mapping code
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <treding@nvidia.com>, <bhelgaas@google.com>,
	<linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<kthota@nvidia.com>
References: <1507834211-24922-1-git-send-email-vidyas@nvidia.com>
 <1507834211-24922-2-git-send-email-vidyas@nvidia.com>
 <20171020190824.GN6332@bhelgaas-glaptop.roam.corp.google.com>
From: Vidya Sagar <vidyas@nvidia.com>
Message-ID: <873cc043-d567-d648-1c6e-0ed962edd953@nvidia.com>
Date: Mon, 23 Oct 2017 11:09:50 +0530
MIME-Version: 1.0
In-Reply-To: <20171020190824.GN6332@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On Saturday 21 October 2017 12:38 AM, Bjorn Helgaas wrote:
> On Fri, Oct 13, 2017 at 12:20:06AM +0530, Vidya Sagar wrote:
>> use only 4K space from available 1GB PCIe aperture to access
>> end points configuration space by dynamically moving AFI_AXI_BAR
>> base address and always making sure that the desired location
>> to be accessed for generating required config space access falls
>> in the 4K space reserved for this purpose. This would give more
>> space for mapping end point device's BARs on some of Tegra platforms
> Do you now have a revlock issue between this driver change and the
> corresponding DT changes?  I.e., what happens when you run this driver
> change with an older DT that specifies a 256MB config aperture?  What
> happens if you run the older driver with a new DT that only specifies
> a 4KB config aperture?
Yes. Both driver and DT changes must go together. New driver and old DT (or)
Old driver and new DT would break config space access.
>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/host/pci-tegra.c | 85 ++++++++++++--------------------------------
>>   1 file changed, 23 insertions(+), 62 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>> index 9c40da54f88a..ebdcfca10e17 100644
>> --- a/drivers/pci/host/pci-tegra.c
>> +++ b/drivers/pci/host/pci-tegra.c
>> @@ -269,6 +269,8 @@ struct tegra_pcie {
>>   	struct list_head buses;
>>   	struct resource *cs;
>>   
>> +	void __iomem *cfg_va_base;
>> +
>>   	struct resource io;
>>   	struct resource pio;
>>   	struct resource mem;
>> @@ -317,7 +319,6 @@ struct tegra_pcie_port {
>>   };
>>   
>>   struct tegra_pcie_bus {
>> -	struct vm_struct *area;
>>   	struct list_head list;
>>   	unsigned int nr;
>>   };
>> @@ -357,34 +358,16 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
>>    *
>>    * Mapping the whole extended configuration space would require 256 MiB of
>>    * virtual address space, only a small part of which will actually be used.
>> - * To work around this, a 1 MiB of virtual addresses are allocated per bus
>> - * when the bus is first accessed. When the physical range is mapped, the
>> - * the bus number bits are hidden so that the extended register number bits
>> - * appear as bits [19:16]. Therefore the virtual mapping looks like this:
>> - *
>> - *    [19:16] extended register number
>> - *    [15:11] device number
>> - *    [10: 8] function number
>> - *    [ 7: 0] register number
>> - *
>> - * This is achieved by stitching together 16 chunks of 64 KiB of physical
>> - * address space via the MMU.
>> + * To work around this, a 4K of region is used to generate required
>> + * configuration transaction with relevant B:D:F values. This is achieved by
>> + * dynamically programming base address and size of AFI_AXI_BAR used for
>> + * end point config space mapping to make sure that the address (access to
>> + * which generates correct config transaction) falls in this 4K region
>>    */
>> -static unsigned long tegra_pcie_conf_offset(unsigned int devfn, int where)
>> -{
>> -	return ((where & 0xf00) << 8) | (PCI_SLOT(devfn) << 11) |
>> -	       (PCI_FUNC(devfn) << 8) | (where & 0xfc);
>> -}
>> -
>>   static struct tegra_pcie_bus *tegra_pcie_bus_alloc(struct tegra_pcie *pcie,
>>   						   unsigned int busnr)
>>   {
>> -	struct device *dev = pcie->dev;
>> -	pgprot_t prot = pgprot_noncached(PAGE_KERNEL);
>> -	phys_addr_t cs = pcie->cs->start;
>>   	struct tegra_pcie_bus *bus;
>> -	unsigned int i;
>> -	int err;
>>   
>>   	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
>>   	if (!bus)
>> @@ -393,33 +376,16 @@ static struct tegra_pcie_bus *tegra_pcie_bus_alloc(struct tegra_pcie *pcie,
>>   	INIT_LIST_HEAD(&bus->list);
>>   	bus->nr = busnr;
>>   
>> -	/* allocate 1 MiB of virtual addresses */
>> -	bus->area = get_vm_area(SZ_1M, VM_IOREMAP);
>> -	if (!bus->area) {
>> -		err = -ENOMEM;
>> -		goto free;
>> -	}
>> -
>> -	/* map each of the 16 chunks of 64 KiB each */
>> -	for (i = 0; i < 16; i++) {
>> -		unsigned long virt = (unsigned long)bus->area->addr +
>> -				     i * SZ_64K;
>> -		phys_addr_t phys = cs + i * SZ_16M + busnr * SZ_64K;
>> -
>> -		err = ioremap_page_range(virt, virt + SZ_64K, phys, prot);
>> -		if (err < 0) {
>> -			dev_err(dev, "ioremap_page_range() failed: %d\n", err);
>> -			goto unmap;
>> +	if (!pcie->cfg_va_base) {
>> +		pcie->cfg_va_base = ioremap(pcie->cs->start, SZ_4K);
>> +		if (!pcie->cfg_va_base) {
>> +			dev_err(pcie->dev, "failed to ioremap config space\n");
>> +			kfree(bus);
>> +			bus = (struct tegra_pcie_bus *)-ENOMEM;
> tegra_pcie_bus_alloc() used to do some bus-specific work -- it allocated VM
> space and mapped it.  This pcie->cfg_va_base ioremap() is not bus-specific,
> so I don't think it fits here.  It looks like something that should be done
> in the tegra_pcie_probe() path instead.
>
> If you move that, then I think you might as well inline the kzalloc() stuff
> into tegra_pcie_add_bus().
I'll take care of it in next patch.
>>   		}
>>   	}
>>   
>>   	return bus;
>> -
>> -unmap:
>> -	vunmap(bus->area->addr);
>> -free:
>> -	kfree(bus);
>> -	return ERR_PTR(err);
>>   }
>>   
>>   static int tegra_pcie_add_bus(struct pci_bus *bus)
>> @@ -445,12 +411,12 @@ static void tegra_pcie_remove_bus(struct pci_bus *child)
>>   
>>   	list_for_each_entry_safe(bus, tmp, &pcie->buses, list) {
>>   		if (bus->nr == child->number) {
>> -			vunmap(bus->area->addr);
>>   			list_del(&bus->list);
>>   			kfree(bus);
>>   			break;
>>   		}
>>   	}
>> +	iounmap(pcie->cfg_va_base);
>>   }
>>   
>>   static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>> @@ -459,8 +425,8 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>>   {
>>   	struct pci_host_bridge *host = pci_find_host_bridge(bus);
>>   	struct tegra_pcie *pcie = pci_host_bridge_priv(host);
>> -	struct device *dev = pcie->dev;
>>   	void __iomem *addr = NULL;
>> +	u32 val = 0;
>>   
>>   	if (bus->number == 0) {
>>   		unsigned int slot = PCI_SLOT(devfn);
>> @@ -473,19 +439,14 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>>   			}
>>   		}
>>   	} else {
>> -		struct tegra_pcie_bus *b;
>> -
>> -		list_for_each_entry(b, &pcie->buses, list)
>> -			if (b->nr == bus->number)
>> -				addr = (void __iomem *)b->area->addr;
>> -
>> -		if (!addr) {
>> -			dev_err(dev, "failed to map cfg. space for bus %u\n",
>> -				bus->number);
>> -			return NULL;
>> -		}
>> -
>> -		addr += tegra_pcie_conf_offset(devfn, where);
>> +		addr = pcie->cfg_va_base;
>> +		val = ((((u32)where & 0xf00) >> 8) << 24) |
>> +		      (bus->number << 16) | (PCI_SLOT(devfn) << 11) |
>> +		      (PCI_FUNC(devfn) << 8) | (where & 0xff);
> I think it would be useful to keep tegra_pcie_conf_offset() (extending
> it to take the bus number) near the comment describing the mapping.
I'll take care of it in next patch.
>
>> +		addr = (val & (SZ_4K - 1)) + addr;
>> +		val = val & ~(SZ_4K - 1);
>    val &= ~(SZ_4K - 1);
>
> I *think* what you're doing is computing a config space offset and
> mapping the 4KB window that contains it.
>
> "addr" is not used at all in the AFI_AXI_BAR0 programming, so this
> would be clearer as:
>
>      val = ...
>      afi_writel(...)
>      afi_writel(...)
>
>      addr = pcie->cfg_va_base + (val & (SZ_4K - 1));
but, addr is using the intermediate 'val' i.e. before 'val &= ~(SZ_4K - 
1)' operation is performed on it.
>    }
>
>    return addr;
>
>> +		afi_writel(pcie, pcie->cs->start - val, AFI_AXI_BAR0_START);
>> +		afi_writel(pcie, (val + SZ_4K) >> 12, AFI_AXI_BAR0_SZ);
>>   	}
>>   
>>   	return addr;
>> -- 
>> 2.7.4
>>
