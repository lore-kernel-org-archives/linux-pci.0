Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:37221 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447Ab2GaUZe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 31 Jul 2012 16:25:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Tue, 31 Jul 2012 22:31:19 +0200
Cc: Huang Ying <ying.huang@intel.com>,
	=?iso-8859-1?q?Bj=F8rn_Mork?= <bjorn@mork.no>,
	huang ying <huang.ying.caritas@gmail.com>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
References: <Pine.LNX.4.44L0.1207291051310.18141-100000@netrider.rowland.org> <201207292118.42547.rjw@sisk.pl>
In-Reply-To: <201207292118.42547.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201207312231.19505.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday, July 29, 2012, Rafael J. Wysocki wrote:
> On Sunday, July 29, 2012, Alan Stern wrote:
> > On Sun, 29 Jul 2012, Rafael J. Wysocki wrote:
> > 
> > > The difference is, if you use _put_sync(), you need to wait the extra 10 ms
> > > for local_pci_probe() to return (if the parent is actually suspended),
> > > although you might not need to wait for it if you used _put(), right?
> > 
> > Yes, that's the difference.  But who waits for local_pci_probe() to 
> > return?  :-)
> 
> pci_register_driver() might, but that's not a big deal.  Hot-plug might
> as well, though.
> 
> > > Which, to me, means that using _put_sync() may not be always better.
> > > It probably doesn't matter a lot, but then the workqueue overhead shouldn't
> > > matter a lot either.
> > 
> > It's that in the end, the extra overhead is pretty small.  For me
> > there's also an issue of style: If you do a synchronous get then it
> > looks odd not to do a synchronous put.  My feeling has always been that
> > the async routines are for use in non-process contexts, where the sync
> > routines can't be used.  Using them just to return a little more
> > quickly is a foreign idea.
> 
> I see. :-)
> 
> The reason for using sync get is quite obvious: we want to be able to access
> the device later on.  For sync put that's not so clear, though. There are cases
> when we definitely want to do it, like the failing .probe() in which we want to
> disable runtime PM next to the put, but usually it doesn't hurt (too much) to
> defer it IMO.

Now it occured to me that perhaps we don't need the current asynchronous
pm_runtime_get() at all.  The usefulness of it is quite questionable, because
either we want to resume the device immediately, for which pm_runtime_get_sync()
should be used, or we just want to bump up the usage counter, in which cases
pm_runtime_get_noresume() should always be sufficient.  I fail to see any
particularly compelling use case for pm_runtime_get() doing an asynchronous
resume at the moment, but perhaps that's just me.

However, I receive reports of people using pm_runtime_get() where they really
should use pm_runtime_get_sync(), so I wonder if we can simply rename
pm_runtime_get_sync() as pm_runtime_get() and drop the asynchronous version
altogether?

Rafael
