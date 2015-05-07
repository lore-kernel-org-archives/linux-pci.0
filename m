Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: George McCollister <george.mccollister@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: I/O conflict on Versalogic Tiger (VL-EPM-24)
Date: Thu, 07 May 2015 23:06:38 +0200
Message-ID: <2829685.et1KqHBDfq@vostro.rjw.lan>
In-Reply-To: <CAFSKS=PxJMwkhrswHTdE-vVJqocHkzWELO=BvKm12NjFRtfNew@mail.gmail.com>
References: <CAFSKS=M8bODT8bLckwtGFziknPG=32Y1=8mz3Fq0H7JcA3GhjQ@mail.gmail.com> <16669466.MatE2KDcHs@vostro.rjw.lan> <CAFSKS=PxJMwkhrswHTdE-vVJqocHkzWELO=BvKm12NjFRtfNew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, May 07, 2015 08:28:35 AM George McCollister wrote:
> On Wed, May 6, 2015 at 5:14 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, May 06, 2015 02:15:15 PM George McCollister wrote:
> >> On Wed, May 6, 2015 at 10:51 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> > [+cc Rafael]

[cut]

> >>
> >> I think the key here is that the region needs to be requested before
> >> bridge window is assigned.
> >
> > That's correct, so things don't happen in the right order now.
> >
> > Well, acpi_reserve_resources() is a device_initcall(), so its ordering with
> > respect to other things is somewhat random.
> >
> > Does the patch below make any difference by any chance?
> >
> 
> Yes, with this patch it boots with no problems.

OK

I'm queuing this one up as a fix for 4.1 and for -stable.

Thanks for your report, it was a good one. :-)

Bjorn, please let me know if you think there's a better place to call
acpi_reserve_resources() from.


> > ---
> >  drivers/acpi/osl.c |    6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/osl.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/osl.c
> > +++ linux-pm/drivers/acpi/osl.c
> > @@ -182,7 +182,7 @@ static void __init acpi_request_region (
> >                 request_mem_region(addr, length, desc);
> >  }
> >
> > -static int __init acpi_reserve_resources(void)
> > +static void __init acpi_reserve_resources(void)
> >  {
> >         acpi_request_region(&acpi_gbl_FADT.xpm1a_event_block, acpi_gbl_FADT.pm1_event_length,
> >                 "ACPI PM1a_EVT_BLK");
> > @@ -211,10 +211,7 @@ static int __init acpi_reserve_resources
> >         if (!(acpi_gbl_FADT.gpe1_block_length & 0x1))
> >                 acpi_request_region(&acpi_gbl_FADT.xgpe1_block,
> >                                acpi_gbl_FADT.gpe1_block_length, "ACPI GPE1_BLK");
> > -
> > -       return 0;
> >  }
> > -device_initcall(acpi_reserve_resources);
> >
> >  void acpi_os_printf(const char *fmt, ...)
> >  {
> > @@ -1845,6 +1842,7 @@ acpi_status __init acpi_os_initialize(vo
> >
> >  acpi_status __init acpi_os_initialize1(void)
> >  {
> > +       acpi_reserve_resources();
> >         kacpid_wq = alloc_workqueue("kacpid", 0, 1);
> >         kacpi_notify_wq = alloc_workqueue("kacpi_notify", 0, 1);
> >         kacpi_hotplug_wq = alloc_ordered_workqueue("kacpi_hotplug", 0);
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
