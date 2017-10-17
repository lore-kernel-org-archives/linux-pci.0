Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Oct 2017 16:12:19 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Ulf Hansson <ulf.hansson@linaro.org>
cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
In-Reply-To: <CAPDyKFrMTSUHP86hnpHius2CDfv-ap4svGg=xgwAiH8pKj9Lvw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1710171558170.1864-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 17 Oct 2017, Ulf Hansson wrote:

> > These functions are wrong, however, because they attempt to reuse the
> > whole callback *path* instead of just reusing driver callbacks.  The
> > *only* reason why it all "works" is because there are no middle layer
> > callbacks involved in that now.
> >
> > If you changed them to reuse driver callbacks only today, nothing would break
> > AFAICS.
> 
> Yes, it would.
> 
> First, for example, the amba bus is responsible for the amba bus
> clock, but relies on drivers to gate/ungate it during system sleep. In
> case the amba drivers don't use the pm_runtime_force_suspend|resume(),
> it will explicitly have to start manage the clock during system sleep
> themselves. Leading to open coding.

I think what Rafael has in mind is that the PM core will call the amba
bus's ->suspend callback, and that routine will then be able to call
the amba driver's runtime_suspend routine directly, if it wants to --
as opposed to going through pm_runtime_force_suspend.

However, it's not clear whether this fully answers your concerns.

> Second, it will introduce a regression in behavior for all users of
> pm_runtime_force_suspend|resume(), especially during system resume as
> the driver may then end up resuming the device even in case it isn't
> needed. I believe I have explained why, also several times by now -
> and that's also how far you could take the i2c designware driver at
> this point.
> 
> That said, I assume the second part may be addressed in this series,
> if these drivers convert to use the "driver PM flags", right?

Presumably.

The problem is how to handle things which need to be treated
differently for runtime PM vs. system suspend vs. hibernation.  If
everything filters through a runtime_suspend routine, that doesn't
leave any scope for handling the different kinds of PM transitions
differently.  Instead, we can make the middle layer (i.e., the bus-type
callbacks) take care of the varying tasks, and they can directly invoke
a driver's runtime-PM callbacks to handle all the common activities.  
If that's how the middle layer wants to do it.

> However, what about the first case? Is some open coding needed or your
> think the amba driver can instruct the amba bus via the "driver PM
> flags"?

PM flags won't directly be able to cover things like disabling clocks.  
But they could be useful for indicating explicitly whether the code to
take care of those things needs to reside at the driver layer or at the
bus layer.

Alan Stern
