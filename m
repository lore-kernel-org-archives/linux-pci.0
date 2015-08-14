Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35175 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbbHNBuL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Aug 2015 21:50:11 -0400
Received: by igbjg10 with SMTP id jg10so3225020igb.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2015 18:50:10 -0700 (PDT)
Date: Thu, 13 Aug 2015 20:50:04 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com,
	will.deacon@arm.com, hanjun.guo@linaro.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH] pci: acpi: Generic function for setting up PCI device
 DMA coherency
Message-ID: <20150814015004.GA26431@google.com>
References: <1439459925-2361-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439459925-2361-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Suravee,

On Thu, Aug 13, 2015 at 04:58:45PM +0700, Suravee Suthikulpanit wrote:
> This patch refactors of_pci_dma_configure() into a more generic
> pci_dma_configure(), which can be reused by non-OF code.
> Then, it adds support for setting up PCI device DMA coherency from
> ACPI _CCA object that should normally be specified in the DSDT node
> of its PCI host bridge..

Since this does two things:
  1) Rename of_pci_dma_configure() and move it to PCI
  2) Add _CCA support,
maybe it should be split into two patches?

There are a couple more comments below.

While looking at this, I thought some of the existing code could be
made simpler and easier to follow.  I appended a couple possible patches;
you can incorporate them or ignore them, whatever seems best to you.

Bjorn

> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Murali Karicheri <m-karicheri2@ti.com>
> ---
> Note: According to the ACPI spec, the _CCA attribute is required
>       for ARM64. Therefore, this patch is a pre-req for ACPI PCI
>       support for ARM64 which is currently in development.
> 
>       Also, this should not affect other architectures since
>       if CCA is not required, the default value is coherent.
>       Please see include/acpi/acpi_bus.h: acpi_check_dma() and
>       drivers/acpi/scan.c: acpi_init_coherency() for more information
> 
>  drivers/of/of_pci.c    | 20 --------------------
>  drivers/pci/probe.c    | 35 +++++++++++++++++++++++++++++++++--
>  include/linux/of_pci.h |  3 ---
>  3 files changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 5751dc5..b66ee4e 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -117,26 +117,6 @@ int of_get_pci_domain_nr(struct device_node *node)
>  }
>  EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
>  
> -/**
> - * of_pci_dma_configure - Setup DMA configuration
> - * @dev: ptr to pci_dev struct of the PCI device
> - *
> - * Function to update PCI devices's DMA configuration using the same
> - * info from the OF node of host bridge's parent (if any).
> - */
> -void of_pci_dma_configure(struct pci_dev *pci_dev)
> -{
> -	struct device *dev = &pci_dev->dev;
> -	struct device *bridge = pci_get_host_bridge_device(pci_dev);
> -
> -	if (!bridge->parent)
> -		return;
> -
> -	of_dma_configure(dev, bridge->parent->of_node);
> -	pci_put_host_bridge_device(bridge);
> -}
> -EXPORT_SYMBOL_GPL(of_pci_dma_configure);
> -
>  #if defined(CONFIG_OF_ADDRESS)
>  /**
>   * of_pci_get_host_bridge_resources - Parse PCI host bridge resources from DT
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index cefd636..e2fcd3b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -6,12 +6,14 @@
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/pci.h>
> -#include <linux/of_pci.h>
> +#include <linux/of_device.h>
>  #include <linux/pci_hotplug.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/cpumask.h>
>  #include <linux/pci-aspm.h>
> +#include <linux/acpi.h>
> +#include <linux/property.h>
>  #include <asm-generic/pci-bridge.h>
>  #include "pci.h"
>  
> @@ -1544,6 +1546,35 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_enable_acs(dev);
>  }
>  
> +/**
> + * pci_dma_configure - Setup DMA configuration
> + * @pci_dev: ptr to pci_dev struct of the PCI device
> + *
> + * Function to update PCI devices's DMA configuration using the same
> + * info from the OF node or ACPI node of host bridge's parent (if any).
> + */
> +static void pci_dma_configure(struct pci_dev *pci_dev)

