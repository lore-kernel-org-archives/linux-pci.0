Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:44686 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab3KUJAP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2013 04:00:15 -0500
Received: by mail-qe0-f53.google.com with SMTP id cy11so6936728qeb.40
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2013 01:00:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1311191258550.1145-100000@iolanthe.rowland.org>
References: <87r4acmjc6.fsf@linaro.org>
	<Pine.LNX.4.44L0.1311191258550.1145-100000@iolanthe.rowland.org>
Date: Thu, 21 Nov 2013 10:00:14 +0100
Message-ID: <CAPDyKFrJ34oWhPosqqfh-cCpoQnAY9Q90wP7nn60RAh87ZCPAw@mail.gmail.com>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 19 November 2013 19:03, Alan Stern <stern@rowland.harvard.edu> wrote:
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
>
> Now, if the bus-level code always takes care of putting the device into
> low power during system suspend, then the driver doesn't have to worry
> about it at all.  That's perfectly fine -- but I would hardly describe
> the situation by saying the driver relies on runtime PM for system
> suspend.

But they are, since that is exactly what these driver depends on
during system suspend. And since the power domain invokes the runtime
callbacks, normally CONFIG_PM_RUNTIME is needed for the callbacks to
be set up from in the bus/driver.

I suppose that the OMAP SoC maintainers were accepting that this
dependency were allowed to exist, since that was the only solution to
their problem at that point.

Today, several years later, we are still indirectly pushing those SoC
maintainers that faces similar issues, to accept this dependency
between system suspend and runtime suspend. I see a conflict here. :-)

Kind regards
Ulf Hansson

>
> Alan Stern
>
