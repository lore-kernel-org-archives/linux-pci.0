Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:33574 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106Ab2G2NuD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 29 Jul 2012 09:50:03 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB hotplug failure
Date: Sun, 29 Jul 2012 15:55:52 +0200
Cc: Huang Ying <ying.huang@intel.com>,
	=?iso-8859-1?q?Bj=F8rn_Mork?= <bjorn@mork.no>,
	huang ying <huang.ying.caritas@gmail.com>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org
References: <Pine.LNX.4.44L0.1207281708000.30227-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1207281708000.30227-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201207291555.52749.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, July 28, 2012, Alan Stern wrote:
> On Sat, 28 Jul 2012, Rafael J. Wysocki wrote:
> 
> > On Saturday, July 28, 2012, Alan Stern wrote:
> > > On Fri, 27 Jul 2012, Rafael J. Wysocki wrote:
> > > 
> > > > > > > > +	if (parent)
> > > > > > > > +		pm_runtime_put(parent);
> > > > > > > 
> > > > > > > You should use pm_runtime_put_sync(), not pm_runtime_put().
> > > > > > 
> > > > > > Hmm, why exactly?
> > > > > 
> > > > > Because it's more efficient to do something directly than to run it in 
> > > > > a workqueue.
> > > > 
> > > > Well, depends.  If that results in a power off (the parent goes into
> > > > D3 for example), we may wait as long as 10 ms for that to complete.
> > > 
> > > True, but so what?  You'd also have to wait 10 ms for the workqueue
> > > item to complete if pm_runtime_put() was used,
> > 
> > Are you sure?  pm_runtime_put() leads to rpm_idle() with the RPM_ASYNC
> > flag set, which causes it to queue up the work item and return immediately
> > without waiting.  Why exactly do you think I'd need to wait, then?
> 
> What I mean is, it takes 10 ms for the parent to suspend regardless of
> whether or not you use the _sync form of the call.  If you're waiting
> for the parent to suspend, you would therefore have to wait 10 ms in
> either case.
> 
> Likewise, if you're waiting for the PCI device to become usable then
> you don't have to wait for 10 ms, because you can use it as soon as the
> probe routine returns.

The difference is, if you use _put_sync(), you need to wait the extra 10 ms
for local_pci_probe() to return (if the parent is actually suspended),
although you might not need to wait for it if you used _put(), right?

Which, to me, means that using _put_sync() may not be always better.
It probably doesn't matter a lot, but then the workqueue overhead shouldn't
matter a lot either.

Thanks,
Rafael
