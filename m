Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:45287 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752775Ab2HGPmX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Aug 2012 11:42:23 -0400
Date: Tue, 7 Aug 2012 11:42:21 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Ming Lei <tom.leiming@gmail.com>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, <linux-pci@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
In-Reply-To: <CACVXFVO957+ORC4dLh5=5Ck=xeFw9cCSDXMNzx7jDPogyMfE_w@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1208071138430.2400-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 7 Aug 2012, Ming Lei wrote:

> On Tue, Aug 7, 2012 at 7:23 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> Yes, I agree, but I don't think it may make .runtime_post_resume
> >> not doable, do I?
> >
> > No more device PM callbacks, please.
> 
> IMO, what the patch is doing is to introduce one callback which
> is just called after .runtime_resume is completed, and you want
> to move something out of previous .runtime_resume and do it
> in another new callback to speedup resume, so it should be
> reasonable to introduce the .runtime_post_resume callback in logic.

No, that's really not what the patch is doing.

The idea behind the new API is that "func" will be called as soon as we
know the device is at full power.  That could be after the next runtime
resume or it could be right away.  This is a one-time call; it should
not be made _every_ time the device resumes.

> Also, the 'func' should be per driver, not per device since only one
> 'func' is enough for all same kind of devices driven by one same
> driver.

But what if the subsystem defines its own dev_pm_info structure?  Then
the driver's dev_pm_info will be ignored by the runtime PM core.  All
the subsystems would have to be changed.

Alan Stern

