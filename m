Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49653 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab3KSSnx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 13:43:53 -0500
Received: by mail-pa0-f46.google.com with SMTP id kl14so3716320pab.5
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 10:43:52 -0800 (PST)
From: Kevin Hilman <khilman@linaro.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm\@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during system suspend
References: <Pine.LNX.4.44L0.1311191258550.1145-100000@iolanthe.rowland.org>
Date: Tue, 19 Nov 2013 10:43:49 -0800
In-Reply-To: <Pine.LNX.4.44L0.1311191258550.1145-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Tue, 19 Nov 2013 13:03:11 -0500 (EST)")
Message-ID: <87pppwkza2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alan Stern <stern@rowland.harvard.edu> writes:

> On Tue, 19 Nov 2013, Kevin Hilman wrote:
>
>> Alan Stern <stern@rowland.harvard.edu> writes:
>> 
>> > On Tue, 19 Nov 2013, Ulf Hansson wrote:
>> >
>> >> At the moment, system PM is already affecting behaviour of runtime PM
>> >> since it is preventing runtime suspend during system suspend.
>> >
>> > Sure.  And that behavior is documented.  In any case, it's a bug for 
>> > drivers to depend on runtime suspend for carrying out a system suspend.
>> 
>> As Rafael mentioned, there is bus/pm_domain code that comes into play
>> here, so I'm not sure it's always a bug.
>> 
>> IMO, it's not a bug for the driver to depend on runtime PM if the
>> bus/pm_domain is handling the details.
>> 
>> On OMAP, we handle all the SoC on-chip devices with a pm_domain since
>> the low-level PM operations that need to happen are bus-level things not
>> device-level things.  Therefore, drivers for these devices can rely
>> entirely on runtime PM, even for system suspend.  The late/early
>> callbacks in the pm_domain can see if the device is runtime suspended
>> already or not and behave accordingly.
>> 
>> So, this all *can* work by handling it at the bus/pm_domain level, but
>> as Ulf has mentioned (and I agree) it seems like a clunky workaround
>> because the PM core is preventing it from happening as one might expect.
>
> The problem is that userspace can disable runtime PM at any time by 
> writing "on" to /sys/.../power/control.  Once that's done, you can't
> depend on runtime PM to put the device into a low-power state during 
> system suspend.

We handle that too.

The way we handle it, that the pm_domain code "knows" that the device
*should* be runtime suspended by the time the pm_domain suspend_noirq
callback is called.  So it checks pm_runtime_status_suspended() and if
the device is not runtime suspended, the pm_domain will "forcibly"
runtime suspend the device (which just means, calling the driver's
->runtime_suspend(), doing the bus-level magic, and setting the runtime
PM state accordingly.)

This is arguably the same approach as the using the late callbacks that
you've already described, but it's just done in a hidden way at the bus
level.  Also, this solution predates the addtion of the late callbacks
and I believe may have even been initially proposed by you (or maybe
Rafael, I forgot.)

Kevin
