Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:51410 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759440Ab2HITfl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Aug 2012 15:35:41 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Thu, 9 Aug 2012 21:41:35 +0200
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <Pine.LNX.4.44L0.1208081432090.1701-100000@iolanthe.rowland.org> <201208091246.25874.rjw@sisk.pl> <CACVXFVM9rQWvOrwR9ENrTx4m8iVK=EFbcjioWiCdgbyBRov3eQ@mail.gmail.com>
In-Reply-To: <CACVXFVM9rQWvOrwR9ENrTx4m8iVK=EFbcjioWiCdgbyBRov3eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208092141.35589.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, August 09, 2012, Ming Lei wrote:
> On Thu, Aug 9, 2012 at 6:46 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Thursday, August 09, 2012, Ming Lei wrote:
> 
> >> driver->runtime_resume should be allowed to do I/O things after
> >> the device has been woken up inside driver callback, shouldn't it? If it
> >> isn't allowed, something wrong should have be reported before.
> >
> > Well, the lack of reports doesn't mean there are no bugs. :-)
> >
> > People may actually see those bugs, but they don't report them or they
> > report them as system suspend/resume bugs, for example.
> 
> Also, I am still wondering why subsystem PM callback need to do
> something after driver->runtime_resume completes, could you explain
> it?

It just isn't guaranteed that the subsystem callback won't do anything
after driver->runtime_resume completion.  I agree that it isn't likely
to happen.

> >> Firstly, introduce one extra pointer in device may increase memory
> >> consume for device allocation,
> >
> > Yes, it does, which may or may not matter depending on the actual size of
> > struct device and the CPU cache line size on the given machine, right?
> 
> It may double memory allocation size in some cases. And it is very possible
> since there are so many device objects in system.

Numbers, please?  If you don't have them, it's just waving your hands.

> >> also it reflects one design drawback in the patch, see below.
> >>
> >> More importantly, the implementation violates some software design
> >> principle in object oriented design.
> >
> > It doesn't violate anything and you're just ignoring what you've been told.
> > That makes discussing with you rather difficult, but I'll try again
> > nevertheless.
> >
> > If you look at the actual patch I've just posted:
> >
> > https://patchwork.kernel.org/patch/1299781/
> >
> > you can see that power.func is never run directly.  Moreover, the pointer it
> > contains is only used to run a function in pm_runtime_work() and note that
> > pm_runtime_work() reads that pointer _twice_, because it may be changed in the
> > meantime by a concurrent thread.
> 
> I have explained it before, it is enough to keep the pointer read only
> since driver can maintain its internal state in its specific device instance
> (for example, usb_interface objects) and decide what to do in 'func'
> for situations, right?

Yes, it is.  I actually have a patch that does something similar (I'll post it
shortly).

Of course, it is based on the assumption that func() will always be the same
pointer for the given driver, which doesn't seem to be proven, but perhaps
it is sufficient.  At least I'm not aware of use cases where it wouldn't be.

Thanks,
Rafael
