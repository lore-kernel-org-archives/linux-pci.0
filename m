Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Zheng, Lv" <lv.zheng@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 1/3] ACPICA: Dispatch active GPEs at init time
Date: Fri, 11 Aug 2017 05:40:56 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CF09085@SHSMSX101.ccr.corp.intel.com>
References: <12346760.yAFCnkEgf6@aspire.rjw.lan>
 <46980112.WLPtxWZQ3y@aspire.rjw.lan>
 <1AE640813FDE7649BE1B193DEA596E886CF066E6@SHSMSX101.ccr.corp.intel.com>
 <5185778.X36DhrMnGV@aspire.rjw.lan>
In-Reply-To: <5185778.X36DhrMnGV@aspire.rjw.lan>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Rafael

> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Subject: Re: [PATCH 1/3] ACPICA: Dispatch active GPEs at init time
> 
> On Thursday, August 10, 2017 3:48:58 AM CEST Zheng, Lv wrote:
> > Hi, Rafael
> >
> > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > Subject: [PATCH 1/3] ACPICA: Dispatch active GPEs at init time
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > In some cases GPEs are already active when they are enabled by
> > > acpi_ev_initialize_gpe_block() and whatever happens next may depend
> > > on the result of handling the events signaled by them, so the
> > > events should not be discarded (which is what happens currently) and
> > > they should be handled as soon as reasonably possible.
> > >
> > > For this reason, modify acpi_ev_initialize_gpe_block() to
> > > dispatch GPEs with the status flag set in-band right after
> > > enabling them.
> >
> > In fact, what we need seems to be invoking acpi_ev_gpe_dispatch()
> > right after enabling an GPE. So there are 2 conditions related:
> > 1. GPE is enabled for the first time.
> > 2. GPE is initialized.
> >
> > And we need to make sure that before acpi_update_all_gpes() is invoked,
> > all GPE EN bits are actually disabled.
> 
> But we don't do it today, do we?

We don't do that.

> 
> And still calling _dispatch() should not be incorrect even if the GPE
> has been enabled already at this point.  Worst case it just will
> queue up the execution of _Lxx/_Exx which may or may not do anything
> useful.
> 
> And BTW this is all done under acpi_gbl_gpe_lock so acpi_ev_gpe_detect()
> will block on it if run concurrently and we've checked the status, so
> we know that the GPE *should* be dispatched, so I sort of fail to see
> the problem.

There is another problem related:
ACPICA clears GPEs before enabling it.
This is proven to be wrong, and we have to fix it:
https://bugzilla.kernel.org/show_bug.cgi?id=196249

without fixing this issue, in this solution, we surely need to save the
GPE STS bit before incrementing GPE reference count, and poll it according
to the saved STS bit. Because if we poll it after enabling, STS bit will
be wrongly cleared.

So if we can do this on top of the "GPE clear" fix, things can be done
in a simpler way - invoke acpi_ev_gpe_detect() after fully initializing
GPEs (as what I pasted).

However I should say - merging "GPE clear" fix might be risky.
So this patch can be in upstream prior than the simpler solution to leave
us a stable base line.

I'll send out the simpler solution along with the "GPE clear" fix.
Maybe you can consider to ship it after merging this patch.

Thanks and best regards
Lv
