Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64267 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965672Ab2ERSNJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 May 2012 14:13:09 -0400
Received: by dady13 with SMTP id y13so4149588dad.19
        for <linux-pci@vger.kernel.org>; Fri, 18 May 2012 11:13:08 -0700 (PDT)
Date: Fri, 18 May 2012 11:13:05 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Shyam Iyer <Shyam_Iyer@Dell.com>, ddutile@redhat.com
Subject: Re: [PATCH] pci, Add AER_panic sysfs file
Message-ID: <20120518181305.GB27021@kroah.com>
References: <20120518045130.GA3281@kroah.com>
 <1337350606-32648-1-git-send-email-prarit@redhat.com>
 <20120518154715.GA21043@kroah.com>
 <4FB68442.1010506@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FB68442.1010506@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2012 at 01:17:54PM -0400, Prarit Bhargava wrote:
> 
> > 
> > Please define "unhardened".  Why aren't all drivers "hardened"?
> 
> Most drivers _currently_ do not handle reading all f's (or -1) from hardware.
> Some drivers do handle some situations but definitely not all of them.
> Hardening a driver involves making the driver "-1" safe.

That's not "hardening", it should be written as, "fixing broken
drivers".  It's a bug if a PCI driver can not handle this as that is
exactly what happens when a PCI device is removed from the system
without the driver knowing about it.

> Some companies do ship hardened drivers, but the ones in the tree are not hardened.

Why are there out-of-tree drivers that are so-called "hardened" and why
are those bug fixes not merged into the kernel tree?

> [The above comment is in no way an approval of shipping drivers outside of the
> kernel.  I'm just stating a fact.]

Any specific drivers you are referring to so that I can go and kick
someone to get their act together?

Seriously, this is a bug in the PCI drivers, not anything else, it needs
to be fixed there, not papered over with a kernel crash from the PCI
core.

> The effort involved in hardening this drivers is significant.

It shouldn't be, this has been well known for what, 13+ years now?  This
is nothing new at all, and again, is a bug if the driver can't handle
this.

> It will be a long time before anyone considers the in-tree drivers
> hardened.  We should start with a baby-step of acknowledging the
> problem and giving current users a way of protecting their data.

No, we need to fix the drivers, again, this is a well-known issue.

What specific drivers do you see in the kernel tree right now that can
not handle this type of thing.  A list would be great so that we can fix
them now.

> >> In these cases, the system should not do a bus reset, but rather the
> >> system should panic to avoid any further possible data corruption.
> > 
> > Really?  You really want to panic the whole system and shut down and
> > potentially loose everything?  That does not sound like a good idea at
> > all to me, is there really no way to recover from this?
> 
> Yes, that's _exactly_ what I want to do.  Having a driver that is capable of
> writing corrupted data to a disk or corrupting memory is much worse than
> panicking and stopping the system for a short period of time.

But by panicking, you just lost data and have potentially corrupt data
written to the disk in a half-finished manner, plus you now have a
broken system that is stuck and needs to be rebooted :)

> The default is to handle an AER through a bus reset so a user must actively
> request the panic.

Fair enough, I can understand why some people might want this type of
control over a system, and if they reboot-on-panic, they can recover
quickly and get back up and running.

But again, this needs to be fixed in the drivers themselves, otherwise
they are broken on systems that, again, have been shipping for 13+ years
now.  It's unacceptable for the driver authors to be that sloppy.

greg k-h
