Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:60830 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752431Ab2G0Tse (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 27 Jul 2012 15:48:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB hotplug failure
Date: Fri, 27 Jul 2012 21:54:20 +0200
Cc: Huang Ying <ying.huang@intel.com>,
	=?iso-8859-1?q?Bj=F8rn_Mork?= <bjorn@mork.no>,
	huang ying <huang.ying.caritas@gmail.com>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org
References: <Pine.LNX.4.44L0.1207271537220.2116-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1207271537220.2116-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201207272154.20717.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 27, 2012, Alan Stern wrote:
> On Fri, 27 Jul 2012, Rafael J. Wysocki wrote:
> 
> > On Friday, July 27, 2012, Alan Stern wrote:
> > > On Fri, 27 Jul 2012, Huang Ying wrote:
> > > 
> > > > --- a/drivers/pci/pci-driver.c
> > > > +++ b/drivers/pci/pci-driver.c
> > > > @@ -280,8 +280,12 @@ static long local_pci_probe(void *_ddi)
> > > >  {
> > > >  	struct drv_dev_and_id *ddi = _ddi;
> > > >  	struct device *dev = &ddi->dev->dev;
> > > > +	struct device *parent = dev->parent;
> > > >  	int rc;
> > > >  
> > > > +	/* The parent bridge must be in active state when probing */
> > > > +	if (parent)
> > > > +		pm_runtime_get_sync(parent);
> > > 
> > > Ooh, this is a very good point.  I completely missed it.
> > > 
> > > >  	/* Unbound PCI devices are always set to disabled and suspended.
> > > >  	 * During probe, the device is set to enabled and active and the
> > > >  	 * usage count is incremented.  If the driver supports runtime PM,
> > > > @@ -298,6 +302,8 @@ static long local_pci_probe(void *_ddi)
> > > >  		pm_runtime_set_suspended(dev);
> > > >  		pm_runtime_put_noidle(dev);
> > > >  	}
> > > > +	if (parent)
> > > > +		pm_runtime_put(parent);
> > > 
> > > You should use pm_runtime_put_sync(), not pm_runtime_put().
> > 
> > Hmm, why exactly?
> 
> Because it's more efficient to do something directly than to run it in 
> a workqueue.

Well, depends.  If that results in a power off (the parent goes into
D3 for example), we may wait as long as 10 ms for that to complete.

Thanks,
Rafael
