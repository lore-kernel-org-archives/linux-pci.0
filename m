Return-Path: <SRS0=h6uj=ZN=huawei.com=john.garry@kernel.org>
Return-Path: <SRS0=h6uj=ZN=huawei.com=john.garry@kernel.org>
Subject: Re: [PATCH V6 2/5] PCI: Adapt pci_register_io_range() for indirect-IO
 and PCI I/O translation
To: Bjorn Helgaas <helgaas@kernel.org>,
        "zhichang.yuan"
	<yuanzhichang@hisilicon.com>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-3-git-send-email-yuanzhichang@hisilicon.com>
 <20170131001030.GB20550@bhelgaas-glaptop.roam.corp.google.com>
CC: <catalin.marinas@arm.com>, <will.deacon@arm.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
        <mark.rutland@arm.com>, <brian.starkey@arm.com>, <olof@lixom.net>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <lorenzo.pieralisi@arm.com>, <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <minyard@acm.org>,
        <liviu.dudau@arm.com>, <zourongrong@gmail.com>,
        <gabriele.paoloni@huawei.com>, <zhichang.yuan02@gmail.com>,
        <kantyzc@163.com>, <xuwei5@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <f8a6c3ce-ba8e-c00e-8e6f-7c799fb4dd44@huawei.com>
Date: Tue, 31 Jan 2017 13:39:09 +0000
MIME-Version: 1.0
In-Reply-To: <20170131001030.GB20550@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 31/01/2017 00:10, Bjorn Helgaas wrote:
> On Tue, Jan 24, 2017 at 03:05:22PM +0800, zhichang.yuan wrote:
>> After indirect-IO is introduced, system must can assigned indirect-IO devices
>> with logical I/O ranges which are different from those for PCI I/O devices.
>> Otherwise, I/O accessors can't identify whether the I/O port is for memory
>> mapped I/O or indirect-IO.
>
> Maybe:
>
>   We must assign logical I/O port space for indirect I/O such that the
>   I/O accessors can tell whether a logical I/O port refers to memory-
>   mapped I/O space or indirect I/O space.
>

It's better

>> As current helper, pci_register_io_range(), is used for PCI I/O ranges
>> registration and translation, indirect-IO devices should also apply these
>> helpers to manage the I/O ranges. It will be easy to ensure the assigned
>> logical I/O ranges unique.
>> But for indirect-IO devices, there is no cpu address. The current
>> pci_register_io_range() can not work for this case.
>>
>> This patch makes some changes on the pci_register_io_range() to support the
>> I/O range registration with device's fwnode also. After this, the indirect-IO
>> devices can register the device-local I/O range to system logical I/O and
>> easily perform the translation between device-local I/O range and sytem
>> logical I/O range.
>
>> -int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
>> +int __weak pci_register_io_range(struct fwnode_handle *node, phys_addr_t addr,
>> +				 resource_size_t size, unsigned long *port)
>
> Why is this __weak?  It looks like it's been __weak since its
> introduction by 41f8bba7f555 ("of/pci: Add pci_register_io_range() and
> pci_pio_to_address()"), but I don't see any other implementations of
> it.
>
> Can you add a patch that does nothing but make this non-weak?
>

OK

>> +#else
>> +	/*
>> +	 * powerpc and microblaze have their own registration,
>> +	 * just look up the value here
>
> Can you include a pointer to the powerpc and microblaze registration
> code here?  It's conceivable that somebody could generalize this
> enough to support powerpc and microblaze as well.
>

It should be no problem

>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -34,6 +34,9 @@
>>
>>  #include <linux/pci_ids.h>
>>
>> +/* the macro below flags an invalid cpu address
>> + * and is used by IO special hosts              */
>
> s/cpu/CPU/
>

OK

> Use conventional multi-line comment style:
>
> /*
>  * IO_RANGE_IOEXT flags an invalid CPU address ...
>  */
>
>> +#define IO_RANGE_IOEXT (resource_size_t)(-1ull)
>
> And put this close to related things, e.g., pci_register_io_range(),
> instead of just dropping it in at the top of the file.

OK

>
>>  /*
>>   * The PCI interface treats multi-function devices as independent
>>   * devices.  The slot/function address of each device is encoded
>> @@ -1197,8 +1200,8 @@ int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
>>  						  resource_size_t),
>>  			void *alignf_data);
>>
>> -
>> -int pci_register_io_range(phys_addr_t addr, resource_size_t size);
>> +int pci_register_io_range(struct fwnode_handle *node, phys_addr_t addr,
>> +			  resource_size_t size, unsigned long *port);
>>  unsigned long pci_address_to_pio(phys_addr_t addr);
>>  phys_addr_t pci_pio_to_address(unsigned long pio);
>>  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
>> --
>> 1.9.1
>>

Thanks,
John

>
> .
>
