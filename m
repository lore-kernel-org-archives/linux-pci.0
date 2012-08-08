Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52596 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752693Ab2HHSmQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Aug 2012 14:42:16 -0400
Date: Wed, 8 Aug 2012 14:42:14 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Ming Lei <tom.leiming@gmail.com>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, <linux-pci@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
In-Reply-To: <CACVXFVNgchXD4J+ORwwp9zc6thQAqSSor_6gshnqPFGTG=x77g@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1208081432090.1701-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 8 Aug 2012, Ming Lei wrote:

> On Wed, Aug 8, 2012 at 4:45 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday, August 07, 2012, Ming Lei wrote:
> >> On Tue, Aug 7, 2012 at 7:23 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> >> Yes, I agree, but I don't think it may make .runtime_post_resume
> >> >> not doable, do I?
> >> >
> >> > No more device PM callbacks, please.
> >>
> >> IMO, what the patch is doing is to introduce one callback which
> >> is just called after .runtime_resume is completed,
> >
> > No, it is not a callback.  It is a function to be run _once_ when the device is
> > known to be active.  It is not a member of a data type or anything like this.
> 
> Looks it was said by Alan, not me, :-)
> 
> "The documentation should explain that in some ways, "func" is like a
> workqueue callback routine:".
> 
> See http://marc.info/?l=linux-usb&m=134426838507799&w=2

I didn't say it _was_ a callback; I said it was _like_ a callback in 
some ways.

> If so, I am wondering why the 'func' can't be called in .runtime_resume
> directly, and follow the below inside caller at the same time?
> 
>              if (device is active or disabled)
>                       call func(device).

That was my original suggestion.  Rafael pointed out that having a 
single function call to do this would make it easier for driver writers 
to get it right.

> > No, not to speed up resume.  The idea is to allow drivers to run something
> > when the resume is complete, so that they don't have to implement a "resume
> > detection" logic or use .runtime_resume() to run things that don't belong
> > there.
> 
> Looks it was said by you, :-)
> 
> "Unless your _driver_ callback is actually executed from within a PM domain
> callback, for example, and something else may be waiting for it to complete,
> so your data processing is adding latencies to some other threads.  I'm not
> making that up, by the way, that really can happen."
> 
> See http://marc.info/?l=linux-pm&m=134394271517527&w=2
> 
> Alan also said "Okay, those are valid reasons" for the idea. Except for
> this one, I don't see other obvious advantages about the patch.

Those _are_ the two advantages:

	The runtime-resume method does nothing but bring the device
	back to full power; it doesn't do any other processing;

	It's easier than calling pm_runtime_get() followed by a test
	to see whether the device is active.

> Suppose one driver may drive 10000 same devices, the same data will be
> stored inside all the 10000 device instances, it is a good way to do it?

If you've got a system with 10000 device instances, you can probably 
spare the memory needed to store these function pointers.  But you're 
right that this is a disadvantage.

Alan Stern

