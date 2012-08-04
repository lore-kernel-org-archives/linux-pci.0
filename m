Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:50378 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753625Ab2HDUs0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 4 Aug 2012 16:48:26 -0400
Date: Sat, 4 Aug 2012 16:48:25 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Ming Lei <tom.leiming@gmail.com>, <linux-pci@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
In-Reply-To: <201208042248.24957.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1208041644240.23711-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 4 Aug 2012, Rafael J. Wysocki wrote:

> > That wasn't what he meant.  What if the code needs to run in the _same_
> > context as the caller?  For example, with a spinlock held.
> 
> I see.  I think it wouldn't be unreasonable to require that func should take
> all of the necessary locks by itself.

But then if func was called directly, because the device was at full
power, it would deadlock trying to acquire a lock the caller already
holds.

> However, I believe that if func is going to be called through the workqueue,
> the usage counter should be incremented before the preceding resume and
> decremented after func returns by the workqueue thread.

Okay.

> > func would need to know whether it should acquire the lock, which means it
> > needs to know whether it was called directly or through the workqueue.
> > 
> > I suppose we could pass it an extra argument with this information...  
> > but that's a little ugly.
> 
> I agree.  I'd prefer to avoid that, if possible.

Do you have any better suggestions?

Alan Stern

