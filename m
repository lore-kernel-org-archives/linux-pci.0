Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 23 Feb 2018 15:35:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dmi: Introduce dmi_get_bios_year() helper
Message-ID: <20180223213552.GL14632@bhelgaas-glaptop.roam.corp.google.com>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 22, 2018 at 02:59:20PM +0200, Andy Shevchenko wrote:
> It's used in several places and more users may come.
> By using this helper they may create a slightly cleaner code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/dmi.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/dmi.h b/include/linux/dmi.h
> index 46e151172d95..241c27008c70 100644
> --- a/include/linux/dmi.h
> +++ b/include/linux/dmi.h
> @@ -147,4 +147,11 @@ static inline const struct dmi_system_id *
>  
>  #endif
>  
> +static inline int dmi_get_bios_year(void)
> +{
> +	int year;
> +	dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
> +	return year;
> +}

I don't really care personally, and I assume this series will go via a
non-PCI tree, but making this inline looks similar to this, which
wasn't well-received:

https://lkml.kernel.org/r/CA+55aFypU331cQy-6ZJ6szF=2KVLqcbwCUGd+gTwPViRqRWN+g@mail.gmail.com

>  #endif	/* __DMI_H__ */
> -- 
> 2.16.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
