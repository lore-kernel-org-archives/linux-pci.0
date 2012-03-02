Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52908 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab2CBUxX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 2 Mar 2012 15:53:23 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PCI / PM: Disable wakeup during shutdown for devices not enabled to wake up
Date: Fri, 2 Mar 2012 21:57:26 +0100
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux PM list <linux-pm@vger.kernel.org>,
	linux-pci@vger.kernel.org
References: <Pine.LNX.4.44L0.1203021302460.8942-100000@netrider.rowland.org> <201203022149.27595.rjw@sisk.pl>
In-Reply-To: <201203022149.27595.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201203022157.27093.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, March 02, 2012, Rafael J. Wysocki wrote:
> On Friday, March 02, 2012, Alan Stern wrote:
> > On Fri, 2 Mar 2012, Jesse Barnes wrote:
> > 
> > > On Fri, 2 Mar 2012 15:44:27 +0100
> > > Francois Romieu <romieu@fr.zoreil.com> wrote:
> > > 
> > > > Rafael J. Wysocki <rjw@sisk.pl> :
> > > > [...]
> > > > > If a PCI device is enabled to generate wakeup signals (PME) when put
> > > > > into a low-power state by runtime PM, it will be still enabled to
> > > > > generate those signals after the system shutdown, unless its driver's
> > > > > .shutdown() callback takes care of the wakeup signals generation
> > > > > setting.  Moreover, there are devices that are not enabled to wake
> > > > > up the system and that are configured by runtime PM to generate
> > > > > wakeup signals so that (runtime) remote wakeup works with them.
> > > > > Those devices should be reconfigured during system shutdown so that
> > > > > they don't generate wakeup signals, but at least some drivers don't
> > > > > do that.  However, that very well may be done by the PCI core so
> > > > > that drivers don't have to worry about it.  For this reason, modify
> > > > > pci_device_shutdown() to disable the generation of wakeup events for
> > > > > devices not supposed to wake up the system.
> > > > 
> > > > On a tangent side, if register writes are ignored by the PCI device
> > > > after its .runtime_suspend() handler has been called, whose
> > > > responsibility is it to bring back the device in a state from where
> > > > the .shutdown() callback can operate ?
> > > > 
> > > > The r8169 driver exhibits this problem. Its .runtime_xyz() callbacks
> > > > are called on link activity. Thus, after a link loss - or no link at
> > > > all - .runtime_suspend() and an ineffective .shutdown(), the device is
> > > > brought back up as soon as the link recovers.
> > > > 
> > > > The device driver can monitor .runtime_{suspend / resume} activity
> > > > and take appropriate action in .shutdown(). Sameer Nanda has sent
> > > > such a patch (see below). I am not sure this is the adequate fix:
> > > > 1. the driver ought essentially to perform the hardware part of a
> > > >    .runtime_resume() on its own behalf. Mildly engaging.
> > > > 2. by the same line as above, could it make more sense to call
> > > >    pm_runtime_resume() in driver/base/core.c::device_shutdown ?
> > > 
> > > I thought there would be a more elegant way of increasing the device
> > > use count on entering .shutdown, either from the wifi core or at the
> > > driver level, so you don't have to track things with a separate flag.
> > 
> > That's right.  For example, instead of keeping its own flag to know
> > whether or not the device is runtime-suspended, the shutdown routine
> > could just always call pm_runtime_resume_sync().  Or it could ask the
> > PCI core to put the device into D0, regardless of the device's current
> > state.
> > 
> > The driver core doesn't do this because most devices don't need it, and
> > it would slow down the whole shutdown procedure if every suspended
> > device were always resumed.
> 
> For devices known to have this problem I think calling pm_runtime_resume_sync()
> unconditionally at the beginning of .suspend() would be a good approach in
> general.

Or even call pm_runtime_get_sync() at the beginning and then
pm_runtime_put_noidle() after .shutdown() has done its own stuff.  Then, you
have a guarantee that runtime PM won't interfere with the shutdown operations.

Thanks,
Rafael
