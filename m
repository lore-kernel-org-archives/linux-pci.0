Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        "D . J . Bernstein" <djb@cr.yp.to>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 02/10] PCI / ACPI: Enable wake automatically for power managed bridges
Date: Tue, 11 Sep 2018 10:50:18 +0200
Message-ID: <1654330.M3KingDFxV@aspire.rjw.lan>
In-Reply-To: <20180906155020.51700-3-mika.westerberg@linux.intel.com>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com> <20180906155020.51700-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 6, 2018 5:50:12 PM CEST Mika Westerberg wrote:
> We enable power management automatically for bridges where
> pci_bridge_d3_possible() returns true. However, these bridges may have
> ACPI methods such as _DSW that need to be called before D3 entry. For
> example in Lenovo Thinkpad X1 Carbon 6th _DSW method is used to prepare
> D3cold for the PCIe root port hosting Thunderbolt chain. Because wake is
> not enabled _DSW method is never called and the port does not enter
> D3cold properly consuming more power than necessary.
> 
> Users can work this around by writing "enabled" to "wakeup" sysfs file
> under the device in question but that is not something an ordinary user
> is expected to do.
> 
> Since we already automatically enable power management for PCIe ports
> with ->bridge_d3 set extend that to enable wake for them as well,
> assuming the port has any ACPI wakeup related objects implemented in the
> namespace (adev->wakeup.flags.valid is true). This ensures the necessary
> ACPI methods get called at appropriate times and allows the root port in
> Thinkpad X1 Carbon 6th to go into D3cold.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pci-acpi.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index c2ab57705043..a4a8c02deaa0 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -762,19 +762,32 @@ static void pci_acpi_setup(struct device *dev)
>  		return;
>  
>  	device_set_wakeup_capable(dev, true);
> +	/*
> +	 * For bridges that can do D3 we enable wake automatically (as
> +	 * we do for the power management itself in that case). The
> +	 * reason is that the bridge may have additional methods such as
> +	 * _DSW that need to be called.
> +	 */
> +	if (pci_dev->bridge_d3)
> +		device_wakeup_enable(dev);
> +
>  	acpi_pci_wakeup(pci_dev, false);
>  }
>  
>  static void pci_acpi_cleanup(struct device *dev)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
>  
>  	if (!adev)
>  		return;
>  
>  	pci_acpi_remove_pm_notifier(adev);
> -	if (adev->wakeup.flags.valid)
> +	if (adev->wakeup.flags.valid) {
> +		if (pci_dev->bridge_d3)
> +			device_wakeup_disable(dev);

Add an empty line here?

>  		device_set_wakeup_capable(dev, false);
> +	}
>  }
>  
>  static bool pci_acpi_bus_match(struct device *dev)
> 

Apart from the above nit this is fine by me:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
