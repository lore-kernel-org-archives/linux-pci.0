Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94C2414A27
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429451; cv=none; b=SXlVdpbIoH4D7T76CF/8xJEoTTrqNlxRlK3va+QDimM3BLRnMQvN3ZiGT4NW0NSnaa3hXD3BnlhCRnInyxPOZ3adTJqGvkiAkOSz1cjuNI1fdlapR6j9Cb6bah74dHw3XleYkYtKS7Vbabao50UwfyNwKkL1s1a8l3gSMHcdsjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429451; c=relaxed/simple;
	bh=YSsne3yvdvBfDxI0qG1bOORYLdXduAdy0KUZ4MueSIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIrIq8k7pXOWSBNSNx6Cxx/4ugJGMZSrK4zylz9jDL9EXc9vIadANjgnf+aXzPzOYIuUfkFAqtx66IxAelwXOFrau8uA8EXDeHrxIx9kLRmKQE4BoGuOt6SLuH5U6lxQmCzyr42yRPeMAVcrmlPeCIzbUaMaJy/BdIL6ivEcovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=myQGjvKz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="myQGjvKz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A13511AC1;
	Tue,  7 Jul 2026 06:04:04 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48EA43FBF5;
	Tue,  7 Jul 2026 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783429449; bh=YSsne3yvdvBfDxI0qG1bOORYLdXduAdy0KUZ4MueSIk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=myQGjvKz++HIOXSBBpTJELGW48BMLscOFJx5BmCZW8padNob+jPs1JTvE4PBQeFHl
	 JF1bAPHREDOzWbvaJ0BoSC/KvIzUb75cMaat01yRDk6ZlF7LOkGsOJVNjTzCznpXnv
	 7vq24KcAJeH9WNM1XddCrKtCkdEwONq7Hyzne/mU=
Message-ID: <396f462b-541b-4c1f-aeec-a65c703603d7@arm.com>
Date: Tue, 7 Jul 2026 14:04:03 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] PCI, device core: Move "untrusted" concept to
 DEVICE_TRUST_ADVERSARY
To: Dan Williams <djbw@kernel.org>, linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
 ankita@nvidia.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <bhelgaas@google.com>, Alexey Kardashevskiy <aik@amd.com>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-10-djbw@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260705220819.2472765-10-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/07/2026 11:08 pm, Dan Williams wrote:
> An "adversary" device is one that the kernel is allowed to operate, but
> with extra safety / paranoia added. It aims to keep the device bounded in
> both address space and time (no batched invalidation) for DMA accesses. The
> concept of adversarial devices already exists in the PCI core. The
> categorization is applied to externally attached PCI devices by default
> (like Thunderbolt attached devices). Unlike DEVICE_TRUST_NONE that says "do
> not allow driver bind", DEVICE_TRUST_ADVERSARY says "allow driver bind as
> long as the driver and/or IOMMU are taking precautions." Uplevel this trust
> mechanism from a PCI device "untrusted" boolean flag to the core device
> trust level.
> 
> The rationale for dev->bus_trust separate from dev->p->trust is to give
> buses the ability to establish a trust level before device_add(). Then,
> after device_add(), the dependency on 'struct device_private' mandates that
> the device-core own and coordinate changes to the device's trust level.
> 
> There are implications of the bus expressing less than full trust in a
> device and a module later expressing higher levels of trust. For PCI, the
> "adversary" / pci_untrusted() determination is made prior to initial
> iommu_probe_device(). The default IOMMU domain determination is latched
> from bus's specified trust value. Later changes to the trust level, for
> example by "modprobe $module trust=auto" skip that IOMMU probing. The
> result is that moving a device to DEVICE_TRUST_AUTO may lift translation
> blocking (PCI_ACS_TB), but not change the default IOMMU domain from
> IOMMU_DOMAIN_DMA.
> 
> The default domain can be validated / changed via iommu_group sysfs. The
> longer term goal is to dynamically adjust iommu domain at the next
> $bus_dma_configure() event, but that needs more surgery and consideration
> for multi-device iommu groups.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> ---
>   drivers/base/Kconfig         | 13 +++++++++++++
>   drivers/pci/Kconfig          |  1 +
>   include/linux/device.h       |  3 +++
>   include/linux/device/trust.h | 20 +++++++++++++++-----
>   include/linux/pci.h          | 13 +++++--------
>   drivers/base/trust.c         | 20 +++++++++++++++++++-
>   drivers/iommu/amd/iommu.c    |  2 +-
>   drivers/iommu/dma-iommu.c    | 13 ++++---------
>   drivers/iommu/intel/iommu.c  |  2 +-
>   drivers/iommu/iommu.c        |  2 +-

For the straightforward drivers/iommu changes:

Acked-by: Robin Murphy <robin.murphy@arm.com>

