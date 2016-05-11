Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41312 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbcEKS25 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 May 2016 14:28:57 -0400
Date: Wed, 11 May 2016 13:28:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCHv4] pcie: Add driver for Downstream Port Containment
Message-ID: <20160511182853.GA28812@localhost>
References: <1461882288-31506-1-git-send-email-keith.busch@intel.com>
 <20160511160817.GA24089@localhost>
 <20160511170649.GA31047@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160511170649.GA31047@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 11, 2016 at 01:06:50PM -0400, Keith Busch wrote:
> On Wed, May 11, 2016 at 11:08:17AM -0500, Bjorn Helgaas wrote:
> > 
> > I know I already merged this, but I just thought of a more
> > philosophical question.  Why is this a "port service driver" as
> > opposed to being simply part of the PCI core like ARI, ACS, etc.?
> > 
> > I guess you did make DPC tristate, so from that point of view, it
> > probably has to use the driver structure to make it convenient to load
> > after boot.  Does that add value?  Do we expect people to make a
> > decision about whether to load pcie-dpc?  Or maybe we plan to autoload
> > it if the DPC capability is present?  Does your patch enable that,
> > i.e., does it expose something udev can use to autoload it?
> > 
> > I've been wondering whether the portdrv service driver concept was a
> > mistake.  With the exception of DPC, I think all the portdrv service
> > drivers are bool, so there's no question of having to load a module.
> > I think using portdrv means we delay initialization of some things
> > that we should do earlier.  For example, I think we should setup
> > pciehp much earlier, when we enumerate the bridge.  And the service
> > driver registration and capability discovery code adds a fair amount
> > of complication that I'm not sure is necessary.
> > 
> > So I guess the question is: why did you make DPC a portdrv service
> > driver, and what bad things would happen if we integrated it into the
> > PCI core without exposing it as a separate service.
> 
> Good points. I actually hadn't considered making this part of core,
> so I don't have all the pros+cons for making this a port services
> driver. Mainly, DPC seemed similar to HP and AER since it takes
> interrupts, so followed their example. The other optional extended
> capabilities you mention don't need interrupts. Since we rely on the
> port driver to initialize port's interrupt vectors, DPC has to be a port
> services driver in order to safely use these, right?

Yes, I think you're probably right about the interrupts; I hadn't
thought about that.

> I made this tristate from vendor request to allow unloading the module;
> sounded reasonable at the time, but didn't consider the implications.
> I don't think anyone tested it that way, so may have been a mistake. We
> don't have the rules for when it needs to load, so it'd have to load
> manually at which point it looks too late.

I suppose the vendor concern might be minimizing unused code in the
kernel, which makes a lot of sense, although I have to say that DPC
looks like about the smallest driver one could imagine.

A modular driver that can't be loaded automatically seems sort of
pointless since hardly anybody would actually use it.

Part of my issue with portdrv is that it exposes additional stuff in
sysfs that seems a little bit disconnected from the rest of PCI,
namely, things like this:

  /sys/bus/pci_express/devices/
  /sys/devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie01/

Having devices like that might help autoload drivers, but as far as I
can tell, only pciehp was ever supported as a modular driver (and it
can no longer be modular), so I don't think this is much of a benefit.

Lukas, I think you're considering another portdrv service driver for
Thunderbolt; do you have any thoughts on this?  Would you want your
driver to be modular?

Bjorn
