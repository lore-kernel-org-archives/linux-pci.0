Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42110 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211Ab2HDUmf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 4 Aug 2012 16:42:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Sat, 4 Aug 2012 22:48:24 +0200
Cc: Ming Lei <tom.leiming@gmail.com>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <Pine.LNX.4.44L0.1208041619440.23711-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1208041619440.23711-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208042248.24957.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, August 04, 2012, Alan Stern wrote:
> On Sat, 4 Aug 2012, Rafael J. Wysocki wrote:
> 
> > On Friday, August 03, 2012, Ming Lei wrote:
> > > On Fri, Aug 3, 2012 at 10:20 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > On Thu, 2 Aug 2012, Rafael J. Wysocki wrote:
> > > 
> > > > Hmmm.  You'd probably want a version that does a "get" at the same
> > > > time.  I suppose you would call func directly if the device was already
> > > > resumed, without going through the workqueue?
> > > 
> > > Maybe it isn't good, the 'func' might not be run in the current context
> > > (irq context or some spinlock is held).
> > 
> > Then I'd say don't use this interface.  If you have code that needs to
> > be run in a different context, then you have to use a work item (or
> > equivalent) anyway and you can do a synchronous runtime resume from there.
> 
> That wasn't what he meant.  What if the code needs to run in the _same_
> context as the caller?  For example, with a spinlock held.

I see.  I think it wouldn't be unreasonable to require that func should take
all of the necessary locks by itself.

However, I believe that if func is going to be called through the workqueue,
the usage counter should be incremented before the preceding resume and
decremented after func returns by the workqueue thread.

> func would need to know whether it should acquire the lock, which means it
> needs to know whether it was called directly or through the workqueue.
> 
> I suppose we could pass it an extra argument with this information...  
> but that's a little ugly.

I agree.  I'd prefer to avoid that, if possible.

Thanks,
Rafael
