Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 27 Mar 2018 14:45:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 5/5] ACPI / hotplug / PCI: Mark stale PCI devices
 disconnected
Message-ID: <20180327194512.GD7759@bhelgaas-glaptop.roam.corp.google.com>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
 <20180226132112.81447-6-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180226132112.81447-6-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 26, 2018 at 04:21:12PM +0300, Mika Westerberg wrote:
> Following PCIehp mark the unplugged PCI devices disconnected. This makes
> sure PCI core code leaves the now missing hardware registers alone.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 5efa21cdddc9..0aef35ee665a 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -651,6 +651,11 @@ static void trim_stale_devices(struct pci_dev *dev)
>  		alive = pci_device_is_present(dev);
>  
>  	if (!alive) {
> +		pci_dev_set_disconnected(dev, NULL);
> +		if (pci_has_subordinate(dev))
> +			pci_walk_bus(dev->subordinate, pci_dev_set_disconnected,
> +				     NULL);

I hate this pci_dev_set_disconnected() thing and hope to remove it
someday.  It's racy and adds additional states that are hard to
manage, e.g., "device has been removed and will not respond to PCI
accesses, but pci_dev_set_disconnected() hasn't been called yet".  If
we can handle that case (and we should), we shouldn't need
pci_dev_set_disconnected().

But I guess I accepted it other places, so now I have to accept it
here.

I do wonder whether it should be factored into a
"pci_disconnect_dev()" that does both the device itself and the bus
walk.

And I wonder whether that should be called form
pci_stop_and_remove_bus_device(), since some callers do this and
others don't.

> +
>  		pci_stop_and_remove_bus_device(dev);
>  		if (adev)
>  			acpi_bus_trim(adev);
> -- 
> 2.16.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
