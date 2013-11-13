Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:45488 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756278Ab3KMTQF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2013 14:16:05 -0500
Date: Wed, 13 Nov 2013 14:16:03 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Ulf Hansson <ulf.hansson@linaro.org>
cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	<linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-pci@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
In-Reply-To: <1384360178-333-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1311131411120.1424-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 13 Nov 2013, Ulf Hansson wrote:

> The PM core was preventing devices from going inactive during system
> suspend. Remove this constraint and moreover try to inactivate devices
> by invoking pm_runtime_idle() before proceeding with device's
> suspend_late callbacks.
> 
> A great amount of drivers that uses runtime PM will benefit from this.

It's not clear how drivers will benefit.

> Drivers that implements some of the system ->suspend* callbacks for the
> only reason of making sure the runtime PM resourses gets inactive, can
> now solely instead rely on the PM core to handle this.

Drivers don't have to implement anything special if they want to use
their runtime routines for system suspend.  All they have to do is set
the .suspend and .resume method pointers to point to their
runtime_suspend and runtime_resume routines.

> In the case were drivers needs there runtime resourses to be activated
> to be able to handle their system suspend tasks, those can easily just
> restore the runtime PM usage count, pm_runtime_put_sync(), once done
> with it's suspend operations, which then will inactivate the device.

The reason for doing things the way they are is to avoid races between
system PM callbacks and runtime PM callbacks.  We don't want to have a
runtime_resume routine powering up a device at the same time as a
suspend routine is powering it down.

Alan Stern

