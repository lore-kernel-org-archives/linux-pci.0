Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41051 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751480AbeCTPdC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Mar 2018 11:33:02 -0400
Date: Tue, 20 Mar 2018 16:32:58 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3 1/2] x86/PCI: Fix a potential regression when use
 dmi_get_bios_year()
Message-ID: <20180320163258.5ac39580@endymion>
In-Reply-To: <20180320135410.11627-2-andriy.shevchenko@linux.intel.com>
References: <20180320135410.11627-1-andriy.shevchenko@linux.intel.com>
        <20180320135410.11627-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Andy,

On Tue, 20 Mar 2018 15:54:09 +0200, Andy Shevchenko wrote:
> dmi_get_bios_year() may return 0 when it is incapable to parse
> the BIOS date string. Previously this has been checked in
> pci_acpi_crs_quirks().
> 
> Update the code to restore old behaviour.

When fixing a regression, a good practice is to tag the fix commit as
such:

Fixes: 69c42d493db4 ("x86/pci: Simplify code by using the new dmi_get_bios_year() helper")

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

This works with the non-inline version of dmi_get_bios_year()
introduced by patch 2/2 of this series. However the inline version of
this function would return 0 on error, which makes the condition above
always true.

The patches need to be applied in the opposite order, or the test above
should be changed to "year > 0".

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
