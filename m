Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbeHOVnt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Aug 2018 17:43:49 -0400
Date: Wed, 15 Aug 2018 13:50:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hari Vyas <hari.vyas@broadcom.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, ray.jui@broadcom.com
Subject: Re: PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
 happening due to race condition)
Message-ID: <20180815185027.GE28888@bhelgaas-glaptop.roam.corp.google.com>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 15, 2018 at 01:35:16PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2018-07-31 at 11:37 -0500, Bjorn Helgaas wrote:
> > On Tue, Jul 03, 2018 at 02:35:40PM +0530, Hari Vyas wrote:
> > > Changes in v3:
> > > 	As per review comments from Lukas Wunner <lukas@wunner.de>,
> > > 	squashed 3 commits to single commit. Without this build breaks.
> > > 	Also clubbed set and clear function for is_added bits to a
> > > 	single assign function. This optimizes code and reduce LoC.
> > > 	Removed one wrongly added blank line in pci.c
> > > 	 
> > > Changes in v2:
> > >         To avoid race condition while updating is_added and is_busmaster
> > >         bits, is_added is moved to a private flag variable.
> > >         is_added updation is handled in atomic manner also.
> > > 
> > > Hari Vyas (1):
> > >   PCI: Data corruption happening due to race condition
> 
> Sooo .... I was chasing a different problem which makes me think we
> have a deeper problem here.
> 
> In my case, I have a system with >70 nvme devices behind layers of
> switches.
> 
> What I think is happening is all the nvme devices are probed in
> parallel (the machine has about 40 CPU cores).
> 
> They all call pci_enable_device() around the same time.
> 
> This will walk up the bridge/switch chain and try to enable every
> switch along the way. However there is *no* locking at the switch level
> at all that I can see. Or am I missing something subtle ?
> 
> So here's an example simplified scenario:
> 
> 	Bridge
> 	/    \
>      dev A   dev B
> 
> Both dev A and B hit pci_enable_device() simultaneously, thus both
> call pci_enable_bridge() at the same time: This does (simplified):
> 
> 	if (pci_is_enabled(dev)) {
> 		if (!dev->is_busmaster)
> 			pci_set_master(dev);
> 		return;
> 	}
> 
> 	retval = pci_enable_device(dev);
> 	if (retval)
> 		pci_err(dev, "Error enabling bridge (%d), continuing\n",
> 			retval);
> 	pci_set_master(dev);
> 
> Now the pci_is_enabled() just checks dev->enable_cnt and pci_enable_device()
> increments it *before* enabling the device.
> 
> So it's possible that pci_is_enabled() returns true for the bridge for dev B
> because dev A just did the atomic_inc_return(), but hasn't actually enabled
> the bridge yet (hasnt yet hit the config space).
> 
> At that point, driver for dev B hits an MMIO and gets an UR response from
> the bridge.
> 
> I need to setup a rig to verify my theory but I think this is racy. The same
> race is also present with dev->is_busmaster. Using bitmaps won't help.
> 
> What's really needed is a per device mutex covering all those operations
> on a given device. (This would also allow to get rid of those games with
> atomics).

Yes, this is definitely broken.  Some folks have tried to fix it in
the past, but it hasn't quite happened yet.  We actually merged one
patch, 40f11adc7cd9 ("PCI: Avoid race while enabling upstream
bridges"), but had to revert it after we found issues:

https://lkml.kernel.org/r/1501858648-22228-1-git-send-email-srinath.mannam@broadcom.com
https://lkml.kernel.org/r/20170915072352.10453.31977.stgit@bhelgaas-glaptop.roam.corp.google.com
