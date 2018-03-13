Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 13 Mar 2018 11:33:13 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v2 1/4] firmware: dmi_scan: Introduce the
 dmi_get_bios_year() helper
Message-ID: <20180313113313.612d66c6@endymion>
In-Reply-To: <20180301180220.11333-2-andriy.shevchenko@linux.intel.com>
References: <20180301180220.11333-1-andriy.shevchenko@linux.intel.com>
        <20180301180220.11333-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Andy,

On Thu,  1 Mar 2018 20:02:17 +0200, Andy Shevchenko wrote:
> The pattern to only extract the year portion of date is used in
> several places and more users may come.
> 
> By using this helper they may create slightly cleaner code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/firmware/dmi_scan.c | 11 +++++++++++
>  include/linux/dmi.h         |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 6ce299926196..616ec17cc802 100644
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

If the DMI field exists but year can't be parsed, "exists" is true but
"year" is 0. From the caller's perspective, it is the same as if the
field did not exist (year is not available in both cases), but the
function returns 0 in one case and -ENODATA in the other. Don't you
think that:

	return year ? year : -ENODATA;

would serve the caller better?

> +}
> +EXPORT_SYMBOL(dmi_get_bios_year);
> +
>  /**
>   *	dmi_walk - Walk the DMI table and get called back for every record
>   *	@decode: Callback function
> diff --git a/include/linux/dmi.h b/include/linux/dmi.h
> index 46e151172d95..6a86d8db16d9 100644
> --- a/include/linux/dmi.h
> +++ b/include/linux/dmi.h
> @@ -106,6 +106,7 @@ extern void dmi_scan_machine(void);
>  extern void dmi_memdev_walk(void);
>  extern void dmi_set_dump_stack_arch_desc(void);
>  extern bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp);
> +extern int dmi_get_bios_year(void);
>  extern int dmi_name_in_vendors(const char *str);
>  extern int dmi_name_in_serial(const char *str);
>  extern int dmi_available;
> @@ -133,6 +134,7 @@ static inline bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp)
>  		*dayp = 0;
>  	return false;
>  }
> +static inline int dmi_get_bios_year(void) { return -ENXIO; }
>  static inline int dmi_name_in_vendors(const char *s) { return 0; }
>  static inline int dmi_name_in_serial(const char *s) { return 0; }
>  #define dmi_available 0

Looks good otherwise.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
