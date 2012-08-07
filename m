Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:47019 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756328Ab2HGUvS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Aug 2012 16:51:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Tue, 7 Aug 2012 22:57:10 +0200
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <CACVXFVO957+ORC4dLh5=5Ck=xeFw9cCSDXMNzx7jDPogyMfE_w@mail.gmail.com> <Pine.LNX.4.44L0.1208071138430.2400-100000@iolanthe.rowland.org> <CACVXFVM6id=oB5x80fin-k8-=sj=fLYu=0YDRZX-Uhqk4Cp8QQ@mail.gmail.com>
In-Reply-To: <CACVXFVM6id=oB5x80fin-k8-=sj=fLYu=0YDRZX-Uhqk4Cp8QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208072257.11091.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, August 07, 2012, Ming Lei wrote:
> On Tue, Aug 7, 2012 at 11:42 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > No, that's really not what the patch is doing.
> >
> > The idea behind the new API is that "func" will be called as soon as we
> > know the device is at full power.  That could be after the next runtime
> > resume or it could be right away.  This is a one-time call; it should
> 
> IMO, in the both two cases, the 'func' should be very similar with
> .runtime_post_resume from view of the caller because the caller
> don't know what the power state of the device is now, so they may
> always think the 'func' should do something similar done in
> .runtime_post_resume.
> 
> Also .runtime_post_resume always knows the device's power state
> is active, which is same with 'func'. In fact, it doesn't matter if the active
> state is the 1st time or other times, does it?

What Alan wanted to say, I think, was that .runtime_post_resume() would have
to be always identical, where func() need not be always the same function.
Moreover, .runtime_post_resume() would _always_ be run after a device resume,
while func() is run only _once_.

> > not be made _every_ time the device resumes.
> 
> Suppose the device is always resumed in the path(such as irq context),
> the callback is still called every time.

Yes, but what if you have _two_ code paths and you want to call different
code as func() in each of them?

> If the .runtime_post_resume is to be a one-time call, that is easy to do it.

No, it isn't.

> Also I am wondering why the callback shouldn't be called after resume
> in sync context, and it may simplify implementation if the two contexts
> (sync vs. async) are kept consistent.

I have no idea what you're talking about.

We actually have a callback that is run every time a device is resumed.
It is called .runtime_idle().  Does it help, though?  No, it doesn't.

> >> Also, the 'func' should be per driver, not per device since only one
> >> 'func' is enough for all same kind of devices driven by one same
> >> driver.
> >
> > But what if the subsystem defines its own dev_pm_info structure?  Then
> > the driver's dev_pm_info will be ignored by the runtime PM core.  All
> > the subsystems would have to be changed.
> 
> Suppose .runtime_post_resume is introduced,

It is not going to be introduced, period.

Thanks,
Rafael
