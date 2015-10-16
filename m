Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:51316 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbbJPIBc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2015 04:01:32 -0400
Message-ID: <5620AEBD.30605@windriver.com>
Date: Fri, 16 Oct 2015 16:01:01 +0800
From: Wenlin Kang <wenlin.kang@windriver.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci: restrict 64-bit pci device to assign resource from
 behind of max_pfn
References: <1444906004-2083-1-git-send-email-wenlin.kang@windriver.com> <20151015140503.GA12958@localhost>
In-Reply-To: <20151015140503.GA12958@localhost>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015年10月15日 22:05, Bjorn Helgaas wrote:
> Hi Wenlin,
>
> On Thu, Oct 15, 2015 at 06:46:44PM +0800, Wenlin Kang wrote:
>> This patch restricts 64-bit pci device to assign resource from behind of
>> max_pfn when kernel config enables CONFIG_64BIT.
>>
>> On some system that pci device requires assignment of large resource(eg,
>> 1GB or larger), sometimes,the assignment of some devices may fail under
>> the current way.
>>
>> e.g. the follow case is that.
>>
>> ...
>> [    0.000000] e820: [mem 0x90000000-0xfed1bfff] available for PCI devices
>> [    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:72 nr_node_ids:2
>> ...
>> [    6.564750] pci 0000:00:1c.7:   bridge window [mem 0x9f000000-0xa08fffff]
>> [    6.587130] pci 0000:84:06.0: BAR 14: can't assign mem (size 0x60000000)
>> [    6.609158] pci 0000:84:00.0: BAR 14: can't assign mem (size 0x100000)
>> ...
>>
>> On this case, although the kernel has [0x90000000-0xfed1bfff] [1.73GB]
>> size space is available for PCI devices, assignment of some devices fail
>> yet, the cause is the resource isn't yet enough for devices.
> We do PCI resource allocation inside the host bridge windows, which
> you didn't include here.
>
> The [mem 0x90000000-0xfed1bfff] range is derived from the E820 table
> and is sort of a theoretical maximum -- it's the range that isn't
> being used by anything else.  The "available for PCI devices" text is
> not quite accurate -- this range is potentially available for *any*
> device that has programmable addresses.
>
> Long ago, we did use that range directly for PCI allocation, but now
> that we have machines with multiple host bridges, it's not sufficient:
> the range may be carved up between several bridges.  We have to look
> at the host bridge windows to see what parts of the range are
> available for devices below each host bridge.
>
> That's a long-winded way of saying that we can't simply look at
> max_pfn as you do in this patch.  We need to look at the host bridge
> windows themselves.  On x86, these come from ACPI _CRS methods, and
> they probably aren't big enough to accommodate this device.  If that's
> the case, we can't do much about it.  If the BIOS tells us "this is
> the only range routed to the PCI bus," we have to assume it's telling
> us the truth.  The BIOS knows how the bridges are configured, and we
> don't.

Hi Bjorn

Thanks your reply quickly.

I understand what you say above, due to on our machine, three host bridge
window all are "root bus resource [mem 0x00000000-0x3fffffffffff]",
and after apply the patch, it also is ok, so I do ignore the consideration
for each host bridge window on restriction, thanks you point out it.

As you said, if we think about each host bridge, that do need to do more
thing, it do be a long-winded way.  I will reconsider this problem.

>> After apply this patch, this problem get resolved, the patch makes kernel
>> assign resource from behind of max_pfn for 64-bit pci devices when kernel
>> is 64BIT, however, previous way always assigns resource below 4GB no
>> matter it is 32 or 64-bit devices, so this patch extends this window of
>> pci resource on 64-bit system that both 32 and 64-bit pci device exist or
>> only 64-bit device exists, makes it more likely that we can assign
>> resource to more or all devices.
>>
>> Signed-off-by: wlkang <wlkang2008@126.com>
>> Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
> I assume both of these Signed-off-by lines refer to you.  If that's
> the case, you should at least use the same "real name" (the "wlkang"
> and "Wenlin Kang" parts).  I think it makes the most sense to use a
> single address, but if you need both, I would put the second in a
> "CC:" line or something.  The Signed-off-by is more of an ownership
> thing where it doesn't really make sense to have two names for a
> single person.

Thinks, I see.

>> ---
>>   drivers/pci/setup-res.c |   12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>> index 232f925..dafd667 100644
>> --- a/drivers/pci/setup-res.c
>> +++ b/drivers/pci/setup-res.c
>> @@ -206,7 +206,19 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>>   	resource_size_t min;
>>   	int ret;
>>   
>> +#ifdef CONFIG_64BIT
>> +	/*
>> +	 * For 64-bit pci device, assign resource start from the next page
>> +	 * boundary above the maximum physical page address
>> +	 */
>> +	resource_size_t min_iomem;
>> +
>> +	min_iomem = (res->flags & IORESOURCE_MEM_64) ?
>> +				(max_pfn + 1) << PAGE_SHIFT : PCIBIOS_MIN_MEM;
>> +	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : min_iomem;
>> +#else
>>   	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
>> +#endif
>>   
>>   	/*
>>   	 * First, try exact prefetching match.  Even if a 64-bit
>> -- 
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Thanks,
Wenlin Kang

