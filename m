Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 2 Mar 2018 15:05:37 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2 1/4] firmware: dmi_scan: Introduce the
 dmi_get_bios_year() helper
Message-ID: <20180302140537.GA22990@wunner.de>
References: <20180301180220.11333-1-andriy.shevchenko@linux.intel.com>
 <20180301180220.11333-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180301180220.11333-2-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 01, 2018 at 08:02:17PM +0200, Andy Shevchenko wrote:
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -1015,6 +1015,17 @@ bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp)
>  }
>  EXPORT_SYMBOL(dmi_get_date);
>  
> +int dmi_get_bios_year(void)
> +{
> +	bool exists;
> +	int year;
> +
> +	exists = dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
> +
> +	return exists ? year : -ENODATA;
> +}
> +EXPORT_SYMBOL(dmi_get_bios_year);

It would be good if kerneldoc was added to this function.  One thing
to mention is that direct usage of the function in a conditional only
works reliably when asserting an exact or minimum BIOS date.  It doesn't
work reliably when asserting a maximum BIOS date unless the return
value is explicitly checked for -ENODATA.  (Fortunately that use case
seems to be rare, but still worth mentioning IMHO.)


> +static inline int dmi_get_bios_year(void) { return -ENXIO; }

Shouldn't this be -ENODATA as well for consistency?  Otherwise one would
have to check for -ENODATA *and* -ENXIO.

Thanks,

Lukas
