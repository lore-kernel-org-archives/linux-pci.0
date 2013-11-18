Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:46159 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751171Ab3KRPRN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2013 10:17:13 -0500
Date: Mon, 18 Nov 2013 10:17:12 -0500 (EST)
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
In-Reply-To: <CAPDyKFrushEwW7x_VguPjOnP8BuSO=+tD=DxS9J0JQVfYTgOYA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1311181010080.1421-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 18 Nov 2013, Ulf Hansson wrote:

> I favour the pm_runtime_no_prevent_suspend API approach, since it
> would mean a change in behaviour of the PM core.

That's exactly why I don't favor it!  :-)

>  I also think that in
> some cases it could make runtime PM better understandable, for those
> who are deploying it.

I don't see how it would make runtime PM either more or less
understandable, since the proposed change affects system PM, not
runtime PM.  On the other hand, it would make the Runtime PM 
documentation more complicated.

(Also, I think the name "pm_runtime_no_prevent_suspend" is a very bad 
choice.  It should be something more like 
"allow_runtime_suspend_during_system_sleep".)

> Another advantage of "pm_runtime_no_prevent_suspend" is that driver's
> can still easily prevent runtime suspend, during system suspend, by an
> extra call to "pm_runtime_get*". Typically this could be used when the
> device is configured for wakeup.

How is this an advantage?  Drivers can accomplish the same thing right 
now by not doing anything at all.

>  In this case the generic suspend_late
> approach would not work, since the driver would need to implement it's
> own .suspend_late callback to handle this.

Actually, drivers would simply need to _avoid_ setting the 
.suspend_late callback.

Alan Stern

