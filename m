Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Message-ID: <65c8e4cb4732f9331fb320f6fd7910756c14fc35.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 1/6] Revert "PCI: Fix is_added/is_busmaster race
 condition"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Hari Vyas <hari.vyas@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck
 <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        Lukas Wunner
 <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta
 Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>, linux-kernel@vger.kernel.org
Date: Fri, 17 Aug 2018 14:57:08 +1000
In-Reply-To: <20180817044902.31420-2-benh@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
	 <20180817044902.31420-2-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-08-17 at 14:48 +1000, Benjamin Herrenschmidt wrote:
> This reverts commit 44bda4b7d26e9fffed6d7152d98a2e9edaeb2a76.
> 
> The new pci state mutex provides a simpler way of addressing
> this race and avoids the relative includes added to the powerpc
> code.

Ignore the cset comment, my "fix" no longer relies on a state mutex,
I'll re-post with a better comment after discussions.

The actual fix is in patch 2:

[RFC PATCH 2/6] pci: Set pci_dev->is_added before calling device_add

(and yes that was supposed be device_attach ... ugh, not enough
caffeine today).

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/pci-common.c          |  4 +---
>  arch/powerpc/platforms/powernv/pci-ioda.c |  3 +--
>  arch/powerpc/platforms/pseries/setup.c    |  3 +--
>  drivers/pci/bus.c                         |  6 +++---
>  drivers/pci/hotplug/acpiphp_glue.c        |  2 +-
>  drivers/pci/pci.h                         | 11 -----------
>  drivers/pci/probe.c                       |  4 ++--
>  drivers/pci/remove.c                      |  5 ++---
>  include/linux/pci.h                       |  1 +
>  9 files changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 471aac313b89..fe9733ffffaa 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -42,8 +42,6 @@
>  #include <asm/ppc-pci.h>
>  #include <asm/eeh.h>
>  
> -#include "../../../drivers/pci/pci.h"
> -
>  /* hose_spinlock protects accesses to the the phb_bitmap. */
>  static DEFINE_SPINLOCK(hose_spinlock);
>  LIST_HEAD(hose_list);
> @@ -1016,7 +1014,7 @@ void pcibios_setup_bus_devices(struct pci_bus *bus)
>  		/* Cardbus can call us to add new devices to a bus, so ignore
>  		 * those who are already fully discovered
>  		 */
> -		if (pci_dev_is_added(dev))
> +		if (dev->is_added)
>  			continue;
>  
>  		pcibios_setup_device(dev);
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 70b2e1e0f23c..5bd0eb6681bc 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -46,7 +46,6 @@
>  
>  #include "powernv.h"
>  #include "pci.h"
> -#include "../../../../drivers/pci/pci.h"
>  
>  #define PNV_IODA1_M64_NUM	16	/* Number of M64 BARs	*/
>  #define PNV_IODA1_M64_SEGS	8	/* Segments per M64 BAR	*/
> @@ -3139,7 +3138,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>  	struct pci_dn *pdn;
>  	int mul, total_vfs;
>  
> -	if (!pdev->is_physfn || pci_dev_is_added(pdev))
> +	if (!pdev->is_physfn || pdev->is_added)
>  		return;
>  
>  	pdn = pci_get_pdn(pdev);
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 8a4868a3964b..139f0af6c3d9 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -71,7 +71,6 @@
>  #include <asm/security_features.h>
>  
>  #include "pseries.h"
> -#include "../../../../drivers/pci/pci.h"
>  
>  int CMO_PrPSP = -1;
>  int CMO_SecPSP = -1;
> @@ -665,7 +664,7 @@ static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
>  	const int *indexes;
>  	struct device_node *dn = pci_device_to_OF_node(pdev);
>  
> -	if (!pdev->is_physfn || pci_dev_is_added(pdev))
> +	if (!pdev->is_physfn || pdev->is_added)
>  		return;
>  	/*Firmware must support open sriov otherwise dont configure*/
>  	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 5cb40b2518f9..35b7fc87eac5 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -330,7 +330,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  		return;
>  	}
>  
> -	pci_dev_assign_added(dev, true);
> +	dev->is_added = 1;
>  }
>  EXPORT_SYMBOL_GPL(pci_bus_add_device);
>  
> @@ -347,14 +347,14 @@ void pci_bus_add_devices(const struct pci_bus *bus)
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		/* Skip already-added devices */
> -		if (pci_dev_is_added(dev))
> +		if (dev->is_added)
>  			continue;
>  		pci_bus_add_device(dev);
>  	}
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		/* Skip if device attach failed */
> -		if (!pci_dev_is_added(dev))
> +		if (!dev->is_added)
>  			continue;
>  		child = dev->subordinate;
>  		if (child)
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index ef0b1b6ba86f..3a17b290df5d 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -509,7 +509,7 @@ static void enable_slot(struct acpiphp_slot *slot)
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		/* Assume that newly added devices are powered on already. */
> -		if (!pci_dev_is_added(dev))
> +		if (!dev->is_added)
>  			dev->current_state = PCI_D0;
>  	}
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 6e0d1528d471..473aa10a5dbf 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -295,7 +295,6 @@ struct pci_sriov {
>  
>  /* pci_dev priv_flags */
>  #define PCI_DEV_DISCONNECTED 0
> -#define PCI_DEV_ADDED 1
>  
>  static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>  {
> @@ -308,16 +307,6 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
>  	return test_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
>  }
>  
> -static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
> -{
> -	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);
> -}
> -
> -static inline bool pci_dev_is_added(const struct pci_dev *dev)
> -{
> -	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);
> -}
> -
>  #ifdef CONFIG_PCIEAER
>  #include <linux/aer.h>
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ec784009a36b..440445ac7dfa 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2525,13 +2525,13 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>  	dev = pci_scan_single_device(bus, devfn);
>  	if (!dev)
>  		return 0;
> -	if (!pci_dev_is_added(dev))
> +	if (!dev->is_added)
>  		nr++;
>  
>  	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
>  		dev = pci_scan_single_device(bus, devfn + fn);
>  		if (dev) {
> -			if (!pci_dev_is_added(dev))
> +			if (!dev->is_added)
>  				nr++;
>  			dev->multifunction = 1;
>  		}
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 461e7fd2756f..01ec7fcb5634 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -18,12 +18,11 @@ static void pci_stop_dev(struct pci_dev *dev)
>  {
>  	pci_pme_active(dev, false);
>  
> -	if (pci_dev_is_added(dev)) {
> +	if (dev->is_added) {
>  		device_release_driver(&dev->dev);
>  		pci_proc_detach_device(dev);
>  		pci_remove_sysfs_dev_files(dev);
> -
> -		pci_dev_assign_added(dev, false);
> +		dev->is_added = 0;
>  	}
>  
>  	if (dev->bus->self)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9b87f1936906..9799109c5e25 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -373,6 +373,7 @@ struct pci_dev {
>  	unsigned int	transparent:1;		/* Subtractive decode bridge */
>  	unsigned int	multifunction:1;	/* Multi-function device */
>  
> +	unsigned int	is_added:1;
>  	unsigned int	is_busmaster:1;		/* Is busmaster */
>  	unsigned int	no_msi:1;		/* May not use MSI */
>  	unsigned int	no_64bit_msi:1; 	/* May only use 32-bit MSIs */
