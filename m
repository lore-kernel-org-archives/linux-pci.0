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
Subject: Re: [PATCH 10/10] PCI / ACPI: Whitelist D3 for more PCIe hotplug ports
Date: Tue, 11 Sep 2018 11:01:27 +0200
Message-ID: <1783231.zbE0DC02F3@aspire.rjw.lan>
In-Reply-To: <20180906155020.51700-11-mika.westerberg@linux.intel.com>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com> <20180906155020.51700-11-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 6, 2018 5:50:20 PM CEST Mika Westerberg wrote:
> In order to have better power management for Thunderbolt PCIe chains,
> Windows enables power management for native PCIe hotplug ports if there
> is following ACPI _DSD attached to the root port:
> 
>   Name (_DSD, Package () {
>       ToUUID ("6211e2c0-58a3-4af3-90e1-927a4e0c55a4"),
>       Package () {
>           Package () {"HotPlugSupportInD3", 1}
>       }
>   })
> 
> This is also documented in:
> 
>   https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
> 
> Do the same in Linux by introducing new firmware PM callback (->bridge_d3())
> and then implement it for ACPI based systems so that the above property is
> checked.
> 
> There is one catch, though. The initial pci_dev->bridge_d3 is set before
> the root port has ACPI companion bound (the device is not added to the
> PCI bus either) so we need to look up the ACPI companion manually in
> that case in acpi_pci_bridge_d3().
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/property.c |  3 +++
>  drivers/pci/pci-acpi.c  | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c       |  9 +++++++++
>  drivers/pci/pci.h       |  3 +++
>  4 files changed, 56 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index f3ddb279d2de..f9d63ee9f623 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -28,6 +28,9 @@ static const guid_t prp_guids[] = {
>  	/* ACPI _DSD device properties GUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301 */
>  	GUID_INIT(0xdaffd814, 0x6eba, 0x4d8c,
>  		  0x8a, 0x91, 0xbc, 0x9b, 0xbf, 0x4a, 0xa3, 0x01),
> +	/* Hotplug in D3 GUID: 6211e2c0-58a3-4af3-90e1-927a4e0c55a4 */
> +	GUID_INIT(0x6211e2c0, 0x58a3, 0x4af3,
> +		  0x90, 0xe1, 0x92, 0x7a, 0x4e, 0x0c, 0x55, 0xa4),
>  };
>  
>  static const guid_t ads_guid =
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a4a8c02deaa0..c0394232fd93 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -519,6 +519,46 @@ static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>  	return PCI_POWER_ERROR;
>  }
>  
> +static struct acpi_device *acpi_pci_find_companion(struct device *dev);
> +
> +static bool acpi_pci_bridge_d3(struct pci_dev *dev)
> +{
> +	const struct fwnode_handle *fwnode;
> +	struct acpi_device *adev;
> +	struct pci_dev *root;
> +	u8 val;
> +
> +	if (!dev->is_hotplug_bridge)
> +		return false;
> +
> +	/*
> +	 * Look for a special _DSD property for the root port and if it
> +	 * is set we know the hierarchy behind it supports D3 just fine.
> +	 */
> +	root = pci_find_pcie_root_port(dev);
> +	if (!root)
> +		return false;
> +
> +	adev = ACPI_COMPANION(&root->dev);
> +	if (root == dev) {
> +		/*
> +		 * It is possible that the ACPI companion is not yet bound
> +		 * for the root port so look it up manually here.
> +		 */
> +		if (!adev && !pci_dev_is_added(root))
> +			adev = acpi_pci_find_companion(&root->dev);
> +	}
> +
> +	if (!adev)
> +		return false;
> +
> +	fwnode = acpi_fwnode_handle(adev);
> +	if (fwnode_property_read_u8(fwnode, "HotPlugSupportInD3", &val))
> +		return false;
> +
> +	return val == 1;
> +}
> +
>  static bool acpi_pci_power_manageable(struct pci_dev *dev)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> @@ -635,6 +675,7 @@ static bool acpi_pci_need_resume(struct pci_dev *dev)
>  }
>  
>  static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
> +	.bridge_d3 = acpi_pci_bridge_d3,
>  	.is_manageable = acpi_pci_power_manageable,
>  	.set_state = acpi_pci_set_power_state,
>  	.get_state = acpi_pci_get_power_state,
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 074f3f0253f9..ce212eb10be9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -791,6 +791,11 @@ static inline bool platform_pci_need_resume(struct pci_dev *dev)
>  	return pci_platform_pm ? pci_platform_pm->need_resume(dev) : false;
>  }
>  
> +static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> +{
> +	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
> +}
> +
>  /**
>   * pci_raw_set_power_state - Use PCI PM registers to set the power state of
>   *                           given PCI device
> @@ -2513,6 +2518,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		if (bridge->is_thunderbolt)
>  			return true;
>  
> +		/* Platform might know better if the bridge supports D3 */
> +		if (platform_pci_bridge_d3(bridge))
> +			return true;
> +
>  		/*
>  		 * Hotplug ports handled natively by the OS were not validated
>  		 * by vendors for runtime D3 at least until 2018 because there
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 6e0d1528d471..66fd5c1bf71b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -39,6 +39,8 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  /**
>   * struct pci_platform_pm_ops - Firmware PM callbacks
>   *
> + * @bridge_d3: Does the bridge allow entering into D3
> + *
>   * @is_manageable: returns 'true' if given device is power manageable by the
>   *		   platform firmware
>   *
> @@ -60,6 +62,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>   * these callbacks are mandatory.
>   */
>  struct pci_platform_pm_ops {
> +	bool (*bridge_d3)(struct pci_dev *dev);
>  	bool (*is_manageable)(struct pci_dev *dev);
>  	int (*set_state)(struct pci_dev *dev, pci_power_t state);
>  	pci_power_t (*get_state)(struct pci_dev *dev);
> 

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
