Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <55648D52.4000809@linaro.org>
Date: Tue, 26 May 2015 17:12:18 +0200
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
MIME-Version: 1.0
To: Hanjun Guo <hanjun.guo@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Jiang Liu <jiang.liu@linux.intel.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yijing Wang <wangyijing@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
Subject: Re: [PATCH 11/11] ARM64 / PCI / ACPI: support for ACPI based PCI
 hostbridge init
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org> <1432644564-24746-12-git-send-email-hanjun.guo@linaro.org>
In-Reply-To: <1432644564-24746-12-git-send-email-hanjun.guo@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 26.05.2015 14:49, Hanjun Guo wrote:
> Based on Jiang Liu's common interface to support PCI host bridge
> init and refactoring of MMCONFIG, this patch using information
> from ACPI MCFG table and IO/irq resources from _CRS to init
> ARM64 PCI hostbridge, then PCI will work on ARM64.
>
> This patch is based on Mark Salter and Tomasz Nowicki's work.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Liviu Dudau <Liviu.Dudau@arm.com>
> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/Kconfig      |   7 ++
>   arch/arm64/kernel/pci.c | 245 +++++++++++++++++++++++++++++++++++++++++++++---
>   drivers/pci/pci.c       |  26 +++--
>   3 files changed, 257 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 9b80428..8e4b789 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -276,6 +276,13 @@ config PCI_DOMAINS_GENERIC
>   config PCI_SYSCALL
>   	def_bool PCI
>
> +config PCI_MMCONFIG
> +	def_bool y
> +	select PCI_ECAM
> +	select HAVE_PCI_ECAM
> +	select GENERIC_PCI_ECAM
HAVE_PCI_ECAM and GENERIC_PCI_ECAM should be selected by platform.

> +	depends on ACPI
I think we should depend on PCI too.

Tomasz

