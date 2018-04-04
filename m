Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:59451 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeDDIiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Apr 2018 04:38:05 -0400
Date: Wed, 4 Apr 2018 10:38:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCHv2 2/7] PCI/DPC: Fix PCI legacy interrupt acknowledgement
Message-ID: <20180404083803.GA32642@wunner.de>
References: <20180402162203.3370-1-keith.busch@intel.com>
 <20180402162203.3370-3-keith.busch@intel.com>
 <20180403203847.GO9322@bhelgaas-glaptop.roam.corp.google.com>
 <20180403230405.GP9322@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.21.1804041002550.2056@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.21.1804041002550.2056@nanos.tec.linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 04, 2018 at 10:13:32AM +0200, Thomas Gleixner wrote:
> On Tue, 3 Apr 2018, Bjorn Helgaas wrote:
> > On Tue, Apr 03, 2018 at 03:38:47PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Apr 02, 2018 at 10:21:58AM -0600, Keith Busch wrote:
> > > > From: Oza Pawandeep <poza@codeaurora.org>
> > > > 
> > > > The DPC driver was acknowledging the DPC interrupt status in deferred
> > > > work. That works for edge triggered interrupts, but causes an interrupt
> > > > storm with level triggered legacy interrupts.
> 
> The problem is homebrewn in the driver. So, yes it needs to mask the
> interrupt before returning from the irq handler if the rest of the magic is
> done in a worker.

If the IRQ is shared, the other handlers are starved for a brief
period of time between the IRQ being masked in the handler and
unmasked in the worker.

What is the recommended way to handle this?

I'm asking because I'm working on patches to runtime suspend
pciehp hotplug ports to D3hot.  The first few Thunderbolt
controllers that came to market had broken MSI signalling
and are thus using INTx.  If a hotplug port is signaling an
interrupt while its parent(s) are in D3hot, its config space
is inaccessible for the IRQ handler, so the parent(s) have to
be resumed to D0 first.  This takes too long to be done in an
IRQ handler and I believe can also sleep, so it's done by a worker.

Now the problem is, INTx interrupts may be shared by multiple
devices, and they *are* on my machine.  The conundrum I'm
facing is to mask the IRQ and starve all the other handlers
while the device is woken, or not mask it but risk getting
lots of spurious interrupts.

For now I've gone with the latter approach, so I leave the
IRQ unmasked and return IRQ_NONE because I don't know yet if
the IRQ originated from this particular hotplug port or from
something else.  Now if I check /proc/interrupts, I can see
that about 5000 spurious interrupts were accumulated until
the hotplug port's parents were woken and the interrupt could
finally be handled.

Is there a better way to deal with this?

Just so you get an idea what I'm talking about, this is
/proc/interrupts on a MacBookPro9,1 with a daisy-chain of two
Light Ridge Thunderbolt controllers and one Port Ridge (all
with broken MSI signaling):

  16:  IO-APIC  16-fasteoi  pciehp
  17:  IO-APIC  17-fasteoi  pciehp, pciehp, pciehp, mmc0, snd_hda_intel, b43
  18:  IO-APIC  18-fasteoi  pciehp, pciehp, i801_smbus
  19:  IO-APIC  19-fasteoi  pciehp

Thanks!

Lukas
