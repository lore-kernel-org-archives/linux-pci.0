Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/12] PM / sleep: Driver flags for system suspend/resume
Date: Wed, 18 Oct 2017 12:24:32 +0200
Message-ID: <2745759.OYb9FSKnNE@aspire.rjw.lan>
In-Reply-To: <1591167.zlNa3zLfmM@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <CAPDyKFrMTSUHP86hnpHius2CDfv-ap4svGg=xgwAiH8pKj9Lvw@mail.gmail.com> <1591167.zlNa3zLfmM@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, October 18, 2017 2:39:24 AM CEST Rafael J. Wysocki wrote:
> On Tuesday, October 17, 2017 9:41:16 PM CEST Ulf Hansson wrote:
> 
> [cut]
> 
> > >
> > >> deploying this and from a middle layer point of view, all the trivial
> > >> cases supports this.
> > >
> > > These functions are wrong, however, because they attempt to reuse the
> > > whole callback *path* instead of just reusing driver callbacks.  The
> > > *only* reason why it all "works" is because there are no middle layer
> > > callbacks involved in that now.
> > >
> > > If you changed them to reuse driver callbacks only today, nothing would break
> > > AFAICS.
> > 
> > Yes, it would.
> > 
> > First, for example, the amba bus is responsible for the amba bus
> > clock, but relies on drivers to gate/ungate it during system sleep. In
> > case the amba drivers don't use the pm_runtime_force_suspend|resume(),
> > it will explicitly have to start manage the clock during system sleep
> > themselves. Leading to open coding.
> 
> Well, I suspected that something like this would surface. ;-)
> 
> Are there any major reasons why the appended patch (obviously untested) won't
> work, then?

OK, there is a reason, which is the optimizations bundled into
pm_runtime_force_*, because (a) the device may be left in runtime suspend
by them (in which case amba_pm_suspend_early() in my patch should not run)
and (b) pm_runtime_force_resume() may decide to leave it suspended (in which
case amba_pm_suspend_late() in my patch should not run).

[BTW, the "leave the device suspended" optimization in pm_runtime_force_*
is potentially problematic too, because it requires the children to do
the right thing, which effectively means that their drivers need to use
pm_runtime_force_* too, but what if they don't want to reuse their
runtime PM callbacks for system-wide PM?]

Honestly, I don't like the way this is designed.  IMO, it would be better
to do the optimizations and all in the bus type middle-layer code instead
of expecting drivers to use pm_runtime_force_* as their system-wide PM
callbacks (and that expectation should at least be documented, which I'm
not sure is the case now).  But whatever.

It all should work the way it does now without pm_runtime_force_* if (a) the
bus type's PM callbacks are changed like in the last patch and the drivers
(b) point their system suspend callbacks to the runtime PM callback routines
and (c) set DPM_FLAG_SMART_SUSPEND and DPM_FLAG_LEAVE_SUSPENDED for the
devices (if they need to do the PM in ->suspend and ->resume, they may set
DPM_FLAG_AVOID_RPM too).

And if you see a reason why that won't work, please let me know.

Thanks,
Rafael

