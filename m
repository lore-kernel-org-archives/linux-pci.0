Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:58865 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754032Ab2HDWNN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 4 Aug 2012 18:13:13 -0400
Date: Sat, 4 Aug 2012 18:13:11 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Ming Lei <tom.leiming@gmail.com>, <linux-pci@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
In-Reply-To: <201208042315.44031.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1208041806490.23711-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 4 Aug 2012, Rafael J. Wysocki wrote:

> On Saturday, August 04, 2012, Alan Stern wrote:
> > On Sat, 4 Aug 2012, Rafael J. Wysocki wrote:
> > 
> > > > That wasn't what he meant.  What if the code needs to run in the _same_
> > > > context as the caller?  For example, with a spinlock held.
> > > 
> > > I see.  I think it wouldn't be unreasonable to require that func should take
> > > all of the necessary locks by itself.
> > 
> > But then if func was called directly, because the device was at full
> > power, it would deadlock trying to acquire a lock the caller already
> > holds.
> 
> I wonder why the caller may want to take any locks beforehand?

Who knows?  :-)

The best answer may be for the caller not to hold any locks.  In the
runtime-PM document's example driver, the lock would be dropped before
the resume-and-call.

> > Do you have any better suggestions?
> 
> Hmm.  What about pm_runtime_get_and_call(dev, func_sync, func_async), where
> func_sync() is to be called if the device is already active and func_async()
> is to be called if it has to be resumed from the workqueue?

That's a little better but not much.  It would require storing two 
function pointers in the dev->power structure.

Alan Stern

