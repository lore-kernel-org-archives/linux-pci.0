Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbdBSAQK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Feb 2017 19:16:10 -0500
Date: Sat, 18 Feb 2017 18:16:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Andreas Noever <andreas.noever@gmail.com>,
        linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Erik Veijola <erik.veijola@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v6 3/8] PCI: pciehp: Reinstate runtime PM on Thunderbolt
 hotplug ports
Message-ID: <20170219001606.GA7668@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1486913733.git.lukas@wunner.de>
 <14ffd1ceeb76200b34e0abfebab134545e504bdc.1486913733.git.lukas@wunner.de>
 <20170214225926.GB19040@bhelgaas-glaptop.roam.corp.google.com>
 <20170218092516.GB1335@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170218092516.GB1335@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 18, 2017 at 10:25:16AM +0100, Lukas Wunner wrote:
> On Tue, Feb 14, 2017 at 04:59:26PM -0600, Bjorn Helgaas wrote:
> > On Sun, Feb 12, 2017 at 05:07:45PM +0100, Lukas Wunner wrote:
> > > Commit 68db9bc81436 ("PCI: pciehp: Add runtime PM support for PCIe
> > > hotplug ports") extended runtime PM for PCIe ports to hotplug ports.
> > > However Yinghai Lu reported the following breakage caused by the commit:
> > > 
> > > * After disabling a slot on one of his servers, the slot signals PME
> > >   which causes pciehp to immediately re-enable the card, thus defeating
> > >   manual slot control via sysfs.
> > 
> > I don't think we've clearly established this.  It surprises me that a
> > Downstream Port would signal PME after turning off power to the slot.
> > Wouldn't that make PME useless?
> > 
> > I'd like to look at this in a little more detail, either by turning
> > off PM and pciehp and poking things manually with setpci, or possibly
> > by adding some debug output in the PME ISR and the pciehp ISR and
> > "write command" paths.
> 
> I'm in the To: header of your e-mail but I am not in a position to
> debug this as I don't have the hardware available.  It would have
> to be done by Yinghai Lu or Intel.  This may already be clear to
> everyone involved, so apologies for stating the obvious.

It is clear; I was just hoping you would make it as easy as possible
for the folks with the hardware by proposing a debugging patch or a
series of specific setpci commands to run.

> Also, I hope it's clear that these Intel servers are not affected
> by v6 of this patch as it only enables runtime PM on *Thunderbolt*
> hotplug ports.

Right.  I just don't understand what's happening, and I don't want
this to become folk wisdom before we have more details.

> > > * On another server which has a Power Controller for PCIe hotplug ports
> > >   (PCIe r3.1, sec 6.7.1.8), the slot cannot be re-enabled after manually
> > >   disabling it via sysfs since commit 68db9bc81436 acquired a runtime
> > >   ref only *after* enabling power on the slot, yet this particular
> > >   SkyLake server requires that the port is in D0 when enabling power.
> > 
> > So this server requires that the Downstream Port must be in D0 before
> > we turn on power to the slot below the Downstream Port?
> 
> Apparently.
> 
> > That seems like it would be a requirement for *all* systems.
> 
> Well, it's not mandated by the spec but indeed seems like a good idea.
> Please note that the present patch does exactly that.

A bridge in D3hot still accepts config cycles, so we should be able to
use Slot Control to turn slot power for its secondary bus on or off.

PCI PM r1.1, Table 16, says the only action we can expect from the
bridge is PME, so we can't rely on interrupts for Command Completion,
Link State Changed, etc.  Unless we wanted to manage the hotplug
controller by polling it, I think we have to put the bridge in D0
before sending any commands to it.

This seems like something that could be split into a separate patch
that wouldn't have anything to do with Thunderbolt.  Would that make
sense to you?

Bjorn
