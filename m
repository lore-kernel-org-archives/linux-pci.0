Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:58393 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab3KSQpT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 11:45:19 -0500
Received: by mail-pd0-f173.google.com with SMTP id p10so692925pdj.4
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 08:45:19 -0800 (PST)
From: Kevin Hilman <khilman@linaro.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm\@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during system suspend
References: <Pine.LNX.4.44L0.1311191011470.1145-100000@iolanthe.rowland.org>
Date: Tue, 19 Nov 2013 08:45:13 -0800
In-Reply-To: <Pine.LNX.4.44L0.1311191011470.1145-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Tue, 19 Nov 2013 10:35:46 -0500 (EST)")
Message-ID: <87r4acmjc6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alan Stern <stern@rowland.harvard.edu> writes:

> On Tue, 19 Nov 2013, Ulf Hansson wrote:
>
>> At the moment, system PM is already affecting behaviour of runtime PM
>> since it is preventing runtime suspend during system suspend.
>
> Sure.  And that behavior is documented.  In any case, it's a bug for 
> drivers to depend on runtime suspend for carrying out a system suspend.

As Rafael mentioned, there is bus/pm_domain code that comes into play
here, so I'm not sure it's always a bug.

IMO, it's not a bug for the driver to depend on runtime PM if the
bus/pm_domain is handling the details.

On OMAP, we handle all the SoC on-chip devices with a pm_domain since
the low-level PM operations that need to happen are bus-level things not
device-level things.  Therefore, drivers for these devices can rely
entirely on runtime PM, even for system suspend.  The late/early
callbacks in the pm_domain can see if the device is runtime suspended
already or not and behave accordingly.

So, this all *can* work by handling it at the bus/pm_domain level, but
as Ulf has mentioned (and I agree) it seems like a clunky workaround
because the PM core is preventing it from happening as one might expect.

Kevin
