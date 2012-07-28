Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:33296 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087Ab2G1UUz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 28 Jul 2012 16:20:55 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB hotplug failure
Date: Sat, 28 Jul 2012 22:26:40 +0200
Cc: Huang Ying <ying.huang@intel.com>,
	=?iso-8859-1?q?Bj=F8rn_Mork?= <bjorn@mork.no>,
	huang ying <huang.ying.caritas@gmail.com>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org
References: <Pine.LNX.4.44L0.1207281208050.23545-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1207281208050.23545-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201207282226.40306.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, July 28, 2012, Alan Stern wrote:
> On Fri, 27 Jul 2012, Rafael J. Wysocki wrote:
> 
> > > > > > +	if (parent)
> > > > > > +		pm_runtime_put(parent);
> > > > > 
> > > > > You should use pm_runtime_put_sync(), not pm_runtime_put().
> > > > 
> > > > Hmm, why exactly?
> > > 
> > > Because it's more efficient to do something directly than to run it in 
> > > a workqueue.
> > 
> > Well, depends.  If that results in a power off (the parent goes into
> > D3 for example), we may wait as long as 10 ms for that to complete.
> 
> True, but so what?  You'd also have to wait 10 ms for the workqueue
> item to complete if pm_runtime_put() was used,

Are you sure?  pm_runtime_put() leads to rpm_idle() with the RPM_ASYNC
flag set, which causes it to queue up the work item and return immediately
without waiting.  Why exactly do you think I'd need to wait, then?

> plus the additional overhead of scheduling the workqueue thread.
> 
> Now, if the length of time required for the probe to run were an issue 
> then yes, the synchronous routine could make things take longer.  But 
> probing is generally done asynchronously anyway, right?  And usually 
> what matters is the time before the device becomes available, not the 
> time for the probe to run.

Still, I see no reason to wait synchronously for the _parent_ to suspend.

Thanks,
Rafael
