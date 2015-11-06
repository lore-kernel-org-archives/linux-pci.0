Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
To: Jiang Liu <jiang.liu@linux.intel.com>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <1444804182-6596-5-git-send-email-jiang.liu@linux.intel.com>
 <563B65EE.7000406@semihalf.com> <20151105181959.GA352@red-moon>
 <563C6A5F.5030500@linux.intel.com> <563C82FA.7050707@semihalf.com>
 <563C930F.4060206@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <563C9FBE.2090303@semihalf.com>
Date: Fri, 6 Nov 2015 13:40:30 +0100
MIME-Version: 1.0
In-Reply-To: <563C930F.4060206@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06.11.2015 12:46, Jiang Liu wrote:
> On 2015/11/6 18:37, Tomasz Nowicki wrote:
>> On 06.11.2015 09:52, Jiang Liu wrote:
>>> On 2015/11/6 2:19, Lorenzo Pieralisi wrote:
>>>> On Thu, Nov 05, 2015 at 03:21:34PM +0100, Tomasz Nowicki wrote:
>>>>> On 14.10.2015 08:29, Jiang Liu wrote:
>>>>
>>>> [...]
>>>>
>>>>>> +static void acpi_pci_root_validate_resources(struct device *dev,
>>>>>> +                         struct list_head *resources,
>>>>>> +                         unsigned long type)
>>>>>> +{
>>>>>> +    LIST_HEAD(list);
>>>>>> +    struct resource *res1, *res2, *root = NULL;
>>>>>> +    struct resource_entry *tmp, *entry, *entry2;
>>>>>> +
>>>>>> +    BUG_ON((type & (IORESOURCE_MEM | IORESOURCE_IO)) == 0);
>>>>>> +    root = (type & IORESOURCE_MEM) ? &iomem_resource :
>>>>>> &ioport_resource;
>>>>>> +
>>>>>> +    list_splice_init(resources, &list);
>>>>>> +    resource_list_for_each_entry_safe(entry, tmp, &list) {
>>>>>> +        bool free = false;
>>>>>> +        resource_size_t end;
>>>>>> +
>>>>>> +        res1 = entry->res;
>>>>>> +        if (!(res1->flags & type))
>>>>>> +            goto next;
>>>>>> +
>>>>>> +        /* Exclude non-addressable range or non-addressable
>>>>>> portion */
>>>>>> +        end = min(res1->end, root->end);
>>>>>> +        if (end <= res1->start) {
>>>>>> +            dev_info(dev, "host bridge window %pR (ignored, not
>>>>>> CPU addressable)\n",
>>>>>> +                 res1);
>>>>>> +            free = true;
>>>>>> +            goto next;
>>>>>> +        } else if (res1->end != end) {
>>>>>> +            dev_info(dev, "host bridge window %pR ([%#llx-%#llx]
>>>>>> ignored, not CPU addressable)\n",
>>>>>> +                 res1, (unsigned long long)end + 1,
>>>>>> +                 (unsigned long long)res1->end);
>>>>>> +            res1->end = end;
>>>>>> +        }
>>>>>> +
>>>>>> +        resource_list_for_each_entry(entry2, resources) {
>>>>>> +            res2 = entry2->res;
>>>>>> +            if (!(res2->flags & type))
>>>>>> +                continue;
>>>>>> +
>>>>>> +            /*
>>>>>> +             * I don't like throwing away windows because then
>>>>>> +             * our resources no longer match the ACPI _CRS, but
>>>>>> +             * the kernel resource tree doesn't allow overlaps.
>>>>>> +             */
>>>>>> +            if (resource_overlaps(res1, res2)) {
>>>>>> +                res2->start = min(res1->start, res2->start);
>>>>>> +                res2->end = max(res1->end, res2->end);
>>>>>> +                dev_info(dev, "host bridge window expanded to %pR;
>>>>>> %pR ignored\n",
>>>>>> +                     res2, res1);
>>>>>> +                free = true;
>>>>>> +                goto next;
>>>>>> +            }
>>>>>> +        }
>>>>>> +
>>>>>> +next:
>>>>>> +        resource_list_del(entry);
>>>>>> +        if (free)
>>>>>> +            resource_list_free_entry(entry);
>>>>>> +        else
>>>>>> +            resource_list_add_tail(entry, resources);
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>> +int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
>>>>>> +{
>>>>>> +    int ret;
>>>>>> +    struct list_head *list = &info->resources;
>>>>>> +    struct acpi_device *device = info->bridge;
>>>>>> +    struct resource_entry *entry, *tmp;
>>>>>> +    unsigned long flags;
>>>>>> +
>>>>>> +    flags = IORESOURCE_IO | IORESOURCE_MEM |
>>>>>> IORESOURCE_MEM_8AND16BIT;
>>>>>> +    ret = acpi_dev_get_resources(device, list,
>>>>>> +                     acpi_dev_filter_resource_type_cb,
>>>>>> +                     (void *)flags);
>>>>>> +    if (ret < 0)
>>>>>> +        dev_warn(&device->dev,
>>>>>> +             "failed to parse _CRS method, error code %d\n", ret);
>>>>>> +    else if (ret == 0)
>>>>>> +        dev_dbg(&device->dev,
>>>>>> +            "no IO and memory resources present in _CRS\n");
>>>>>> +    else {
>>>>>> +        resource_list_for_each_entry_safe(entry, tmp, list) {
>>>>>> +            if (entry->res->flags & IORESOURCE_DISABLED)
>>>>>> +                resource_list_destroy_entry(entry);
>>>>>> +            else
>>>>>> +                entry->res->name = info->name;
>>>>>> +        }
>>>>>> +        acpi_pci_root_validate_resources(&device->dev, list,
>>>>>> +                         IORESOURCE_MEM);
>>>>>> +        acpi_pci_root_validate_resources(&device->dev, list,
>>>>>> +                         IORESOURCE_IO);
>>>>>
>>>>> It is not clear to me why we need these two calls above ^^^. We are
>>>>> using pci_acpi_root_add_resources(info) later. Is it not enough?
>>>>>
>>>>> Also, I cannot use acpi_pci_probe_root_resources() in my ARM64 PCI
>>>>> driver. It is because acpi_dev_get_resources is adding
>>>>> translation_offset to IO ranges start address and then:
>>>>> acpi_pci_root_validate_resources(&device->dev, list,
>>>>>                   IORESOURCE_IO);
>>>>> rejects that IO regions as it is out of my 0x0-SZ_16M window.
>>>>>
>>>>> Does acpi_pci_probe_root_resources meant to be x86 specific and I
>>>>> should avoid using it?
>>>>
>>>> IIUC, you _have_ to have the proper translation_offset to map the bridge
>>>> window into the IO address space:
>>>>
>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/348708.html
>>>>
>>>>
>>>> Then, using the offset, you should do something ia64 does, namely,
>>>> retrieve the CPU address corresponding to IO space (see
>>>> arch/ia64/pci/pci.c
>>>> - add_io_space()) and map it in the physical address space by using
>>>> pci_remap_iospace(), it is similar to what we have to do with DT.
>>>>
>>>> It is extremely confusing and I am not sure I got it right myself,
>>>> I am still grokking ia64 code to understand what it really does.
>>>>
>>>> So basically, the IO bridge window coming from acpi_dev_get_resource()
>>>> should represent the IO space in 0 - 16M, IIUC.
>>>>
>>>> By using the offset (that was initialized using translation_offset) and
>>>> the resource->start, you can retrieve the cpu address that you need to
>>>> actually map the IO space, since that's what we do on ARM (ie the
>>>> IO resource is an offset into the virtual address space set aside
>>>> for IO).
>>>>
>>>> Confusing, to say the least. Jiang, did I get it right ?
>>> Hi Lorenzo and Tomasz,
>>>      With a cup of coffee, I got myself awake eventually:)
>>> Now we are going to talk about IO port on IA64, really a little
>>> complex:( Actually there are two types of translation.
>>> 1) A PCI domain has a 24-bit IO port address space, there may
>>> be multiple IO port address spaces in systems with multiple PCI
>>> domains. So the first type of translation is to translate domain
>>> specific IO port address into system global IO port address
>>> (iomem_resource) by
>>>     res->start = acpi_des->start + acpi_des->translation_offset
>>>
>>> 2) IA64 needs to map IO port address spaces into MMIO address
>>> space because it has no instructions to access IO ports directly.
>>> So IA64 has reserved a MMIO range to map IO port address spaces.
>>> This type of translation relies on architecture specific information
>>> instead of ACPI descriptors.
>>>
>>> On the other hand, ACPI specification has defined  "I/O to Memory
>>> Translation" flag and "Memory to I/O Translation" flag in
>>> ACPI Extended Address Space Descriptor,
>>
>> Based on 2) and above, does it mean IA64 should use "ACPI Extended
>> Address Space Descriptor" for its PCI bridge IO windows only?
>>
>>   but current implementation
>>> doesn't really support such a use case. So we need to find a way
>>> out here. Could you please help to provide more information about
>>> PCI host bridge resource descriptor implementation details on
>>> ARM64?
>>>
>>
>> Sure, ARM64 (0-16M IO space) QEMU example:
>> DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
>>           0x00000000,         // Granularity
>>           0x00000000,         // Range Minimum
>>           0x0000FFFF,         // Range Maximum
>>           0x3EFF0000,         // Translation Offset
>>           0x00010000,         // Length
>>           ,, , TypeStatic)
> The above DWordIO resource descriptor doesn't confirm to the ACPI spec.
> According to my understanding, ARM/ARM64 has no concept of IO port
> address space, so the PCI host bridge will map IO port on PCI side
> onto MMIO on host side. In other words, PCI host bridge on ARM64
> implement a IO Port->MMIO translation instead of a IO Port->IO Port
> translation. If that's true, it should use 'TypeTranslation' instead
> of 'TypeStatic'. And kernel ACPI resource parsing interface doesn't
> support 'TypeTranslation' yet, so we need to find a solution for it.

I think you are right, we need TypeTranslation flag for ARM64 DWordIO 
descriptors and an extra kernel patch to support it.

Thanks,
Tomasz
