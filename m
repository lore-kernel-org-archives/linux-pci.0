Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 30 May 2018 15:23:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, David Keck <david.keck@amd.com>
Subject: Re: [PATCH v8 2/7] PCI: Introduce shpchp_is_native()
Message-ID: <20180530202343.GO39853@bhelgaas-glaptop.roam.corp.google.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180528124756.78512-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180528124756.78512-3-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc David]

On Mon, May 28, 2018 at 03:47:51PM +0300, Mika Westerberg wrote:
> In the same way we do for pciehp, introduce a new function
> shpchp_is_native() that returns true whether the bridge should be
> handled by the native SHCP driver. Then convert the driver to use this
> function.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/hotplug/acpi_pcihp.c  |  4 ++--
>  drivers/pci/hotplug/shpchp_core.c |  2 --
>  drivers/pci/pci-acpi.c            | 21 +++++++++++++++++++++
>  include/linux/pci_hotplug.h       |  2 ++
>  4 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
> index 597d22aeefc1..3979f89b250a 100644
> --- a/drivers/pci/hotplug/acpi_pcihp.c
> +++ b/drivers/pci/hotplug/acpi_pcihp.c
> @@ -83,11 +83,11 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
>  	 * OSHP within the scope of the hotplug controller and its parents,
>  	 * up to the host bridge under which this controller exists.
>  	 */
> -	host = pci_find_host_bridge(pdev->bus);
> -	if (host->native_shpc_hotplug)
> +	if (shpchp_is_native(pdev))
>  		return 0;
>  
>  	/* If _OSC exists, we should not evaluate OSHP */
> +	host = pci_find_host_bridge(pdev->bus);
>  	root = acpi_pci_find_root(ACPI_HANDLE(&host->dev));
>  	if (root->osc_support_set)
>  		goto no_control;
> diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
> index 47decc9b3bb3..0f3711404c2b 100644
> --- a/drivers/pci/hotplug/shpchp_core.c
> +++ b/drivers/pci/hotplug/shpchp_core.c
> @@ -275,8 +275,6 @@ static int is_shpc_capable(struct pci_dev *dev)
>  	if (dev->vendor == PCI_VENDOR_ID_AMD &&
>  	    dev->device == PCI_DEVICE_ID_AMD_GOLAM_7450)
>  		return 1;
> -	if (!pci_find_capability(dev, PCI_CAP_ID_SHPC))
> -		return 0;
>  	if (acpi_get_hp_hw_control_from_firmware(dev))
>  		return 0;
>  	return 1;
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 52b8434d4d6e..bb83be0d0e5b 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -394,6 +394,27 @@ bool pciehp_is_native(struct pci_dev *bridge)
>  	return host->native_pcie_hotplug;
>  }
>  
> +/**
> + * shpchp_is_native - Check whether a hotplug port is handled by the OS
> + * @bridge: Hotplug port to check
> + *
> + * Returns true if the given @bridge is handled by the native SHPC hotplug
> + * driver.
> + */
> +bool shpchp_is_native(struct pci_dev *bridge)
> +{
> +	const struct pci_host_bridge *host;
> +
> +	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
> +		return false;
> +
> +	if (!pci_find_capability(bridge, PCI_CAP_ID_SHPC))
> +		return false;
> +
> +	host = pci_find_host_bridge(bridge->bus);
> +	return host->native_shpc_hotplug;
> +}

This is sort-of-but-not-exactly the same as is_shpc_capable().

For PCI_DEVICE_ID_AMD_GOLAM_7450, is_shpc_capable() will return true
and shpchp will claim the device, but shpchp_is_native() will return
false because there's no SHPC capability.

At least that's my interpretation of the AMD GOLAM stuff.  I don't
have a spec for it, but if GOLAM did have an SHPC capability, I assume
is_shpc_capable() would look for it *before* testing for GOLAM.

So I think these two things need to be reconciled somehow.  I
mentioned this before, but it was buried at the bottom of a long
email, sorry about that.

I wish we had a spec or details about the erratum.  It looks like
it's been there "forever": https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/drivers/pci/hotplug/shpchp.h?id=c16b4b14d9806e639f4afefa2d651a857a212afe

But neither GOLAM (0x7450) nor POGO (0x7458) is in the PCI database at
https://pci-ids.ucw.cz/read/PC/1002, so who knows if those chips ever
even saw the light of day.  I'll cc the author of

  53044f357448 ("[PATCH] PCI Hotplug: shpchp: AMD POGO errata fix")

But that was 12 years ago, so the email address may not even work any
more.

>  /**
>   * pci_acpi_wake_bus - Root bus wakeup notification fork function.
>   * @context: Device wakeup context.
> diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
> index 1f5c935eb0de..4c378368215c 100644
> --- a/include/linux/pci_hotplug.h
> +++ b/include/linux/pci_hotplug.h
> @@ -164,6 +164,7 @@ struct hotplug_params {
>  int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp);
>  bool pciehp_is_native(struct pci_dev *bridge);
>  int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge);
> +bool shpchp_is_native(struct pci_dev *bridge);
>  int acpi_pci_check_ejectable(struct pci_bus *pbus, acpi_handle handle);
>  int acpi_pci_detect_ejectable(acpi_handle handle);
>  #else
> @@ -178,5 +179,6 @@ static inline int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge)
>  	return 0;
>  }
>  static inline bool pciehp_is_native(struct pci_dev *bridge) { return true; }
> +static inline bool shpchp_is_native(struct pci_dev *bridge) { return true; }
>  #endif
>  #endif
> -- 
> 2.17.0
> 
