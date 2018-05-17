Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <f9221fcc3c828e529c470e514046fb05ce16c230.camel@linux.intel.com>
Subject: Re: [PATCH v7 12/12] ACPI / hotplug / PCI: Drop unnecessary
 parentheses
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date: Thu, 17 May 2018 14:43:49 +0300
In-Reply-To: <20180517092903.43701-13-mika.westerberg@linux.intel.com>
References: <20180517092903.43701-1-mika.westerberg@linux.intel.com>
         <20180517092903.43701-13-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-05-17 at 12:29 +0300, Mika Westerberg wrote:
> There is no need for them and it makes the code look uglier than it
> should. Remove them.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c
> b/drivers/pci/hotplug/acpiphp_glue.c
> index db256bb2bd6a..07d511d62296 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -522,7 +522,7 @@ static void enable_slot(struct acpiphp_slot *slot)
>  		if (!dev) {
>  			/* Do not set SLOT_ENABLED flag if some funcs
>  			   are not added. */
> -			slot->flags &= (~SLOT_ENABLED);
> +			slot->flags &= ~SLOT_ENABLED;
>  			continue;
>  		}
>  	}
> @@ -551,7 +551,7 @@ static void disable_slot(struct acpiphp_slot
> *slot)
>  	list_for_each_entry(func, &slot->funcs, sibling)
>  		acpi_bus_trim(func_to_acpi_device(func));
>  
> -	slot->flags &= (~SLOT_ENABLED);
> +	slot->flags &= ~SLOT_ENABLED;
>  }
>  
>  static bool slot_no_hotplug(struct acpiphp_slot *slot)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
