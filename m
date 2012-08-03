Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:55574 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753052Ab2HCO2N (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Aug 2012 10:28:13 -0400
Date: Fri, 3 Aug 2012 10:28:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Ming Lei <tom.leiming@gmail.com>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, <linux-pci@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
In-Reply-To: <CACVXFVOdwNiSkF1_Bs-FY-PT4gqZ86j6pcr4A=Yckc0bxykgRQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1208031020060.1520-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 3 Aug 2012, Ming Lei wrote:

> On Fri, Aug 3, 2012 at 10:20 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Thu, 2 Aug 2012, Rafael J. Wysocki wrote:
> 
> > Hmmm.  You'd probably want a version that does a "get" at the same
> > time.  I suppose you would call func directly if the device was already
> > resumed, without going through the workqueue?
> 
> Maybe it isn't good, the 'func' might not be run in the current context
> (irq context or some spinlock is held).

True.  But we don't want to wait for the workqueue if the device is 
already at full power.  Suggestions?

> >> And what if you are a parent waited for by a child to resume so that _it_
> >> can process its data?  Would you still want to process your data in the
> >> resume callback in that case?
> 
> Looks the child is always resumed after its parent completes the resuming,
> and current pm_runtime_get doesn't delay the resume of the parent, and
> just make the .runtime_resume run in another context.

I don't understand.  Rafael's point was that if the parent's resume
callback did a bunch of real work, it would delay resuming the child 
because the child can't be resumed until the parent's resume callback 
returns.

> Also are there actual examples about the above situation?

I don't know of any.  I suspect there aren't many examples.  It 
wouldn't make much sense.

> IMO, the .runtime_resume callback can handle the IO things easily
> via scheduling worker function if the driver don't want to delay
> its children's resume.

That was one of Rafael's other suggestions.  But calling 
pm_request_resume_and_call() is easier than scheduling a worker 
function.

Alan Stern