Almost all pci_dev pointers in probe.c are named "dev", so I would use
that for this one, too.  I probably would just drop the "struct device
*dev" below and use "&dev->dev" the two places you need it.  That's a
common idiom in PCI.

> +{
> +	struct device *dev = &pci_dev->dev;
> +	struct device *bridge = pci_get_host_bridge_device(pci_dev);
> +	struct acpi_device *adev;
> +	bool coherent;
> +
> +	if (has_acpi_companion(bridge)) {
> +		adev = to_acpi_node(bridge->fwnode);
> +		if (acpi_check_dma(adev, &coherent))
> +			arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
> +	} else {
> +		struct device *host = bridge->parent;
> +		if (!host)
> +			return;
> +
> +		of_dma_configure(dev, host->of_node);
> +	}

Why is this check reversed with respect to device_dma_is_coherent()?
In device_dma_is_coherent(), we first look for an OF property, then look
for ACPI _CCA.  But here we check for _CCA, then for OF.

> +
> +	pci_put_host_bridge_device(bridge);
> +}
> +
>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  {
>  	int ret;
> @@ -1557,7 +1588,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	dev->dev.dma_mask = &dev->dma_mask;
>  	dev->dev.dma_parms = &dev->dma_parms;
>  	dev->dev.coherent_dma_mask = 0xffffffffull;
> -	of_pci_dma_configure(dev);
> +	pci_dma_configure(dev);
>  
>  	pci_set_dma_max_seg_size(dev, 65536);
>  	pci_set_dma_seg_boundary(dev, 0xffffffff);
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 29fd3fe..ce0e5ab 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -16,7 +16,6 @@ int of_pci_get_devfn(struct device_node *np);
>  int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
>  int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
>  int of_get_pci_domain_nr(struct device_node *node);
> -void of_pci_dma_configure(struct pci_dev *pci_dev);
>  #else
>  static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
>  {
> @@ -51,8 +50,6 @@ of_get_pci_domain_nr(struct device_node *node)
>  {
>  	return -1;
>  }
> -
> -static inline void of_pci_dma_configure(struct pci_dev *pci_dev) { }
>  #endif
>  
>  #if defined(CONFIG_OF_ADDRESS)
> -- 
> 2.1.0
> 
commit 18183957888f601807ca0e166516ae60f682eb62
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Aug 13 20:01:21 2015 -0500

    ACPI / scan: Move _CCA comments to acpi_init_coherency()
    
    Move the comments about how we handle _CCA to the code that looks at _CCA,
    and fix a couple typos.
    
    No functional change.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ec25635..a12e522 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2188,6 +2188,22 @@ static void acpi_init_coherency(struct acpi_device *adev)
 	acpi_status status;
 	struct acpi_device *parent = adev->parent;
 
+	/**
+	 * Currently, we only support _CCA=1 (i.e. coherent_dma=1)
+	 * This should be equivalent to specifying dma-coherent for
+	 * a device in OF.
+	 *
+	 * For the case when _CCA=0 (i.e. coherent_dma=0 && cca_seen=1),
+	 * we have two choices:
+	 * case 1. Do not support and disable DMA.
+	 * case 2. Support but rely on arch-specific cache maintenance for
+	 *         non-coherent DMA operations.
+	 * Currently, we implement case 1 above.
+	 *
+	 * For the case when _CCA is missing (i.e. cca_seen=0) and
+	 * platform specifies ACPI_CCA_REQUIRED, we do not support DMA,
+	 * and fallback to arch-specific default handling.
+	 */
 	if (parent && parent->flags.cca_seen) {
 		/*
 		 * From ACPI spec, OSPM will ignore _CCA if an ancestor
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 83061ca..718942b 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -389,24 +389,6 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
 	if (!adev)
 		return ret;
 
-	/**
-	 * Currently, we only support _CCA=1 (i.e. coherent_dma=1)
-	 * This should be equivalent to specifyig dma-coherent for
-	 * a device in OF.
-	 *
-	 * For the case when _CCA=0 (i.e. coherent_dma=0 && cca_seen=1),
-	 * There are two cases:
-	 * case 1. Do not support and disable DMA.
-	 * case 2. Support but rely on arch-specific cache maintenance for
-	 *         non-coherence DMA operations.
-	 * Currently, we implement case 1 above.
-	 *
-	 * For the case when _CCA is missing (i.e. cca_seen=0) and
-	 * platform specifies ACPI_CCA_REQUIRED, we do not support DMA,
-	 * and fallback to arch-specific default handling.
-	 *
-	 * See acpi_init_coherency() for more info.
-	 */
 	if (adev->flags.coherent_dma) {
 		ret = true;
 		if (coherent)

commit 84cfb2213cd400fef227ec0d7829ec4e12895da9
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Aug 13 19:49:52 2015 -0500

    ACPI / scan: Rename acpi_check_dma() to acpi_dma_is_coherent()
    
    The name "acpi_check_dma()" doesn't give any much indication about what
    exactly it checks.  The function also returns information both as a normal
    return value and as the "bool *coherent" return parameter.  But "*coherent"
    doesn't actually give any extra information: it is unchanged when returning
    false and set to true when returning true.
    
    Rename acpi_check_dma() to acpi_dma_is_coherent() so the callers read more
    naturally.  Drop the return parameter and just use the function return
    value.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 06a67d5..fc6138d 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -103,7 +103,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
 	pdevinfo.res = resources;
 	pdevinfo.num_res = count;
 	pdevinfo.fwnode = acpi_fwnode_handle(adev);
-	pdevinfo.dma_mask = acpi_check_dma(adev, NULL) ? DMA_BIT_MASK(32) : 0;
+	pdevinfo.dma_mask = acpi_dma_is_coherent(adev) ? DMA_BIT_MASK(32) : 0;
 	pdev = platform_device_register_full(&pdevinfo);
 	if (IS_ERR(pdev))
 		dev_err(&adev->dev, "platform device creation failed: %ld\n",
diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index b9657af..89b1cf8 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -168,7 +168,6 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 	struct list_head *physnode_list;
 	unsigned int node_id;
 	int retval = -EINVAL;
-	bool coherent;
 
 	if (has_acpi_companion(dev)) {
 		if (acpi_dev) {
@@ -225,8 +224,8 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 	if (!has_acpi_companion(dev))
 		ACPI_COMPANION_SET(dev, acpi_dev);
 
-	if (acpi_check_dma(acpi_dev, &coherent))
-		arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
+	if (acpi_dma_is_coherent(acpi_dev))
+		arch_setup_dma_ops(dev, 0, 0, NULL, true);
 
 	acpi_physnode_link_name(physical_node_name, node_id);
 	retval = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
diff --git a/drivers/base/property.c b/drivers/base/property.c
index f3f6d16..1124130 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -523,13 +523,9 @@ EXPORT_SYMBOL_GPL(device_get_child_node_count);
 
 bool device_dma_is_coherent(struct device *dev)
 {
-	bool coherent = false;
-
 	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
-		coherent = of_dma_is_coherent(dev->of_node);
-	else
-		acpi_check_dma(ACPI_COMPANION(dev), &coherent);
+		return of_dma_is_coherent(dev->of_node);
 
-	return coherent;
+	return acpi_dma_is_coherent(ACPI_COMPANION(dev));
 }
 EXPORT_SYMBOL_GPL(device_dma_is_coherent);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 718942b..39f1be6 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -382,19 +382,12 @@ struct acpi_device {
 	void (*remove)(struct acpi_device *);
 };
 
-static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
+static inline bool acpi_dma_is_coherent(struct acpi_device *adev)
 {
-	bool ret = false;
+	if (adev && adev->flags.coherent_dma)
+		return true;
 
-	if (!adev)
-		return ret;
-
-	if (adev->flags.coherent_dma) {
-		ret = true;
-		if (coherent)
-			*coherent = adev->flags.coherent_dma;
-	}
-	return ret;
+	return false;
 }
 
 static inline bool is_acpi_node(struct fwnode_handle *fwnode)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d2445fa..f29b8b5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -562,7 +562,7 @@ static inline int acpi_device_modalias(struct device *dev,
 	return -ENODEV;
 }
 
-static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
+static inline bool acpi_dma_is_coherent(struct acpi_device *adev)
 {
 	return false;
 }
