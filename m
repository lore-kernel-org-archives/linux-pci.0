Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34671 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752415Ab2G0TjU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jul 2012 15:39:20 -0400
Date: Fri, 27 Jul 2012 15:39:19 -0400 (EDT)
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
In-Reply-To: <201207272111.29289.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1207271537220.2116-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 27 Jul 2012, Rafael J. Wysocki wrote:

> On Friday, July 27, 2012, Alan Stern wrote:
> > On Fri, 27 Jul 2012, Huang Ying wrote:
> > 
> > > --- a/drivers/pci/pci-driver.c
> > > +++ b/drivers/pci/pci-driver.c
> > > @@ -280,8 +280,12 @@ static long local_pci_probe(void *_ddi)
> > >  {
> > >  	struct drv_dev_and_id *ddi = _ddi;
> > >  	struct device *dev = &ddi->dev->dev;
> > > +	struct device *parent = dev->parent;
> > >  	int rc;
> > >  
> > > +	/* The parent bridge must be in active state when probing */
> > > +	if (parent)
> > > +		pm_runtime_get_sync(parent);
> > 
> > Ooh, this is a very good point.  I completely missed it.
> > 
> > >  	/* Unbound PCI devices are always set to disabled and suspended.
> > >  	 * During probe, the device is set to enabled and active and the
> > >  	 * usage count is incremented.  If the driver supports runtime PM,
> > > @@ -298,6 +302,8 @@ static long local_pci_probe(void *_ddi)
> > >  		pm_runtime_set_suspended(dev);
> > >  		pm_runtime_put_noidle(dev);
> > >  	}
> > > +	if (parent)
> > > +		pm_runtime_put(parent);
> > 
> > You should use pm_runtime_put_sync(), not pm_runtime_put().
> 
> Hmm, why exactly?

Because it's more efficient to do something directly than to run it in 
a workqueue.

Alan Stern

