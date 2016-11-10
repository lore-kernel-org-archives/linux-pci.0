Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:30879 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbcKJG0G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2016 01:26:06 -0500
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for special
 ISA
To: "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
 <20161109113955.GD10219@e106497-lin.cambridge.arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8F27C0@lhreml507-mbx>
 <20161109165044.GE10219@e106497-lin.cambridge.arm.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        John Garry <john.garry@huawei.com>,
        "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Message-ID: <58241286.1070107@hisilicon.com>
Date: Thu, 10 Nov 2016 14:24:06 +0800
MIME-Version: 1.0
In-Reply-To: <20161109165044.GE10219@e106497-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,Liviu,

Thanks for your comments!


On 2016/11/10 0:50, liviu.dudau@arm.com wrote:
> On Wed, Nov 09, 2016 at 04:16:17PM +0000, Gabriele Paoloni wrote:
>> Hi Liviu
>>
>> Thanks for reviewing
>>
> 
> [removed some irrelevant part of discussion, avoid crazy formatting]
> 
>>>> +/**
>>>> + * addr_is_indirect_io - check whether the input taddr is for
>>> indirectIO.
>>>> + * @taddr: the io address to be checked.
>>>> + *
>>>> + * Returns 1 when taddr is in the range; otherwise return 0.
>>>> + */
>>>> +int addr_is_indirect_io(u64 taddr)
>>>> +{
>>>> +	if (arm64_extio_ops->start > taddr || arm64_extio_ops->end <
>>> taddr)
>>>
>>> start >= taddr ?
>>
>> Nope... if  (taddr < arm64_extio_ops->start || taddr > arm64_extio_ops->end)
>> then taddr is outside the range [start; end] and will return 0; otherwise
>> it will return 1...
> 
> Oops, sorry, did not pay attention to the returned value. The check is
> correct as it is, no need to change then.
> 
>>
>>>
>>>> +		return 0;
>>>> +
>>>> +	return 1;
>>>> +}
>>>>
>>>>  BUILD_EXTIO(b, u8)
>>>>
>>>> diff --git a/drivers/of/address.c b/drivers/of/address.c
>>>> index 02b2903..cc2a05d 100644
>>>> --- a/drivers/of/address.c
>>>> +++ b/drivers/of/address.c
>>>> @@ -479,6 +479,50 @@ static int of_empty_ranges_quirk(struct
>>> device_node *np)
>>>>  	return false;
>>>>  }
>>>>
>>>> +
>>>> +/*
>>>> + * of_isa_indirect_io - get the IO address from some isa reg
>>> property value.
>>>> + *	For some isa/lpc devices, no ranges property in ancestor node.
>>>> + *	The device addresses are described directly in their regs
>>> property.
>>>> + *	This fixup function will be called to get the IO address of
>>> isa/lpc
>>>> + *	devices when the normal of_translation failed.
>>>> + *
>>>> + * @parent:	points to the parent dts node;
>>>> + * @bus:		points to the of_bus which can be used to parse
>>> address;
>>>> + * @addr:	the address from reg property;
>>>> + * @na:		the address cell counter of @addr;
>>>> + * @presult:	store the address paresed from @addr;
>>>> + *
>>>> + * return 1 when successfully get the I/O address;
>>>> + * 0 will return for some failures.
>>>
>>> Bah, you are returning a signed int, why 0 for failure? Return a
>>> negative value with
>>> error codes. Otherwise change the return value into a bool.
>>
>> Yes we'll move to bool
>>
>>>
>>>> + */
>>>> +static int of_get_isa_indirect_io(struct device_node *parent,
>>>> +				struct of_bus *bus, __be32 *addr,
>>>> +				int na, u64 *presult)
>>>> +{
>>>> +	unsigned int flags;
>>>> +	unsigned int rlen;
>>>> +
>>>> +	/* whether support indirectIO */
>>>> +	if (!indirect_io_enabled())
>>>> +		return 0;
>>>> +
>>>> +	if (!of_bus_isa_match(parent))
>>>> +		return 0;
>>>> +
>>>> +	flags = bus->get_flags(addr);
>>>> +	if (!(flags & IORESOURCE_IO))
>>>> +		return 0;
>>>> +
>>>> +	/* there is ranges property, apply the normal translation
>>> directly. */
>>>
>>> s/there is ranges/if we have a 'ranges'/
>>
>> Thanks for spotting this
>>
>>>
>>>> +	if (of_get_property(parent, "ranges", &rlen))
>>>> +		return 0;
>>>> +
>>>> +	*presult = of_read_number(addr + 1, na - 1);
>>>> +	/* this fixup is only valid for specific I/O range. */
>>>> +	return addr_is_indirect_io(*presult);
>>>> +}
>>>> +
>>>>  static int of_translate_one(struct device_node *parent, struct
>>> of_bus *bus,
>>>>  			    struct of_bus *pbus, __be32 *addr,
>>>>  			    int na, int ns, int pna, const char *rprop)
>>>> @@ -595,6 +639,15 @@ static u64 __of_translate_address(struct
>>> device_node *dev,
>>>>  			result = of_read_number(addr, na);
>>>>  			break;
>>>>  		}
>>>> +		/*
>>>> +		 * For indirectIO device which has no ranges property, get
>>>> +		 * the address from reg directly.
>>>> +		 */
>>>> +		if (of_get_isa_indirect_io(dev, bus, addr, na, &result)) {
>>>> +			pr_debug("isa indirectIO matched(%s)..addr =
>>> 0x%llx\n",
>>>> +				of_node_full_name(dev), result);
>>>> +			break;
>>>> +		}
>>>>
>>>>  		/* Get new parent bus and counts */
>>>>  		pbus = of_match_bus(parent);
>>>> @@ -688,8 +741,9 @@ static int __of_address_to_resource(struct
>>> device_node *dev,
>>>>  	if (taddr == OF_BAD_ADDR)
>>>>  		return -EINVAL;
>>>>  	memset(r, 0, sizeof(struct resource));
>>>> -	if (flags & IORESOURCE_IO) {
>>>> +	if (flags & IORESOURCE_IO && taddr >= PCIBIOS_MIN_IO) {
>>>>  		unsigned long port;
>>>> +
>>>>  		port = pci_address_to_pio(taddr);
>>>>  		if (port == (unsigned long)-1)
>>>>  			return -EINVAL;
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index ba34907..1a08511 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -3263,7 +3263,7 @@ int __weak pci_register_io_range(phys_addr_t
>>> addr, resource_size_t size)
>>>>
>>>>  #ifdef PCI_IOBASE
>>>>  	struct io_range *range;
>>>> -	resource_size_t allocated_size = 0;
>>>> +	resource_size_t allocated_size = PCIBIOS_MIN_IO;
>>>>
>>>>  	/* check if the range hasn't been previously recorded */
>>>>  	spin_lock(&io_range_lock);
>>>> @@ -3312,7 +3312,7 @@ phys_addr_t pci_pio_to_address(unsigned long
>>> pio)
>>>>
>>>>  #ifdef PCI_IOBASE
>>>>  	struct io_range *range;
>>>> -	resource_size_t allocated_size = 0;
>>>> +	resource_size_t allocated_size = PCIBIOS_MIN_IO;
>>>
>>> Have you checked that pci_pio_to_address still returns valid values
>>> after this? I know that
>>> you are trying to take into account PCIBIOS_MIN_IO limit when
>>> allocating reserving the IO ranges,
>>> but the values added in the io_range_list are still starting from zero,
>>> no from PCIBIOS_MIN_IO,
>>
>> I think you're wrong here as in pci_address_to_pio we have:
>> +	resource_size_t offset = PCIBIOS_MIN_IO;
>>
>> This should be enough to guarantee that the PIOs start at
>> PCIBIOS_MIN_IO...right?
> 
> I don't think you can guarantee that the pio value that gets passed into
> pci_pio_to_address() always comes from a previously returned value by
> pci_address_to_pio(). Maybe you can add a check in pci_pio_to_address()
> 
> 	if (pio < PCIBIOS_MIN_IO)
> 		return address;
> 
> to avoid adding more checks in the list_for_each_entry() loop.
> 

I will register some ranges to the list and test it later.

But from my understanding, pci_pio_to_address() should can return the right
original physical address.


According to the algorithm, the output PIO ranges are consecutive， just like this:


					input pio of pci_pio_to_address()
						|
						V
|----------------|--------------------------|------|-----------|
					    ^
					    |
					allocated_size is here


The change of this patch just make the start PIO from ZERO to PCIBIOS_MIN_IO.

in pci_pio_to_address(), for one input pio which fall into any PIO segment, the
return address will be:

address = range->start + pio - allocated_size;

Since allocated_size is the total range size of all IO ranges before the one
where pio belong, then (pio - allocated_size) is the offset to the range start,
So....


Thanks!
Zhichang

> Best regards,
> Liviu
> 
>>
>>
>>> so the calculation of the address in this function could return
>>> negative values casted to pci_addr_t.
>>>
>>> Maybe you want to adjust the range->start value in
>>> pci_register_io_range() as well to have it
>>> offset by PCIBIOS_MIN_IO as well.
>>>
>>> Best regards,
>>> Liviu
>>>
>>>>
>>>>  	if (pio > IO_SPACE_LIMIT)
>>>>  		return address;
>>>> @@ -3335,7 +3335,7 @@ unsigned long __weak
>>> pci_address_to_pio(phys_addr_t address)
>>>>  {
>>>>  #ifdef PCI_IOBASE
>>>>  	struct io_range *res;
>>>> -	resource_size_t offset = 0;
>>>> +	resource_size_t offset = PCIBIOS_MIN_IO;
>>>>  	unsigned long addr = -1;
>>>>
>>>>  	spin_lock(&io_range_lock);
>>>> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
>>>> index 3786473..deec469 100644
>>>> --- a/include/linux/of_address.h
>>>> +++ b/include/linux/of_address.h
>>>> @@ -24,6 +24,23 @@ struct of_pci_range {
>>>>  #define for_each_of_pci_range(parser, range) \
>>>>  	for (; of_pci_range_parser_one(parser, range);)
>>>>
>>>> +
>>>> +#ifndef indirect_io_enabled
>>>> +#define indirect_io_enabled indirect_io_enabled
>>>> +static inline bool indirect_io_enabled(void)
>>>> +{
>>>> +	return false;
>>>> +}
>>>> +#endif
>>>> +
>>>> +#ifndef addr_is_indirect_io
>>>> +#define addr_is_indirect_io addr_is_indirect_io
>>>> +static inline int addr_is_indirect_io(u64 taddr)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +#endif
>>>> +
>>>>  /* Translate a DMA address from device space to CPU space */
>>>>  extern u64 of_translate_dma_address(struct device_node *dev,
>>>>  				    const __be32 *in_addr);
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index 0e49f70..7f6bbb6 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -2130,4 +2130,12 @@ static inline bool pci_ari_enabled(struct
>>> pci_bus *bus)
>>>>  /* provide the legacy pci_dma_* API */
>>>>  #include <linux/pci-dma-compat.h>
>>>>
>>>> +/*
>>>> + * define this macro here to refrain from compilation error for some
>>>> + * platforms. Please keep this macro at the end of this header file.
>>>> + */
>>>> +#ifndef PCIBIOS_MIN_IO
>>>> +#define PCIBIOS_MIN_IO		0
>>>> +#endif
>>>> +
>>>>  #endif /* LINUX_PCI_H */
>>>> --
>>>> 1.9.1
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-pci"
>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