> +
>   source "drivers/pci/Kconfig"
>   source "drivers/pci/pcie/Kconfig"
>   source "drivers/pci/hotplug/Kconfig"
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 4095379..d1629dc 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -11,12 +11,15 @@
>    */
>
>   #include <linux/acpi.h>
> +#include <linux/ecam.h>
>   #include <linux/init.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
>   #include <linux/mm.h>
> +#include <linux/of_address.h>
>   #include <linux/of_pci.h>
>   #include <linux/of_platform.h>
> +#include <linux/pci-acpi.h>
>   #include <linux/slab.h>
>
>   #include <asm/pci-bridge.h>
> @@ -43,31 +46,251 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>    */
>   int pcibios_add_device(struct pci_dev *dev)
>   {
> -	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> +	if (acpi_disabled)
> +		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>
>   	return 0;
>   }
>
> +#ifdef CONFIG_ACPI
> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	struct pci_controller *sd = bridge->bus->sysdata;
> +
> +	ACPI_COMPANION_SET(&bridge->dev, sd->companion);
> +	return 0;
> +}
> +
> +void pcibios_add_bus(struct pci_bus *bus)
> +{
> +	acpi_pci_add_bus(bus);
> +}
> +
> +void pcibios_remove_bus(struct pci_bus *bus)
> +{
> +	acpi_pci_remove_bus(bus);
> +}
> +
> +int pcibios_enable_irq(struct pci_dev *dev)
> +{
> +	if (!pci_dev_msi_enabled(dev))
> +		acpi_pci_irq_enable(dev);
> +	return 0;
> +}
> +
> +int pcibios_disable_irq(struct pci_dev *dev)
> +{
> +	if (!pci_dev_msi_enabled(dev))
> +		acpi_pci_irq_disable(dev);
> +	return 0;
> +}
> +
> +int pcibios_enable_device(struct pci_dev *dev, int bars)
> +{
> +	int err;
> +
> +	err = pci_enable_resources(dev, bars);
> +	if (err < 0)
> +		return err;
> +
> +	return pcibios_enable_irq(dev);
> +}
> +
> +static int __init pcibios_assign_resources(void)
> +{
> +	struct pci_bus *root_bus;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	list_for_each_entry(root_bus, &pci_root_buses, node) {
> +		pcibios_resource_survey_bus(root_bus);
> +		pci_assign_unassigned_root_bus_resources(root_bus);
> +	}
> +	return 0;
> +}
>   /*
> - * raw_pci_read/write - Platform-specific PCI config space access.
> + * fs_initcall comes after subsys_initcall, so we know acpi scan
> + * has run.
>    */
> -int raw_pci_read(unsigned int domain, unsigned int bus,
> -		  unsigned int devfn, int reg, int len, u32 *val)
> +fs_initcall(pcibios_assign_resources);
> +
> +static int pci_read(struct pci_bus *bus, unsigned int devfn, int where,
> +		    int size, u32 *value)
>   {
> -	return -ENXIO;
> +	return raw_pci_read(pci_domain_nr(bus), bus->number,
> +			    devfn, where, size, value);
>   }
>
> -int raw_pci_write(unsigned int domain, unsigned int bus,
> -		unsigned int devfn, int reg, int len, u32 val)
> +static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
> +		     int size, u32 value)
>   {
> -	return -ENXIO;
> +	return raw_pci_write(pci_domain_nr(bus), bus->number,
> +			     devfn, where, size, value);
>   }
>
> -#ifdef CONFIG_ACPI
> +struct pci_ops pci_root_ops = {
> +	.read = pci_read,
> +	.write = pci_write,
> +};
> +
> +struct pci_root_info {
> +	struct acpi_pci_root_info common;
> +#ifdef  CONFIG_PCI_MMCONFIG
> +	bool mcfg_added;
> +	u8 start_bus;
> +	u8 end_bus;
> +#endif
> +};
> +
> +#ifdef CONFIG_PCI_MMCONFIG
> +static int pci_add_mmconfig_region(struct acpi_pci_root_info *ci)
> +{
> +	struct pci_mmcfg_region *cfg;
> +	struct pci_root_info *info;
> +	struct acpi_pci_root *root = ci->root;
> +	int err, seg = ci->controller.segment;
> +
> +	info = container_of(ci, struct pci_root_info, common);
> +	info->start_bus = (u8)root->secondary.start;
> +	info->end_bus = (u8)root->secondary.end;
> +	info->mcfg_added = false;
> +
> +	rcu_read_lock();
> +	cfg = pci_mmconfig_lookup(seg, info->start_bus);
> +	rcu_read_unlock();
> +	if (cfg)
> +		return 0;
> +
> +	cfg = pci_mmconfig_alloc(seg, info->start_bus, info->end_bus,
> +				 root->mcfg_addr);
> +	if (!cfg)
> +		return -ENOMEM;
> +
> +	err = pci_mmconfig_inject(cfg);
> +	if (!err)
> +		info->mcfg_added = true;
> +
> +	return err;
> +}
> +
> +static void pci_remove_mmconfig_region(struct acpi_pci_root_info *ci)
> +{
> +	struct pci_root_info *info;
> +
> +	info = container_of(ci, struct pci_root_info, common);
> +	if (info->mcfg_added) {
> +		pci_mmconfig_delete(ci->controller.segment, info->start_bus,
> +				    info->end_bus);
> +		info->mcfg_added = false;
> +	}
> +}
> +#else
> +static int pci_add_mmconfig_region(struct acpi_pci_root_info *ci)
> +{
> +	return 0;
> +}
> +
> +static void pci_remove_mmconfig_region(struct acpi_pci_root_info *ci) { }
> +#endif
> +
> +static int pci_acpi_root_init_info(struct acpi_pci_root_info *ci)
> +{
> +	return pci_add_mmconfig_region(ci);
> +}
> +
> +static void pci_acpi_root_release_info(struct acpi_pci_root_info *ci)
> +{
> +	struct pci_root_info *info;
> +
> +	info = container_of(ci, struct pci_root_info, common);
> +	pci_remove_mmconfig_region(ci);
> +	kfree(info);
> +}
> +
> +static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci,
> +					   int status)
> +{
> +	struct resource_entry *entry, *tmp;
> +
> +	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> +		struct resource *res = entry->res;
> +
> +		/*
> +		 * Special handling for ARM IO range
> +		 * TODO: need to move pci_register_io_range() function out
> +		 * of drivers/of/address.c for both used by DT and ACPI
> +		 */
> +		if (res->flags & IORESOURCE_IO) {
> +			unsigned long port;
> +			int err;
> +			resource_size_t length = res->end - res->start;
> +
> +			err = pci_register_io_range(res->start, length);
> +			if (err) {
> +				resource_list_destroy_entry(entry);
> +				continue;
> +			}
> +
> +			port = pci_address_to_pio(res->start);
> +			if (port == (unsigned long)-1) {
> +				resource_list_destroy_entry(entry);
> +				continue;
> +			}
> +
> +			res->start = port;
> +			res->end = res->start + length - 1;
> +
> +			if (pci_remap_iospace(res, res->start) < 0)
> +				resource_list_destroy_entry(entry);
> +		}
> +	}
> +
> +	return status;
> +}
> +
> +static struct acpi_pci_root_ops acpi_pci_root_ops = {
> +	.pci_ops = &pci_root_ops,
> +	.init_info = pci_acpi_root_init_info,
> +	.release_info = pci_acpi_root_release_info,
> +	.prepare_resources = pci_acpi_root_prepare_resources,
> +};
> +
>   /* Root bridge scanning */
>   struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>   {
> -	/* TODO: Should be revisited when implementing PCI on ACPI */
> -	return NULL;
> +	struct pci_root_info *info;
> +	int node;
> +	int domain = root->segment;
> +	int busnum = root->secondary.start;
> +	struct pci_bus *bus;
> +
> +	if (domain && !pci_domains_supported) {
> +		pr_warn("PCI %04x:%02x: multiple domains not supported.\n",
> +			domain, busnum);
> +		return NULL;
> +	}
> +
> +	node = acpi_get_node(root->device->handle);
> +	info = kzalloc_node(sizeof(*info), GFP_KERNEL, node);
> +	if (!info) {
> +		dev_err(&root->device->dev, "pci_bus %04x:%02x: ignored (out of memory)\n",
> +			domain, busnum);
> +		return NULL;
> +	}
> +
> +	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, &info->common);
> +
> +	/* After the PCI-E bus has been walked and all devices discovered,
> +	 * configure any settings of the fabric that might be necessary.
> +	 */
> +	if (bus) {
> +		struct pci_bus *child;
> +
> +		list_for_each_entry(child, &bus->children, node)
> +			pcie_bus_configure_settings(child);
> +	}
> +
> +	return bus;
>   }
>   #endif
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index acc4b6e..0268a1d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -25,6 +25,7 @@
>   #include <linux/device.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/pci_hotplug.h>
> +#include <linux/acpi.h>
>   #include <asm-generic/pci-bridge.h>
>   #include <asm/setup.h>
>   #include "pci.h"
> @@ -4509,7 +4510,7 @@ int pci_get_new_domain_nr(void)
>   void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>   {
>   	static int use_dt_domains = -1;
> -	int domain = of_get_pci_domain_nr(parent->of_node);
> +	int domain;
>
>   	/*
>   	 * Check DT domain and use_dt_domains values.
> @@ -4537,17 +4538,22 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>   	 * invalidating the domain value (domain = -1) and printing a
>   	 * corresponding error.
>   	 */
> -	if (domain >= 0 && use_dt_domains) {
> -		use_dt_domains = 1;
> -	} else if (domain < 0 && use_dt_domains != 1) {
> -		use_dt_domains = 0;
> -		domain = pci_get_new_domain_nr();
> +	if (acpi_disabled) {
> +		domain = of_get_pci_domain_nr(parent->of_node);
> +		if (domain >= 0 && use_dt_domains) {
> +			use_dt_domains = 1;
> +		} else if (domain < 0 && use_dt_domains != 1) {
> +			use_dt_domains = 0;
> +			domain = pci_get_new_domain_nr();
> +		} else {
> +			dev_err(parent, "Node %s has inconsistent \"linux,pci-domain\" property in DT\n",
> +				parent->of_node->full_name);
> +			domain = -1;
> +		}
>   	} else {
> -		dev_err(parent, "Node %s has inconsistent \"linux,pci-domain\" property in DT\n",
> -			parent->of_node->full_name);
> -		domain = -1;
> +		struct pci_controller *sd = bus->sysdata;
> +		domain = sd->segment;
>   	}
> -
>   	bus->domain_nr = domain;
>   }
>   #endif
>
