Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:56817 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757225Ab2DZPF0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 11:05:26 -0400
Received: by dadz8 with SMTP id z8so1694823dad.10
        for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 08:05:25 -0700 (PDT)
Message-ID: <4F996401.5010609@gmail.com>
Date: Thu, 26 Apr 2012 23:04:33 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Keping Chen <chenkeping@huawei.com>, ddutile@redhat.com,
	greg.pearson@hp.com
Subject: Re: [PATCH 6/6] PCI, x86: change the way to add MMCFG region on x86
References: <20120426193712.11256973.izumi.taku@jp.fujitsu.com> <20120426194254.3679abe0.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120426194254.3679abe0.izumi.taku@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Taku,
	Thanks for following this up. Please refer to inline comments below.
I feel there are still some concerns from Don about the change proposed by
Bjorn. And I haven't found a solution to address Don's concerns yet. So it
would be better for us to hold on this for a while.

	BTW, is it OK to split the task into two steps? 
1) enhance mmcfg to support host bridge hotplug.
2) refine the mmcfg setup logic.
Seems it's more realistic for us to reach an agreement for task 1 in a short time,
but there is still much work ahead for task 2.

On 04/26/2012 06:42 PM, Taku Izumi wrote:
> 
> This patch changes the way to add MMCFG region on x86.
> MMCFG region information provided by ACPI MCFG table 
> or _CBA method will be added at acpi_pci_root_add()
> of pci_root driver.
> 
> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  arch/x86/include/asm/pci_x86.h |    2 +
>  arch/x86/pci/acpi.c            |   45 +++++++++++++++++++++++++++++++++++++
>  arch/x86/pci/mmconfig-shared.c |   49 ++++++++++++++++++++++++++++++-----------
>  arch/x86/pci/mmconfig_32.c     |    2 -
>  arch/x86/pci/mmconfig_64.c     |    2 -
>  drivers/acpi/pci_root.c        |   15 ++++++++++++
>  include/acpi/acnames.h         |    1 
>  include/linux/pci-acpi.h       |    3 ++
>  8 files changed, 105 insertions(+), 14 deletions(-)
> 
> Index: bjorn-next/arch/x86/include/asm/pci_x86.h
> ===================================================================
> --- bjorn-next.orig/arch/x86/include/asm/pci_x86.h
> +++ bjorn-next/arch/x86/include/asm/pci_x86.h
> @@ -100,6 +100,7 @@ struct pci_raw_ops {
>  extern const struct pci_raw_ops *raw_pci_ops;
>  extern const struct pci_raw_ops *raw_pci_ext_ops;
>  
> +extern const struct pci_raw_ops pci_mmcfg;
>  extern const struct pci_raw_ops pci_direct_conf1;
>  extern bool port_cf9_safe;
>  
> @@ -140,6 +141,7 @@ extern void pci_mmcfg_arch_unmap(struct 
>  extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
>  extern int __devinit pci_mmconfig_add(int seg, int start, int end, u64 addr);
>  extern int pci_mmconfig_delete(int seg, int start, int end);
> +extern u64 query_acpi_mcfg_table(int segment, int start);
>  extern struct list_head pci_mmcfg_list;
>  
>  #define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
> Index: bjorn-next/arch/x86/pci/acpi.c
> ===================================================================
> --- bjorn-next.orig/arch/x86/pci/acpi.c
> +++ bjorn-next/arch/x86/pci/acpi.c
> @@ -4,6 +4,7 @@
>  #include <linux/irq.h>
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
> +#include <linux/pci-acpi.h>
>  #include <asm/numa.h>
>  #include <asm/pci_x86.h>
>  
> @@ -461,6 +462,50 @@ struct pci_bus * __devinit pci_acpi_scan
>  	return bus;
>  }
>  
> +
> +int __devinit arch_acpi_pci_root_add(struct acpi_pci_root *root)
> +{
> +	int result = 0;
> +	acpi_status status;
> +	unsigned long long base_addr = 0;
> +
> +	/* MMCFG not in use */
> +	if (raw_pci_ext_ops && raw_pci_ext_ops != &pci_mmcfg)
> +		return result;
> +
> +	/* Evaluate _CBA */
> +	status = acpi_evaluate_integer(root->device->handle, METHOD_NAME__CBA,
> +				       NULL, &base_addr);
> +	if (ACPI_FAILURE(status)) {
> +		/* search MCFG table */
> +		base_addr = query_acpi_mcfg_table(root->segment,
> +						  root->secondary.start);
> +
> +	}
> +
> +	/* add MMCFG region */
> +	if (base_addr) {
> +		if (pci_mmconfig_add(root->segment, root->secondary.start,
> +					root->secondary.end, base_addr)) {
> +			printk(KERN_ERR
> +				"can't add MMCFG information for Bus "
> +				"%04x:%02x\n",
> +				root->segment,
> +				(unsigned int)root->secondary.start);
Should set 'result' to suitable error code here.

> +		}
raw_pci_ext_ops should be set to &pci_mmcfg if raw_pci_ext_ops is still NULL
and pci_mmconfig_add succeeds.

> +	} else {
> +		result = -ENODEV;
> +	}
> +
> +	return result;
> +}
> +
> +void arch_acpi_pci_root_remove(struct acpi_pci_root *root)
> +{
> +	pci_mmconfig_delete(root->segment, root->secondary.start,
> +				root->secondary.end);
> +}
> +
>  int __init pci_acpi_init(void)
>  {
>  	struct pci_dev *dev = NULL;
> Index: bjorn-next/arch/x86/pci/mmconfig_32.c
> ===================================================================
> --- bjorn-next.orig/arch/x86/pci/mmconfig_32.c
> +++ bjorn-next/arch/x86/pci/mmconfig_32.c
> @@ -126,7 +126,7 @@ static int pci_mmcfg_write(unsigned int 
>  	return 0;
>  }
>  
> -static const struct pci_raw_ops pci_mmcfg = {
> +const struct pci_raw_ops pci_mmcfg = {
>  	.read =		pci_mmcfg_read,
>  	.write =	pci_mmcfg_write,
>  };
> Index: bjorn-next/arch/x86/pci/mmconfig_64.c
> ===================================================================
> --- bjorn-next.orig/arch/x86/pci/mmconfig_64.c
> +++ bjorn-next/arch/x86/pci/mmconfig_64.c
> @@ -90,7 +90,7 @@ static int pci_mmcfg_write(unsigned int 
>  	return 0;
>  }
>  
> -static const struct pci_raw_ops pci_mmcfg = {
> +const struct pci_raw_ops pci_mmcfg = {
>  	.read =		pci_mmcfg_read,
>  	.write =	pci_mmcfg_write,
>  };
> Index: bjorn-next/drivers/acpi/pci_root.c
> ===================================================================
> --- bjorn-next.orig/drivers/acpi/pci_root.c
> +++ bjorn-next/drivers/acpi/pci_root.c
> @@ -449,6 +449,15 @@ out:
>  }
>  EXPORT_SYMBOL(acpi_pci_osc_control_set);
>  
> +int __weak arch_acpi_pci_root_add(struct acpi_pci_root *root)
> +{
> +	return 0;
> +}
> +
> +void __weak arch_acpi_pci_root_remove(struct acpi_pci_root *root)
> +{
> +}
> +
>  static int __devinit acpi_pci_root_add(struct acpi_device *device)
>  {
>  	unsigned long long segment, bus;
> @@ -505,6 +514,11 @@ static int __devinit acpi_pci_root_add(s
>  	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
>  	device->driver_data = root;
>  
> +	if (arch_acpi_pci_root_add(root)) {
> +		result = -ENODEV;
> +		goto end;
> +	}
> +
>  	/*
>  	 * All supported architectures that use ACPI have support for
>  	 * PCI domains, so we indicate this in _OSC support capabilities.
> @@ -627,6 +641,7 @@ static int __devinit acpi_pci_root_add(s
>  end:
>  	if (!list_empty(&root->node))
>  		list_del(&root->node);
> +	arch_acpi_pci_root_remove(root);
>  	kfree(root);
>  	return result;
>  }
> Index: bjorn-next/include/acpi/acnames.h
> ===================================================================
> --- bjorn-next.orig/include/acpi/acnames.h
> +++ bjorn-next/include/acpi/acnames.h
> @@ -62,6 +62,7 @@
>  #define METHOD_NAME__AEI        "_AEI"
>  #define METHOD_NAME__PRW        "_PRW"
>  #define METHOD_NAME__SRS        "_SRS"
> +#define METHOD_NAME__CBA	"_CBA"
>  
>  /* Method names - these methods must appear at the namespace root */
>  
> Index: bjorn-next/include/linux/pci-acpi.h
> ===================================================================
> --- bjorn-next.orig/include/linux/pci-acpi.h
> +++ bjorn-next/include/linux/pci-acpi.h
> @@ -18,6 +18,9 @@ extern acpi_status pci_acpi_add_pm_notif
>  					     struct pci_dev *pci_dev);
>  extern acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev);
>  
> +int arch_acpi_pci_root_add(struct acpi_pci_root *root);
> +void arch_acpi_pci_root_remove(struct acpi_pci_root *root);
> +
>  static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
>  {
>  	struct pci_bus *pbus = pdev->bus;
> Index: bjorn-next/arch/x86/pci/mmconfig-shared.c
> ===================================================================
> --- bjorn-next.orig/arch/x86/pci/mmconfig-shared.c
> +++ bjorn-next/arch/x86/pci/mmconfig-shared.c
> @@ -28,6 +28,9 @@
>  /* Indicate if the mmcfg resources have been placed into the resource table. */
>  static int __initdata pci_mmcfg_resources_inserted;
>  
> +static struct acpi_mcfg_allocation __initdata *mcfg_table;
> +static int __initdata mcfg_table_entry_size;
> +
Yinghai is working on PCI root host bridge hotplug. One of his work is to provide
online/offline support to non-hotplug-capable PCI host bridges. Here online/offline
means enable/disable PCI host bridge without physical hotplug operations.

With that change, query_acpi_mcfg_table() may be called at runtime for host bridges
without _CBA method, so mcfg_table shouldn't be __initdata.

Suggest to call acpi_sfi_table_parse() directly for simplicity in query_acpi_mcfg_table()
instead of cache MMCFG info in mcfg_table.

>  LIST_HEAD(pci_mmcfg_list);
>  
>  static __init void pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
> @@ -522,6 +525,25 @@ static int __init acpi_mcfg_check_entry(
>  	return -EINVAL;
>  }
>  
> +u64 query_acpi_mcfg_table(int segment, int start)
> +{
> +	u64 base_addr = 0;
> +	int i;
> +
> +	if (!mcfg_table)
> +		return 0;
> +
> +	for (i = 0; i < mcfg_table_entry_size; i++) {
> +		if (segment == mcfg_table[i].pci_segment &&
> +			start == mcfg_table[i].start_bus_number) {
> +			base_addr = mcfg_table[i].address;
> +			break;
> +		}
> +	}
> +
> +	return base_addr;
> +}
It should check the MMCFG item contains [(segment, start), (segment, end)]
instead of "start == mcfg_table[i].start_bus_number".
We have observed many systems which have several PCI host bridges in segment 0
and MMCFG table only reports one entry for bus 0-255 on segment 0.
The above code can't support such a system.

> +
>  static int __init pci_parse_mcfg(struct acpi_table_header *header)
>  {
>  	struct acpi_table_mcfg *mcfg;
> @@ -551,19 +573,19 @@ static int __init pci_parse_mcfg(struct 
>  	for (i = 0; i < entries; i++) {
>  		cfg = &cfg_table[i];
>  		if (acpi_mcfg_check_entry(mcfg, cfg)) {
> -			free_all_mmcfg();
>  			return -ENODEV;
>  		}
> -
> -		if (pci_mmconfig_add(cfg->pci_segment, cfg->start_bus_number,
> -				   cfg->end_bus_number, cfg->address) == NULL) {
> -			printk(KERN_WARNING PREFIX
> -			       "no memory for MCFG entries\n");
> -			free_all_mmcfg();
> -			return -ENOMEM;
> -		}
>  	}
>  
> +	/* populate mcfg_table */
> +	mcfg_table = kzalloc(sizeof(struct acpi_mcfg_allocation) * entries,
> +			     GFP_KERNEL);
> +	if (!mcfg_table)
> +		return -ENOMEM;
> +	memcpy(mcfg_table, cfg_table,
> +	sizeof(struct acpi_mcfg_allocation) * entries);
> +	mcfg_table_entry_size = entries;
> +
The above change will break the pcibios_last_bus logic. The MMCFG initialization sequence
is something like:
1) pci_mmcfg_early_init()
	->__pci_mmcfg_init()
		->pci_parse_mcfg()
2) initialize ACPICA subsystem
3) pci_mmcfg_late_init()
	->__pci_mmcfg_init()
		->pci_parse_mcfg()
4) bind pci_root driver to pci host bridges
	pci_mmconfig_add()

If pci_parse_mcfg() doesn't call pci_mmconfig_add(), pci_mmcfg_list will always be
NULL until step 4. Then function __pci_mmcfg_init() can't set pcibios_last_bus to
the correct value. As Don has mentioned, it's high risky to cause compatibility issues
if pcibios_last_bus hasn't been setup correctly.

>  	return 0;
>  }
>  
> @@ -589,9 +611,6 @@ static void __init __pci_mmcfg_init(int 
>  	if (!known_bridge)
>  		acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
>  
> -	if (list_empty(&pci_mmcfg_list))
> -		return;
> -
This change will always use MMCFG as the mechanism to access PCI extended configuration
space, then it will break some AMD platforms which should use pci_direct_conf1 to access
extend configuration space. Please refer to pci_direct_init() in arch/x86/pci/direct.c

>  	if (pcibios_last_bus < 0) {
>  		const struct pci_mmcfg_region *cfg;
>  
> @@ -641,6 +660,12 @@ static int __init pci_mmcfg_late_insert_
>  	 */
>  	pci_mmcfg_insert_resources();
>  
> +	/*
> +	 * MCFG table should not be reffered to any longer
> +	 */
> +	kfree(mcfg_table);
> +	mcfg_table = NULL;
> +
>  	return 0;
>  }
>  
> 

