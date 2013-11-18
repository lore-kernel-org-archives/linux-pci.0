Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qe0-f50.google.com ([209.85.128.50]:49682 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab3KRN1B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2013 08:27:01 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so3980186qee.23
        for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2013 05:27:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1311151006280.1527-100000@iolanthe.rowland.org>
References: <CAPDyKFrQfwOQsOCB1QFo4GWeX303AEWnanE61svy9UUJpNBUiw@mail.gmail.com>
	<Pine.LNX.4.44L0.1311151006280.1527-100000@iolanthe.rowland.org>
Date: Mon, 18 Nov 2013 14:27:00 +0100
Message-ID: <CAPDyKFrushEwW7x_VguPjOnP8BuSO=+tD=DxS9J0JQVfYTgOYA@mail.gmail.com>
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

> In any case, although Bjørn made a good point about latency, the main
> reason for having the sysfs interface was to cope with buggy devices.
> Linux started using runtime PM before Windows did.  At that time, many
> devices did not support runtime suspend very well -- they didn't have
> to since Windows didn't use it.  Plenty of devices simply couldn't
> handle it.  Too many for a blacklist.
>
> So we pushed the decision about whether to enable runtime PM out to
> userspace.  There was no other choice; too many people were having too
> many problems when runtime PM was automatically on.
>
>> What would make sense to me, is to move the runtime PM sysfs to
>> debugfs, because it is a good feature to make use of during
>> development and debugging.
>
> But since it is primarily needed for device control by the user, it
> belongs in sysfs.
>

Got it! Thanks for giving me the history to better understand why the
sysfs exists.

<snip>

>> >> So as a way forward, I am thinking of a similar approach as you
>> >> suggested with the "generic" suspend_late. But instead add a new
>> >> runtime PM API, which intent is to let drivers to specify for PM core,
>> >> if it should care to prevent the runtime suspend from happen during
>> >> system system - or not. Could that work?
>> >
>> > I don't see what good it would do.  Instead of adding a new flag, why
>> > not just let drivers point their .suspend_late methods to the new
>> > generic function?  That would accomplish almost the same thing without
>> > changing the API.
>>
>> Two minor functions will be added to the API, no big deal I think.
>> More importantly these will actually make life easier for some drivers
>> since they don't need to set up any additional PM callbacks.
>>
>> Using the generic suspend_late approach would for sure work, but it
>> will spread to buses and power domains as well, which is not the case
>> when adding when adding a new API.
>
> I don't understand what you mean by "spread to".  That makes it sound
> like an infectious disease rather than a subroutine.  :-)
>
> Also, I don't see how adding one line for an extra callback pointer is
> any harder than adding one line to call pm_runtime_no_prevent_suspend.
>

I favour the pm_runtime_no_prevent_suspend API approach, since it
would mean a change in behaviour of the PM core. I also think that in
some cases it could make runtime PM better understandable, for those
who are deploying it.

Another advantage of "pm_runtime_no_prevent_suspend" is that driver's
can still easily prevent runtime suspend, during system suspend, by an
extra call to "pm_runtime_get*". Typically this could be used when the
device is configured for wakeup. In this case the generic suspend_late
approach would not work, since the driver would need to implement it's
own .suspend_late callback to handle this.

Kind regards
Ulf Hansson

>> > (Actually, it would be superior.  The generic suspend_late approach
>> > will work even if the user writes "on" to /sys/.../power/control,
>> > whereas your approach won't work.)
>>
>> We have different view here. :-)
>>
>> Whether I like it or not, the sysfs interface exist and then I think
>> the kernel must act accordingly. We shouldn’t override it. I mean if
>> userspace has decided to keep a device active, there is probably a
>> reason.
>>
>>
>> Thanks a lot Alan for being patient with me and continuing the discussion!
>
> My pleasure.
>
> Alan Stern
>
