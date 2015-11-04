Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <20151103165555.GF3574@red-moon>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Message-ID: <5639D6F4.4040308@linaro.org>
Date: Wed, 4 Nov 2015 10:59:16 +0100
MIME-Version: 1.0
In-Reply-To: <20151103165555.GF3574@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03.11.2015 17:55, Lorenzo Pieralisi wrote:
> On Tue, Oct 27, 2015 at 05:38:42PM +0100, Tomasz Nowicki wrote:
>
> [...]
>
>>   menu "Kernel Features"
>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>> index b3d098b..66cc1ae 100644
>> --- a/arch/arm64/kernel/pci.c
>> +++ b/arch/arm64/kernel/pci.c
>> @@ -11,12 +11,15 @@
>>    */
>>
>>   #include <linux/acpi.h>
>> +#include <linux/ecam.h>
>>   #include <linux/init.h>
>>   #include <linux/io.h>
>>   #include <linux/kernel.h>
>>   #include <linux/mm.h>
>> +#include <linux/of_address.h>
>>   #include <linux/of_pci.h>
>>   #include <linux/of_platform.h>
>> +#include <linux/pci-acpi.h>
>>   #include <linux/slab.h>
>>
>>   #include <asm/pci-bridge.h>
>> @@ -52,35 +55,216 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>>   }
>>
>>   /*
>> - * Try to assign the IRQ number from DT when adding a new device
>> + * Try to assign the IRQ number from DT/ACPI when adding a new device
>>    */
>>   int pcibios_add_device(struct pci_dev *dev)
>>   {
>> -	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>> +	if (acpi_disabled)
>> +		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>> +#ifdef CONFIG_ACPI
>> +	else
>> +		acpi_pci_irq_enable(dev);
>> +#endif
>
> This series:
>
> http://www.spinics.net/lists/linux-pci/msg45950.html
>
> will allow us to initialize the irq mapping function according to
> the boot method, code above is getting cumbersome and it is already
> overriden when booting with DT, so we will remove it altogether.
>
>>
>>   	return 0;
>>   }
>>
>> +#ifdef CONFIG_ACPI
>> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>> +{
>> +	struct acpi_pci_root *root = bridge->bus->sysdata;
>> +
>> +	ACPI_COMPANION_SET(&bridge->dev, root->device);
>> +	return 0;
>
> This should be made part of core code IMO.
>
>> +}
>> +
>> +void pcibios_add_bus(struct pci_bus *bus)
>> +{
>> +	acpi_pci_add_bus(bus);
>> +}
>> +
>> +void pcibios_remove_bus(struct pci_bus *bus)
>> +{
>> +	acpi_pci_remove_bus(bus);
>> +}
>
> Two functions above are identical for arm64, ia64 and x86, I do
> not think they belong in arch code.
>
>> +static int __init pcibios_assign_resources(void)
>> +{
>> +	if (acpi_disabled)
>> +		return 0;
>> +
>> +	pci_assign_unassigned_resources();
>> +	return 0;
>
> Already commented on this.
>
>> +}
>>   /*
>> - * raw_pci_read/write - Platform-specific PCI config space access.
>> + * rootfs_initcall comes after subsys_initcall and fs_initcall_sync,
>> + * so we know acpi scan and PCI_FIXUP_FINAL quirks have both run.
>>    */
>> -int raw_pci_read(unsigned int domain, unsigned int bus,
>> -		  unsigned int devfn, int reg, int len, u32 *val)
>> +rootfs_initcall(pcibios_assign_resources);
>> +
>> +static void __iomem *
>> +pci_mcfg_dev_base(struct pci_bus *bus, unsigned int devfn, int offset)
>>   {
>> -	return -ENXIO;
>> +	struct pci_mmcfg_region *cfg;
>> +
>> +	cfg = pci_mmconfig_lookup(pci_domain_nr(bus), bus->number);
>> +	if (cfg && cfg->virt)
>> +		return cfg->virt +
>> +			(PCI_MMCFG_BUS_OFFSET(bus->number) | (devfn << 12)) +
>> +			offset;
>> +	return NULL;
>
> Why is this code arm64 specific ?
>
>>   }
>>
>> -int raw_pci_write(unsigned int domain, unsigned int bus,
>> -		unsigned int devfn, int reg, int len, u32 val)
>> +struct pci_ops pci_root_ops = {
>> +	.map_bus = pci_mcfg_dev_base,
>> +	.read = pci_generic_config_read,
>> +	.write = pci_generic_config_write,
>> +};
>> +
>> +#ifdef CONFIG_PCI_MMCONFIG
>> +static int pci_add_mmconfig_region(struct acpi_pci_root_info *ci)
>>   {
>> -	return -ENXIO;
>> +	struct pci_mmcfg_region *cfg;
>> +	struct acpi_pci_root *root;
>> +	int seg, start, end, err;
>> +
>> +	root = ci->root;
>> +	seg = root->segment;
>> +	start = root->secondary.start;
>> +	end = root->secondary.end;
>> +
>> +	cfg = pci_mmconfig_lookup(seg, start);
>> +	if (cfg)
>> +		return 0;
>> +
>> +	cfg = pci_mmconfig_alloc(seg, start, end, root->mcfg_addr);
>> +	if (!cfg)
>> +		return -ENOMEM;
>> +
>> +	err = pci_mmconfig_inject(cfg);
>> +	return err;
>>   }
>>
>> -#ifdef CONFIG_ACPI
>> +static void pci_remove_mmconfig_region(struct acpi_pci_root_info *ci)
>> +{
>> +	struct acpi_pci_root *root = ci->root;
>> +	struct pci_mmcfg_region *cfg;
>> +
>> +	cfg = pci_mmconfig_lookup(root->segment, root->secondary.start);
>> +	if (cfg)
>> +		return;
>> +
>> +	if (cfg->hot_added)
>> +		pci_mmconfig_delete(root->segment, root->secondary.start,
>> +				    root->secondary.end);
>> +}
>> +#else
>> +static int pci_add_mmconfig_region(struct acpi_pci_root_info *ci)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void pci_remove_mmconfig_region(struct acpi_pci_root_info *ci) { }
>> +#endif
>
> Ditto.
>
>> +
>> +static int pci_acpi_root_init_info(struct acpi_pci_root_info *ci)
>> +{
>> +	return pci_add_mmconfig_region(ci);
>> +}
>> +
>> +static void pci_acpi_root_release_info(struct acpi_pci_root_info *ci)
>> +{
>> +	pci_remove_mmconfig_region(ci);
>> +	kfree(ci);
>> +}
>> +
>> +static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>> +{
>> +	struct resource_entry *entry, *tmp;
>> +	int ret;
>> +
>> +	ret = acpi_pci_probe_root_resources(ci);
>> +	if (ret < 0)
>> +		return ret;
>
> Code above is identical on arm64, ia64 and x86.
>
>> +
>> +	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
>> +		struct resource *res = entry->res;
>> +
>> +		/*
>> +		 * Special handling for ARM IO range
>> +		 * TODO: need to move pci_register_io_range() function out
>> +		 * of drivers/of/address.c for both used by DT and ACPI
>> +		 */
>> +		if (res->flags & IORESOURCE_IO) {
>> +			unsigned long port;
>> +			int err;
>> +			resource_size_t length = res->end - res->start;
>> +
>> +			err = pci_register_io_range(res->start, length);
>> +			if (err) {
>> +				resource_list_destroy_entry(entry);
>> +				continue;
>> +			}
>> +
>> +			port = pci_address_to_pio(res->start);
>> +			if (port == (unsigned long)-1) {
>> +				resource_list_destroy_entry(entry);
>> +				continue;
>> +			}
>> +
>> +			res->start = port;
>> +			res->end = res->start + length - 1;
>> +
>> +			if (pci_remap_iospace(res, res->start) < 0)
>> +				resource_list_destroy_entry(entry);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct acpi_pci_root_ops acpi_pci_root_ops = {
>> +	.pci_ops = &pci_root_ops,
>> +	.init_info = pci_acpi_root_init_info,
>> +	.release_info = pci_acpi_root_release_info,
>> +	.prepare_resources = pci_acpi_root_prepare_resources,
>> +};
>> +
>>   /* Root bridge scanning */
>>   struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>>   {
>> -	/* TODO: Should be revisited when implementing PCI on ACPI */
>> -	return NULL;
>> +	int node = acpi_get_node(root->device->handle);
>> +	int domain = root->segment;
>> +	int busnum = root->secondary.start;
>> +	struct acpi_pci_root_info *info;
>> +	struct pci_bus *bus;
>> +
>> +	if (domain && !pci_domains_supported) {
>> +		pr_warn("PCI %04x:%02x: multiple domains not supported.\n",
>> +			domain, busnum);
>> +		return NULL;
>> +	}
>> +
>> +	info = kzalloc_node(sizeof(*info), GFP_KERNEL, node);
>> +	if (!info) {
>> +		dev_err(&root->device->dev,
>> +			"pci_bus %04x:%02x: ignored (out of memory)\n",
>> +			domain, busnum);
>> +		return NULL;
>> +	}
>> +
>> +	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, info, root);
>> +
>> +	/* After the PCI-E bus has been walked and all devices discovered,
>> +	 * configure any settings of the fabric that might be necessary.
>> +	 */
>> +	if (bus) {
>> +		struct pci_bus *child;
>> +
>> +		list_for_each_entry(child, &bus->children, node)
>> +			pcie_bus_configure_settings(child);
>> +	}
>> +
>> +	return bus;
>
> Code above is entirely arch agnostic (apart from what data is passed to
> sysdata) and I think there is room for further consolidation with
> x86 and ia64, I will have a look into this.
>

I agree with your comments, currently I do not know how much of it can 
be consolidated but I will rework my next version in this direction.

Thanks,
Tomasz
