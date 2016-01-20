Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38696 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744AbcATPDa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2016 10:03:30 -0500
Received: by mail-wm0-f41.google.com with SMTP id b14so33898679wmb.1
        for <linux-pci@vger.kernel.org>; Wed, 20 Jan 2016 07:03:29 -0800 (PST)
Subject: Re: [PATCH V3 19/21] pci, acpi: Support for ACPI based generic PCI
 host controller init
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-20-git-send-email-tn@semihalf.com>
 <20160119115815.GC5276@red-moon>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <569FA145.8070201@semihalf.com>
Date: Wed, 20 Jan 2016 16:01:25 +0100
MIME-Version: 1.0
In-Reply-To: <20160119115815.GC5276@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 19.01.2016 12:58, Lorenzo Pieralisi wrote:
> On Wed, Jan 13, 2016 at 02:21:05PM +0100, Tomasz Nowicki wrote:
>> Because of two patch series:
>> 1. Jiang Liu's common interface to support PCI host controller init
>> 2. MMCONFIG refactoring (part of this patch set)
>> now we can think about generic ACPI based PCI host controller init
>> implementation out of arch/ directory.
>>
>> These calls use information from MCFG table (PCI config space regions)
>> and _CRS method (IO/irq resources) to initialize PCI hostbridge.
>>
>> TBD: We are still not sure whether we should reassign resources
>> after PCI bus enumeration or trust firmware to do all that work for
>> us properly.
>
> We should claim resources and assign unassigned ones. I put together a
> patch for resource claiming instead of reinventing the wheel, waiting
> for feedback:
>
> https://patchwork.ozlabs.org/patch/545669/
>
> If we merge the code with no resources claiming, we may end up in
> situations where claiming can trigger regressions so we won't be able
> to do it anymore.
>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Liviu Dudau <Liviu.Dudau@arm.com>
>> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/Kconfig    |   5 ++
>>   drivers/acpi/pci_root.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 136 insertions(+)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index c3664be..e315061 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -335,6 +335,11 @@ config ACPI_PCI_SLOT
>>   	  i.e., segment/bus/device/function tuples, with physical slots in
>>   	  the system.  If you are unsure, say N.
>>
>> +config ACPI_PCI_HOST_GENERIC
>> +	bool "Generic ACPI PCI host controller"
>> +	help
>> +	  Say Y here if you want to support generic ACPI PCI host controller.
>
> You should add a proper description here.

Will do.

>
>> +
>>   config X86_PM_TIMER
>>   	bool "Power Management Timer Support" if EXPERT
>>   	depends on X86
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index a65c8c2..d483e2a 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/init.h>
>>   #include <linux/types.h>
>>   #include <linux/mutex.h>
>> +#include <linux/of_address.h>
>
> We should move the IO space management to PCI core instead of having
> it in OF core, code carrying out PIO mapping does not depend on OF
> as far as I can see.

Yes, this should be cleaned up, I will add another patch in the next series.

