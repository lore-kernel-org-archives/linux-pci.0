Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:41108 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752900Ab2G1VMX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Jul 2012 17:12:23 -0400
Date: Sat, 28 Jul 2012 17:12:22 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Huang Ying <ying.huang@intel.com>,
	=?iso-8859-1?q?Bj=F8rn_Mork?= <bjorn@mork.no>,
	huang ying <huang.ying.caritas@gmail.com>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB
 hotplug failure
In-Reply-To: <201207282226.40306.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1207281708000.30227-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 28 Jul 2012, Rafael J. Wysocki wrote:

> On Saturday, July 28, 2012, Alan Stern wrote:
> > On Fri, 27 Jul 2012, Rafael J. Wysocki wrote:
> > 
> > > > > > > +	if (parent)
> > > > > > > +		pm_runtime_put(parent);
> > > > > > 
> > > > > > You should use pm_runtime_put_sync(), not pm_runtime_put().
> > > > > 
> > > > > Hmm, why exactly?
> > > > 
> > > > Because it's more efficient to do something directly than to run it in 
> > > > a workqueue.
> > > 
> > > Well, depends.  If that results in a power off (the parent goes into
> > > D3 for example), we may wait as long as 10 ms for that to complete.
> > 
> > True, but so what?  You'd also have to wait 10 ms for the workqueue
> > item to complete if pm_runtime_put() was used,
> 
> Are you sure?  pm_runtime_put() leads to rpm_idle() with the RPM_ASYNC
> flag set, which causes it to queue up the work item and return immediately
> without waiting.  Why exactly do you think I'd need to wait, then?

What I mean is, it takes 10 ms for the parent to suspend regardless of
whether or not you use the _sync form of the call.  If you're waiting
for the parent to suspend, you would therefore have to wait 10 ms in
either case.

Likewise, if you're waiting for the PCI device to become usable then
you don't have to wait for 10 ms, because you can use it as soon as the
probe routine returns.

> > plus the additional overhead of scheduling the workqueue thread.
> > 
> > Now, if the length of time required for the probe to run were an issue 
> > then yes, the synchronous routine could make things take longer.  But 
> > probing is generally done asynchronously anyway, right?  And usually 
> > what matters is the time before the device becomes available, not the 
> > time for the probe to run.
> 
> Still, I see no reason to wait synchronously for the _parent_ to suspend.

Why not?  There's no penalty, particularly since most device probing 
happens asynchronously these days anyway.

Alan Stern

