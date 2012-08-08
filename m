Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:49410 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759139Ab2HHUKy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Aug 2012 16:10:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Wed, 8 Aug 2012 22:16:48 +0200
Cc: Ming Lei <tom.leiming@gmail.com>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <Pine.LNX.4.44L0.1208081432090.1701-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1208081432090.1701-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208082216.48863.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 08, 2012, Alan Stern wrote:
> On Wed, 8 Aug 2012, Ming Lei wrote:
[...]
> > If so, I am wondering why the 'func' can't be called in .runtime_resume
> > directly, and follow the below inside caller at the same time?
> > 
> >              if (device is active or disabled)
> >                       call func(device).
> 
> That was my original suggestion.  Rafael pointed out that having a 
> single function call to do this would make it easier for driver writers 
> to get it right.

Not only would it be easier to get it right, in my opinion, but also in the
example above func() may be called in some places where the driver may not
want it to be called and which are very difficult to detect (like a resume
from __device_suspend() during system suspend).  Moreover, if the driver
callback is not executed directly by the PM core, but instead it is executed by
a subsystem or PM domain callback, there's no guarantee that the device _can_
be used for processing regular I/O before the driver callback returns (the
subsystem callback may still need to do something _after_ that happens).

So, this appears to be a matter of correctness too.

> > > No, not to speed up resume.  The idea is to allow drivers to run something
> > > when the resume is complete, so that they don't have to implement a "resume
> > > detection" logic or use .runtime_resume() to run things that don't belong
> > > there.
> > 
> > Looks it was said by you, :-)
> > 
> > "Unless your _driver_ callback is actually executed from within a PM domain
> > callback, for example, and something else may be waiting for it to complete,
> > so your data processing is adding latencies to some other threads.  I'm not
> > making that up, by the way, that really can happen."
> > 
> > See http://marc.info/?l=linux-pm&m=134394271517527&w=2
> > 
> > Alan also said "Okay, those are valid reasons" for the idea. Except for
> > this one, I don't see other obvious advantages about the patch.
> 
> Those _are_ the two advantages:
> 
> 	The runtime-resume method does nothing but bring the device
> 	back to full power; it doesn't do any other processing;
> 
> 	It's easier than calling pm_runtime_get() followed by a test
> 	to see whether the device is active.
> 
> > Suppose one driver may drive 10000 same devices, the same data will be
> > stored inside all the 10000 device instances, it is a good way to do it?
> 
> If you've got a system with 10000 device instances, you can probably 
> spare the memory needed to store these function pointers.  But you're 
> right that this is a disadvantage.

Yes, it is in grand general, but that also is a matter of alignment and of
the way the slab allocator works.  For example, if every struct device
object were stored at the beginning of a new memory page, then its size
wouldn't matter a lot as long as it were smaller than PAGE_SIZE.

I haven't checked the details, but I'm pretty sure that focusing on the size
alone doesn't give us the whole picture here.

Thanks,
Rafael
