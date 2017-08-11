Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59787 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752703AbdHKMbU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2017 08:31:20 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: Re: [PATCH 1/3] ACPICA: Dispatch active GPEs at init time
Date: Fri, 11 Aug 2017 14:23:00 +0200
Message-ID: <3677056.OS19FbOdkF@aspire.rjw.lan>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CF09085@SHSMSX101.ccr.corp.intel.com>
References: <12346760.yAFCnkEgf6@aspire.rjw.lan> <5185778.X36DhrMnGV@aspire.rjw.lan> <1AE640813FDE7649BE1B193DEA596E886CF09085@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, August 11, 2017 7:40:56 AM CEST Zheng, Lv wrote:
> Hi, Rafael
> 
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Subject: Re: [PATCH 1/3] ACPICA: Dispatch active GPEs at init time
> > 
> > On Thursday, August 10, 2017 3:48:58 AM CEST Zheng, Lv wrote:
> > > Hi, Rafael
> > >
> > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > Subject: [PATCH 1/3] ACPICA: Dispatch active GPEs at init time
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > In some cases GPEs are already active when they are enabled by
> > > > acpi_ev_initialize_gpe_block() and whatever happens next may depend
> > > > on the result of handling the events signaled by them, so the
> > > > events should not be discarded (which is what happens currently) and
> > > > they should be handled as soon as reasonably possible.
> > > >
> > > > For this reason, modify acpi_ev_initialize_gpe_block() to
> > > > dispatch GPEs with the status flag set in-band right after
> > > > enabling them.
> > >
> > > In fact, what we need seems to be invoking acpi_ev_gpe_dispatch()
> > > right after enabling an GPE. So there are 2 conditions related:
> > > 1. GPE is enabled for the first time.
> > > 2. GPE is initialized.
> > >
> > > And we need to make sure that before acpi_update_all_gpes() is invoked,
> > > all GPE EN bits are actually disabled.
> > 
> > But we don't do it today, do we?
> 
> We don't do that.
> 
> > 
> > And still calling _dispatch() should not be incorrect even if the GPE
> > has been enabled already at this point.  Worst case it just will
> > queue up the execution of _Lxx/_Exx which may or may not do anything
> > useful.
> > 
> > And BTW this is all done under acpi_gbl_gpe_lock so acpi_ev_gpe_detect()
> > will block on it if run concurrently and we've checked the status, so
> > we know that the GPE *should* be dispatched, so I sort of fail to see
> > the problem.
> 
> There is another problem related:
> ACPICA clears GPEs before enabling it.
> This is proven to be wrong, and we have to fix it:
> https://bugzilla.kernel.org/show_bug.cgi?id=196249
> 
> without fixing this issue, in this solution, we surely need to save the
> GPE STS bit before incrementing GPE reference count, and poll it according
> to the saved STS bit. Because if we poll it after enabling, STS bit will
> be wrongly cleared.

I'm not sure if I understand you correctly, but why would we poll it?

In the $subject patch the status is checked and then
acpi_ev_add_gpe_reference() is called to add a reference to the GPE.

If this is the first reference (which will be the case in the majority
of cases), acpi_ev_enable_gpe() will be called and that will clear the
status.

Then, acpi_ev_gpe_dispatch() is called if the status was set and that
itself doesn't check the status.  It disables the GPE upfront (so the
status doesn't matter from now on until the GPE is enabled again) and
clears the status unconditionally if the GPE is edge-triggered.  This
means that for edge-triggered GPEs the clearing of the status by
acpi_ev_enable_gpe() doesn't matter here.

For level-triggered GPEs the status is not cleared by acpi_ev_gpe_dispatch()
itself, but _Lxx is executed (again, without checking the status) and
finally the status is cleared by acpi_ev_finish_gpe() anyway, so we
end up with cleared status no matter what (and that before re-enabling
the GPE).  End even if _Lxx itself checked the status (but honestly why
would it?), then this is a level-triggered GPE, so it will re-trigger
anyway if not handled this time.

So it looks like the fact that acpi_ev_enable_gpe() clears the status before
enabling the GPE doesn't matter for this patch, although it may matter in
general, but that is a different (and somewhat related) issue.

Thanks,
Rafael
