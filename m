Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63856 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752231AbdHJQPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2017 12:15:00 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: Re: [PATCH 1/3] ACPICA: Dispatch active GPEs at init time
Date: Thu, 10 Aug 2017 18:06:41 +0200
Message-ID: <5185778.X36DhrMnGV@aspire.rjw.lan>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CF066E6@SHSMSX101.ccr.corp.intel.com>
References: <12346760.yAFCnkEgf6@aspire.rjw.lan> <46980112.WLPtxWZQ3y@aspire.rjw.lan> <1AE640813FDE7649BE1B193DEA596E886CF066E6@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, August 10, 2017 3:48:58 AM CEST Zheng, Lv wrote:
> Hi, Rafael
> 
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Subject: [PATCH 1/3] ACPICA: Dispatch active GPEs at init time
> > 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > In some cases GPEs are already active when they are enabled by
> > acpi_ev_initialize_gpe_block() and whatever happens next may depend
> > on the result of handling the events signaled by them, so the
> > events should not be discarded (which is what happens currently) and
> > they should be handled as soon as reasonably possible.
> > 
> > For this reason, modify acpi_ev_initialize_gpe_block() to
> > dispatch GPEs with the status flag set in-band right after
> > enabling them.
> 
> In fact, what we need seems to be invoking acpi_ev_gpe_dispatch()
> right after enabling an GPE. So there are 2 conditions related:
> 1. GPE is enabled for the first time.
> 2. GPE is initialized.
> 
> And we need to make sure that before acpi_update_all_gpes() is invoked,
> all GPE EN bits are actually disabled.

But we don't do it today, do we?

And still calling _dispatch() should not be incorrect even if the GPE
has been enabled already at this point.  Worst case it just will
queue up the execution of _Lxx/_Exx which may or may not do anything
useful.

And BTW this is all done under acpi_gbl_gpe_lock so acpi_ev_gpe_detect()
will block on it if run concurrently and we've checked the status, so
we know that the GPE *should* be dispatched, so I sort of fail to see
the problem.

Thanks,
Rafael
