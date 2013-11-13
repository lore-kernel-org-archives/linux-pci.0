Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51688 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751715Ab3KMWAz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2013 17:00:55 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	Kevin Hilman <khilman@linaro.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during system suspend
Date: Wed, 13 Nov 2013 23:13:24 +0100
Message-ID: <2003753.HAeVh74cdL@vostro.rjw.lan>
In-Reply-To: <1384360178-333-1-git-send-email-ulf.hansson@linaro.org>
References: <1384360178-333-1-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, November 13, 2013 05:29:38 PM Ulf Hansson wrote:
> The PM core was preventing devices from going inactive during system
> suspend.

That's not even correct.  It prevents the runtime PM framework from being
used to suspend devices during system suspend and that's on purpose.  The
reason why is that we don't want asynchronous runtime suspends to happen
during system suspend and race with the suspend process.

> Remove this constraint and moreover try to inactivate devices
> by invoking pm_runtime_idle() before proceeding with device's
> suspend_late callbacks.
> 
> A great amount of drivers that uses runtime PM will benefit from this.

If the idea is to be able to do pm_runtime_suspend() from the system suspend
code path, this is not the way to go and it kind of indicates the lack of
understanding why things have been arranged this way.

If you want a driver to do the same thing for runtime PM and system
suspend/resume, point its .suspend_late() and .runtime_suspend() to the
same routine and analogously for .runtime_resume() and .resume_early()
(that may not work for PCI, though, because of the _noirq stuff, but that's
the PCI bus type issue).

Of course, the assumption behind .runtime_suspend() and .runtime_resume() is
that they will be run when the device is not in use, while system suspend
may actually happen when the device *is* in use and .suspend() should take
care of that if necessary.  So you may need .suspend() anyway.

One important property of system suspend is that it can happen at any time
and that's why the .suspend() and .resume() callbacks are needed (and this
also means that they can't be the same as .runtime_suspend() and
.runtime_resume() in general).

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
