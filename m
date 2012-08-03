Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:55550 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753435Ab2HCOF5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Aug 2012 10:05:57 -0400
Date: Fri, 3 Aug 2012 10:05:56 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: linux-pci@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
In-Reply-To: <Pine.LNX.4.44L0.1208022151450.22991-100000@netrider.rowland.org>
Message-ID: <Pine.LNX.4.44L0.1208031001460.1520-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2 Aug 2012, Alan Stern wrote:

> On Thu, 2 Aug 2012, Rafael J. Wysocki wrote:
> 
> > > I don't know about that -- the logic involved in doing the processing 
> > > within the resume callback isn't terribly complicated.  At least, not 
> > > much more complicated than the logic involved in setting up a custom 
> > > work routine as you suggest.
> > 
> > That's why I had the idea of pm_request_resume_and_call(dev, func)
> > described in this message:
> > 
> > http://marc.info/?l=linux-usb&m=134377126804170&w=4
> > 
> > although perheps it would be better to call it something like
> > pm_runtime_async_resume_and_call(dev, func).
> 
> Hmmm.  You'd probably want a version that does a "get" at the same 
> time.  I suppose you would call func directly if the device was already 
> resumed, without going through the workqueue?
> 
> Yes, I agree this would be a better interface then pm_runtime_get.

A few problems:

What happens if a system sleep begins after 
pm_runtime_async_resume_and_call() but before the runtime resume?  When 
the system wakes up, the device will be back at full power without ever 
executing a runtime PM call.  Then how will func get invoked?

What happens if the driver is unbound after
pm_runtime_async_resume_and_call() but before the runtime resume?  The
When the runtime resume occurs, func will be invoked -- and the driver
might not even be in memory any more.

Alan Stern


