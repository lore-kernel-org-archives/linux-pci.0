Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 13 Mar 2018 11:45:37 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v2 2/4] x86/PCI: Simplify code by using the new
 dmi_get_bios_year() helper
Message-ID: <20180313114537.59cbc766@endymion>
In-Reply-To: <20180301180220.11333-3-andriy.shevchenko@linux.intel.com>
References: <20180301180220.11333-1-andriy.shevchenko@linux.intel.com>
        <20180301180220.11333-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Andy,

On Thu,  1 Mar 2018 20:02:18 +0200, Andy Shevchenko wrote:
> Use new dmi_get_bios_year() helper instead of open-coding its
> functionality.
> 
> No changes in functionality.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/pci/acpi.c            | 10 +++++-----
>  arch/x86/pci/direct.c          |  5 ++---
>  arch/x86/pci/mmconfig-shared.c |  9 ++-------
>  3 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 7df49c40665e..52b22137243f 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -138,14 +138,14 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
>  	{}
>  };
>  
> +#define in_range(b, first, len) ((b) >= (first) && (b) <= (first) + (len) - 1)
> +
>  void __init pci_acpi_crs_quirks(void)
>  {
> -	int year;
> +	int year = dmi_get_bios_year();
>  
> -	if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year < 2008) {
> -		if (iomem_resource.end <= 0xffffffff)
> -			pci_use_crs = false;
> -	}
> +	if (in_range(year, 0, 2008) && iomem_resource.end <= 0xffffffff)

I don't like this, sorry. I find "in_range" confusing, there are many
definitions of it throughout the kernel which differ in the details
(some take a length as 3rd parameter, others take upper boundary, some
include the boundaries, some do not...) The following:

	if (year >= 0 && year < 2008 && iomem_resource.end <= 0xffffffff)

is a lot more readable in my opinion. No need to look-up a tricky macro
definition to figure what happens if year is 2008.

> +		pci_use_crs = false;
>  
>  	dmi_check_system(pci_crs_quirks);

-- 
Jean Delvare
SUSE L3 Support
