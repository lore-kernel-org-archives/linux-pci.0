Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46404 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932614AbcCQNkg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Mar 2016 09:40:36 -0400
Date: Thu, 17 Mar 2016 08:40:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/6] PCI: Move PCIe ports to D3hot during suspend
Message-ID: <20160317134026.GA17069@localhost>
References: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
 <1456750566-116248-4-git-send-email-mika.westerberg@linux.intel.com>
 <20160312002039.GK4725@localhost>
 <20160314093259.GD1796@lahna.fi.intel.com>
 <20160317103154.GR1793@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160317103154.GR1793@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 17, 2016 at 12:31:54PM +0200, Mika Westerberg wrote:
> On Mon, Mar 14, 2016 at 11:32:59AM +0200, Mika Westerberg wrote:
> > > What happens if the PCIe port initially can be put in D3hot, but we we
> > > later hot-add a device that would disqualify it?
> > > 
> > > Oh, I think I see -- we walk the subordinate devices every time we
> > > would like to put the port in D3hot:
> > > 
> > >   pcie_port_suspend_noirq
> > >     pcie_port_suspend_allowed
> > >       dmi_get_date
> > >       pcie_port_can_suspend
> > >         pci_walk_bus
> > > 
> > > I guess that should work, but it seems clunky to do all that work,
> > > even though it's not really a performance path.  What if we did this:
> > > 
> > >   - add a d3hot_allowed bit in struct pci_dev
> > > 
> > >   - when enumerating a port, set d3hot_allowed if BIOS is new enough
> > >     (it makes me a bit nervous that we apparently default to enabling
> > >     D3hot on arches without DMI)
> > > 
> > >   - when enumerating devices, clear d3hot_allowed in upstream bridge
> > >     if necessary
> > > 
> > >   - when removing last device on a bus, re-do port config (set
> > >     d3hot_allowed if appropriate)
> > 
> > Sounds reasonable. I'll give it a try.
> 
> It looks like we cannot use this approach. Userspace (and drivers) can
> prevent devices from entering D3cold by changing dev->d3cold_allowed.
> That can happen after the device has been enumerated.

Well, maybe.  If we want to change d3cold_allowed after enumeration,
we could propagate that change through whatever part of the hierarchy
it affects at that time.  I'd rather have the complexity of DMI
checks, walking the bus, etc., there than in the suspend path.

Bjorn
