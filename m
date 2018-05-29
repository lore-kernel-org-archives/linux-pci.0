Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8 3/7] PCI: Introduce hotplug_is_native()
Date: Tue, 29 May 2018 11:06:44 +0200
Message-ID: <1728078.B8Za3xLYKa@aspire.rjw.lan>
In-Reply-To: <20180528124756.78512-4-mika.westerberg@linux.intel.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com> <20180528124756.78512-4-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, May 28, 2018 2:47:52 PM CEST Mika Westerberg wrote:
> This helper function can be used for finding out whether the OS is
> supposed to handle native hotplug of a given bridge.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/pci_hotplug.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
> index 4c378368215c..cf5e22103f68 100644
> --- a/include/linux/pci_hotplug.h
> +++ b/include/linux/pci_hotplug.h
> @@ -181,4 +181,9 @@ static inline int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge)
>  static inline bool pciehp_is_native(struct pci_dev *bridge) { return true; }
>  static inline bool shpchp_is_native(struct pci_dev *bridge) { return true; }
>  #endif
> +
> +static inline bool hotplug_is_native(struct pci_dev *bridge)
> +{
> +	return pciehp_is_native(bridge) || shpchp_is_native(bridge);
> +}
>  #endif
> 


