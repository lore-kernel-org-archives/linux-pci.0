Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 15 Oct 2015 15:47:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
Message-ID: <20151015204720.GG10442@localhost>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <1444804182-6596-5-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444804182-6596-5-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 14, 2015 at 02:29:39PM +0800, Jiang Liu wrote:
> Introduce common interface acpi_pci_root_create() and related data
> structures to create PCI root bus for ACPI PCI host bridges. It will
> be used to kill duplicated arch specific code for IA64 and x86. It may
> also help ARM64 in future.
> 
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Signed-off-by: Liu Jiang <jiang.liu@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/acpi/pci_root.c  |  204 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h |   24 ++++++
>  2 files changed, 228 insertions(+)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 393706a5261b..850d7bf0c873 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -652,6 +652,210 @@ static void acpi_pci_root_remove(struct acpi_device *device)
>  	kfree(root);
>  }
>  
> +/*
> + * Following code to support acpi_pci_root_create() is copied from
> + * arch/x86/pci/acpi.c and modified so it could be reused by x86, IA64
> + * and ARM64.
> + */
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
> +int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
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
> +
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
> +				     void *sysdata)
> +{
> +	int ret, busnum = root->secondary.start;
> +	struct acpi_device *device = root->device;
> +	int node = acpi_get_node(device->handle);
> +	struct pci_bus *bus;
> +
> +	info->root = root;
> +	info->bridge = device;
> +	info->ops = ops;
> +	INIT_LIST_HEAD(&info->resources);
> +	snprintf(info->name, sizeof(info->name), "PCI Bus %04x:%02x",
> +		 root->segment, busnum);
> +
> +	if (ops->init_info && ops->init_info(info))
> +		goto out_release_info;
> +	if (ops->prepare_resources)
> +		ret = ops->prepare_resources(info);
> +	else
> +		ret = acpi_pci_probe_root_resources(info);
> +	if (ret < 0)
> +		goto out_release_info;
> +
> +	pci_acpi_root_add_resources(info);
> +	pci_add_resource(&info->resources, &root->secondary);
> +	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
> +				  sysdata, &info->resources);
> +	if (!bus)
> +		goto out_release_info;
> +
> +	pci_scan_child_bus(bus);
> +	pci_set_host_bridge_release(to_pci_host_bridge(bus->bridge),
> +				    acpi_pci_root_release_info, info);
> +	if (node != NUMA_NO_NODE)
> +		dev_printk(KERN_DEBUG, &bus->dev, "on NUMA node %d\n", node);
> +	return bus;
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
> index a965efa52152..89ab0572dbc6 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -52,6 +52,30 @@ static inline acpi_handle acpi_pci_get_bridge_handle(struct pci_bus *pbus)
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
> +	int (*prepare_resources)(struct acpi_pci_root_info *info);
> +};
> +
> +extern int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info);
> +extern struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> +					    struct acpi_pci_root_ops *ops,
> +					    struct acpi_pci_root_info *info,
> +					    void *sd);
> +
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
