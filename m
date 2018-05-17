Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 17 May 2018 09:13:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v7 03/12] PCI: Request control of native PCIe hotplug
 only if supported
Message-ID: <20180517141324.GD19955@bhelgaas-glaptop.roam.corp.google.com>
References: <20180517092903.43701-1-mika.westerberg@linux.intel.com>
 <20180517092903.43701-4-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180517092903.43701-4-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 17, 2018 at 12:28:54PM +0300, Mika Westerberg wrote:
> Currently we request control of native PCIe hotplug unconditionally.
> That may cause problems because native PCIe hotplug events are handled
> by pciehp driver and if it is not enabled those events will be lost.
> Make this bit more robust and request control of native PCIe hotplug
> only if we are actually prepared to do so (pciehp driver is enabled).
> 
> While there rename host->native_hotplug to host->native_pcie_hotplug
> because we do the same for SHPC hotplug in subsequent patches.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/pci_root.c         | 6 ++++--
>  drivers/pci/pcie/portdrv_core.c | 2 +-
>  drivers/pci/probe.c             | 2 +-
>  include/linux/pci.h             | 2 +-
>  4 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 0da18bde6a16..02ab96f00952 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -29,6 +29,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
>  #include <linux/pci-aspm.h>
> +#include <linux/pci_hotplug.h>
>  #include <linux/dmar.h>
>  #include <linux/acpi.h>
>  #include <linux/slab.h>
> @@ -472,9 +473,10 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>  	}
>  
>  	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
> -		| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
>  		| OSC_PCI_EXPRESS_PME_CONTROL;
>  
> +	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> +		control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
>  	if (pci_aer_available()) {
>  		if (aer_acpi_firmware_first())
>  			dev_info(&device->dev,
> @@ -900,7 +902,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  
>  	host_bridge = to_pci_host_bridge(bus->bridge);
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
> -		host_bridge->native_hotplug = 0;
> +		host_bridge->native_pcie_hotplug = 0;
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
>  		host_bridge->native_aer = 0;
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))

Rafael, I noticed that the PCI Firmware Spec, r3.2, sec 4.5.2.2, says
we're required to evaluate _OSC when resuming from S4.  I don't see a
path where we do that today.

Am I missing it?  If not, what resume hook do we need to use to do
this?
