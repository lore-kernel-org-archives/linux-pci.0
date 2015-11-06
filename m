Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33366 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032921AbbKFKTI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2015 05:19:08 -0500
Received: by lbbkw15 with SMTP id kw15so48538717lbb.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2015 02:19:06 -0800 (PST)
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <1444804182-6596-5-git-send-email-jiang.liu@linux.intel.com>
 <563B65EE.7000406@semihalf.com> <20151105181959.GA352@red-moon>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <563C7E90.5080403@semihalf.com>
Date: Fri, 6 Nov 2015 11:18:56 +0100
MIME-Version: 1.0
In-Reply-To: <20151105181959.GA352@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05.11.2015 19:19, Lorenzo Pieralisi wrote:
> On Thu, Nov 05, 2015 at 03:21:34PM +0100, Tomasz Nowicki wrote:
>> On 14.10.2015 08:29, Jiang Liu wrote:
>
> [...]
>
>>> +static void acpi_pci_root_validate_resources(struct device *dev,
>>> +					     struct list_head *resources,
>>> +					     unsigned long type)
>>> +{
>>> +	LIST_HEAD(list);
>>> +	struct resource *res1, *res2, *root = NULL;
>>> +	struct resource_entry *tmp, *entry, *entry2;
>>> +
>>> +	BUG_ON((type & (IORESOURCE_MEM | IORESOURCE_IO)) == 0);
>>> +	root = (type & IORESOURCE_MEM) ? &iomem_resource : &ioport_resource;
>>> +
>>> +	list_splice_init(resources, &list);
>>> +	resource_list_for_each_entry_safe(entry, tmp, &list) {
>>> +		bool free = false;
>>> +		resource_size_t end;
>>> +
>>> +		res1 = entry->res;
>>> +		if (!(res1->flags & type))
>>> +			goto next;
>>> +
>>> +		/* Exclude non-addressable range or non-addressable portion */
>>> +		end = min(res1->end, root->end);
>>> +		if (end <= res1->start) {
>>> +			dev_info(dev, "host bridge window %pR (ignored, not CPU addressable)\n",
>>> +				 res1);
>>> +			free = true;
>>> +			goto next;
>>> +		} else if (res1->end != end) {
>>> +			dev_info(dev, "host bridge window %pR ([%#llx-%#llx] ignored, not CPU addressable)\n",
>>> +				 res1, (unsigned long long)end + 1,
>>> +				 (unsigned long long)res1->end);
>>> +			res1->end = end;
>>> +		}
>>> +
>>> +		resource_list_for_each_entry(entry2, resources) {
>>> +			res2 = entry2->res;
>>> +			if (!(res2->flags & type))
>>> +				continue;
>>> +
>>> +			/*
>>> +			 * I don't like throwing away windows because then
>>> +			 * our resources no longer match the ACPI _CRS, but
>>> +			 * the kernel resource tree doesn't allow overlaps.
>>> +			 */
>>> +			if (resource_overlaps(res1, res2)) {
>>> +				res2->start = min(res1->start, res2->start);
>>> +				res2->end = max(res1->end, res2->end);
>>> +				dev_info(dev, "host bridge window expanded to %pR; %pR ignored\n",
>>> +					 res2, res1);
>>> +				free = true;
>>> +				goto next;
>>> +			}
>>> +		}
>>> +
>>> +next:
>>> +		resource_list_del(entry);
>>> +		if (free)
>>> +			resource_list_free_entry(entry);
>>> +		else
>>> +			resource_list_add_tail(entry, resources);
>>> +	}
>>> +}
>>> +
>>> +int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
>>> +{
>>> +	int ret;
>>> +	struct list_head *list = &info->resources;
>>> +	struct acpi_device *device = info->bridge;
>>> +	struct resource_entry *entry, *tmp;
>>> +	unsigned long flags;
>>> +
>>> +	flags = IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT;
>>> +	ret = acpi_dev_get_resources(device, list,
>>> +				     acpi_dev_filter_resource_type_cb,
>>> +				     (void *)flags);
>>> +	if (ret < 0)
>>> +		dev_warn(&device->dev,
>>> +			 "failed to parse _CRS method, error code %d\n", ret);
>>> +	else if (ret == 0)
>>> +		dev_dbg(&device->dev,
>>> +			"no IO and memory resources present in _CRS\n");
>>> +	else {
>>> +		resource_list_for_each_entry_safe(entry, tmp, list) {
>>> +			if (entry->res->flags & IORESOURCE_DISABLED)
>>> +				resource_list_destroy_entry(entry);
>>> +			else
>>> +				entry->res->name = info->name;
>>> +		}
>>> +		acpi_pci_root_validate_resources(&device->dev, list,
>>> +						 IORESOURCE_MEM);
>>> +		acpi_pci_root_validate_resources(&device->dev, list,
>>> +						 IORESOURCE_IO);
>>
>> It is not clear to me why we need these two calls above ^^^. We are
>> using pci_acpi_root_add_resources(info) later. Is it not enough?
>>
>> Also, I cannot use acpi_pci_probe_root_resources() in my ARM64 PCI
>> driver. It is because acpi_dev_get_resources is adding
>> translation_offset to IO ranges start address and then:
>> acpi_pci_root_validate_resources(&device->dev, list,
>> 				 IORESOURCE_IO);
>> rejects that IO regions as it is out of my 0x0-SZ_16M window.
>>
>> Does acpi_pci_probe_root_resources meant to be x86 specific and I
>> should avoid using it?
>
> IIUC, you _have_ to have the proper translation_offset to map the bridge
> window into the IO address space:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/348708.html
>
> Then, using the offset, you should do something ia64 does, namely,
> retrieve the CPU address corresponding to IO space (see arch/ia64/pci/pci.c
> - add_io_space()) and map it in the physical address space by using
> pci_remap_iospace(), it is similar to what we have to do with DT.
>
> It is extremely confusing and I am not sure I got it right myself,
> I am still grokking ia64 code to understand what it really does.
>
> So basically, the IO bridge window coming from acpi_dev_get_resource()
> should represent the IO space in 0 - 16M, IIUC.

Yes, you are right IMO.

>
> By using the offset (that was initialized using translation_offset) and
> the resource->start, you can retrieve the cpu address that you need to
> actually map the IO space, since that's what we do on ARM (ie the
> IO resource is an offset into the virtual address space set aside
> for IO).
>

Right, that is clear to me, below my current implementation example 
which works for ARM64 now:

static struct acpi_pci_root_ops acpi_pci_root_ops = {
[...]
	.prepare_resources = pci_acpi_root_prepare_resources,
};

static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
{
	struct list_head *list = &ci->resources;
	struct acpi_device *device = ci->bridge;
	struct resource_entry *entry, *tmp;
	unsigned long flags;
	int ret;

	flags = IORESOURCE_IO | IORESOURCE_MEM;
	ret = acpi_dev_get_resources(device, list,
				     acpi_dev_filter_resource_type_cb,
				     (void *)flags);
	if (ret < 0) {
		dev_warn(&device->dev,
			 "failed to parse _CRS method, error code %d\n", ret);
		return ret;
	} else if (ret == 0)
		dev_dbg(&device->dev,
			"no IO and memory resources present in _CRS\n");

	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
		struct resource *res = entry->res;

		if (entry->res->flags & IORESOURCE_DISABLED)
			resource_list_destroy_entry(entry);
		else
			res->name = ci->name;

		/*
		 * TODO: need to move pci_register_io_range() function out
		 * of drivers/of/address.c for both used by DT and ACPI
		 */
		if (res->flags & IORESOURCE_IO) {
			unsigned long port;
			int err;
			resource_size_t length = res->end - res->start;
			resource_size_t start = res->start;

			err = pci_register_io_range(res->start, length);
			if (err) {
				resource_list_destroy_entry(entry);
				continue;
			}

			port = pci_address_to_pio(res->start);
			if (port == (unsigned long)-1) {
				resource_list_destroy_entry(entry);
				continue;
			}

			res->start = port;
			res->end = res->start + length;
			entry->offset = port - (start - entry->offset);

			if (pci_remap_iospace(res, start) < 0)
				resource_list_destroy_entry(entry);
		}
	}
	return ret;
}

As you see acpi_dev_get_resources returns:
res->start = acpi_des->start + acpi_des->translation_offset (CPU address)
which then must be adjusted as you described to get io port and call 
pci_remap_iospace.

This is also why I can not use acpi_pci_probe_root_resources here. Lets 
assume we have IO range like that DSDT table form QEMU:
DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
          0x00000000,         // Granularity
          0x00000000,         // Range Minimum
          0x0000FFFF,         // Range Maximum
          0x3EFF0000,         // Translation Offset
          0x00010000,         // Length
          ,, , TypeStatic)
so see acpi_dev_get_resources returns res->start = acpi_des->start (0x0) 
+ acpi_des->translation_offset(0x3EFF0000) = 0x3EFF0000. This will be 
rejected in acpi_pci_root_validate_resources() as 0x3EFF0000 does not 
fit within 0-16M.

My question is if acpi_pci_probe_root_resources is handling 
translation_offset properly and if we have some silent assumption 
specific for e.g. ia64 here.

Thanks for help in looking at it.

Tomasz



