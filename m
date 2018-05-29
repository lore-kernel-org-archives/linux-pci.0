Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <c73c3e3c1b8b16f3335b9c42d42598dc3fac171b.camel@linux.intel.com>
Subject: Re: [PATCH v8 3/7] PCI: Introduce hotplug_is_native()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date: Tue, 29 May 2018 19:34:41 +0300
In-Reply-To: <20180528124756.78512-4-mika.westerberg@linux.intel.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
         <20180528124756.78512-4-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2018-05-28 at 15:47 +0300, Mika Westerberg wrote:
> This helper function can be used for finding out whether the OS is
> supposed to handle native hotplug of a given bridge.
> 

Nice simple helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  include/linux/pci_hotplug.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
> index 4c378368215c..cf5e22103f68 100644
> --- a/include/linux/pci_hotplug.h
> +++ b/include/linux/pci_hotplug.h
> @@ -181,4 +181,9 @@ static inline int
> acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge)
>  static inline bool pciehp_is_native(struct pci_dev *bridge) { return
> true; }
>  static inline bool shpchp_is_native(struct pci_dev *bridge) { return
> true; }
>  #endif
> +
> +static inline bool hotplug_is_native(struct pci_dev *bridge)
> +{
> +	return pciehp_is_native(bridge) || shpchp_is_native(bridge);
> +}
>  #endif

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
