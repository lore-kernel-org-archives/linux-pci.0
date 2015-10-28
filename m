Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
To: Liviu.Dudau@arm.com
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <20151028114940.GL963@e106497-lin.cambridge.arm.com>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, jiang.liu@linux.intel.com,
	robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <5630D0C6.8020304@semihalf.com>
Date: Wed, 28 Oct 2015 14:42:30 +0100
MIME-Version: 1.0
In-Reply-To: <20151028114940.GL963@e106497-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 28.10.2015 12:49, Liviu.Dudau@arm.com wrote:
> On Tue, Oct 27, 2015 at 05:38:42PM +0100, Tomasz Nowicki wrote:
>> Because of two patch series:
>> 1. Jiang Liu's common interface to support PCI host bridge init
>> 2. Refactoring of MMCONFIG, part of this patch set
>> now we can think about PCI buses enumeration for ARM64 and ACPI tables.
>>
>> This patch introduce ACPI based PCI hostbridge init calls which
>> use information from MCFG table (PCI config space regions) and
>> _CRS (IO/irq resources) to initialize PCI hostbridge.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Liviu Dudau <Liviu.Dudau@arm.com>
>> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> ---
>>   arch/arm64/Kconfig      |   6 ++
>>   arch/arm64/kernel/pci.c | 208 +++++++++++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 202 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 07d1811..bbcc6b1 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -89,6 +89,7 @@ config ARM64
>>   	select SPARSE_IRQ
>>   	select SYSCTL_EXCEPTION_TRACE
>>   	select HAVE_CONTEXT_TRACKING
>> +	select HAVE_PCI_ECAM
>>   	help
>>   	  ARM 64-bit (AArch64) Linux support.
>>
>> @@ -202,6 +203,11 @@ source "drivers/pci/Kconfig"
>>   source "drivers/pci/pcie/Kconfig"
>>   source "drivers/pci/hotplug/Kconfig"
>>
>> +config PCI_MMCONFIG
>> +	def_bool y
>> +	select PCI_ECAM
>> +	depends on ACPI
>> +
>>   endmenu
>>
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
>> +
>> +static int __init pcibios_assign_resources(void)
>> +{
>> +	if (acpi_disabled)
>> +		return 0;
>> +
>> +	pci_assign_unassigned_resources();
>> +	return 0;
>
> You can change this function into:
> {
> 	if (!acpi_disabled)
> 		pci_assign_unassigned_resources();
>
> 	return 0;
> }
>
> as the equivalent but shorter form.

Sure, will do.

>
>> +}
>>   /*
>> - * raw_pci_read/write - Platform-specific PCI config space access.
>> + * rootfs_initcall comes after subsys_initcall and fs_initcall_sync,
>> + * so we know acpi scan and PCI_FIXUP_FINAL quirks have both run.
>>    */
>> -int raw_pci_read(unsigned int domain, unsigned int bus,
>> -		  unsigned int devfn, int reg, int len, u32 *val)
>
> What happened with raw_pci_{read,write} ? Why do you remove them?

We do not need raw_pci_{read,write} any more, we will use empty 
raw_pci_{read,write} from mcfg.c introduced in patch 6/11.

I think this is another candidate to split up, first I will remove these 
raw_pci_{read,write} accessors and then introduce ACPI PCI hostbridge 
init, it will be easier to review, what do you think?

>
>
>> +rootfs_initcall(pcibios_assign_resources);
>
> Would you be so kind and explain to me why you need this initcall?
> Can you not set the PCI_REASSIGN_ALL_RSRC flag before calling
> pci_scan_root_bus() ?
>
> I haven't focused on ACPI before so I'm a bit hazy on the init order when
> that is enabled. That being said, I don't like adding in the architecture
> code initcall hooks just to fix up some dependency orders that could / should
> be fixed some other way.

My idea was to defer resource reassigning to give a chance for running 
DECLARE_PCI_FIXUP_FINAL. I used DECLARE_PCI_FIXUP_FINAL to set 
IORESOURCE_PCI_FIXED for some PCI devices. Now I am not sure we need to 
defer it, my DECLARE_PCI_FIXUP_FINALs might be done in firmware, let me 
get back to you on this.

>
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
>> +
>> +	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
>> +		struct resource *res = entry->res;
>> +
>> +		/*
>> +		 * Special handling for ARM IO range
>
> There is nothing ARM specific here. It should apply to any memory mapped IO range.

OK, I will remove that comment.

>
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
>>   }
>>   #endif
>> --
>> 1.9.1
>>
>
