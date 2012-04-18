Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:40921 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab2DRGrS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Apr 2012 02:47:18 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 216973EE0BC
	for <linux-pci@vger.kernel.org>; Wed, 18 Apr 2012 15:47:17 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0621045DE54
	for <linux-pci@vger.kernel.org>; Wed, 18 Apr 2012 15:47:17 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id E1AE845DE53
	for <linux-pci@vger.kernel.org>; Wed, 18 Apr 2012 15:47:16 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id CACCFE08007
	for <linux-pci@vger.kernel.org>; Wed, 18 Apr 2012 15:47:16 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7C098E08003
	for <linux-pci@vger.kernel.org>; Wed, 18 Apr 2012 15:47:16 +0900 (JST)
Date: Wed, 18 Apr 2012 15:47:25 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Jiang Liu <liuj97@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V4 6/6] PCI, ACPI, x86: update MMCFG information when
 hot-plugging PCI host bridges
Message-Id: <20120418154725.92833e4d.izumi.taku@jp.fujitsu.com>
In-Reply-To: <1334103063-2283-7-git-send-email-jiang.liu@huawei.com>
References: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com>
	<1334103063-2283-7-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Jiang,

On Wed, 11 Apr 2012 08:11:03 +0800
Jiang Liu <liuj97@gmail.com> wrote:

