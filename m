Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 16 May 2015 09:37:50 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jarod Wilson <jarod@redhat.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/hotplug: work-around for missing _RMV on HP ZBook G2
Message-ID: <20150516143750.GG31666@google.com>
References: <1431632038-39917-1-git-send-email-jarod@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431632038-39917-1-git-send-email-jarod@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jarod,

On Thu, May 14, 2015 at 03:33:58PM -0400, Jarod Wilson wrote:
> The HP ZBook 15 and 17 Mobile Workstations, generation 2, up to and
> including at least BIOS revision 01.07, do not have an ACPI _RMV object
> associated with their expresscard slots, so acpi-based hotplug-capable
> slot detection fails. If we fall back to pcie-based detection, the systems
> work just fine, so this uses dmi matching to do that. With luck, a future
> BIOS will remedy this (I've let someone at HP know about the problem),
> but for now, just use this for all existing versions.
> 
> Note: they *do* have a proper _RMV object for what I believe is their
> thunderbolt ports.
> 
> Tested successfully on an HP ZBook 17 G2 and HP ZBook 15 G2.
> 
> CC: Len Brown <lenb@kernel.org>
> CC: "Rafael J. Wysocki" <rjw@sisk.pl>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: linux-acpi@vger.kernel.org
> CC: linux-pci@vger.kernel.org
> Signed-off-by: Jarod Wilson <jarod@redhat.com>
> ---
>  drivers/pci/hotplug/pciehp_acpi.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_acpi.c b/drivers/pci/hotplug/pciehp_acpi.c
> index 93cc926..db38fb5 100644
> --- a/drivers/pci/hotplug/pciehp_acpi.c
> +++ b/drivers/pci/hotplug/pciehp_acpi.c
> @@ -28,6 +28,7 @@
>  #include <linux/pci_hotplug.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/dmi.h>
>  #include "pciehp.h"
>  
>  #define PCIEHP_DETECT_PCIE	(0)
> @@ -109,10 +110,40 @@ static struct pcie_port_service_driver __initdata dummy_driver = {
>  	.probe		= dummy_probe,
>  };
>  
> +static int __init set_slot_detection_mode_pcie(const struct dmi_system_id *d)
> +{
> +	info("%s lacks ACPI _RMV object for expresscard\n", d->ident);
> +	return 1;
> +}
> +
> +static struct dmi_system_id __initdata missing_acpi_rmv[] = {
> +	/* ZBook 17 through at least bios v01.07 */
> +	{
> +	 .callback = set_slot_detection_mode_pcie,
> +	 .ident = "HP ZBook 17 G2 Mobile Workstation",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "HP ZBook 17 G2"),
> +		},
> +	},
> +	/* ZBook 15 through at least bios v01.07 */
> +	{
> +	 .callback = set_slot_detection_mode_pcie,
> +	 .ident = "HP ZBook 15 G2 Mobile Workstation",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "HP ZBook 15 G2"),
> +		},
> +	},
> +	{ .ident = NULL }
> +};
> +
>  static int __init select_detection_mode(void)
>  {
>  	struct dummy_slot *slot, *tmp;
>  
> +	if (dmi_check_system(missing_acpi_rmv))
> +		return PCIEHP_DETECT_PCIE;

Oh, my goodness.  I forgot how terrible this path is.  Can anyone write a
simple explanation of how we choose to use acpiphp or pciehp?  Module
parameters?  A dummy driver that looks for duplicate slot numbers?  Looking
for _ADR, _EJ0, _RMV?  This is just nuts.

I can't really believe that we're doing this correctly.

If I understand correctly, the ZBooks don't have _RMV, but we try to use
acpiphp anyway, and acpiphp doesn't work?  That sounds more like a problem
with our acpiphp/pciehp selection "algorithm" than a BIOS bug.

Jarod, can you open a report at http://bugzilla.kernel.org and attach a
complete dmesg log, "lspci -vv" output, and an acpidump?  I'm particularly
interested in whether the BIOS granted us control over PCIe native hotplug.
If it did, I wonder why we would even attempt to use acpiphp.

Bjorn

>  	if (pcie_port_service_register(&dummy_driver))
>  		return PCIEHP_DETECT_ACPI;
>  	pcie_port_service_unregister(&dummy_driver);
> @@ -134,4 +165,6 @@ void __init pciehp_acpi_slot_detection_init(void)
>  out:
>  	if (slot_detection_mode == PCIEHP_DETECT_ACPI)
>  		info("Using ACPI for slot detection.\n");
> +	else if (slot_detection_mode == PCIEHP_DETECT_PCIE)
> +		info("Using PCIE-based slot detection.\n");
>  }
> -- 
> 1.8.3.1
> 
