Return-Path: <SRS0=H44n=BJ=hisilicon.com=wangzhou1@kernel.org>
Return-Path: <SRS0=H44n=BJ=hisilicon.com=wangzhou1@kernel.org>
Subject: Re: [RFC PATCH] PCI: Fix prefetchable range broken in
 pci_bridge_check_ranges
To: Bjorn Helgaas <helgaas@kernel.org>, Yinghai Lu <yinghai@kernel.org>
References: <1506151482-113560-1-git-send-email-wangzhou1@hisilicon.com>
 <20171002041700.GA3834@localhost.localdomain>
 <20171002203830.GD5407@bhelgaas-glaptop.roam.corp.google.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <59DC81DB.5070400@hisilicon.com>
Date: Tue, 10 Oct 2017 16:16:27 +0800
MIME-Version: 1.0
In-Reply-To: <20171002203830.GD5407@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

On 2017/10/3 4:38, Bjorn Helgaas wrote:
> [+cc Lorenzo]
> 
> On Sun, Oct 01, 2017 at 09:17:01PM -0700, Yinghai Lu wrote:
>> On Sat, Sep 23, 2017 at 03:24:42PM +0800, Zhou Wang wrote:
>>>                                         -> pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, 0xffffffff)
>>>
>>> This will change the prefetch range of 00:00.0 in a time slot, so
>>> traffic of 01:00.0 or 01:00.1 may be broken.
>>>
>>> In fact, we can get if one bridge supports 64bit range by the
>>> bottom 4bits of prefetchable memory base/limit. Honestly speaking,
>>> I don't know why 1f82de10d6b1 ("PCI/86: don't assume prefetchable
>>> ranges are 64bit") has added the double check code.
> 
> I agree this is a problem.  We shouldn't be changing the window while
> devices below the bridge are active.
> 
>> some chip even that flags say that 64bit is support from that bits,
>> but its upper 32 bits actually can not be changed.
> 
> We should figure this out at enumeration-time, before we enable any
> devices below the bridge.  Maybe it could be done in the
> pci_setup_device() path.
> 
> This is sort of related to the pci_read_bridge_bases() path, which is
> currently done by the arch-specific pcibios_fixup_bus(), even though
> it really isn't arch-specific.  Somebody tried to fix that recently,
> but I don't remember the issues.
> 
> I think it would be nice if pci_setup_device() could read bridge
> window info the same way it currently reads BAR info.  Maybe it would
> make dmesg more intelligible, too, e.g., we could print the bridge
> info before we print info about devices below the bridge.

So can we move pci_bridge_check_ranges to pci_setup_device? just like:

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a6560c9..61e016d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -366,4 +366,6 @@ int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 			  struct resource *res);
 #endif

+void pci_bridge_check_ranges(struct pci_dev *dev);
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ff94b69..a5c25e0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1517,6 +1517,7 @@ int pci_setup_device(struct pci_dev *dev)
 		pci_read_irq(dev);
 		dev->transparent = ((dev->class & 0xff) == 1);
 		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
+                pci_bridge_check_ranges(dev);
 		set_pcie_hotplug_bridge(dev);
 		pos = pci_find_capability(dev, PCI_CAP_ID_SSVID);
 		if (pos) {
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 958da7d..220e6c8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -738,11 +738,10 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 /* Check whether the bridge supports optional I/O and
    prefetchable memory ranges. If not, the respective
    base/limit registers must be read-only and read as 0. */
-static void pci_bridge_check_ranges(struct pci_bus *bus)
+void pci_bridge_check_ranges(struct pci_dev *bridge)
 {
 	u16 io;
 	u32 pmem;
-	struct pci_dev *bridge = bus->self;
 	struct resource *b_res;

 	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
@@ -1248,7 +1247,6 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		break;

 	case PCI_CLASS_BRIDGE_PCI:
-		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
 			additional_io_size  = pci_hotplug_io_size;
 			additional_mem_size = pci_hotplug_mem_size;

Thanks,
Zhou

> 
> Bjorn
> 
>>> So Can we remove the double checking of prefetchable range to
>>> avoid this problem?
>>>
>>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>>> ---
>>>  drivers/pci/setup-bus.c | 14 --------------
>>>  1 file changed, 14 deletions(-)
>>>
>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>>> index 958da7d..23010a9 100644
>>> --- a/drivers/pci/setup-bus.c
>>> +++ b/drivers/pci/setup-bus.c
>>> @@ -778,20 +778,6 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
>>>  			b_res[2].flags |= PCI_PREF_RANGE_TYPE_64;
>>>  		}
>>>  	}
>>> -
>>> -	/* double check if bridge does support 64 bit pref */
>>> -	if (b_res[2].flags & IORESOURCE_MEM_64) {
>>> -		u32 mem_base_hi, tmp;
>>> -		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32,
>>> -					 &mem_base_hi);
>>> -		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
>>> -					       0xffffffff);
>>> -		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &tmp);
>>> -		if (!tmp)
>>> -			b_res[2].flags &= ~IORESOURCE_MEM_64;
>>> -		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
>>> -				       mem_base_hi);
>>> -	}
>>>  }
>>>  
>>>  /* Helper function for sizing routines: find first available
>>
>> Maybe we can try this: only touch upper 32bits after we touched low 32bits ?
>>
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 958da7db9033..2ac4d20e5c11 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -744,6 +744,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
>>  	u32 pmem;
>>  	struct pci_dev *bridge = bus->self;
>>  	struct resource *b_res;
>> +	int pref_memory_base_touched = 0;
>>  
>>  	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
>>  	b_res[1].flags |= IORESOURCE_MEM;
>> @@ -769,6 +770,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
>>  					       0xffe0fff0);
>>  		pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
>>  		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
>> +		pref_memory_base_touched = 1;
>>  	}
>>  	if (pmem) {
>>  		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
>> @@ -780,7 +782,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
>>  	}
>>  
>>  	/* double check if bridge does support 64 bit pref */
>> -	if (b_res[2].flags & IORESOURCE_MEM_64) {
>> +	if (pref_memory_base_touched && b_res[2].flags & IORESOURCE_MEM_64) {
>>  		u32 mem_base_hi, tmp;
>>  		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32,
>>  					 &mem_base_hi);
>>
>>
>>
> 
> .
> 
