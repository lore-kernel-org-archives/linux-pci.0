Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43325 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756925AbdJQXRO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2017 19:17:14 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
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
Date: Wed, 18 Oct 2017 01:07:35 +0200
Message-ID: <2098332.bUT5UI0m5H@aspire.rjw.lan>
In-Reply-To: <Pine.LNX.4.44L0.1710171558170.1864-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1710171558170.1864-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, October 17, 2017 10:12:19 PM CEST Alan Stern wrote:
> On Tue, 17 Oct 2017, Ulf Hansson wrote:
> 
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
> I think what Rafael has in mind is that the PM core will call the amba
> bus's ->suspend callback, and that routine will then be able to call
> the amba driver's runtime_suspend routine directly, if it wants to --
> as opposed to going through pm_runtime_force_suspend.

Right in general.

> However, it's not clear whether this fully answers your concerns.

Well, in the particular AMBA case fixing this should be quite straightforward.

> > Second, it will introduce a regression in behavior for all users of
> > pm_runtime_force_suspend|resume(), especially during system resume as
> > the driver may then end up resuming the device even in case it isn't
> > needed. I believe I have explained why, also several times by now -
> > and that's also how far you could take the i2c designware driver at
> > this point.
> > 
> > That said, I assume the second part may be addressed in this series,
> > if these drivers convert to use the "driver PM flags", right?
> 
> Presumably.
> 
> The problem is how to handle things which need to be treated
> differently for runtime PM vs. system suspend vs. hibernation.  If
> everything filters through a runtime_suspend routine, that doesn't
> leave any scope for handling the different kinds of PM transitions
> differently.  Instead, we can make the middle layer (i.e., the bus-type
> callbacks) take care of the varying tasks, and they can directly invoke
> a driver's runtime-PM callbacks to handle all the common activities.  
> If that's how the middle layer wants to do it.

Well, that's what happens today, except that driver runtime PM callbacks
are not directly invoked.  Actually, I tried to implement that, but it was
so ugly and fragile that I gave up.

It really is better if drivers point the different callback pointers to the
same rountine if they want to reuse it.

> > However, what about the first case? Is some open coding needed or your
> > think the amba driver can instruct the amba bus via the "driver PM
> > flags"?
> 
> PM flags won't directly be able to cover things like disabling clocks.  
> But they could be useful for indicating explicitly whether the code to
> take care of those things needs to reside at the driver layer or at the
> bus layer.

Right.

Thanks,
Rafael
