Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36456 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbbEKNgf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2015 09:36:35 -0400
Received: by pabsx10 with SMTP id sx10so110308131pab.3
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2015 06:36:34 -0700 (PDT)
Message-ID: <5550B056.2080608@linaro.org>
Date: Mon, 11 May 2015 21:36:22 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Len Brown <lenb@kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	"x86 @ kernel . org" <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC v2 5/7] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
References: <1430793970-11159-1-git-send-email-jiang.liu@linux.intel.com> <1430793970-11159-6-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1430793970-11159-6-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jiang,

I have comments inline.

On 2015年05月05日 10:46, Jiang Liu wrote:
> Introduce common interface acpi_pci_root_create() and related data
> structures to create PCI root bus for ACPI PCI host bridges. It will
> be used to kill duplicated arch specific code for IA64 and x86. It may
> also help ARM64 in future.
>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>   drivers/acpi/pci_root.c  |  214 ++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/pci-acpi.h |   24 ++++++
>   2 files changed, 238 insertions(+)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 1b5569c092c6..97c260959a54 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -656,6 +656,220 @@ static void acpi_pci_root_remove(struct acpi_device *device)
>   	kfree(root);
>   }
>
> +static void acpi_pci_root_validate_resources(struct device *dev,
> +					     struct list_head *resources,
> +					     unsigned long type)
> +{
> +	LIST_HEAD(list);
> +	struct resource *res1, *res2, *root = NULL;
> +	struct resource_entry *tmp, *entry, *entry2;
> +
> +	BUG_ON((type & (IORESOURCE_MEM | IORESOURCE_IO)) == 0);
> +	root = (type & IORESOURCE_MEM) ? &iomem_resource : &ioport_resource;
> +
> +	list_splice_init(resources, &list);
> +	resource_list_for_each_entry_safe(entry, tmp, &list) {
> +		bool free = false;
> +		resource_size_t end;
> +
> +		res1 = entry->res;
> +		if (!(res1->flags & type))
> +			goto next;
> +
> +		/* Exclude non-addressable range or non-addressable portion */
> +		end = min(res1->end, root->end);
> +		if (end <= res1->start) {
> +			dev_info(dev, "host bridge window %pR (ignored, not CPU addressable)\n",
> +				 res1);
> +			free = true;
> +			goto next;
> +		} else if (res1->end != end) {
> +			dev_info(dev, "host bridge window %pR ([%#llx-%#llx] ignored, not CPU addressable)\n",
> +				 res1, (unsigned long long)end + 1,
> +				 (unsigned long long)res1->end);
> +			res1->end = end;
> +		}
> +
> +		resource_list_for_each_entry(entry2, resources) {
> +			res2 = entry2->res;
> +			if (!(res2->flags & type))
> +				continue;
> +
> +			/*
> +			 * I don't like throwing away windows because then
> +			 * our resources no longer match the ACPI _CRS, but
> +			 * the kernel resource tree doesn't allow overlaps.
> +			 */
> +			if (resource_overlaps(res1, res2)) {
> +				res2->start = min(res1->start, res2->start);
> +				res2->end = max(res1->end, res2->end);
> +				dev_info(dev, "host bridge window expanded to %pR; %pR ignored\n",
> +					 res2, res1);
> +				free = true;
> +				goto next;
> +			}
> +		}
> +
> +next:
> +		resource_list_del(entry);
> +		if (free)
> +			resource_list_free_entry(entry);
> +		else
> +			resource_list_add_tail(entry, resources);
> +	}
> +}
> +
> +static int acpi_pci_probe_root_resources(struct acpi_pci_root_info_common *info)
> +{
> +	int ret;
> +	struct list_head *list = &info->resources;
> +	struct acpi_device *device = info->bridge;
> +	struct resource_entry *entry, *tmp;
> +	unsigned long flags;
> +
> +	flags = IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT;
> +	ret = acpi_dev_get_resources(device, list,
> +				     acpi_dev_filter_resource_type_cb,
> +				     (void *)flags);
> +	if (ret < 0)
> +		dev_warn(&device->dev,
> +			 "failed to parse _CRS method, error code %d\n", ret);
> +	else if (ret == 0)
> +		dev_dbg(&device->dev,
> +			"no IO and memory resources present in _CRS\n");
> +	else {
> +		resource_list_for_each_entry_safe(entry, tmp, list) {
> +			if (entry->res->flags & IORESOURCE_DISABLED)
> +				resource_list_destroy_entry(entry);
> +			else
> +				entry->res->name = info->name;
> +		}
> +		acpi_pci_root_validate_resources(&device->dev, list,
> +						 IORESOURCE_MEM);
> +		acpi_pci_root_validate_resources(&device->dev, list,
> +						 IORESOURCE_IO);
> +	}
> +
> +	return ret;
> +}
> +
> +static void pci_acpi_root_add_resources(struct acpi_pci_root_info_common *info)
> +{
> +	struct resource_entry *entry, *tmp;
> +	struct resource *res, *conflict, *root = NULL;
> +
> +	resource_list_for_each_entry_safe(entry, tmp, &info->resources) {
> +		res = entry->res;
> +		if (res->flags & IORESOURCE_MEM)
> +			root = &iomem_resource;
> +		else if (res->flags & IORESOURCE_IO)
> +			root = &ioport_resource;
> +		else
> +			continue;
> +
> +		conflict = insert_resource_conflict(root, res);
> +		if (conflict) {
> +			dev_info(&info->bridge->dev,
> +				 "ignoring host bridge window %pR (conflicts with %s %pR)\n",
> +				 res, conflict->name, conflict);
> +			resource_list_destroy_entry(entry);
> +		}
> +	}
> +}
> +
> +static void __acpi_pci_root_release_info(struct acpi_pci_root_info_common *info)
> +{
> +	struct resource *res;
> +	struct resource_entry *entry, *tmp;
> +
> +	if (!info)
> +		return;
> +
> +	if (info->ops && info->ops->release_info)
> +		info->ops->release_info(info);
> +
> +	resource_list_for_each_entry_safe(entry, tmp, &info->resources) {
> +		res = entry->res;
> +		if (res->parent &&
> +		    (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
> +			release_resource(res);
> +		resource_list_destroy_entry(entry);
> +	}
> +
> +	kfree(info);
> +}
> +
> +static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
> +{
> +	struct resource *res;
> +	struct resource_entry *entry;
> +
> +	resource_list_for_each_entry(entry, &bridge->windows) {
> +		res = entry->res;
> +		if (res->parent &&
> +		    (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
> +			release_resource(res);
> +	}
> +	__acpi_pci_root_release_info(bridge->release_data);
> +}
> +
> +struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> +				     struct acpi_pci_root_ops *ops,
> +				     size_t extra_size)
> +{
> +	int ret, busnum = root->secondary.start;
> +	struct acpi_device *device = root->device;
> +	struct acpi_pci_root_info_common *info;
> +	struct pci_bus *bus;
> +
> +	info = kzalloc(sizeof(*info) + extra_size, GFP_KERNEL);

For x86, the memory is allocated on its local numa node if memory
is available by using kzalloc_node(), and if
node = acpi_get_node(device->handle) is NUMA_NO_NODE, the code will
get the numa node info by using x86_pci_root_bus_node() (which you
consolidate them as a function pci_acpi_root_get_node() in later
patch).

but the code here just ignore that information, so the code
here has functional change for x86 code since you didn't use numa
information.

I'm not sure how frequently used for the info after init, so
not sure about the performance impact, but I think we should
keep consistence with the code behavior as before.

Further more, there is a implicit cast for
struct acpi_pci_root_info_common *info to arch specific
struct pci_root_info *info by using extra size, it's not
easy to understand (at least for me :) ), so how about
alloc the memory in arch specific function, and pass
struct acpi_pci_root_info_common *info fr this function?

other than that, this code is pretty good, I reworked ARM64
ACPI based PCI host bridge init code, and this patch simplified
the coed a lot, will have a test tomorrow and let you know
the result.

Thanks
Hanjun
