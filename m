Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 16 Mar 2017 12:48:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rui Wang <rui.y.wang@intel.com>
Cc: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, fengguang.wu@intel.com, kbuild-all@01.org
Subject: Re: [PATCH v2 2/2] x86/ioapic: Split IOAPIC hot-removal into two
 steps
Message-ID: <20170316174842.GC2021@bhelgaas-glaptop.roam.corp.google.com>
References: <201702280904.A2EXAFMQ%fengguang.wu@intel.com>
 <1488288869-31290-1-git-send-email-rui.y.wang@intel.com>
 <1488288869-31290-3-git-send-email-rui.y.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488288869-31290-3-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 28, 2017 at 09:34:29PM +0800, Rui Wang wrote:
> The hot-removal of IOAPIC is broken into two parts: the PCI part and
> the ACPI part. The PCI part releases PCI resources before the PCI bus
> is gone, and the ACPI part is moved to a stage later than the hot-removal
> of the PCI root bus, so that the IOAPIC driver is able to hook the
> pcibios_release_device() of every PCI device under the same parent root
> bus, before the IOAPIC is hot-removed. This makes it possible for the
> IOAPIC to free any IRQ resource previously unable to get freed.
> 
> v2: Fixed compiling error on i386 (missing stub of pci_ioapic_remove())
> 
> Signed-off-by: Rui Wang <rui.y.wang@intel.com>

Minor comments below, but

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/acpi/internal.h |  2 ++
>  drivers/acpi/ioapic.c   | 22 ++++++++++++++++------
>  drivers/acpi/pci_root.c |  4 ++--
>  3 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 219b90b..f159001 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -41,8 +41,10 @@ static inline void acpi_amba_init(void) {}
>  void acpi_container_init(void);
>  void acpi_memory_hotplug_init(void);
>  #ifdef	CONFIG_ACPI_HOTPLUG_IOAPIC
> +void pci_ioapic_remove(struct acpi_pci_root *root);
>  int acpi_ioapic_remove(struct acpi_pci_root *root);
>  #else
> +static inline void pci_ioapic_remove(struct acpi_pci_root *root) { return; }

Superfluous "return;" here.

>  static inline int acpi_ioapic_remove(struct acpi_pci_root *root) { return 0; }
>  #endif
>  #ifdef CONFIG_ACPI_DOCK
> diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
> index 6d7ce6e..1120dfd6 100644
> --- a/drivers/acpi/ioapic.c
> +++ b/drivers/acpi/ioapic.c
> @@ -206,24 +206,34 @@ int acpi_ioapic_add(acpi_handle root_handle)
>  	return ACPI_SUCCESS(status) && ACPI_SUCCESS(retval) ? 0 : -ENODEV;
>  }
>  
> -int acpi_ioapic_remove(struct acpi_pci_root *root)
> +void pci_ioapic_remove(struct acpi_pci_root *root)
>  {
> -	int retval = 0;
>  	struct acpi_pci_ioapic *ioapic, *tmp;
>  
>  	mutex_lock(&ioapic_list_lock);
>  	list_for_each_entry_safe(ioapic, tmp, &ioapic_list, list) {

I don't think it's necessary to use the "safe" iterator here, since
you're not modifying ioapic_list in the loop any more.

>  		if (root->device->handle != ioapic->root_handle)
>  			continue;
> -
> -		if (acpi_unregister_ioapic(ioapic->handle, ioapic->gsi_base))
> -			retval = -EBUSY;
> -
>  		if (ioapic->pdev) {
>  			pci_release_region(ioapic->pdev, 0);
>  			pci_disable_device(ioapic->pdev);
>  			pci_dev_put(ioapic->pdev);
>  		}
> +	}
> +	mutex_unlock(&ioapic_list_lock);
> +}
> +
> +int acpi_ioapic_remove(struct acpi_pci_root *root)
> +{
> +	int retval = 0;
> +	struct acpi_pci_ioapic *ioapic, *tmp;
> +
> +	mutex_lock(&ioapic_list_lock);
> +	list_for_each_entry_safe(ioapic, tmp, &ioapic_list, list) {
> +		if (root->device->handle != ioapic->root_handle)
> +			continue;
> +		if (acpi_unregister_ioapic(ioapic->handle, ioapic->gsi_base))
> +			retval = -EBUSY;
>  		if (ioapic->res.flags && ioapic->res.parent)
>  			release_resource(&ioapic->res);
>  		list_del(&ioapic->list);
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index bf601d4..919be0a 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -648,12 +648,12 @@ static void acpi_pci_root_remove(struct acpi_device *device)
>  
>  	pci_stop_root_bus(root->bus);
>  
> -	WARN_ON(acpi_ioapic_remove(root));
> -
> +	pci_ioapic_remove(root);
>  	device_set_run_wake(root->bus->bridge, false);
>  	pci_acpi_remove_bus_pm_notifier(device);
>  
>  	pci_remove_root_bus(root->bus);
> +	WARN_ON(acpi_ioapic_remove(root));

You didn't change this, but my personal preference is not to call
functions with side-effects inside a WARN_ON() or BUG_ON().  The
acpi_ioapic_remove() call is essential here, and I think it gets
obscured a bit by being inside WARN_ON().

>  	dmar_device_remove(device->handle);
>  
> -- 
> 1.8.3.1
> 