>
>>   #include <linux/pm.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/pci.h>
>> @@ -514,6 +515,136 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>>   	}
>>   }
>>
>> +#ifdef CONFIG_ACPI_PCI_HOST_GENERIC
>> +static int pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
>> +{
>> +	if (pci_dev_msi_enabled(dev))
>> +		return 0;
>> +
>> +	acpi_pci_irq_enable(dev);
>> +	return dev->irq;
>> +}
>> +
>> +static void pci_mcfg_release_info(struct acpi_pci_root_info *ci)
>> +{
>> +	pci_mmcfg_teardown_map(ci);
>> +	kfree(ci);
>> +}
>> +
>> +static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>> +{
>> +	struct list_head *list = &ci->resources;
>> +	struct acpi_device *device = ci->bridge;
>> +	struct resource_entry *entry, *tmp;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	flags = IORESOURCE_IO | IORESOURCE_MEM;
>> +	ret = acpi_dev_get_resources(device, list,
>> +				     acpi_dev_filter_resource_type_cb,
>> +				     (void *)flags);
>> +	if (ret < 0) {
>> +		dev_warn(&device->dev,
>> +			 "failed to parse _CRS method, error code %d\n", ret);
>> +		return ret;
>> +	} else if (ret == 0)
>> +		dev_dbg(&device->dev,
>> +			"no IO and memory resources present in _CRS\n");
> 		^^^^
> 		what's the point in carrying on then ?

There is no point, hence resource_list_for_each_entry_safe will not 
iterate &ci->resources and simply return. If you like I can add here 
return to make code more readable.

>
>> +
>> +	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
>> +		resource_size_t cpu_addr, length;
>> +		struct resource *res = entry->res;
>> +
>> +		if (entry->res->flags & IORESOURCE_DISABLED)
>> +			resource_list_destroy_entry(entry);
>> +		else
>> +			res->name = ci->name;
>> +
>> +		/* PCI -> CPU space translation */
>> +		cpu_addr = res->start + entry->offset;
>> +		length = res->end - res->start + 1;
>> +
>> +		if (res->flags & IORESOURCE_MEM) {
>> +			res->start = cpu_addr;
>> +			res->end = cpu_addr + length - 1;
>> +		} else if (res->flags & IORESOURCE_IO) {
>> +			resource_size_t pci_addr = res->start;
>> +			unsigned long port;
>> +
>> +			if (pci_register_io_range(cpu_addr, length)) {
>> +				resource_list_destroy_entry(entry);
>> +				continue;
>> +			}
>> +
>> +			port = pci_address_to_pio(cpu_addr);
>> +			if (port == (unsigned long)-1) {
>> +				resource_list_destroy_entry(entry);
>> +				continue;
>> +			}
>> +
>> +			res->start = port;
>> +			res->end = port + length - 1;
>> +			entry->offset = port - pci_addr;
>> +
>> +			if (pci_remap_iospace(res, cpu_addr) < 0)
>> +				resource_list_destroy_entry(entry);
>> +		}
>> +	}
>> +	return ret;
>> +}
>> +
>> +static struct acpi_pci_root_ops acpi_pci_root_ops = {
>> +	.init_info = pci_mmcfg_setup_map,
>> +	.release_info = pci_mcfg_release_info,
>> +	.prepare_resources = pci_acpi_root_prepare_resources,
>> +};
>> +
>> +/* Root bridge scanning */
>> +struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>> +{
>> +	int node = acpi_get_node(root->device->handle);
>> +	int domain = root->segment;
>> +	int busnum = root->secondary.start;
>> +	struct acpi_pci_root_info *info;
>> +	struct pci_host_bridge *bridge;
>> +	struct pci_bus *bus, *child;
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
>> +	acpi_pci_root_ops.pci_ops = pci_mcfg_get_ops(root);
>> +	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, info, root);
>> +	if (!bus)
>> +		return NULL;
> 		^^^
> 		Leaking memory here.

No leak here. See acpi_pci_root_create->__acpi_pci_root_release_info

>
>> +
>> +	bridge = pci_find_host_bridge(bus);
>> +	bridge->map_irq = pcibios_map_irq;
>
> It would be nice to use map_irq for that, but Matthew's series seems
> stuck in review mode, either we take that series on and make some
> progress on it or you should add the irq mapping code to arm64 arch
> code, *temporarily* :)

Right, I decided to decouple this and Matthew's series.

>
> Also, we should claim resources here.

Let me investigate it more and get back to you.

>
>> +
>> +	pci_bus_size_bridges(bus);
>> +	pci_bus_assign_resources(bus);
>> +
>> +	/*
>> +	 * After the PCI-E bus has been walked and all devices discovered,
>> +	 * configure any settings of the fabric that might be necessary.
>> +	 */
>> +	list_for_each_entry(child, &bus->children, node)
>> +		pcie_bus_configure_settings(child);
>> +
>> +	return bus;
>> +}
>> +#endif /* CONFIG_ARCH_PCI_HOST_GENERIC_ACPI */
>               ^^^
> 	     does not match the #ifdef
Fixed.


Thanks,
Tomasz
