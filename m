Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 26 Jul 2016 15:19:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rui Wang <rui.y.wang@intel.com>
Cc: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
	bhelgaas@google.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] x86/ioapic: Support hot-removal of IOAPICs present
 during boot
Message-ID: <20160726201932.GD15037@localhost>
References: <1469549597-19253-1-git-send-email-rui.y.wang@intel.com>
 <1469549597-19253-2-git-send-email-rui.y.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469549597-19253-2-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 27, 2016 at 12:13:14AM +0800, Rui Wang wrote:
> IOAPICs present during system boot aren't added to ioapic_list,
> thus are unable to be hot-removed. Fix it by calling
> acpi_ioapic_add() during root bus enumeration.
> 
> Signed-off-by: Rui Wang <rui.y.wang@intel.com>
> ---
>  drivers/acpi/internal.h |  2 --
>  drivers/acpi/ioapic.c   |  7 ++++---
>  drivers/acpi/pci_root.c | 13 ++++++++++++-
>  drivers/pci/setup-bus.c |  5 ++++-
>  include/linux/acpi.h    |  6 ++++++
>  5 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 27cc7fe..6d8e67e 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -40,10 +40,8 @@ int acpi_sysfs_init(void);
>  void acpi_container_init(void);
>  void acpi_memory_hotplug_init(void);
>  #ifdef	CONFIG_ACPI_HOTPLUG_IOAPIC
> -int acpi_ioapic_add(struct acpi_pci_root *root);
>  int acpi_ioapic_remove(struct acpi_pci_root *root);
>  #else
> -static inline int acpi_ioapic_add(struct acpi_pci_root *root) { return 0; }

It would be nicer if the interface change and header file munging
were in a separate patch so they wouldn't obscure the meat of the
change, i.e., the addition of calls to acpi_ioapic_add().

>  static inline int acpi_ioapic_remove(struct acpi_pci_root *root) { return 0; }
>  #endif
>  #ifdef CONFIG_ACPI_DOCK
> diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
> index ccdc8db..0f272e2 100644
> --- a/drivers/acpi/ioapic.c
> +++ b/drivers/acpi/ioapic.c
> @@ -189,16 +189,17 @@ exit:
>  	return AE_OK;
>  }
>  
> -int acpi_ioapic_add(struct acpi_pci_root *root)
> +int acpi_ioapic_add(acpi_handle root_handle)
>  {
>  	acpi_status status, retval = AE_OK;
>  
> -	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, root->device->handle,
> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, root_handle,
>  				     UINT_MAX, handle_ioapic_add, NULL,
> -				     root->device->handle, (void **)&retval);
> +				     root_handle, (void **)&retval);
>  
>  	return ACPI_SUCCESS(status) && ACPI_SUCCESS(retval) ? 0 : -ENODEV;
>  }
> +EXPORT_SYMBOL_GPL(acpi_ioapic_add);

What loadable module needs to call this?  It shouldn't be exported
unless there is such a module.

>  int acpi_ioapic_remove(struct acpi_pci_root *root)
>  {
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index ae3fe4e..d818c61 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -614,7 +614,18 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  	if (hotadd) {
>  		pcibios_resource_survey_bus(root->bus);
>  		pci_assign_unassigned_root_bus_resources(root->bus);
> -		acpi_ioapic_add(root);
> +
> +		/*
> +		 * This is only called for the hotadd case. For the boot-time
> +		 * case, we need to wait until after PCI initialization in
> +		 * order to deal with IOAPICs mapped in on a PCI BAR.
> +		 *
> +		 * This is currently x86-specific, because acpi_ioapic_add()
> +		 * is an empty function without CONFIG_ACPI_HOTPLUG_IOAPIC.
> +		 * And CONFIG_ACPI_HOTPLUG_IOAPIC depends on CONFIG_X86_IO_APIC
> +		 * (see drivers/acpi/Kconfig).
> +		 */
> +		acpi_ioapic_add(root->device->handle);
>  	}
>  
>  	pci_lock_rescan_remove();
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 55641a3..e32c356 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -25,6 +25,7 @@
>  #include <linux/ioport.h>
>  #include <linux/cache.h>
>  #include <linux/slab.h>
> +#include <linux/acpi.h>
>  #include "pci.h"
>  
>  unsigned int pci_flags;
> @@ -1779,8 +1780,10 @@ void __init pci_assign_unassigned_resources(void)
>  {
>  	struct pci_bus *root_bus;
>  
> -	list_for_each_entry(root_bus, &pci_root_buses, node)
> +	list_for_each_entry(root_bus, &pci_root_buses, node) {
>  		pci_assign_unassigned_root_bus_resources(root_bus);
> +		acpi_ioapic_add(ACPI_HANDLE(root_bus->bridge));
> +	}
>  }
>  
>  void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 288fac5..f5114dc 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -680,6 +680,12 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>  
>  #endif	/* !CONFIG_ACPI */
>  
> +#ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
> +int acpi_ioapic_add(acpi_handle root);
> +#else
> +static inline int acpi_ioapic_add(acpi_handle root) { return 0; }
> +#endif
> +
>  #ifdef CONFIG_ACPI
>  void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
>  			       u32 pm1a_ctrl,  u32 pm1b_ctrl));
> -- 
> 1.8.3.1
> 
