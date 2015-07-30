Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:43238 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbbG3HRP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2015 03:17:15 -0400
Message-ID: <55B9CF5A.2080503@hisilicon.com>
Date: Thu, 30 Jul 2015 15:16:42 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: Re: [PATCH v6] PCI: Store PCIe bus address in struct of_pci_range
References: <1438010223-124422-1-git-send-email-gabriele.paoloni@huawei.com> <20150729172053.GE31170@google.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D6F350@lhreml503-mbs>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01D6F350@lhreml503-mbs>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/7/30 3:44, Gabriele Paoloni wrote:
> Hi Bjorn
> 
> Many Thanks for your reply
> 
> I have commented back inline with resolutions from my side.
> 
> If you're ok with them I'll send it out a new version in the appropriate patchset
> 
> Cheers
> 
> Gab
> 
>> -----Original Message-----
>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>> Sent: Wednesday, July 29, 2015 6:21 PM
>> To: Gabriele Paoloni
>> Cc: arnd@arndb.de; lorenzo.pieralisi@arm.com; Wangzhou (B);
>> robh+dt@kernel.org; james.morse@arm.com; Liviu.Dudau@arm.com; linux-
>> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> devicetree@vger.kernel.org; Yuanzhichang; Zhudacai; zhangjukuo;
>> qiuzhenfa; Liguozhu (Kenneth)
>> Subject: Re: [PATCH v6] PCI: Store PCIe bus address in struct
>> of_pci_range
>>
>> Hi Gabriele,
>>
>> As far as I can tell, this is not specific to PCIe, so please use "PCI"
>> in
>> the subject as a generic term that includes both PCI and PCIe.
> 
> sure agreed
> 
>>
>> On Mon, Jul 27, 2015 at 11:17:03PM +0800, Gabriele Paoloni wrote:
>>> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>>>
>>>     This patch is needed port PCIe designware to new DT parsing API
>>>     As discussed in
>>>     http://lists.infradead.org/pipermail/linux-arm-kernel/2015-
>> January/317743.html
>>>     in designware we have a problem as the PCI addresses in the PCIe
>> controller
>>>     address space are required in order to perform correct HW
>> operation.
>>>
>>>     In order to solve this problem commit f4c55c5a3 "PCI: designware:
>>>     Program ATU with untranslated address" added code to read the
>> PCIe
>>
>> Conventional reference is 12-char SHA1, like this:
>>
>>   f4c55c5a3f7f ("PCI: designware: Program ATU with untranslated
>> address")
> 
> Agreed, will change this
> 
>>
>>>     controller start address directly from the DT ranges.
>>>
>>>     In the new DT parsing API of_pci_get_host_bridge_resources()
>> hides the
>>>     DT parser from the host controller drivers, so it is not possible
>>>     for drivers to parse values directly from the DT.
>>>
>>>     In http://www.spinics.net/lists/linux-pci/msg42540.html we
>> already tried
>>>     to use the new DT parsing API but there is a bug (obviously) in
>> setting
>>>     the <*>_mod_base addresses
>>>     Applying this patch we can easily set "<*>_mod_base = win-
>>> __res.start"
>>
>> By itself, this patch adds something.  It would help me understand it
>> if
>> the *user* of this new something were in the same patch series.
> 
> the user is: "[PATCH v5 2/5] PCI: designware: Add ARM64 support"
> I will ask Zhou Wang to include this patch in his patchset
>

Hi Gab,

I can merge this patch in my series if this make it clearer to understand.

Thanks,
Zhou

> 
>>
>>>     This patch adds a new field in "struct of_pci_range" to store the
>>>     pci bus start address; it fills the field in
>> of_pci_range_parser_one();
>>>     in of_pci_get_host_bridge_resources() it retrieves the resource
>> entry
>>>     after it is created and added to the resource list and uses
>>>     entry->__res.start to store the pci controller address
>>
>> struct of_pci_range is starting to get confusing to non-OF folks like
>> me.
>> It now contains:
>>
>>   u32 pci_space;
>>   u64 pci_addr;
>>   u64 cpu_addr;
>>   u64 bus_addr;
>>
>> Can you explain what all these things mean, and maybe even add one-line
>> comments to the structure?
> 
> sure I can add comments inline in the code
> 
>>
>> pci_space: The only uses I see are to determine whether to print
>> "Prefetch".  I don't see any real functionality that uses this.
> 
> Looking at the code I agree. it's seems to be used only in powerpc 
> and microblaze to print out.
> However from my understanding pci_space is the phys.hi field of the 
> ranges property: it defines the properties of the address space associated
> to the PCI address. if you're curious you can find a nice and quick to read
> "guide" in http://devicetree.org/MPC5200:PCI
> 
>>
>> pci_addr: I assume this is a PCI bus address, like what you would see
>> if
>> you put an analyzer on the bus/link.  This address could go in a BAR.
> 
> Yes, this is the PCI start address of the range: phys.mid + phys.low in the
> guide mentioned above
> 
>>
>> cpu_addr: I assume this is a CPU physical address, like what you would
>> see
>> in /proc/iomem and what you would pass to ioremap().
> 
> Yes correct
> 
>>
>> bus_addr: ?
>>
> 
> According to the guide above, this is the address into which the pci_address 
> get translated to and that is passed to the root complex. Between the root 
> complex and the CPU there can be intermediate translation layers: see that to 
> get pci_address we call "of_translate_address"; this will apply all the 
> translation layers (ranges in the DT) that it finds till it comes to the root 
> node of the DT (thus retrieving the CPU address).
> Now said that, for designware we need the first translated PCI address, that we call
> here bus_addr after Rob Herring suggested the name...honestly I cannot think of a 
> different name
> 
>    
> 
>> I'm trying to imagine how this might be expressed in ACPI.  A host
>> bridge
>> ACPI _CRS contains a CPU physical address and applying a _TRA
>> (translation
>> offset) to the CPU address gives you a PCI bus address.  I know this
>> code
>> is OF, not ACPI, but I assume that it should be possible to describe
>> your
>> hardware via ACPI as well as by OF.
>>
>>>     the patch is based on 4.2-rc1
>>
>> You can put this after the "---" line because it's not relevant in the
>> permanent changelog.
> 
> Agreed
> 
>>
>>>     Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>>     Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
>>>     Acked-by: Rob Herring <robh@kernel.org>
>>
>> Please un-indent your changelog.
> 
> Ok agreed
> 
>>
>>> ---
>>>  drivers/of/address.c       | 2 ++
>>>  drivers/of/of_pci.c        | 4 ++++
>>>  include/linux/of_address.h | 1 +
>>>  3 files changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/of/address.c b/drivers/of/address.c
>>> index 8bfda6a..23a5793 100644
>>> --- a/drivers/of/address.c
>>> +++ b/drivers/of/address.c
>>> @@ -253,6 +253,7 @@ struct of_pci_range
>> *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>>>  						struct of_pci_range *range)
>>>  {
>>>  	const int na = 3, ns = 2;
>>> +	const int p_ns = of_n_size_cells(parser->node);
>>>
>>>  	if (!range)
>>>  		return NULL;
>>> @@ -265,6 +266,7 @@ struct of_pci_range
>> *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>>>  	range->pci_addr = of_read_number(parser->range + 1, ns);
>>>  	range->cpu_addr = of_translate_address(parser->node,
>>>  				parser->range + na);
>>> +	range->bus_addr = of_read_number(parser->range + na, p_ns);
>>>  	range->size = of_read_number(parser->range + parser->pna + na,
>> ns);
>>>
>>>  	parser->range += parser->np;
>>> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
>>> index 5751dc5..fe57030 100644
>>> --- a/drivers/of/of_pci.c
>>> +++ b/drivers/of/of_pci.c
>>> @@ -198,6 +198,7 @@ int of_pci_get_host_bridge_resources(struct
>> device_node *dev,
>>>
>>>  	pr_debug("Parsing ranges property...\n");
>>>  	for_each_of_pci_range(&parser, &range) {
>>> +		struct resource_entry *entry;
>>>  		/* Read next ranges element */
>>>  		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
>>>  			snprintf(range_type, 4, " IO");
>>> @@ -240,6 +241,9 @@ int of_pci_get_host_bridge_resources(struct
>> device_node *dev,
>>>  		}
>>>
>>>  		pci_add_resource_offset(resources, res,	res->start -
>> range.pci_addr);
>>> +		entry = list_last_entry(resources, struct resource_entry,
>> node);
>>> +		/* we are using __res for storing the PCI controller
>> address */
>>> +		entry->__res.start = range.bus_addr;
>>>  	}
>>>
>>>  	return 0;
>>> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
>>> index d88e81b..865f96e 100644
>>> --- a/include/linux/of_address.h
>>> +++ b/include/linux/of_address.h
>>> @@ -16,6 +16,7 @@ struct of_pci_range {
>>>  	u32 pci_space;
>>>  	u64 pci_addr;
>>>  	u64 cpu_addr;
>>> +	u64 bus_addr;
>>>  	u64 size;
>>>  	u32 flags;
>>>  };
>>> --
>>> 1.9.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci"
>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


