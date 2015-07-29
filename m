Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 29 Jul 2015 15:24:40 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [Patch v5 4/6] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
Message-ID: <20150729202440.GA9640@google.com>
References: <1433780448-18636-1-git-send-email-jiang.liu@linux.intel.com>
 <1433780448-18636-5-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433780448-18636-5-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 09, 2015 at 12:20:46AM +0800, Jiang Liu wrote:
> Introduce common interface acpi_pci_root_create() and related data
> structures to create PCI root bus for ACPI PCI host bridges. It will
> be used to kill duplicated arch specific code for IA64 and x86. It may
> also help ARM64 in future.

I assume most of this code is copied from somewhere else.  You should
mention where it came from.

> Tested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/acpi/pci_root.c  |  198 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h |   23 ++++++
>  2 files changed, 221 insertions(+)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 1b5569c092c6..70f851dc0051 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -656,6 +656,204 @@ static void acpi_pci_root_remove(struct acpi_device *device)
>  	kfree(root);
>  }
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
> +static int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
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

Please use this style to minimize indentation and return errors as soon as
possible:

    if (ret < 0) {
	dev_warn(...)
	return ret;
    }

    if (ret == 0) {
	dev_dbg(...);
	return 0;
    }

    resource_list_for_each_entry_safe(...) {
    }
    return ret;

> +	return ret;
> +}
> +
> +static void pci_acpi_root_add_resources(struct acpi_pci_root_info *info)
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
> +static void __acpi_pci_root_release_info(struct acpi_pci_root_info *info)
> +{
> +	struct resource *res;
> +	struct resource_entry *entry, *tmp;
> +
> +	if (!info)
> +		return;

In what circumstance could "info" be NULL?  As far as I can tell, the only
way it could be NULL is if we're called from acpi_pci_root_release_info()
and the bridge->release_data element got scribbled on after we called
pci_set_host_bridge_release().  In that case, I'd rather oops than silently
return.

> +	resource_list_for_each_entry_safe(entry, tmp, &info->resources) {
> +		res = entry->res;
> +		if (res->parent &&
> +		    (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
> +			release_resource(res);
> +		resource_list_destroy_entry(entry);
> +	}
> +
> +	info->ops->release_info(info);
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
> +				     struct acpi_pci_root_info *info,
> +				     void *sysdata, int segment, int node)
> +{
> +	int ret, busnum = root->secondary.start;
> +	struct acpi_device *device = root->device;
> +	struct pci_bus *bus;
> +
> +	info->root = root;
> +	info->bridge = device;
> +	info->ops = ops;
> +	INIT_LIST_HEAD(&info->resources);
> +	snprintf(info->name, sizeof(info->name), "PCI Bus %04x:%02x",
> +		 segment, busnum);
> +
> +	if (ops->init_info && ops->init_info(info))
> +		goto out_release_info;
> +	ret = acpi_pci_probe_root_resources(info);
> +	if (ops->prepare_resources)
> +		ret = ops->prepare_resources(info, ret);

It's goofy to pass the return value from acpi_pci_probe_root_resources()
into prepare_resources(), especially since the local context gives no clue
about what "ret" means.

Neither the x86 nor the ia64 version of pci_acpi_root_prepare_resources()
actually does anything useful with "ret" except return it.

I think you should just make acpi_pci_probe_root_resources() void.  It will
create a list of zero or more resources from _CRS.  If _CRS fails, you
already print a diagnostic and the list will be empty.  If _CRS succeeds
and there are no windows, you also print a (debug) diagnostic and the list
will be empty.  The pci_acpi_root_prepare_resources() implementations will
deal with empty lists just fine.

I think the change from your code here is that we would create the root bus
and enumerate it even if _CRS fails.  I think that's OK: we'll find devices
and we'll learn what resources they want, but we won't have anything to
assign them.  I think that's OK and it will make this code simpler.

> +	if (ret < 0)
> +		goto out_release_info;
> +	else if (ret > 0)
> +		pci_acpi_root_add_resources(info);
> +	pci_add_resource(&info->resources, &root->secondary);
> +
> +	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
> +				  sysdata, &info->resources);
> +	if (bus) {

    if (!bus)
	goto out_release_info;

Then this code can be un-indented:

> +		pci_scan_child_bus(bus);
> +		pci_set_host_bridge_release(to_pci_host_bridge(bus->bridge),
> +					    acpi_pci_root_release_info, info);
> +		if (node != NUMA_NO_NODE)
> +			dev_printk(KERN_DEBUG, &bus->dev, "on NUMA node %d\n",
> +				   node);
> +		return bus;
> +	}
> +
> +out_release_info:
> +	__acpi_pci_root_release_info(info);
> +	return NULL;
> +}
> +
>  void __init acpi_pci_root_init(void)
>  {
>  	acpi_hest_init();
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index a965efa52152..a76cb6f24ca1 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -52,6 +52,29 @@ static inline acpi_handle acpi_pci_get_bridge_handle(struct pci_bus *pbus)
>  	return ACPI_HANDLE(dev);
>  }
>  
> +struct acpi_pci_root;
> +struct acpi_pci_root_ops;
> +
> +struct acpi_pci_root_info {
> +	struct acpi_pci_root		*root;
> +	struct acpi_device		*bridge;
> +	struct acpi_pci_root_ops	*ops;
> +	struct list_head		resources;
> +	char				name[16];
> +};
> +
> +struct acpi_pci_root_ops {
> +	struct pci_ops *pci_ops;
> +	int (*init_info)(struct acpi_pci_root_info *info);
> +	void (*release_info)(struct acpi_pci_root_info *info);
> +	int (*prepare_resources)(struct acpi_pci_root_info *info, int status);
> +};
> +
> +extern struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> +					    struct acpi_pci_root_ops *ops,
> +					    struct acpi_pci_root_info *info,
> +					    void *sd, int seg, int node);

Drop the "extern" here to match the declarations below.  I know there's
still a mix in this file, but my preference is to skip them in new code.

>  void acpi_pci_add_bus(struct pci_bus *bus);
>  void acpi_pci_remove_bus(struct pci_bus *bus);
>  
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
