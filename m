Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
To: Tomasz Nowicki <tn@semihalf.com>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <1444804182-6596-5-git-send-email-jiang.liu@linux.intel.com>
 <563B65EE.7000406@semihalf.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <563C5BEA.1090309@linux.intel.com>
Date: Fri, 6 Nov 2015 15:51:06 +0800
MIME-Version: 1.0
In-Reply-To: <563B65EE.7000406@semihalf.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/11/5 22:21, Tomasz Nowicki wrote:
> On 14.10.2015 08:29, Jiang Liu wrote:
>> Introduce common interface acpi_pci_root_create() and related data
>> structures to create PCI root bus for ACPI PCI host bridges. It will
>> be used to kill duplicated arch specific code for IA64 and x86. It may
>> also help ARM64 in future.
>>
>> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Tested-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> Signed-off-by: Liu Jiang <jiang.liu@linux.intel.com>
>> ---
>>   drivers/acpi/pci_root.c  |  204
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci-acpi.h |   24 ++++++
>>   2 files changed, 228 insertions(+)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 393706a5261b..850d7bf0c873 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -652,6 +652,210 @@ static void acpi_pci_root_remove(struct
>> acpi_device *device)
>>       kfree(root);
>>   }
>>
>> +/*
>> + * Following code to support acpi_pci_root_create() is copied from
>> + * arch/x86/pci/acpi.c and modified so it could be reused by x86, IA64
>> + * and ARM64.
>> + */
>> +static void acpi_pci_root_validate_resources(struct device *dev,
>> +                         struct list_head *resources,
>> +                         unsigned long type)
>> +{
>> +    LIST_HEAD(list);
>> +    struct resource *res1, *res2, *root = NULL;
>> +    struct resource_entry *tmp, *entry, *entry2;
>> +
>> +    BUG_ON((type & (IORESOURCE_MEM | IORESOURCE_IO)) == 0);
>> +    root = (type & IORESOURCE_MEM) ? &iomem_resource : &ioport_resource;
>> +
>> +    list_splice_init(resources, &list);
>> +    resource_list_for_each_entry_safe(entry, tmp, &list) {
>> +        bool free = false;
>> +        resource_size_t end;
>> +
>> +        res1 = entry->res;
>> +        if (!(res1->flags & type))
>> +            goto next;
>> +
>> +        /* Exclude non-addressable range or non-addressable portion */
>> +        end = min(res1->end, root->end);
>> +        if (end <= res1->start) {
>> +            dev_info(dev, "host bridge window %pR (ignored, not CPU
>> addressable)\n",
>> +                 res1);
>> +            free = true;
>> +            goto next;
>> +        } else if (res1->end != end) {
>> +            dev_info(dev, "host bridge window %pR ([%#llx-%#llx]
>> ignored, not CPU addressable)\n",
>> +                 res1, (unsigned long long)end + 1,
>> +                 (unsigned long long)res1->end);
>> +            res1->end = end;
>> +        }
>> +
>> +        resource_list_for_each_entry(entry2, resources) {
>> +            res2 = entry2->res;
>> +            if (!(res2->flags & type))
>> +                continue;
>> +
>> +            /*
>> +             * I don't like throwing away windows because then
>> +             * our resources no longer match the ACPI _CRS, but
>> +             * the kernel resource tree doesn't allow overlaps.
>> +             */
>> +            if (resource_overlaps(res1, res2)) {
>> +                res2->start = min(res1->start, res2->start);
>> +                res2->end = max(res1->end, res2->end);
>> +                dev_info(dev, "host bridge window expanded to %pR;
>> %pR ignored\n",
>> +                     res2, res1);
>> +                free = true;
>> +                goto next;
>> +            }
>> +        }
>> +
>> +next:
>> +        resource_list_del(entry);
>> +        if (free)
>> +            resource_list_free_entry(entry);
>> +        else
>> +            resource_list_add_tail(entry, resources);
>> +    }
>> +}
>> +
>> +int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
>> +{
>> +    int ret;
>> +    struct list_head *list = &info->resources;
>> +    struct acpi_device *device = info->bridge;
>> +    struct resource_entry *entry, *tmp;
>> +    unsigned long flags;
>> +
>> +    flags = IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT;
>> +    ret = acpi_dev_get_resources(device, list,
>> +                     acpi_dev_filter_resource_type_cb,
>> +                     (void *)flags);
>> +    if (ret < 0)
>> +        dev_warn(&device->dev,
>> +             "failed to parse _CRS method, error code %d\n", ret);
>> +    else if (ret == 0)
>> +        dev_dbg(&device->dev,
>> +            "no IO and memory resources present in _CRS\n");
>> +    else {
>> +        resource_list_for_each_entry_safe(entry, tmp, list) {
>> +            if (entry->res->flags & IORESOURCE_DISABLED)
>> +                resource_list_destroy_entry(entry);
>> +            else
>> +                entry->res->name = info->name;
>> +        }
>> +        acpi_pci_root_validate_resources(&device->dev, list,
>> +                         IORESOURCE_MEM);
>> +        acpi_pci_root_validate_resources(&device->dev, list,
>> +                         IORESOURCE_IO);
> 
> It is not clear to me why we need these two calls above ^^^. We are
> using pci_acpi_root_add_resources(info) later. Is it not enough?
Hi Tomasz,
	acpi_pci_root_validate_resources() will try adjust (or fix)
conflicting resources among all resources of the PCI host bridge,
but pci_acpi_root_add_resources() only rejects conflicting resources.

> 
> Also, I cannot use acpi_pci_probe_root_resources() in my ARM64 PCI
> driver. It is because acpi_dev_get_resources is adding
> translation_offset to IO ranges start address and then:
> acpi_pci_root_validate_resources(&device->dev, list,
>                  IORESOURCE_IO);
> rejects that IO regions as it is out of my 0x0-SZ_16M window.
> 
> Does acpi_pci_probe_root_resources meant to be x86 specific and I should
> avoid using it?
It should be generic, but we have some issue in support of
translation_offset. I'm trying to get this fixed.
Thanks,
Gerry

> 
> Thanks,
> Tomasz
