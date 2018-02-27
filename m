Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752094AbeB0JO0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Feb 2018 04:14:26 -0500
Date: Tue, 27 Feb 2018 10:14:22 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dmi: Introduce dmi_get_bios_year() helper
Message-ID: <20180227101422.7c0efb40@endymion>
In-Reply-To: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Andy,

On Thu, 22 Feb 2018 14:59:20 +0200, Andy Shevchenko wrote:
> It's used in several places and more users may come.
> By using this helper they may create a slightly cleaner code.

In general I'm not a big fan of arbitrary API shortcuts. I won't object
if you think it's a good one to have, however I'm a bit concerned about
the silent handling of the "error case", which could cause unexpected
default decisions as seen in patch 2/4 of this series. The fact that
dmi_get_bios_year() returns 0 if there is no DMI BIOS date provided
should at least be documented, to limit the risk.

I also wonder if dmi_get_date() itself couldn't be optimized a bit if
it turns out that most callers are only interested in the year.
Currently it will parse the whole string even if the caller isn't
interested in the month and day.

The fact that dmi_get_date() returns true even if it couldn't parse the
date string at all is also strange, although unrelated with your
current work.

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

checkpatch complains:

WARNING: Missing a blank line after declarations
#61: FILE: include/linux/dmi.h:153:
+	int year;
+	dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);

And I would tend to agree. Just because it is an inline function in a
header file doesn't mean we don't stick to the usual coding style
policy.

> +
>  #endif	/* __DMI_H__ */

-- 
Jean Delvare
SUSE L3 Support
