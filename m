Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:35095 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757365AbcJYF1y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2016 01:27:54 -0400
Date: Tue, 25 Oct 2016 07:28:32 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 6/9] PCI: Unfold conditions to block runtime PM on PCIe
 ports
Message-ID: <20161025052832.GA5630@wunner.de>
References: <cover.1476875113.git.lukas@wunner.de>
 <ba2f9f322b4aeea1aeb01f98a2eda8efe055494f.1476875113.git.lukas@wunner.de>
 <20161020141810.GM24289@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161020141810.GM24289@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 20, 2016 at 05:18:10PM +0300, Mika Westerberg wrote:
> On Wed, Oct 19, 2016 at 04:07:13PM +0200, Lukas Wunner wrote:
> > The conditions to block D3 on parent ports are currently condensed into
> > a single expression in pci_dev_check_d3cold().  Upcoming commits will
> > add further conditions for hotplug ports, making this expression fairly
> > large and impenetrable.  Unfold the conditions to maintain readability
> > when they are amended.
> > 
> > No functional change intended.
> 
> This actually results a functional change because now all the conditions
> are evaluated whereas previosly it bailed out immediately when the
> condition was true ;-)

You're right. That's a step backward, good catch.

I've reworked this commit to restore the old behaviour and will respin
after some more testing and comparing disassembler output.

Thanks!

Lukas

> 
> Not that it matters here.
> 
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> >  drivers/pci/pci.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index a19056e..f1ddb6b 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2270,19 +2270,20 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> >  static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
> >  {
> >  	bool *d3cold_ok = data;
> > -	bool no_d3cold;
> >  
> > -	/*
> > -	 * The device needs to be allowed to go D3cold and if it is wake
> > -	 * capable to do so from D3cold.
> > -	 */
> > -	no_d3cold = dev->no_d3cold || !dev->d3cold_allowed ||
> > -		(device_may_wakeup(&dev->dev) && !pci_pme_capable(dev, PCI_D3cold)) ||
> > -		!pci_power_manageable(dev);
> > +	/* The device needs to be allowed to go D3cold. */
> > +	if (dev->no_d3cold || !dev->d3cold_allowed)
> > +		*d3cold_ok = false;
> > +
> > +	/* If it is wakeup capable it must be able to do so from D3cold. */
> > +	if (device_may_wakeup(&dev->dev) && !pci_pme_capable(dev, PCI_D3cold))
> > +		*d3cold_ok = false;
> >  
> > -	*d3cold_ok = !no_d3cold;
> > +	/* If it is a bridge it must be allowed to go to D3. */
> > +	if (!pci_power_manageable(dev))
> > +		*d3cold_ok = false;
> >  
> > -	return no_d3cold;
> > +	return !*d3cold_ok;
> >  }
> >  
> >  /*
> > -- 
> > 2.9.3
