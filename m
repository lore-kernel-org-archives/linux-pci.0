Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:53288 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752507Ab2G1QNA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Jul 2012 12:13:00 -0400
Date: Sat, 28 Jul 2012 12:12:58 -0400 (EDT)
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
In-Reply-To: <201207272154.20717.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1207281208050.23545-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 27 Jul 2012, Rafael J. Wysocki wrote:

> > > > > +	if (parent)
> > > > > +		pm_runtime_put(parent);
> > > > 
> > > > You should use pm_runtime_put_sync(), not pm_runtime_put().
> > > 
> > > Hmm, why exactly?
> > 
> > Because it's more efficient to do something directly than to run it in 
> > a workqueue.
> 
> Well, depends.  If that results in a power off (the parent goes into
> D3 for example), we may wait as long as 10 ms for that to complete.

True, but so what?  You'd also have to wait 10 ms for the workqueue
item to complete if pm_runtime_put() was used, plus the additional
overhead of scheduling the workqueue thread.

Now, if the length of time required for the probe to run were an issue 
then yes, the synchronous routine could make things take longer.  But 
probing is generally done asynchronously anyway, right?  And usually 
what matters is the time before the device becomes available, not the 
time for the probe to run.

Alan Stern


