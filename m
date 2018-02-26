Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 26 Feb 2018 17:28:32 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] x86/pci: Re-use new dmi_get_bios_year() helper
Message-ID: <20180226172832.7bf82336@endymion>
In-Reply-To: <20180222125923.57385-2-andriy.shevchenko@linux.intel.com>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
        <20180222125923.57385-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Andy,

On Thu, 22 Feb 2018 14:59:21 +0200, Andy Shevchenko wrote:
> ...instead of open coding its functionality.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/pci/acpi.c            | 8 ++------
>  arch/x86/pci/direct.c          | 5 ++---
>  arch/x86/pci/mmconfig-shared.c | 9 ++-------
>  3 files changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 7df49c40665e..00e60de30328 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -140,12 +140,8 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
>  
>  void __init pci_acpi_crs_quirks(void)
>  {
> -	int year;
> -
> -	if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year < 2008) {
> -		if (iomem_resource.end <= 0xffffffff)
> -			pci_use_crs = false;
> -	}
> +	if ((dmi_get_bios_year() < 2008) && (iomem_resource.end <= 0xffffffff))
> +		pci_use_crs = false;

You are changing the behavior here, when DMI does not provide a BIOS
date. Beforehand, the test would fail and pci_use_crs would be left
alone. After your change, dmi_get_bios_year() will return 0, and
"0 < 2008" is true, so pci_use_crs is set to false.

I have no opinion on what this driver should do in such case, but I
certainly wouldn't expect a change of behavior from a "use a helper
instead of open-coding" kind of patch.

I don't think you can safely assume that the code calling
dmi_get_bios_year() will always do the right thing when 0 is being
returned. It's up to the calling code to decide what the default
behavior should be.

Also there are more parentheses than needed.

>  
>  	dmi_check_system(pci_crs_quirks);
>  
> diff --git a/arch/x86/pci/direct.c b/arch/x86/pci/direct.c
> index 2d9503323d10..a51074c55982 100644
> --- a/arch/x86/pci/direct.c
> +++ b/arch/x86/pci/direct.c
> @@ -195,14 +195,13 @@ static const struct pci_raw_ops pci_direct_conf2 = {
>  static int __init pci_sanity_check(const struct pci_raw_ops *o)
>  {
>  	u32 x = 0;
> -	int year, devfn;
> +	int devfn;
>  
>  	if (pci_probe & PCI_NO_CHECKS)
>  		return 1;
>  	/* Assume Type 1 works for newer systems.
>  	   This handles machines that don't have anything on PCI Bus 0. */
> -	dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
> -	if (year >= 2001)
> +	if (dmi_get_bios_year() >= 2001)
>  		return 1;
>  
>  	for (devfn = 0; devfn < 0x100; devfn++) {
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 96684d0adcf9..0b40482578b8 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -547,19 +547,14 @@ static void __init pci_mmcfg_reject_broken(int early)
>  static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
>  					struct acpi_mcfg_allocation *cfg)
>  {
> -	int year;
> -
>  	if (cfg->address < 0xFFFFFFFF)
>  		return 0;
>  
>  	if (!strncmp(mcfg->header.oem_id, "SGI", 3))
>  		return 0;
>  
> -	if (mcfg->header.revision >= 1) {
> -		if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) &&
> -		    year >= 2010)
> -			return 0;
> -	}
> +	if ((mcfg->header.revision >= 1) && (dmi_get_bios_year() >= 2010))
> +		return 0;

Here too some parentheses are not needed.

>  
>  	pr_err(PREFIX "MCFG region for %04x [bus %02x-%02x] at %#llx "
>  	       "is above 4GB, ignored\n", cfg->pci_segment,


-- 
Jean Delvare
SUSE L3 Support
