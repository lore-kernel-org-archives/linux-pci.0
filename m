Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35497 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753798Ab3KNP7y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Nov 2013 10:59:54 -0500
Date: Thu, 14 Nov 2013 10:59:53 -0500 (EST)
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
In-Reply-To: <CAPDyKFocx3L5d5_6TCx5fDy9RgD0MmmWEG0pL=77Hk7bA5EZfA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1311141055470.1439-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 14 Nov 2013, Ulf Hansson wrote:

> > The reason for doing things the way they are is to avoid races between
> > system PM callbacks and runtime PM callbacks.  We don't want to have a
> > runtime_resume routine powering up a device at the same time as a
> > suspend routine is powering it down.
> 
> I believe I understand why the PM core prevent this. Some subsystems
> and drivers depends on this behaviour, but I wonder if we should
> consider this as common cases or more like special cases?
> 
> For those drivers that potentially could rely on runtime PM (and it's
> callbacks) to inactivate the device during system suspend, and thus
> don't have issues with races you describe above, the current behaviour
> in the PM core adds unnecessary complexity for these drivers to handle
> system suspend.

What unnecessary complexity?

Bear in mind that drivers _cannot_ rely on runtime PM to inactivate a 
device during system suspend.  The user can always prevent a device 
from going into runtime suspend by writing "on" to the 
/sys/.../power/control file.

> Drivers/buses/power_domains that handles runtime PM enabled devices,
> will, as you also have pointed out earlier, need to implement the
> .suspend callback (suspend_late or suspend_noirq might work as well)
> and the corresponding .resume callback. This just for the sake of
> making sure all their runtime enabled devices gets fully inactivated
> during system suspend.
> 
> I wonder if we somehow should move the responsibility of preventing
> "runtime suspend" as a part of the system suspend, down to the driver
> to decide instead of the PM core?

No, I don't think so.  It would mean that every driver's suspend
routine would have to do a pm_runtime_get of some sort.  It's better to
just leave the single runtime_get call in the PM core.

Alan Stern

