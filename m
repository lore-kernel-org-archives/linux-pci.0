Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58879 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946592Ab2ERXTF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 May 2012 19:19:05 -0400
Received: by pbbrp8 with SMTP id rp8so4535201pbb.19
        for <linux-pci@vger.kernel.org>; Fri, 18 May 2012 16:19:05 -0700 (PDT)
Date: Fri, 18 May 2012 16:19:02 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Shyam Iyer <Shyam_Iyer@Dell.com>, ddutile@redhat.com
Subject: Re: [PATCH] pci, Add AER_panic sysfs file
Message-ID: <20120518231902.GA9488@kroah.com>
References: <20120518045130.GA3281@kroah.com>
 <1337350606-32648-1-git-send-email-prarit@redhat.com>
 <20120518154715.GA21043@kroah.com>
 <4FB68442.1010506@redhat.com>
 <20120518181305.GB27021@kroah.com>
 <4FB6A2E4.2080203@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FB6A2E4.2080203@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2012 at 03:28:36PM -0400, Prarit Bhargava wrote:
> 
> 
> On 05/18/2012 02:13 PM, Greg KH wrote:
> > On Fri, May 18, 2012 at 01:17:54PM -0400, Prarit Bhargava wrote:
> >>
> >>>
> >>> Please define "unhardened".  Why aren't all drivers "hardened"?
> >>
> >> Most drivers _currently_ do not handle reading all f's (or -1) from hardware.
> >> Some drivers do handle some situations but definitely not all of them.
> >> Hardening a driver involves making the driver "-1" safe.
> > 
> > That's not "hardening", it should be written as, "fixing broken
> > drivers".  It's a bug if a PCI driver can not handle this as that is
> > exactly what happens when a PCI device is removed from the system
> > without the driver knowing about it.
> 
> Sorry Greg, I should have stated this at the beginning.  Without question
> patches should be _and will be_ sent to drivers as problems are found.

Great, just do that then.

Seriously, that's all you need to do, no modifying the PCI core needed.

There shouldn't be these problems in any "real" drivers anyway, a number
of us did a lot of testing for this very problem years ago (yanking out
huge drawers of PCI slots, having fun with ExpressCard devices, etc.)

Any driver that can't handle this is fundimentally broken, and needs to
be fixed now, no messing around with this "enterprise" crud.

> >> Some companies do ship hardened drivers, but the ones in the tree are not hardened.
> > 
> > Why are there out-of-tree drivers that are so-called "hardened" and why
> > are those bug fixes not merged into the kernel tree?
> 
> See comment below.
> > 
> >> [The above comment is in no way an approval of shipping drivers outside of the
> >> kernel.  I'm just stating a fact.]
> 
> I'm just stating a fact.  I have no idea why patches are not on the list.  Nor
> am I condoning the activity of keeping fixes outside of the tree.  I've _just
> started_ working with a group who has patches and am going to do some work with
> them on getting patches out to the tree.

Send them today.  What's keeping them from going in right now?

> > Any specific drivers you are referring to so that I can go and kick
> > someone to get their act together?
> 
> I'll get a list together and hopefully we can get some patches out.
> 
> > 
> >> The effort involved in hardening this drivers is significant.
> > 
> > It shouldn't be, this has been well known for what, 13+ years now?  This
> > is nothing new at all, and again, is a bug if the driver can't handle
> > this.
> 
> Most drivers cannot handle surprise removals, and in this case that's what we're
> effectively talking about.  There may be a few that can, and even those might be
> able to handle a few cases of surprise removal or reset events.

I think it's really the other way around, most should be able to handle
this as it was tested by a lot of people.

Unless new code crept in that wasn't tested, but no, no company would
ever submit stuff like that, would they?  Nevermind...

> >>>> In these cases, the system should not do a bus reset, but rather the
> >>>> system should panic to avoid any further possible data corruption.
> >>>
> >>> Really?  You really want to panic the whole system and shut down and
> >>> potentially loose everything?  That does not sound like a good idea at
> >>> all to me, is there really no way to recover from this?
> >>
> >> Yes, that's _exactly_ what I want to do.  Having a driver that is capable of
> >> writing corrupted data to a disk or corrupting memory is much worse than
> >> panicking and stopping the system for a short period of time.
> > 
> > But by panicking, you just lost data and have potentially corrupt data
> > written to the disk in a half-finished manner, plus you now have a
> > broken system that is stuck and needs to be rebooted :)
> 
> Fair enough -- I suppose this comes down to:  Which is worse?  Coming back to a
> system with corrupt data or memory, or rebooting and losing data (and waiting
> for a reboot)? :)
> 
> In my view, if a user *KNOWS* that a driver isn't going to play well with a
> reset then let them make the call -- it shouldn't be up to us to decide what is
> best for them.  If they want a panic, let them have it.  As time goes on the
> drivers will get better but that isn't going to happen overnight.

How can a user know that?  You haven't even told us what drivers can't
handle this!  That's not fair at all, what you are really asking us to
do is:
	Take this core patch to cause oopses to work around some unnamed
	crappy drivers that are broken and can't handle basic,
	fundamental, aspects of handling their hardware.

That's not acceptable at all, fix the problem at the root cause, in the
drivers, right now.  There should not be anything stopping this.

> >> The default is to handle an AER through a bus reset so a user must actively
> >> request the panic.
> > 
> > Fair enough, I can understand why some people might want this type of
> > control over a system, and if they reboot-on-panic, they can recover
> > quickly and get back up and running.
> > 
> > But again, this needs to be fixed in the drivers themselves, otherwise
> > they are broken on systems that, again, have been shipping for 13+ years
> > now.  It's unacceptable for the driver authors to be that sloppy.
> 
> I agree with you Greg.  I 100% agree with you.  But getting fixes into the
> drivers will take some time.  Getting them to a state where
> commercial/enterprise customers consider them reliable for surprise events is
> going to take some time... so I'm arguing that we should go with a simple
> user-based policy and fix the drivers as we move along.

I don't care about "enterprise" customers (hint, there is no such thing,
everyone is an "enterprise").  I care about people who don't know how to
write basic PCI drivers to handle this type of event that has been known
for well over a decade[1].

You are also making the claim that somehow it is easier, and safer, to
modify the PCI core, and that these skittish "enterprise" people will
take that, instead of fixing their drivers.

So I say NAK to this patch, fix the root problem now, there is no excuse
for this work around.

greg k-h

[1] Actually longer than that, this went back to PCMCIA cards which came
out what, in the 1980's?
