Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.de>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3 1/2] x86/PCI: Fix a potential regression when use dmi_get_bios_year()
Date: Tue, 20 Mar 2018 17:53:54 +0100
Message-ID: <39019613.0FkGD81NNE@aspire.rjw.lan>
In-Reply-To: <20180320135410.11627-2-andriy.shevchenko@linux.intel.com>
References: <20180320135410.11627-1-andriy.shevchenko@linux.intel.com> <20180320135410.11627-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, March 20, 2018 2:54:09 PM CET Andy Shevchenko wrote:
> dmi_get_bios_year() may return 0 when it is incapable to parse
> the BIOS date string. Previously this has been checked in
> pci_acpi_crs_quirks().
> 
> Update the code to restore old behaviour.
> 
> Reported-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/pci/acpi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 00e60de30328..5559dcaddd5e 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -140,7 +140,9 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
>  
>  void __init pci_acpi_crs_quirks(void)
>  {
> -	if ((dmi_get_bios_year() < 2008) && (iomem_resource.end <= 0xffffffff))
> +	int year = dmi_get_bios_year();
> +
> +	if (year >= 0 && year < 2008 && iomem_resource.end <= 0xffffffff)
>  		pci_use_crs = false;
>  
>  	dmi_check_system(pci_crs_quirks);
> 

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


