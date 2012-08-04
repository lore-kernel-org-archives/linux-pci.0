Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42133 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753390Ab2HDVJ5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 4 Aug 2012 17:09:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Sat, 4 Aug 2012 23:15:43 +0200
Cc: Ming Lei <tom.leiming@gmail.com>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <Pine.LNX.4.44L0.1208041644240.23711-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1208041644240.23711-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208042315.44031.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, August 04, 2012, Alan Stern wrote:
> On Sat, 4 Aug 2012, Rafael J. Wysocki wrote:
> 
> > > That wasn't what he meant.  What if the code needs to run in the _same_
> > > context as the caller?  For example, with a spinlock held.
> > 
> > I see.  I think it wouldn't be unreasonable to require that func should take
> > all of the necessary locks by itself.
> 
> But then if func was called directly, because the device was at full
> power, it would deadlock trying to acquire a lock the caller already
> holds.

I wonder why the caller may want to take any locks beforehand?

> > However, I believe that if func is going to be called through the workqueue,
> > the usage counter should be incremented before the preceding resume and
> > decremented after func returns by the workqueue thread.
> 
> Okay.
> 
> > > func would need to know whether it should acquire the lock, which means it
> > > needs to know whether it was called directly or through the workqueue.
> > > 
> > > I suppose we could pass it an extra argument with this information...  
> > > but that's a little ugly.
> > 
> > I agree.  I'd prefer to avoid that, if possible.
> 
> Do you have any better suggestions?

Hmm.  What about pm_runtime_get_and_call(dev, func_sync, func_async), where
func_sync() is to be called if the device is already active and func_async()
is to be called if it has to be resumed from the workqueue?

Rafael
