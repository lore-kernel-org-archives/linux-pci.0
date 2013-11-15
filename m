Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:37312 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab3KOIot convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2013 03:44:49 -0500
Received: by mail-qc0-f176.google.com with SMTP id s19so1912730qcw.7
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2013 00:44:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1311141249580.1439-100000@iolanthe.rowland.org>
References: <CAPDyKFqYOnfWKH7BFRem5T5yGmJrOWBTDhZwoExuemMf0HQ7Ag@mail.gmail.com>
	<Pine.LNX.4.44L0.1311141249580.1439-100000@iolanthe.rowland.org>
Date: Fri, 15 Nov 2013 09:44:48 +0100
Message-ID: <CAPDyKFrQfwOQsOCB1QFo4GWeX303AEWnanE61svy9UUJpNBUiw@mail.gmail.com>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14 November 2013 18:57, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 14 Nov 2013, Ulf Hansson wrote:
>
>> > Bear in mind that drivers _cannot_ rely on runtime PM to inactivate a
>> > device during system suspend.  The user can always prevent a device
>> > from going into runtime suspend by writing "on" to the
>> > /sys/.../power/control file.
>>
>> Good that you brought this up. From my point of view I think the sysfs
>> for runtime PM could be debated whether it should exist at all, at
>> least in it's current form.
>
> What other form would you suggest?

I think it is kind of strange to give provision to userspace to
control a "request based" power management feature in the kernel. Me
personally can't think of any good use case, but I comes from the
embedded/ARM world so I might not have the full picture.

What would make sense to me, is to move the runtime PM sysfs to
debugfs, because it is a good feature to make use of during
development and debugging.

>
>> Anyway, if userspace decides to prevent runtime_suspend, I guess it
>> will have take the consequences for it as well. :-)
>
> Right now, those consequences don't include also preventing the device
> from going to low power during system system.  What would you do if you
> had a buggy device, where you knew it couldn't handle runtime suspend?
> If you still wanted to put the whole system to sleep, you'd be stuck.

Hmm, this seems like a use case for runtime PM sysfs then. :-)

It sounds like vague arguments. If the driver has bugs we need to fix
them, right? Should we really let userspace workaround bugs in the
kernel?

>
>> So as a way forward, I am thinking of a similar approach as you
>> suggested with the "generic" suspend_late. But instead add a new
>> runtime PM API, which intent is to let drivers to specify for PM core,
>> if it should care to prevent the runtime suspend from happen during
>> system system - or not. Could that work?
>
> I don't see what good it would do.  Instead of adding a new flag, why
> not just let drivers point their .suspend_late methods to the new
> generic function?  That would accomplish almost the same thing without
> changing the API.

Two minor functions will be added to the API, no big deal I think.
More importantly these will actually make life easier for some drivers
since they don't need to set up any additional PM callbacks.

Using the generic suspend_late approach would for sure work, but it
will spread to buses and power domains as well, which is not the case
when adding when adding a new API.

>
> (Actually, it would be superior.  The generic suspend_late approach
> will work even if the user writes "on" to /sys/.../power/control,
> whereas your approach won't work.)

We have different view here. :-)

Whether I like it or not, the sysfs interface exist and then I think
the kernel must act accordingly. We shouldn’t override it. I mean if
userspace has decided to keep a device active, there is probably a
reason.


Thanks a lot Alan for being patient with me and continuing the discussion!

Kind regards
Ulf Hansson

>
> Alan Stern
>
