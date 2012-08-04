Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:41768 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753390Ab2HDUZH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 4 Aug 2012 16:25:07 -0400
Date: Sat, 4 Aug 2012 16:25:06 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Ming Lei <tom.leiming@gmail.com>, <linux-pci@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
In-Reply-To: <201208042147.25845.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1208041619440.23711-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 4 Aug 2012, Rafael J. Wysocki wrote:

> On Friday, August 03, 2012, Ming Lei wrote:
> > On Fri, Aug 3, 2012 at 10:20 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > On Thu, 2 Aug 2012, Rafael J. Wysocki wrote:
> > 
> > > Hmmm.  You'd probably want a version that does a "get" at the same
> > > time.  I suppose you would call func directly if the device was already
> > > resumed, without going through the workqueue?
> > 
> > Maybe it isn't good, the 'func' might not be run in the current context
> > (irq context or some spinlock is held).
> 
> Then I'd say don't use this interface.  If you have code that needs to
> be run in a different context, then you have to use a work item (or
> equivalent) anyway and you can do a synchronous runtime resume from there.

That wasn't what he meant.  What if the code needs to run in the _same_
context as the caller?  For example, with a spinlock held.  func would
need to know whether it should acquire the lock, which means it needs
to know whether it was called directly or through the workqueue.

I suppose we could pass it an extra argument with this information...  
but that's a little ugly.

Alan Stern

