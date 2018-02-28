Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1519813990.10722.262.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/4] dmi: Introduce dmi_get_bios_year() helper
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 28 Feb 2018 12:33:10 +0200
In-Reply-To: <20180227101422.7c0efb40@endymion>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
         <20180227101422.7c0efb40@endymion>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-02-27 at 10:14 +0100, Jean Delvare wrote:
> Hi Andy,
> 
> On Thu, 22 Feb 2018 14:59:20 +0200, Andy Shevchenko wrote:
> > It's used in several places and more users may come.
> > By using this helper they may create a slightly cleaner code.
> 
> In general I'm not a big fan of arbitrary API shortcuts. I won't
> object
> if you think it's a good one to have, however I'm a bit concerned
> about
> the silent handling of the "error case", which could cause unexpected
> default decisions as seen in patch 2/4 of this series.

Yes, we better to return -ERRNO in such case and allow callers to behave
correspondingly.

>  The fact that
> dmi_get_bios_year() returns 0 if there is no DMI BIOS date provided
> should at least be documented, to limit the risk.
> 
> I also wonder if dmi_get_date() itself couldn't be optimized a bit if
> it turns out that most callers are only interested in the year.
> Currently it will parse the whole string even if the caller isn't
> interested in the month and day.
> 
> The fact that dmi_get_date() returns true even if it couldn't parse
> the
> date string at all is also strange, although unrelated with your
> current work.

So, what I consider is to
- move inline function to be regular one
- optimize it with current dmi_get_date()
- return error code when year is not parsable
- consider current use cases where we do compare for less than a given
year

Does it sound a correct approach?

> 
> checkpatch complains:
> 
> WARNING: Missing a blank line after declarations
> #61: FILE: include/linux/dmi.h:153:
> +	int year;
> +	dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
> 
> And I would tend to agree. Just because it is an inline function in a
> header file doesn't mean we don't stick to the usual coding style
> policy.

Ingo fixed that.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
