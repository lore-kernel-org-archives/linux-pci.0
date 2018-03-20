Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1521560965.23017.68.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] x86/PCI: Fix a potential regression when use
 dmi_get_bios_year()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Lukas Wunner <lukas@wunner.de>
Date: Tue, 20 Mar 2018 17:49:25 +0200
In-Reply-To: <20180320163258.5ac39580@endymion>
References: <20180320135410.11627-1-andriy.shevchenko@linux.intel.com>
         <20180320135410.11627-2-andriy.shevchenko@linux.intel.com>
         <20180320163258.5ac39580@endymion>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-03-20 at 16:32 +0100, Jean Delvare wrote:
> Hi Andy,
> 
> On Tue, 20 Mar 2018 15:54:09 +0200, Andy Shevchenko wrote:
> > dmi_get_bios_year() may return 0 when it is incapable to parse
> > the BIOS date string. Previously this has been checked in
> > pci_acpi_crs_quirks().
> > 
> > Update the code to restore old behaviour.
> 
> When fixing a regression, a good practice is to tag the fix commit as
> such:
> 
> Fixes: 69c42d493db4 ("x86/pci: Simplify code by using the new
> dmi_get_bios_year() helper")

Someone (perhaps Ingo) told me that Fixes doesn't make much sense if the
fixing commit is not yet in vanilla.

Since it's supposed to go via tip tree I would like to hear Ingo's
opinion before adding this line to the patch.

> > Reported-by: Jean Delvare <jdelvare@suse.de>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/x86/pci/acpi.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> > index 00e60de30328..5559dcaddd5e 100644
> > --- a/arch/x86/pci/acpi.c
> > +++ b/arch/x86/pci/acpi.c
> > @@ -140,7 +140,9 @@ static const struct dmi_system_id
> > pci_crs_quirks[] __initconst = {
> >  
> >  void __init pci_acpi_crs_quirks(void)
> >  {
> > -	if ((dmi_get_bios_year() < 2008) && (iomem_resource.end <=
> > 0xffffffff))
> > +	int year = dmi_get_bios_year();
> > +
> > +	if (year >= 0 && year < 2008 && iomem_resource.end <=
> > 0xffffffff)
> >  		pci_use_crs = false;
> >  
> >  	dmi_check_system(pci_crs_quirks);
> 
> This works with the non-inline version of dmi_get_bios_year()
> introduced by patch 2/2 of this series. However the inline version of
> this function would return 0 on error, which makes the condition above
> always true.
> 
> The patches need to be applied in the opposite order, or the test
> above
> should be changed to "year > 0".

Err... Yes, I use to have them in opposite order, but at some point I
decided to reverse and forgot about the condition.

So, you are right, it needs to be applied in reversed order.

> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
