Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 27 Jul 2016 12:13:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rui Wang <rui.y.wang@intel.com>
Cc: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
	bhelgaas@google.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] x86/ioapic: Support hot-removal of IOAPICs
 present during boot
Message-ID: <20160727171358.GA8901@localhost>
References: <20160726204640.GA17664@localhost>
 <1469634255-24101-1-git-send-email-rui.y.wang@intel.com>
 <1469634255-24101-3-git-send-email-rui.y.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469634255-24101-3-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 27, 2016 at 11:44:12PM +0800, Rui Wang wrote:
> IOAPICs present during system boot aren't added to ioapic_list,
> thus are unable to be hot-removed. Fix it by calling
> acpi_ioapic_add() during root bus enumeration.
> 
> Signed-off-by: Rui Wang <rui.y.wang@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume Rafael will merge this since it's mostly ACPI changes.  Let me
know if you need anything else from me.

> ---
>  drivers/acpi/pci_root.c | 10 ++++++++++
>  drivers/pci/setup-bus.c |  5 ++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 53f5965..fa9c83a 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -614,6 +614,16 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  	if (hotadd) {
>  		pcibios_resource_survey_bus(root->bus);
>  		pci_assign_unassigned_root_bus_resources(root->bus);
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
>  		acpi_ioapic_add(root->device->handle);
>  	}
>  
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
> -- 
> 1.8.3.1
> 
