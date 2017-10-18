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
Date: Wed, 18 Oct 2017 23:54:28 +0200
Message-ID: <20665978.JlZ4Hgb5rF@aspire.rjw.lan>
In-Reply-To: <CAPDyKFpNHL=tZYbQduDJqypz7rbwPwvW7sOymm-djbRSFgZ00g@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <2745759.OYb9FSKnNE@aspire.rjw.lan> <CAPDyKFpNHL=tZYbQduDJqypz7rbwPwvW7sOymm-djbRSFgZ00g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, October 18, 2017 2:34:10 PM CEST Ulf Hansson wrote:
> [...]
> 
> >> Are there any major reasons why the appended patch (obviously untested) won't
> >> work, then?
> >
> > OK, there is a reason, which is the optimizations bundled into
> > pm_runtime_force_*, because (a) the device may be left in runtime suspend
> > by them (in which case amba_pm_suspend_early() in my patch should not run)
> > and (b) pm_runtime_force_resume() may decide to leave it suspended (in which
> > case amba_pm_suspend_late() in my patch should not run).
> 
> Exactly.
> 
> >
> > [BTW, the "leave the device suspended" optimization in pm_runtime_force_*
> > is potentially problematic too, because it requires the children to do
> > the right thing, which effectively means that their drivers need to use
> > pm_runtime_force_* too, but what if they don't want to reuse their
> > runtime PM callbacks for system-wide PM?]
> 
> Deployment of pm_runtime_force_suspend() should generally be done for
> children devices first.
> 
> If some reason that isn't the case, it's expected that the call to
> pm_runtime_set_suspended() invoked from pm_runtime_force_suspend(),
> for the parent, should fail and thus abort system suspend.

Well, generally what about drivers that need to do something significantly
different for system suspend and runtime PM?  The whole picture seems to be
falling apart if one of these is involved.

> >
> > Honestly, I don't like the way this is designed.  IMO, it would be better
> > to do the optimizations and all in the bus type middle-layer code instead
> > of expecting drivers to use pm_runtime_force_* as their system-wide PM
> > callbacks (and that expectation should at least be documented, which I'm
> > not sure is the case now).  But whatever.
> >
> > It all should work the way it does now without pm_runtime_force_* if (a) the
> > bus type's PM callbacks are changed like in the last patch and the drivers
> > (b) point their system suspend callbacks to the runtime PM callback routines
> > and (c) set DPM_FLAG_SMART_SUSPEND and DPM_FLAG_LEAVE_SUSPENDED for the
> > devices (if they need to do the PM in ->suspend and ->resume, they may set
> > DPM_FLAG_AVOID_RPM too).
> >
> > And if you see a reason why that won't work, please let me know.
> 
> I will have look and try out the series by using my local "runtime PM
> test driver".
> 
> I get back to you with an update on this.

OK, thanks!

