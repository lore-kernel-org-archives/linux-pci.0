Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <1444804182-6596-5-git-send-email-jiang.liu@linux.intel.com>
 <563B65EE.7000406@semihalf.com> <20151105181959.GA352@red-moon>
 <563C6A5F.5030500@linux.intel.com> <563C82FA.7050707@semihalf.com>
 <563C930F.4060206@linux.intel.com> <563C9FBE.2090303@semihalf.com>
 <563CA9A6.7050309@linux.intel.com> <20151106144534.GC5146@red-moon>
 <563CC810.3040601@linux.intel.com>
Cc: Tomasz Nowicki <tn@semihalf.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <563CCAD5.7080508@linux.intel.com>
Date: Fri, 6 Nov 2015 23:44:21 +0800
MIME-Version: 1.0
In-Reply-To: <563CC810.3040601@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/11/6 23:32, Jiang Liu wrote:
> On 2015/11/6 22:45, Lorenzo Pieralisi wrote:
>> On Fri, Nov 06, 2015 at 09:22:46PM +0800, Jiang Liu wrote:
>>> On 2015/11/6 20:40, Tomasz Nowicki wrote:
>>>> On 06.11.2015 12:46, Jiang Liu wrote:
>>>>> On 2015/11/6 18:37, Tomasz Nowicki wrote:
>>>>>> On 06.11.2015 09:52, Jiang Liu wrote:
>>>>>> Sure, ARM64 (0-16M IO space) QEMU example:
>>>>>> DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
>>>>>>           0x00000000,         // Granularity
>>>>>>           0x00000000,         // Range Minimum
>>>>>>           0x0000FFFF,         // Range Maximum
>>>>>>           0x3EFF0000,         // Translation Offset
>>>>>>           0x00010000,         // Length
>>>>>>           ,, , TypeStatic)
>>>>> The above DWordIO resource descriptor doesn't confirm to the ACPI spec.
>>>>> According to my understanding, ARM/ARM64 has no concept of IO port
>>>>> address space, so the PCI host bridge will map IO port on PCI side
>>>>> onto MMIO on host side. In other words, PCI host bridge on ARM64
>>>>> implement a IO Port->MMIO translation instead of a IO Port->IO Port
>>>>> translation. If that's true, it should use 'TypeTranslation' instead
>>>>> of 'TypeStatic'. And kernel ACPI resource parsing interface doesn't
>>>>> support 'TypeTranslation' yet, so we need to find a solution for it.
>>>>
>>>> I think you are right, we need TypeTranslation flag for ARM64 DWordIO
>>>> descriptors and an extra kernel patch to support it.
>>> How about the attached to patch to support TypeTranslation?
>>> It only passes compilation:)
>>
>> Eh, hopefully there are not any ACPI tables out there with that bit
>> set that work _today_ and would not work with the patch attached :)
>>
>> My question is still there: do we want to handle the same problem
>> as ia64 has in a different manner ? Certainly we won't be able
>> to update ia64 platforms ACPI tables, so we would end up with
>> two platforms handling IO resources in different ways unless I am
>> missing something here.
> There are some difference between IA64 and ARM64.
> On IA64, it supports 16M IO address space per PCI domain and 256 PCI
> domains at max. So the system IO address space is 16M * 256 = 4G.
> So it does two level translations to support IO port
> 1) translate PCI bus local IO port address into system global IO port
>    address by adding acpi_des->translation_offset.
> 2) translate the 4G system IO port address space into MMIO address.
>    IA64 has reserved a 4G space for IO port mapping. This translation
>    is done by arch specific method.
> In other word, IA64 needs two level translation, but ACPI only provides
> on (trans_type, trans_offset) pair for encoding, so it's used for step 1).
> 
> For ARM64, I think currently it only needs step 2).
> 
>>
>> BTW, why would we add offset to res->start only if TypeTranslation is
>> clear ? Is not that something we would do just to make things "work" ?
>> That flag has no bearing on the offset, only on the resource type AFAIK.
> It's not a hack, but a way to interpret ACPI spec:)
> 
> With current linux resource management framework, we need to allocate
> both MMIO and IO port address space range for an ACPI resource of type
> 'TypeTranslation'. And struct resource could be either IO port or MMIO,
> not both. So the choice is to keep the resource as IO port, and let
> arch code to build the special MMIO mapping for it. Otherwise it will
> break too many things if we convert the resource as MMIO.
> 
> That said, we need to add translation_offset to convert bus local
> IO port address into system global IO port address if it's type of
> TypeStatic, because ioresource_ioport uses system global IO port
> address.
> 
> For an ACPI resource of type TypeTranslation, system global IO port
> address equals bus local IO port address, and the translation_offset
> is used to translate IO port address into MMIO address, so we shouldn't
> add translation_offset to the IO port resource descriptor.
One note for the TypeTranslation case, the arch code needs to reset
resource_win->offset to zero after setting up the MMIO map. Sample
code as below:
va = ioremap(resource_win->offset + res->start, resource_size(res));
resource_win->offset = 0;

Otherwise it will break pcibios_resource_to_bus() etc.

> 
> Thanks,
> Gerry
> 
>>
>> This without taking into account ARM64 systems shipping with ACPI
>> tables that does not set the TypeTranslation at present.
>>
>> On top of that, I noticed that core ACPI code handles Sparse
>> Translation (ie _TRS), that should be considered meaningful only if _TTP
>> is set (and that's not checked).
> Yes, that's a flaw:(
> 
>>
>> Thoughts ?
>>
>> Thanks,
>> Lorenzo
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
