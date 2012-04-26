Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:59716 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab2DZOAR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 10:00:17 -0400
Received: by dadz8 with SMTP id z8so1616353dad.10
        for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 07:00:17 -0700 (PDT)
Message-ID: <4F9954DE.6070805@gmail.com>
Date: Thu, 26 Apr 2012 21:59:58 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Keping Chen <chenkeping@huawei.com>, ddutile@redhat.com,
	greg.pearson@hp.com
Subject: Re: [PATCH 5/6] PCI, x86: introduce pci_mmcongi_add() / pci_mmconfig_delete()
References: <20120426193712.11256973.izumi.taku@jp.fujitsu.com> <20120426194237.93088dcb.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120426194237.93088dcb.izumi.taku@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/26/2012 06:42 PM, Taku Izumi wrote:
> 
> This patch replaces pci_mmconfig_add() and introduces pci_mmconfig_delte()
> for adding or deleting MCFG region.
> 
> The newly pci_mmconfig_add() does the following:
>   - region check
>   - insert_resource
>   - ioremap
>   - add new pci_mmcfg_region entry to pci_mmcfg_list
> 
> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  arch/x86/include/asm/pci_x86.h |    3 
>  arch/x86/pci/mmconfig-shared.c |  142 ++++++++++++++++++++++++++++++-----------
>  arch/x86/pci/mmconfig_64.c     |   11 ---
>  3 files changed, 109 insertions(+), 47 deletions(-)
> 
> Index: bjorn-next/arch/x86/include/asm/pci_x86.h
> ===================================================================
> --- bjorn-next.orig/arch/x86/include/asm/pci_x86.h
> +++ bjorn-next/arch/x86/include/asm/pci_x86.h
> @@ -138,7 +138,8 @@ extern void __init pci_mmcfg_arch_free(v
>  extern int __devinit pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
>  extern void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
>  extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
> -
> +extern int __devinit pci_mmconfig_add(int seg, int start, int end, u64 addr);
> +extern int pci_mmconfig_delete(int seg, int start, int end);
>  extern struct list_head pci_mmcfg_list;
>  
>  #define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
> Index: bjorn-next/arch/x86/pci/mmconfig-shared.c
> ===================================================================
> --- bjorn-next.orig/arch/x86/pci/mmconfig-shared.c
> +++ bjorn-next/arch/x86/pci/mmconfig-shared.c
> @@ -17,6 +17,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
> +#include <linux/mutex.h>
>  #include <linux/rculist.h>
>  #include <asm/e820.h>
>  #include <asm/pci_x86.h>
> @@ -96,18 +97,6 @@ static __devinit struct pci_mmcfg_region
>  	return new;
>  }
>  
> -static __init struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
> -							int end, u64 addr)
> -{
> -	struct pci_mmcfg_region *new;
> -
> -	new = pci_mmconfig_alloc(segment, start, end, addr);
> -	if (new)
> -		list_add_sorted(new);
> -
> -	return new;
> -}
> -
>  struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus)
>  {
>  	struct pci_mmcfg_region *cfg;
> @@ -129,7 +118,7 @@ static const char __init *pci_mmcfg_e752
>  	if (win == 0x0000 || win == 0xf000)
>  		return NULL;
>  
> -	if (pci_mmconfig_add(0, 0, 255, win << 16) == NULL)
> +	if (pci_mmconfig_add(0, 0, 255, win << 16))
>  		return NULL;
>  
>  	return "Intel Corporation E7520 Memory Controller Hub";
> @@ -173,7 +162,7 @@ static const char __init *pci_mmcfg_inte
>  	if ((pciexbar & mask) >= 0xf0000000U)
>  		return NULL;
>  
> -	if (pci_mmconfig_add(0, 0, (len >> 20) - 1, pciexbar & mask) == NULL)
> +	if (pci_mmconfig_add(0, 0, (len >> 20) - 1, pciexbar & mask))
>  		return NULL;
>  
>  	return "Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub";
> @@ -221,7 +210,7 @@ static const char __init *pci_mmcfg_amd_
>  	end_bus = (1 << busnbits) - 1;
>  	for (i = 0; i < (1 << segnbits); i++)
>  		if (pci_mmconfig_add(i, 0, end_bus,
> -				     base + (1<<28) * i) == NULL) {
> +				     base + (1<<28) * i)) {
>  			free_all_mmcfg();
>  			return NULL;
>  		}
> @@ -278,7 +267,7 @@ static const char __init *pci_mmcfg_nvid
>  		base <<= extcfg_base_lshift;
>  		start = (extcfg & extcfg_start_mask) >> extcfg_start_shift;
>  		end = start + extcfg_sizebus[size_index] - 1;
> -		if (pci_mmconfig_add(0, start, end, base) == NULL)
> +		if (pci_mmconfig_add(0, start, end, base))
>  			continue;
>  		mcp55_mmconf_found++;
>  	}
> @@ -376,7 +365,7 @@ static void __init pci_mmcfg_insert_reso
>  	pci_mmcfg_resources_inserted = 1;
>  }
>  
> -static acpi_status __init check_mcfg_resource(struct acpi_resource *res,
> +static acpi_status __devinit check_mcfg_resource(struct acpi_resource *res,
>  					      void *data)
Please pay attention to indent for above line.

>  {
>  	struct resource *mcfg_res = data;
> @@ -413,7 +402,7 @@ static acpi_status __init check_mcfg_res
>  	return AE_OK;
>  }
>  
> -static acpi_status __init find_mboard_resource(acpi_handle handle, u32 lvl,
> +static acpi_status __devinit find_mboard_resource(acpi_handle handle, u32 lvl,
>  		void *context, void **rv)
>  {
>  	struct resource *mcfg_res = context;
> @@ -427,7 +416,7 @@ static acpi_status __init find_mboard_re
>  	return AE_OK;
>  }
>  
> -static int __init is_acpi_reserved(u64 start, u64 end, unsigned not_used)
> +static int __devinit is_acpi_reserved(u64 start, u64 end, unsigned not_used)
>  {
>  	struct resource mcfg_res;
>  
> @@ -446,7 +435,7 @@ static int __init is_acpi_reserved(u64 s
>  
>  typedef int (*check_reserved_t)(u64 start, u64 end, unsigned type);
>  
> -static int __init is_mmconf_reserved(check_reserved_t is_reserved,
> +static int __devinit is_mmconf_reserved(check_reserved_t is_reserved,
>  				    struct pci_mmcfg_region *cfg, int with_e820)
Please pay attention to indent for above line.

>  {
>  	u64 addr = cfg->res.start;
> @@ -507,19 +496,6 @@ static int __devinit pci_mmcfg_check_res
>  	return false;
>  }
>  
> -static void __init pci_mmcfg_reject_broken(int early)
> -{
> -	struct pci_mmcfg_region *cfg;
> -
> -	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
> -		if (pci_mmcfg_check_reserved(cfg, early) == false) {
> -			printk(KERN_INFO PREFIX "not using MMCONFIG\n");
> -			free_all_mmcfg();
> -			return;
> -		}
> -	}
> -}
> -
pci_mmcfg_check_reserved() performs different checks according to the parameter 'early'.
The patch has changed the behavior of original code. 

At early time when mmcfg_early_init() is called, the ACPICA subsystem is still
uninitialized yet and is_acpi_reserved() shouldn't be called yet. So at early
stage, pci_mmcfg_check_reserved() should be called with parameter early as 1(true).
But this patch always call pci_mmcfg_check_reserved() with parameter as 0.

So suggest to keep pci_mmconfig_add() and pci_mmcfg_reject_broken(), but change return
value of pci_mmconfig_add() from "struct pci_mmcfg_region *" to "int".

>  static int __initdata known_bridge;
>  
>  static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
> @@ -613,8 +589,6 @@ static void __init __pci_mmcfg_init(int 
>  	if (!known_bridge)
>  		acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
>  
> -	pci_mmcfg_reject_broken(early);
> -
>  	if (list_empty(&pci_mmcfg_list))
>  		return;
>  
> @@ -676,3 +650,101 @@ static int __init pci_mmcfg_late_insert_
>   * with other system resources.
>   */
>  late_initcall(pci_mmcfg_late_insert_resources);
> +
> +static DEFINE_MUTEX(pci_mmcfg_lock);
> +
> +int __devinit pci_mmconfig_add(int segment, int start, int end, u64 addr)
> +{
> +	int rc = 0;
> +	struct pci_mmcfg_region *cfg, *new = NULL;
> +
> +	if (segment < 0 || segment > USHRT_MAX ||
> +	    start < 0 || start > 255 || end < start || end > 255)
> +		return -EINVAL;
> +
> +	mutex_lock(&pci_mmcfg_lock);
> +	cfg = pci_mmconfig_lookup(segment, start);
> +	if (cfg) {
> +		if (cfg->start_bus <= start && cfg->end_bus >= end) {
> +			rc = -EEXIST;
> +		} else {
> +			rc = -EINVAL;
> +			printk(KERN_WARNING PREFIX
> +			       "MMCONFIG for domain %04x [bus %02x-%02x] "
> +			       "conflicts with domain %04x [bus %02x-%02x]\n",
> +			       segment, start, end,
> +			       cfg->segment, cfg->start_bus, cfg->end_bus);
> +		}
> +		goto out;
> +	}
> +
> +	new = pci_mmconfig_alloc(segment, start, end, addr);
> +	if (new == NULL) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (!pci_mmcfg_check_reserved(new, 0)) {
> +		rc = -EINVAL;
> +		printk(KERN_WARNING PREFIX
> +		       "MMCONFIG for domain %04x [bus %02x-%02x] "
> +		       "isn't reserved\n", segment, start, end);
> +		goto out;
> +	}
> +
> +	if (pci_mmcfg_resources_inserted &&
> +	    insert_resource(&iomem_resource, &new->res)) {
> +		rc = -EBUSY;
> +		printk(KERN_WARNING PREFIX
> +		       "failed to insert resource for domain "
> +		       "%04x [bus %02x-%02x]\n", segment, start, end);
> +		goto out;
> +	}
> +
> +	if (pci_mmcfg_arch_map(new)) {
> +		rc = -EBUSY;
> +		printk(KERN_WARNING PREFIX
> +		       "failed to map resource for domain "
> +		       "%04x [bus %02x-%02x]\n", segment, start, end);
> +		goto out;
> +	}
> +
> +	list_add_sorted(new);
> +	new = NULL;
> +
> +out:
> +	if (new) {
> +		if (new->res.parent)
> +			release_resource(&new->res);
> +		kfree(new);
> +	}
> +
> +	mutex_unlock(&pci_mmcfg_lock);
> +
> +	return rc;
> +}
> +
> +/* Delete MMCFG information at runtime */
> +int pci_mmconfig_delete(int segment, int start, int end)
> +{
> +	struct pci_mmcfg_region *cfg;
> +
> +	mutex_lock(&pci_mmcfg_lock);
> +	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list) {
> +		if (cfg->segment == segment && cfg->start_bus == start &&
> +		    cfg->end_bus == end) {
> +			list_del_rcu(&cfg->list);
> +			synchronize_rcu();
> +			pci_mmcfg_arch_unmap(cfg);
> +			if (cfg->res.parent)
> +				release_resource(&cfg->res);
> +			mutex_unlock(&pci_mmcfg_lock);
> +			kfree(cfg);
> +			return 0;
> +		}
> +	}
> +	mutex_unlock(&pci_mmcfg_lock);
> +
> +	return -ENOENT;
> +}
> +
> Index: bjorn-next/arch/x86/pci/mmconfig_64.c
> ===================================================================
> --- bjorn-next.orig/arch/x86/pci/mmconfig_64.c
> +++ bjorn-next/arch/x86/pci/mmconfig_64.c
> @@ -112,17 +112,6 @@ static void __iomem * __devinit mcfg_ior
>  
>  int __init pci_mmcfg_arch_init(void)
>  {
> -	struct pci_mmcfg_region *cfg;
> -
> -	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
> -		cfg->virt = mcfg_ioremap(cfg);
> -		if (!cfg->virt) {
> -			printk(KERN_ERR PREFIX "can't map MMCONFIG at %pR\n",
> -			       &cfg->res);
> -			pci_mmcfg_arch_free();
> -			return 0;
> -		}
> -	}
>  	raw_pci_ext_ops = &pci_mmcfg;
>  	return 1;
>  }
> 

