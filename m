Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Rui Wang <rui.y.wang@intel.com>
Cc: helgaas@kernel.org, tglx@linutronix.de, tony.luck@intel.com, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] x86/ioapic: Support hot-removal of IOAPICs present during boot
Date: Wed, 17 Aug 2016 02:33:30 +0200
Message-ID: <23015419.Vf5YANn61V@vostro.rjw.lan>
In-Reply-To: <1470801718-29004-3-git-send-email-rui.y.wang@intel.com>
References: <1470801718-29004-1-git-send-email-rui.y.wang@intel.com> <1470801718-29004-3-git-send-email-rui.y.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 10, 2016 12:01:55 PM Rui Wang wrote:
> IOAPICs present during system boot aren't added to ioapic_list,
> thus are unable to be hot-removed. Fix it by calling
> acpi_ioapic_add() during root bus enumeration.
> 
> Signed-off-by: Rui Wang <rui.y.wang@intel.com>

This patch has been ACKed by Bjorn, right?

In which case you should have added the Acked-by tag to it when reposting.

> ---
>  drivers/acpi/pci_root.c | 10 ++++++++++
>  drivers/pci/setup-bus.c |  5 ++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index b07eda1..bf601d4 100644
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
> index c74059e..ec538d3 100644
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
> @@ -1852,8 +1853,10 @@ void __init pci_assign_unassigned_resources(void)
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
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
