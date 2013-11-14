Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:43861 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab3KNQk5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Nov 2013 11:40:57 -0500
Received: by mail-qa0-f51.google.com with SMTP id i13so310984qae.17
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2013 08:40:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1311141055470.1439-100000@iolanthe.rowland.org>
References: <CAPDyKFocx3L5d5_6TCx5fDy9RgD0MmmWEG0pL=77Hk7bA5EZfA@mail.gmail.com>
	<Pine.LNX.4.44L0.1311141055470.1439-100000@iolanthe.rowland.org>
Date: Thu, 14 Nov 2013 17:40:55 +0100
Message-ID: <CAPDyKFqYOnfWKH7BFRem5T5yGmJrOWBTDhZwoExuemMf0HQ7Ag@mail.gmail.com>
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
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14 November 2013 16:59, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 14 Nov 2013, Ulf Hansson wrote:
>
>> > The reason for doing things the way they are is to avoid races between
>> > system PM callbacks and runtime PM callbacks.  We don't want to have a
>> > runtime_resume routine powering up a device at the same time as a
>> > suspend routine is powering it down.
>>
>> I believe I understand why the PM core prevent this. Some subsystems
>> and drivers depends on this behaviour, but I wonder if we should
>> consider this as common cases or more like special cases?
>>
>> For those drivers that potentially could rely on runtime PM (and it's
>> callbacks) to inactivate the device during system suspend, and thus
>> don't have issues with races you describe above, the current behaviour
>> in the PM core adds unnecessary complexity for these drivers to handle
>> system suspend.
>
> What unnecessary complexity?
>
> Bear in mind that drivers _cannot_ rely on runtime PM to inactivate a
> device during system suspend.  The user can always prevent a device
> from going into runtime suspend by writing "on" to the
> /sys/.../power/control file.

Good that you brought this up. From my point of view I think the sysfs
for runtime PM could be debated whether it should exist at all, at
least in it's current form.

Anyway, if userspace decides to prevent runtime_suspend, I guess it
will have take the consequences for it as well. :-)

>
>> Drivers/buses/power_domains that handles runtime PM enabled devices,
>> will, as you also have pointed out earlier, need to implement the
>> .suspend callback (suspend_late or suspend_noirq might work as well)
>> and the corresponding .resume callback. This just for the sake of
>> making sure all their runtime enabled devices gets fully inactivated
>> during system suspend.
>>
>> I wonder if we somehow should move the responsibility of preventing
>> "runtime suspend" as a part of the system suspend, down to the driver
>> to decide instead of the PM core?
>
> No, I don't think so.  It would mean that every driver's suspend
> routine would have to do a pm_runtime_get of some sort.  It's better to
> just leave the single runtime_get call in the PM core.

In the end I suppose what case that is most common should win. :-) At
the same time, we should go slowly forward and it is probably not
realistic to convert each and every driver in one go.

So as a way forward, I am thinking of a similar approach as you
suggested with the "generic" suspend_late. But instead add a new
runtime PM API, which intent is to let drivers to specify for PM core,
if it should care to prevent the runtime suspend from happen during
system system - or not. Could that work?

Kind regards
Ulf Hansson

>
> Alan Stern
>
