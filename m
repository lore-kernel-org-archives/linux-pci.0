Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:64585 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab3KNNVL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Nov 2013 08:21:11 -0500
Received: by mail-qe0-f54.google.com with SMTP id 1so1214625qec.41
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2013 05:21:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1311131411120.1424-100000@iolanthe.rowland.org>
References: <1384360178-333-1-git-send-email-ulf.hansson@linaro.org>
	<Pine.LNX.4.44L0.1311131411120.1424-100000@iolanthe.rowland.org>
Date: Thu, 14 Nov 2013 14:21:10 +0100
Message-ID: <CAPDyKFocx3L5d5_6TCx5fDy9RgD0MmmWEG0pL=77Hk7bA5EZfA@mail.gmail.com>
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

>
> Drivers don't have to implement anything special if they want to use
> their runtime routines for system suspend.  All they have to do is set
> the .suspend and .resume method pointers to point to their
> runtime_suspend and runtime_resume routines.
>
>> In the case were drivers needs there runtime resourses to be activated
>> to be able to handle their system suspend tasks, those can easily just
>> restore the runtime PM usage count, pm_runtime_put_sync(), once done
>> with it's suspend operations, which then will inactivate the device.
>
> The reason for doing things the way they are is to avoid races between
> system PM callbacks and runtime PM callbacks.  We don't want to have a
> runtime_resume routine powering up a device at the same time as a
> suspend routine is powering it down.

I believe I understand why the PM core prevent this. Some subsystems
and drivers depends on this behaviour, but I wonder if we should
consider this as common cases or more like special cases?

For those drivers that potentially could rely on runtime PM (and it's
callbacks) to inactivate the device during system suspend, and thus
don't have issues with races you describe above, the current behaviour
in the PM core adds unnecessary complexity for these drivers to handle
system suspend.

Drivers/buses/power_domains that handles runtime PM enabled devices,
will, as you also have pointed out earlier, need to implement the
.suspend callback (suspend_late or suspend_noirq might work as well)
and the corresponding .resume callback. This just for the sake of
making sure all their runtime enabled devices gets fully inactivated
during system suspend.

I wonder if we somehow should move the responsibility of preventing
"runtime suspend" as a part of the system suspend, down to the driver
to decide instead of the PM core?

Kind regards
Ulf Hansson
