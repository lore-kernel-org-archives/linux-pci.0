Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V2 00/23] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
To: okaya@codeaurora.org, bhelgaas@google.com, arnd@arndb.de,
	will.deacon@arm.com
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <5673281E.7020204@codeaurora.org> <5673FB6C.80008@semihalf.com>
 <4bccc2de7668dde04436ac9c19aac25d.squirrel@www.codeaurora.org>
Cc: catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	lorenzo.pieralisi@arm.com, jiang.liu@linux.intel.com,
	stefano.stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	liviu.dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, suravee.suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
Message-ID: <5677D66B.2070909@semihalf.com>
Date: Mon, 21 Dec 2015 11:37:31 +0100
MIME-Version: 1.0
In-Reply-To: <4bccc2de7668dde04436ac9c19aac25d.squirrel@www.codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 18.12.2015 19:56, okaya@codeaurora.org wrote:
>> On 17.12.2015 22:24, Sinan Kaya wrote:
>>> Hi Tomasz,
>>>
>>> On 12/16/2015 10:16 AM, Tomasz Nowicki wrote:
>>>>   From the functionality point of view this series might be split into
>>>> the
>>>> following logic parts:
>>>> 1. Make MMCONFIG code arch-agnostic which allows all architectures to
>>>> collect
>>>>      PCI config regions and used when necessary.
>>>> 2. Move non-arch specific bits to the core code.
>>>> 3. Use MMCONFIG code and implement generic ACPI based PCI host
>>>>      controller driver.
>>>> 4. Enable above driver on ARM64
>>>>
>>>> Patches has been built on top of 4.4-rc4 and can be found here:
>>>> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v2)
>>>>
>>>> NOTE, this patch set depends on Matthew's patches:
>>>> http://www.spinics.net/lists/linux-pci/msg45950.html
>>>> https://github.com/Vality/linux/tree/pci-fixes
>>>>
>>>> This has been tested on Cavium ThunderX 1 socket server and QEMU.
>>>> Any help in reviewing and testing is very appreciated.
>>>>
>>>> v1 -> v2
>>>> - moved non-arch specific piece of code to dirver/acpi/ directory
>>>> - fixed IO resource handling
>>>> - introduced PCI config accessors quirks matching
>>>> - moved ACPI_COMPANION_SET to generic code
>>>>
>>>
>>> Just tested your series. I'm seeing a resource assignment problem below.
>>> The bus addresses show as memory addresses and memory addresses show as
>>> bus addresses and IO resource did not show up.
>>>
>>>
>>> Tomasz V2
>>>
>>> [    2.520852] ACPI: PCI Interrupt Link [LN1C] (IRQs *238)
>>> [    2.535472] ACPI: PCI Interrupt Link [LN1D] (IRQs *239)
>>> [    2.550562] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-1f])
>>> [    2.567813] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM
>>> ClockPM Segments MSI]
>>> [    2.591270] acpi PNP0A08:02: _OSC: platform does not support
>>> [PCIeHotplug]
>>> [    2.611144] acpi PNP0A08:02: _OSC: OS now controls [PME AER
>>> PCIeCapability]
>>> [    2.630299] ACPI: IORT: can't find node related to (null) device
>>> [    2.647184]_acpi_PNP0A08:02:_PCI_host_bridge_to_bus_0002:00
>>> [    2.662663] pci_bus 0002:00: root bus resource [mem
>>> 0x00100000-0x3fffffff window] (bus address
>>> [0xfffff5ff00100000-0xfffff5ff3fffffff])
>>> [    2.703561] pci_bus 0002:00: root bus resource [mem
>>> 0x40000000-0x7fffffff window] (bus address
>>> [0xfffff5fe80000000-0xfffff5febfffffff])
>>> [    2.737737] pci_bus 0002:00: root bus resource [mem
>>> 0x80000000-0xffffffff window] (bus address
>>> [0xfffff5fe00000000-0xfffff5fe7fffffff])
>>> [    2.794961] pci_bus 0002:00: root bus resource [bus 00-1f]
>>>
>>> Mark Salter's patches
>>>
>>> [    2.730011] ACPI: PCI Interrupt Link [LN1C] (IRQs *238)
>>> [    2.744648] ACPI: PCI Interrupt Link [LN1D] (IRQs *239)
>>> [    2.759330] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-1f])
>>> [    2.783295] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM
>>> ClockPM Segments MSI]
>>> [    2.806726] acpi PNP0A08:02: _OSC: platform does not support
>>> [PCIeHotplug]
>>> [    2.826005] acpi PNP0A08:02: _OSC: OS now controls [PME AER
>>> PCIeCapability]
>>> [    2.845361] PCI host bridge to bus 0002:00
>>> [    2.856719]_pci_bus_0002:00:_root_bus_resource_[bus_00-1f]
>>> [    2.872056] pci_bus 0002:00: root bus resource [mem
>>> 0xa0100100000-0xa013fffffff] (bus address [0x00100000-0x3fffffff])
>>> [    2.902008] pci_bus 0002:00: root bus resource [mem
>>> 0xa0200000000-0xa023fffffff] (bus address [0x40000000-0x7fffffff])
>>> [    2.932396] pci_bus 0002:00: root bus resource [mem
>>> 0xa0300000000-0xa037fffffff] (bus address [0x80000000-0xffffffff])
>>> [    2.983827] pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
>>>
>>> Here is how the ACPI table looks like:
>>>
>>> 		QWORDMemory(			// Consumed-And-prodced resource(all of memory space)
>>> 			ResourceProducer,	// bit 0 of general flags is 0
>>> 			PosDecode,		// positive Decode:  		_DEC
>>> 			MinFixed,		// Range is fixed:   		_MIF
>>> 			MaxFixed,		// Range is fixed:   		_MAF
>>> 			NonCacheable,		// 				_MEM
>>> 			ReadWrite,		// 				_RW
>>> 			0x00000000,		// Granularity: 	   	_GRA
>>> 			0x00100000,		// Min - PCI Memory start: 	_MIN
>>> 			0x3FFFFFFF,		// Max - PCI Memory end:   	_MAX
>>> 			0xA0100000000,		// Translation: 		_TRA
>>> 			0x3FF00000,		// Range Length: 		_LEN
>>> 			,			// Optional field left blank
>>> 			,			// Optional field left blank
>>> 			MEM0,			// Name declaration for this descriptor
>>> 			AddressRangeMemory,
>>> 			TypeStatic
>>> 			)
>>>
>>>
>>> Any thoughts?
>>>
>>>
>>
>> Yes, this is because of:
>> [PATCH V2 20/23] ACPI, PCI: Refine the way to handle translation_offset
>> for ACPI resources
>> which should have RFC tag. I posted this patch to re-trigger discussion
>> on this.
>>
>> The patch does not add Translation offset to the MMIO type resource
>> start address and for acpi_pci_probe_root_resources(ci) causes problems
>> like that. Indeed MMIO has to be fixed.
>
> OK. I assume you'll post a patch for this soon similar to what Liu Jiang
> is doing in IA64 directory (arch/ia64/pci/pci.c) as I can't proceed with
> my testing without this bugfix.
>>
>> But IO resource type is more problematic. Actually, how
>> acpi_decode_space() should parse resources and which ACPI IO descriptor
>> should be used for ARM64: QWORDIO (offset == 0 vs offset != 0), DWordIO
>> (TypeStatic vs TypeTranslation) + backward compatibility with IA64...
>>
>> Please refer to:
>> https://lkml.org/lkml/2015/11/5/581
>>
>> As Lorenzo pointed out, we *all* need to agree upon the IO resource ACPI
>> descriptor and its parsing method.
>
> Here is what I have as an IO resource.
>
> 		QWORDIO(			//Consumed-And-produced resource
> 			ResourceProducer,	// bit 0 of general flags is 0
> 			MinFixed,		// Range is fixed
> 			MaxFixed,		// Range is fixed
> 			PosDecode,
> 			EntireRange,
> 			0x0000,			// Granularity
> 			0x1000,		// Min, 0 is not accepted
> 			0x10FFF,		// Max
> 			0x8FFFFFEF000,	// Translation
> 			0x10000,		// Range Length
> 			,, PI00
> 		 )
>
> I don't have any type specified.
>
> I agree with Lorenzo's assessment. The min and max values represent the
> PCI IO bus addresses. The translation offset is added to these values to
> figure out the CPU view of the PCI IO range.
>
> The endpoints BAR addresses are programmed with IO addresses ranging
> between 0x1000 and 0x10FFF for this example above.
>
> Here is another question. Chris Covington and I asked this question on a
> private email to you but we didn't hear back.

I have not seen any mails like that in my mail box, unless you sent it 
to linaro one, which is not accessible for me any more. Please use @semihalf

>
> We were referring to a Linaro IO hack patch as we were not sure whether
> this was a limitation of the hack or a general expectation for ARM64 PCI
> in general.
>
> I'll repeat it here.
>
> I have multiple root ports with the same IO port configuration in the
> current ACPI table.
>
> Root port 0 = IO range 0x1000-0x10FFF
> Root port 1 = IO range 0x1000-0x10FFF
> Root port 2 = IO range 0x1000-0x10FFF
>
> Each root port can have the same IO address range configuration, are we
> expecting IO port numbers to be unique across the whole system for ARM64?

Looking at pci_register_io_range which is currently used on ARM64 I 
would say, no you can't have the same CPU addressable IO ranges.

pci_register_io_range does not allow to use regions which overlap each 
other.

Bjorn, Arnd, Will, any opinion on this apart from current code restrictions?

Tomasz
