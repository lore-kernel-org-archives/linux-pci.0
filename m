Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:49587 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107Ab2HHWVy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Aug 2012 18:21:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Thu, 9 Aug 2012 00:27:47 +0200
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <CACVXFVPNO2yQXJjwPGm8oLeNHsj72wtHnJ5YKLg65hR2X7BWDg@mail.gmail.com> <201208072245.46334.rjw@sisk.pl> <CACVXFVNgchXD4J+ORwwp9zc6thQAqSSor_6gshnqPFGTG=x77g@mail.gmail.com>
In-Reply-To: <CACVXFVNgchXD4J+ORwwp9zc6thQAqSSor_6gshnqPFGTG=x77g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208090027.47951.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 08, 2012, Ming Lei wrote:
> On Wed, Aug 8, 2012 at 4:45 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday, August 07, 2012, Ming Lei wrote:
> >> On Tue, Aug 7, 2012 at 7:23 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
[...]
> >
> >> and you want to move something out of previous .runtime_resume
> >
> > No, I don't.  Where did you get that idea from?
> 
> If so, I am wondering why the 'func' can't be called in .runtime_resume
> directly, and follow the below inside caller at the same time?
> 
>              if (device is active or disabled)
>                       call func(device).

This was covered in my last reply to Alan.

> >> and do it in another new callback to speedup resume,
> >
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

We were discussing specific pseudo-code in the documentation and you
conveniently took the above out of context.  Never mind. :-)

I was trying to illustrate my point with a convincing example and I admit I
could do better.

Anyway the point was that the purpose of .runtime_resume() was not to
process random I/O.  Its purpose is to _resume_ a suspended device,
no less, no more.  Which the "so that they don't have to [...] use
.runtime_resume() to run things that don't belong there." sentence above is
about.  So I've been saying the same thing all the time and it's never been
specifically about speedup (or rather about latencies added by random I/O
processing in drivers' runtime resume callbacks).

> Alan also said "Okay, those are valid reasons" for the idea. Except for
> this one, I don't see other obvious advantages about the patch.
> 
> >
> >> so it should be reasonable to introduce the .runtime_post_resume callback in
> >> logic.
> >
> > No.  This doesn't have anything to do with callbacks!
> >
> > If you want a new callback, you should specify what the role of this callback
> > is, otherwise it is not well defined.  I this case, though, what the role of
> > func() is depends on the caller and most likely every driver would use it
> > for something different.  So no, I don't see how it can be a callback.
> >
> >> Also, the 'func' should be per driver, not per device since only one
> >> 'func' is enough for all same kind of devices driven by one same
> >> driver.
> >
> > It isn't per device!  It is per _caller_.  The fact that the pointer is
> > stored _temporarily_ in struct device doesn't mean that it is per device
> > and that it is a callback.  From the struct device point of view it is _data_,
> > not a member function.
> 
> The fact is that it will become per-device one you store it in 'struct device'.
> 
> Suppose one driver may drive 10000 same devices,

Do you have any specific example of that?  If not, then please don't make up
arguments.

> the same data will be stored inside all the 10000 device instances, it is a
> good way to do it?
> 
> Not mention 90% devices mayn't use the _temporarily_ data at all.

It may be unused just as well as an additional callback pointer in a driver
object.

[...]
> >
> > So now please count how many struct dev_pm_ops objects there are on that system
> > and compute the differece.  And please note that drivers that don't use
> > struct dev_pm_ops for power management will do that in the future.
> 
> Most of dev_pm_ops stays inside module image, and not in ram.

Care to explain?  I'm not sure I understand the above correctly.

> It is a bit difficult to get the count of all dev_pm_ops objects in ram
> since it is defined statically.

Still, they are occupying memory, aren't they?  So you really can't tell
the difference between storing pointers in device driver objects and
struct device objects.

> For example, in USB subsystem, there are only 2 dev_pm_ops
> objects in RAM for a normal system, but there may have hundreds of
> usb devices in the system(usb_device, usb_interface, ep_device, ...).

Yes, USB is kind of exceptional, but also this means that your "let's
put that pointer into struct dev_pm_ops" idea won't work for USB drivers,
precisely because they don't use struct dev_pm_ops objects.

Thanks,
Rafael
