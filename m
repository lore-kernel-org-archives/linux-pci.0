Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 23 Feb 2018 15:40:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] pci: Re-use new dmi_get_bios_year() helper
Message-ID: <20180223214051.GN14632@bhelgaas-glaptop.roam.corp.google.com>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
 <20180222125923.57385-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180222125923.57385-4-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Please use

  PCI: Re-use ...

to match the prevailing drivers/pci style.

On Thu, Feb 22, 2018 at 02:59:23PM +0200, Andy Shevchenko wrote:
> ...instead of open coding its functionality.

Same comment about making the changelog complete, independent of the
subject.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Let me know if you want me to take the series.  Otherwise I'll assume it
goes elsewhere.

> ---
>  drivers/pci/pci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f6a4dd10d9b0..ae654e21439d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2258,8 +2258,6 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
>   */
>  bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  {
> -	unsigned int year;
> -
>  	if (!pci_is_pcie(bridge))
>  		return false;
>  
> @@ -2287,10 +2285,8 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		 * It should be safe to put PCIe ports from 2015 or newer
>  		 * to D3.
>  		 */
> -		if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) &&
> -		    year >= 2015) {
> +		if (dmi_get_bios_year() >= 2015)
>  			return true;
> -		}
>  		break;
>  	}
>  
> -- 
> 2.16.1
> 
