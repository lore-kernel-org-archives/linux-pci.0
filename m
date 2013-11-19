Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36386 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753555Ab3KSSDM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 13:03:12 -0500
Date: Tue, 19 Nov 2013 13:03:11 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Kevin Hilman <khilman@linaro.org>
cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
In-Reply-To: <87r4acmjc6.fsf@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1311191258550.1145-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 19 Nov 2013, Kevin Hilman wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > On Tue, 19 Nov 2013, Ulf Hansson wrote:
> >
> >> At the moment, system PM is already affecting behaviour of runtime PM
> >> since it is preventing runtime suspend during system suspend.
> >
> > Sure.  And that behavior is documented.  In any case, it's a bug for 
> > drivers to depend on runtime suspend for carrying out a system suspend.
> 
> As Rafael mentioned, there is bus/pm_domain code that comes into play
> here, so I'm not sure it's always a bug.
> 
> IMO, it's not a bug for the driver to depend on runtime PM if the
> bus/pm_domain is handling the details.
> 
> On OMAP, we handle all the SoC on-chip devices with a pm_domain since
> the low-level PM operations that need to happen are bus-level things not
> device-level things.  Therefore, drivers for these devices can rely
> entirely on runtime PM, even for system suspend.  The late/early
> callbacks in the pm_domain can see if the device is runtime suspended
> already or not and behave accordingly.
> 
> So, this all *can* work by handling it at the bus/pm_domain level, but
> as Ulf has mentioned (and I agree) it seems like a clunky workaround
> because the PM core is preventing it from happening as one might expect.

The problem is that userspace can disable runtime PM at any time by 
writing "on" to /sys/.../power/control.  Once that's done, you can't
depend on runtime PM to put the device into a low-power state during 
system suspend.

Now, if the bus-level code always takes care of putting the device into
low power during system suspend, then the driver doesn't have to worry
about it at all.  That's perfectly fine -- but I would hardly describe
the situation by saying the driver relies on runtime PM for system
suspend.

Alan Stern

