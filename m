Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1520000496.10722.392.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/4] firmware: dmi_scan: Introduce the
 dmi_get_bios_year() helper
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.de>
Date: Fri, 02 Mar 2018 16:21:36 +0200
In-Reply-To: <20180302140537.GA22990@wunner.de>
References: <20180301180220.11333-1-andriy.shevchenko@linux.intel.com>
         <20180301180220.11333-2-andriy.shevchenko@linux.intel.com>
         <20180302140537.GA22990@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-03-02 at 15:05 +0100, Lukas Wunner wrote:
> On Thu, Mar 01, 2018 at 08:02:17PM +0200, Andy Shevchenko wrote:
> > --- a/drivers/firmware/dmi_scan.c
> > +++ b/drivers/firmware/dmi_scan.c
> > @@ -1015,6 +1015,17 @@ bool dmi_get_date(int field, int *yearp, int
> > *monthp, int *dayp)
> >  }
> >  EXPORT_SYMBOL(dmi_get_date);
> >  
> > +int dmi_get_bios_year(void)
> > +{
> > +	bool exists;
> > +	int year;
> > +
> > +	exists = dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
> > +
> > +	return exists ? year : -ENODATA;
> > +}
> > +EXPORT_SYMBOL(dmi_get_bios_year);
> 
> It would be good if kerneldoc was added to this function.

Perhaps.

>   One thing
> to mention is that direct usage of the function in a conditional only
> works reliably when asserting an exact or minimum BIOS date.  It
> doesn't
> work reliably when asserting a maximum BIOS date unless the return
> value is explicitly checked for -ENODATA.

Just < 0.

>   (Fortunately that use case
> seems to be rare, but still worth mentioning IMHO.)
> 
> 
> > +static inline int dmi_get_bios_year(void) { return -ENXIO; }
> 
> Shouldn't this be -ENODATA as well for consistency?  Otherwise one
> would
> have to check for -ENODATA *and* -ENXIO.

I was thinking about this, though checking for negative errors is a
pattern in kernel. If user would like to distinguish what really
happened, then they may to check for explicit code.

ENXIO is chosen to be consistent with other calls when !DMI.
ENODATA on the other hand is not related to access to the data, but to
the contents of it. So, I would like to keep them different.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