> This patch enhances pci_root driver to update MMCFG information when
> hot-plugging PCI root bridges on x86 platforms.
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> ---
>  arch/x86/include/asm/pci_x86.h |    1 +
>  arch/x86/pci/acpi.c            |   58 ++++++++++++++++++++++++++++++++++++++++
>  arch/x86/pci/mmconfig_32.c     |    2 +-
>  arch/x86/pci/mmconfig_64.c     |    2 +-
>  drivers/acpi/pci_root.c        |   16 +++++++++++
>  include/acpi/acnames.h         |    1 +
>  include/acpi/acpi_bus.h        |    1 +
>  include/linux/pci-acpi.h       |    3 ++
>  8 files changed, 82 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index 3252c97..5e1d9a6 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -100,6 +100,7 @@ struct pci_raw_ops {
>  extern const struct pci_raw_ops *raw_pci_ops;
>  extern const struct pci_raw_ops *raw_pci_ext_ops;
>  
> +extern const struct pci_raw_ops pci_mmcfg;
>  extern const struct pci_raw_ops pci_direct_conf1;
>  extern bool port_cf9_safe;
>  
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index da0149d..729d694 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -4,6 +4,7 @@
>  #include <linux/irq.h>
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
> +#include <linux/pci-acpi.h>
>  #include <asm/numa.h>
>  #include <asm/pci_x86.h>
>  
> @@ -488,6 +489,63 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
>  	return bus;
>  }
>  
> +int __devinit arch_acpi_pci_root_add(struct acpi_pci_root *root)
> +{
> +	int result = 0;
> +	acpi_status status;
> +	unsigned long long base_addr;
> +
> +	/* MMCFG not in use */
> +	if (raw_pci_ext_ops && raw_pci_ext_ops != &pci_mmcfg)
> +		return result;
> +
> +	status = acpi_evaluate_integer(root->device->handle, METHOD_NAME__CBA,
> +				       NULL, &base_addr);
> +	if (ACPI_FAILURE(status))
> +		base_addr = 0;
> +	/*
> +	 * Try to insert MMCFG information for host bridge
> +	 */
> +	result = pci_mmconfig_insert(root->segment, root->secondary.start,
> +				     root->secondary.end, base_addr);

	This logic looks strange.
	If the evaluation of "_CBA" failed (for example, "_CBA" didn't exist), 
	pci_mmconfig_insert() should not be invoked.


> +	if (result == -EEXIST)
> +		result = 0;
> +	else if (!result) {
> +		root->mmconf_added = true;
> +
> +		/* Try to enable MMCFG if it hasn't been enabled yet */
> +		if (raw_pci_ext_ops == NULL) {
> +			if (pci_probe & PCI_PROBE_MMCONF)
> +				raw_pci_ext_ops = &pci_mmcfg;
> +			else {
> +				arch_acpi_pci_root_remove(root);
> +				result = -ENODEV;
> +			}
> +		}
> +	}
> +	if (result)
> +		printk(KERN_ERR
> +			"can't add MMCFG information for Bus %04x:%02x\n",
> +			root->segment, (unsigned int)root->secondary.start);
> +
> +	/* still could use conf1 with it */
> +	if (!root->segment)
> +		result = 0;
> +
> +	return result;
> +}
> +
> +void arch_acpi_pci_root_remove(struct acpi_pci_root *root)
> +{
> +	if (root->mmconf_added) {
> +		pci_mmconfig_delete(root->segment,
> +				    root->secondary.start,
> +				    root->secondary.end);
> +		root->mmconf_added = false;
> +	}
> +}
> +
>  int __init pci_acpi_init(void)
>  {
>  	struct pci_dev *dev = NULL;
> diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
> index a22785d..db63ac2 100644
> --- a/arch/x86/pci/mmconfig_32.c
> +++ b/arch/x86/pci/mmconfig_32.c
> @@ -126,7 +126,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
>  	return 0;
>  }
>  
> -static const struct pci_raw_ops pci_mmcfg = {
> +const struct pci_raw_ops pci_mmcfg = {
>  	.read =		pci_mmcfg_read,
>  	.write =	pci_mmcfg_write,
>  };
> diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
> index 4e05779..34c08dd 100644
> --- a/arch/x86/pci/mmconfig_64.c
> +++ b/arch/x86/pci/mmconfig_64.c
> @@ -90,7 +90,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
>  	return 0;
>  }
>  
> -static const struct pci_raw_ops pci_mmcfg = {
> +const struct pci_raw_ops pci_mmcfg = {
>  	.read =		pci_mmcfg_read,
>  	.write =	pci_mmcfg_write,
>  };
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 4a7d575..b7c0b53 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -448,6 +448,15 @@ out:
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
> @@ -504,6 +513,11 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>  	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
>  	device->driver_data = root;
>  
> +	if (arch_acpi_pci_root_add(root)) {
> +		result = -ENODEV;
> +		goto out_free;
> +	}
> +
>  	/*
>  	 * All supported architectures that use ACPI have support for
>  	 * PCI domains, so we indicate this in _OSC support capabilities.
> @@ -629,6 +643,7 @@ out_del_root:
>  	list_del_rcu(&root->node);
>  	mutex_unlock(&acpi_pci_root_lock);
>  	synchronize_rcu();
> +	arch_acpi_pci_root_remove(root);
>  out_free:
>  	kfree(root);
>  	return result;
> @@ -679,6 +694,7 @@ out:
>  	list_del_rcu(&root->node);
>  	mutex_unlock(&acpi_pci_root_lock);
>  	synchronize_rcu();
> +	arch_acpi_pci_root_remove(root);
>  	kfree(root);
>  
>  	return 0;
> diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
> index 38f5088..99bda75 100644
> --- a/include/acpi/acnames.h
> +++ b/include/acpi/acnames.h
> @@ -62,6 +62,7 @@
>  #define METHOD_NAME__AEI        "_AEI"
>  #define METHOD_NAME__PRW        "_PRW"
>  #define METHOD_NAME__SRS        "_SRS"
> +#define METHOD_NAME__CBA	"_CBA"
>  
>  /* Method names - these methods must appear at the namespace root */
>  
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index f1c8ca6..cb4f402 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -370,6 +370,7 @@ struct acpi_pci_root {
>  
>  	u32 osc_support_set;	/* _OSC state of support bits */
>  	u32 osc_control_set;	/* _OSC state of control bits */
> +	bool mmconf_added;
>  };
>  
>  /* helper */
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index ac93634..7745b8a 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -18,6 +18,9 @@ extern acpi_status pci_acpi_add_pm_notifier(struct acpi_device *dev,
>  					     struct pci_dev *pci_dev);
>  extern acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev);
>  
> +int arch_acpi_pci_root_add(struct acpi_pci_root *root);
> +void arch_acpi_pci_root_remove(struct acpi_pci_root *root);
> +
>  static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
>  {
>  	struct pci_bus *pbus = pdev->bus;
> -- 
> 1.7.5.4
> 
> 


-- 
Taku Izumi <izumi.taku@jp.fujitsu.com>

