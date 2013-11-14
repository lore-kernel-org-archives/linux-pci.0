Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35589 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753295Ab3KNR5T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Nov 2013 12:57:19 -0500
Date: Thu, 14 Nov 2013 12:57:18 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Ulf Hansson <ulf.hansson@linaro.org>
cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
In-Reply-To: <CAPDyKFqYOnfWKH7BFRem5T5yGmJrOWBTDhZwoExuemMf0HQ7Ag@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1311141249580.1439-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 14 Nov 2013, Ulf Hansson wrote:

> > Bear in mind that drivers _cannot_ rely on runtime PM to inactivate a
> > device during system suspend.  The user can always prevent a device
> > from going into runtime suspend by writing "on" to the
> > /sys/.../power/control file.
> 
> Good that you brought this up. From my point of view I think the sysfs
> for runtime PM could be debated whether it should exist at all, at
> least in it's current form.

What other form would you suggest?

> Anyway, if userspace decides to prevent runtime_suspend, I guess it
> will have take the consequences for it as well. :-)

Right now, those consequences don't include also preventing the device
from going to low power during system system.  What would you do if you
had a buggy device, where you knew it couldn't handle runtime suspend?  
If you still wanted to put the whole system to sleep, you'd be stuck.

> So as a way forward, I am thinking of a similar approach as you
> suggested with the "generic" suspend_late. But instead add a new
> runtime PM API, which intent is to let drivers to specify for PM core,
> if it should care to prevent the runtime suspend from happen during
> system system - or not. Could that work?

I don't see what good it would do.  Instead of adding a new flag, why 
not just let drivers point their .suspend_late methods to the new 
generic function?  That would accomplish almost the same thing without 
changing the API.

(Actually, it would be superior.  The generic suspend_late approach 
will work even if the user writes "on" to /sys/.../power/control, 
whereas your approach won't work.)

Alan Stern

