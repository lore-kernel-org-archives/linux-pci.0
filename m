Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:33781 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367Ab2G2TMy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 29 Jul 2012 15:12:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB hotplug failure
Date: Sun, 29 Jul 2012 21:18:42 +0200
Cc: Huang Ying <ying.huang@intel.com>,
	=?iso-8859-1?q?Bj=F8rn_Mork?= <bjorn@mork.no>,
	huang ying <huang.ying.caritas@gmail.com>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org
References: <Pine.LNX.4.44L0.1207291051310.18141-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1207291051310.18141-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201207292118.42547.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday, July 29, 2012, Alan Stern wrote:
> On Sun, 29 Jul 2012, Rafael J. Wysocki wrote:
> 
> > The difference is, if you use _put_sync(), you need to wait the extra 10 ms
> > for local_pci_probe() to return (if the parent is actually suspended),
> > although you might not need to wait for it if you used _put(), right?
> 
> Yes, that's the difference.  But who waits for local_pci_probe() to 
> return?  :-)

pci_register_driver() might, but that's not a big deal.  Hot-plug might
as well, though.

> > Which, to me, means that using _put_sync() may not be always better.
> > It probably doesn't matter a lot, but then the workqueue overhead shouldn't
> > matter a lot either.
> 
> It's that in the end, the extra overhead is pretty small.  For me
> there's also an issue of style: If you do a synchronous get then it
> looks odd not to do a synchronous put.  My feeling has always been that
> the async routines are for use in non-process contexts, where the sync
> routines can't be used.  Using them just to return a little more
> quickly is a foreign idea.

I see. :-)

The reason for using sync get is quite obvious: we want to be able to access
the device later on.  For sync put that's not so clear, though. There are cases
when we definitely want to do it, like the failing .probe() in which we want to
disable runtime PM next to the put, but usually it doesn't hurt (too much) to
defer it IMO.

Thanks,
Rafael