I don't have time to have a strong opinion about the internal 
implementation details, but I agree a driver-core-level abstraction of 
hierarchical bus/device trust seems like the right step to take in general.

Cheers,
Robin.

>   drivers/pci/ats.c            |  2 +-
>   drivers/pci/pci.c            |  2 +-
>   drivers/pci/probe.c          | 10 +++++++---
>   drivers/pci/quirks.c         |  4 ++--
>   14 files changed, 74 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index a08523d348d8..a4233bdf9804 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -291,6 +291,14 @@ config DEVICE_TRUST_NONE
>   	  possible, the device is blocked by an IOMMU from accessing
>   	  assets.
>   
> +config DEVICE_TRUST_ADVERSARY
> +	bool "Adversary"
> +	help
> +	  Device is allowed to bind. Bus, IOMMU, and driver layers may
> +	  react to this trust level by disabling access validation
> +	  bypass mechanisms like PCI ATS. When device is unbound from a
> +	  driver the device is blocked by an IOMMU where possible.
> +
>   config DEVICE_TRUST_AUTO
>   	bool "Auto"
>   	help
> @@ -317,6 +325,11 @@ config BUILTIN_DEVICE_TRUST_AUTO
>   	  a driver and deploy all available mechanisms to allow performant
>   	  direct memory access This trust level does not grant TCB privileges.
>   
> +config BUILTIN_DEVICE_TRUST_ADVERSARY
> +	bool "Adversary"
> +	help
> +	  Deploy mitigations in the IOMMU layer and driver to limit access.
> +
>   endchoice
>   
>   endmenu
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index ed17b5d2d5ae..185b42cefe20 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -22,6 +22,7 @@ menuconfig PCI
>   	bool "PCI support"
>   	depends on HAVE_PCI
>   	depends on MMU
> +	select DEVICE_TRUST
>   	help
>   	  This option enables support for the PCI local bus, including
>   	  support for PCI-X and the foundations for PCI Express support.
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 7b2baffdd2f5..3e203d573a58 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -688,6 +688,8 @@ enum struct_device_flags {
>    * @removable:  Whether the device can be removed from the system. This
>    *              should be set by the subsystem / bus driver that discovered
>    *              the device.
> + * @bus_trust: Device's initial / prior to device_add() trust level.
> + *
>    * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
>    *
>    * At the lowest level, every device in a Linux system is represented by an
> @@ -791,6 +793,7 @@ struct device {
>   	struct device_physical_location *physical_location;
>   
>   	enum device_removable	removable;
> +	enum device_trust	bus_trust;
>   
>   	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
>   };
> diff --git a/include/linux/device/trust.h b/include/linux/device/trust.h
> index 3377d26dc485..283d3196e5e6 100644
> --- a/include/linux/device/trust.h
> +++ b/include/linux/device/trust.h
> @@ -11,30 +11,40 @@
>    *
>    * @DEVICE_TRUST_UNSET: Unregistered device object with no current bus
>    * @DEVICE_TRUST_NONE: Blocked when idle, cannot bind
> + * @DEVICE_TRUST_ADVERSARY: Blocked when idle, constrained when active.
>    * @DEVICE_TRUST_AUTO: All typical privileges granted
> + *
> + * Devices flagged as adversarial are the ones that can potentially
> + * execute DMA attacks and similar. They are typically connected through
> + * external ports such as Thunderbolt but not limited to that. When an
> + * IOMMU is enabled they should be getting full mappings to make sure
> + * they cannot access arbitrary memory.
>    */
>   enum device_trust {
>   	DEVICE_TRUST_UNSET,
>   	DEVICE_TRUST_NONE,
> +	DEVICE_TRUST_ADVERSARY,
>   	DEVICE_TRUST_AUTO,
>   };
>   
> -#define DEVICE_DEFAULT_TRUST                                        \
> -	(IS_ENABLED(CONFIG_DEVICE_TRUST_NONE) ? DEVICE_TRUST_NONE : \
> -						DEVICE_TRUST_AUTO)
> +#define DEVICE_DEFAULT_TRUST \
> +	(IS_ENABLED(CONFIG_DEVICE_TRUST_NONE)      ? DEVICE_TRUST_NONE      : \
> +	 IS_ENABLED(CONFIG_DEVICE_TRUST_ADVERSARY) ? DEVICE_TRUST_ADVERSARY : \
> +	 DEVICE_TRUST_AUTO)
>   
>   struct device;
>   struct device_driver;
>   
>   #ifdef CONFIG_DEVICE_TRUST
> +bool device_untrusted(struct device *dev);
>   void module_driver_trust(struct module *mod, const char *val);
> -void module_driver_trust_init(struct module *mod, bool distrust);
> +void module_driver_trust_init(struct module *mod, bool require_trust);
>   #else
>   static inline void module_driver_trust(struct module *mod, const char *val)
>   {
>   	pr_warn("module: %s: trust= support disabled\n", mod->name);
>   }
> -static inline void module_driver_trust_init(struct module *mod, bool distrust)
> +static inline void module_driver_trust_init(struct module *mod, bool require_trust)
>   {
>   }
>   #endif
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index ebb5b9d76360..095ea37fc6d0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -485,14 +485,6 @@ struct pci_dev {
>   	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>   	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
>   	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
> -	/*
> -	 * Devices marked being untrusted are the ones that can potentially
> -	 * execute DMA attacks and similar. They are typically connected
> -	 * through external ports such as Thunderbolt but not limited to
> -	 * that. When an IOMMU is enabled they should be getting full
> -	 * mappings to make sure they cannot access arbitrary memory.
> -	 */
> -	unsigned int	untrusted:1;
>   	/*
>   	 * Info from the platform, e.g., ACPI or device tree, may mark a
>   	 * device as "external-facing".  An external-facing device is
> @@ -812,6 +804,11 @@ static inline bool pcie_is_cxl(struct pci_dev *pci_dev)
>   	return pci_dev->is_cxl;
>   }
>   
> +static inline bool pci_untrusted(struct pci_dev *pdev)
> +{
> +	return device_untrusted(&pdev->dev);
> +}
> +
>   #define for_each_pci_bridge(dev, bus)				\
>   	list_for_each_entry(dev, &bus->devices, bus_list)	\
>   		if (!pci_is_bridge(dev)) {} else
> diff --git a/drivers/base/trust.c b/drivers/base/trust.c
> index 0fd494e1557d..8efbe5c51250 100644
> --- a/drivers/base/trust.c
> +++ b/drivers/base/trust.c
> @@ -6,15 +6,28 @@
>   #include <linux/module.h>
>   #include "base.h"
>   
> +/* If the bus did not initialize trust, set a default */
>   void device_initialize_trust(struct device *dev)
>   {
> +	dev->p->trust = dev->bus_trust;
>   	if (dev->p->trust == DEVICE_TRUST_UNSET)
>   		dev->p->trust = DEVICE_DEFAULT_TRUST;
>   }
>   
> +/*
> + * ->bus_trust is evaluated / manipulated prior to device_add() and
> + *  synced with dev->p->trust post device_add() under device_lock().
> + */
> +bool device_untrusted(struct device *dev)
> +{
> +	return dev->bus_trust && dev->bus_trust <= DEVICE_TRUST_ADVERSARY;
> +}
> +
>   /* Driver trust policy requires modules, builtin drivers always attach */
>   static enum device_trust builtin_driver_trust(void)
>   {
> +	if (IS_ENABLED(CONFIG_BUILTIN_DEVICE_TRUST_ADVERSARY))
> +		return DEVICE_TRUST_ADVERSARY;
>   	return DEVICE_TRUST_AUTO;
>   }
>   
> @@ -30,18 +43,23 @@ static enum device_trust driver_trust(struct module *mod)
>    * policy on trusting devices it attaches, update the device's trust
>    * level from that policy. Trust privileges beyond driver bind are
>    * realized in a bus's ->dma_configure().
> + *
> + * Reflect the operational trust level back to the public indicator.
>    */
>   bool device_trust_bind(const struct device_driver *drv, struct device *dev)
>   {
>   	enum device_trust drv_trust = driver_trust(drv->owner);
>   
> -	if (drv_trust != DEVICE_TRUST_UNSET)
> +	if (drv_trust != DEVICE_TRUST_UNSET) {
>   		dev->p->trust = drv_trust;
> +		dev->bus_trust = drv_trust;
> +	}
>   	return dev->p->trust > DEVICE_TRUST_NONE;
>   }
>   
>   static const char * const device_trust_names[] = {
>   	[DEVICE_TRUST_NONE]	 = "none",
> +	[DEVICE_TRUST_ADVERSARY] = "adversary",
>   	[DEVICE_TRUST_AUTO]	 = "auto",
>   };
>   
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 563f9c2672d5..ef663e3efc70 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3121,7 +3121,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
>   		return 0;
>   
>   	/* Always use DMA domain for untrusted device */
> -	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> +	if (device_untrusted(dev))
>   		return IOMMU_DOMAIN_DMA;
>   
>   	/*
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703ef..957ef77911a9 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -588,16 +588,11 @@ static int iova_reserve_iommu_regions(struct device *dev,
>   	return ret;
>   }
>   
> -static bool dev_is_untrusted(struct device *dev)
> -{
> -	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
> -}
> -
>   static bool dev_use_swiotlb(struct device *dev, size_t size,
>   			    enum dma_data_direction dir)
>   {
>   	return IS_ENABLED(CONFIG_SWIOTLB) &&
> -		(dev_is_untrusted(dev) ||
> +		(device_untrusted(dev) ||
>   		 dma_kmalloc_needs_bounce(dev, size, dir));
>   }
>   
> @@ -610,7 +605,7 @@ static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
>   	if (!IS_ENABLED(CONFIG_SWIOTLB))
>   		return false;
>   
> -	if (dev_is_untrusted(dev))
> +	if (device_untrusted(dev))
>   		return true;
>   
>   	/*
> @@ -1188,7 +1183,7 @@ static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>   	 * swiotlb_tbl_map_single() has initialized the bounce buffer proper to
>   	 * the contents of the original memory buffer.
>   	 */
> -	if (phys != (phys_addr_t)DMA_MAPPING_ERROR && dev_is_untrusted(dev)) {
> +	if (phys != (phys_addr_t)DMA_MAPPING_ERROR && device_untrusted(dev)) {
>   		size_t start, virt = (size_t)phys_to_virt(phys);
>   
>   		/* Pre-padding */
> @@ -1761,7 +1756,7 @@ size_t iommu_dma_opt_mapping_size(void)
>   
>   size_t iommu_dma_max_mapping_size(struct device *dev)
>   {
> -	if (dev_is_untrusted(dev))
> +	if (device_untrusted(dev))
>   		return swiotlb_max_mapping_size(dev);
>   
>   	return SIZE_MAX;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 849d06dfe1ae..82d9abe87d99 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3501,7 +3501,7 @@ static bool intel_iommu_is_attach_deferred(struct device *dev)
>    */
>   static bool risky_device(struct pci_dev *pdev)
>   {
> -	if (pdev->untrusted) {
> +	if (pci_untrusted(pdev)) {
>   		pci_info(pdev,
>   			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
>   			 pdev->vendor, pdev->device);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e8f13dcebbde..4769d2b548d6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1901,7 +1901,7 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
>   		driver_type = iommu_get_def_domain_type(group, gdev->dev,
>   							driver_type);
>   
> -		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted) {
> +		if (device_untrusted(gdev->dev)) {
>   			/*
>   			 * No ARM32 using systems will set untrusted, it cannot
>   			 * work.
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 96efa00d9743..7296f0ce7530 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -43,7 +43,7 @@ bool pci_ats_supported(struct pci_dev *dev)
>   	if (!dev->ats_cap)
>   		return false;
>   
> -	return (dev->untrusted == 0);
> +	return !pci_untrusted(dev);
>   }
>   EXPORT_SYMBOL_GPL(pci_ats_supported);
>   
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee61..ff1ca74f30b1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -994,7 +994,7 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
>   	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_UF);
>   
>   	/* Enable Translation Blocking for external devices and noats */
> -	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
> +	if (pci_ats_disabled() || dev->external_facing || pci_untrusted(dev))
>   		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
>   }
>   
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18..91a7bbcfdecb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -6,6 +6,7 @@
>   #include <linux/array_size.h>
>   #include <linux/kernel.h>
>   #include <linux/delay.h>
> +#include <linux/device/trust.h>
>   #include <linux/init.h>
>   #include <linux/pci.h>
>   #include <linux/msi.h>
> @@ -1737,20 +1738,23 @@ static void set_pcie_untrusted(struct pci_dev *dev)
>   {
>   	struct pci_dev *parent = pci_upstream_bridge(dev);
>   
> +	dev->dev.bus_trust = DEVICE_DEFAULT_TRUST;
>   	if (!parent)
>   		return;
>   	/*
>   	 * If the upstream bridge is untrusted we treat this device as
>   	 * untrusted as well.
>   	 */
> -	if (parent->untrusted) {
> -		dev->untrusted = true;
> +	if (pci_untrusted(parent)) {
> +		dev->dev.bus_trust =
> +			min(dev->dev.bus_trust, parent->dev.bus_trust);
>   		return;
>   	}
>   
>   	if (arch_pci_dev_is_removable(dev)) {
>   		pci_dbg(dev, "marking as untrusted\n");
> -		dev->untrusted = true;
> +		dev->dev.bus_trust =
> +			min(dev->dev.bus_trust, DEVICE_TRUST_ADVERSARY);
>   	}
>   }
>   
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..73e473856999 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5370,7 +5370,7 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
>    * PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
>    *
>    * TODO: This quirk also needs to do equivalent of PCI_ACS_TB,
> - * if dev->external_facing || dev->untrusted
> + * if dev->external_facing || pci_untrusted(dev)
>    */
>   static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
>   {
> @@ -5411,7 +5411,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
>   	ctrl |= (cap & PCI_ACS_CR);
>   	ctrl |= (cap & PCI_ACS_UF);
>   
> -	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
> +	if (pci_ats_disabled() || dev->external_facing || pci_untrusted(dev))
>   		ctrl |= (cap & PCI_ACS_TB);
>   
>   	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);

