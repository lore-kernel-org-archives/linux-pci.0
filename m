Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754816AbcHSBVk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Aug 2016 21:21:40 -0400
Date: Thu, 18 Aug 2016 15:33:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Benedikt Spranger <b.spranger@linutronix.de>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: x86/PCI: Scan all functions during probing
Message-ID: <20160818203348.GK27353@localhost>
References: <alpine.DEB.2.20.1608091318530.5388@nanos>
 <20160809134452.GA27301@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160809134452.GA27301@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 09, 2016 at 08:44:53AM -0500, Bjorn Helgaas wrote:
> [+cc Lukas]
> 
> On Tue, Aug 09, 2016 at 01:22:30PM +0200, Thomas Gleixner wrote:
> > From: Benedikt Spranger <b.spranger@linutronix.de>
> > 
> > PCI and PCIBIOS probing only scans devices at function number 0/8/16/...
> > Subdevices (e.g. multiqueue) have function numbers which are not a
> > multiple of 8.
> > 
> > Simple hypervisors (e.g. Jailhouse) pass subdevices directly w/o providing
> > virtual PCI mappings like KVM. As a consequence a simple PCI passthrough from
> > Jailhouse to a linux guest is not able to detect such devices.
> > 
> > Changing the probe functions to scan all function numbers makes it work. This
> > has no side effects and there is no reason to force the 0/8/16... probing
> > scheme.
> 
> "devfn" here is a 8-bit field (5 bits of device number and 3 bits of
> function number), so incrementing by 8 is really a way of looking at
> function 0 of each device number.  I'm pretty sure this is based on
> something in the spec that says a multi-function device must implement
> function 0.  Please look that up and include a reference in the
> changelog so we have a more complete story here.
> 
> It's possible there are other assumptions in the code about
> multi-function devices always having a function 0.  It would take a
> little more research to be certain that this wouldn't break anything.
> 
> As Lukas pointed out, it does increase the number of probe attempts by
> a factor of 8.  I don't know how much that will affect boot time, but
> it's certainly something to consider and hopefully quantify.

Any comments on this?  I'm waiting for at least the spec reference
and hopefully some warm fuzzies about boot time and safety.

I looked up the spec: PCI (not PCIe) r3.0, sec 3.2.2.3.4, says:

  A single-function device may optionally respond to all function
  numbers as the same function or may ... respond only to function 0
  and not respond to the other function numbers.

I'm concerned that a single-function device that responds to all
function numbers might break with this patch.

  [multi-function devices] are also required to always implement
  function 0 in the device.

Here's the reason we can advance by 8 in the "Go find them" loop.

  If a single function device is detected (i.e., bit 7 in the Header
  Type register of function 0 is 0), no more functions for that Device
  Number will be checked.  If a multi-function device is detected
  (i.e., bit 7 in the Header Type register of function 0 is 1), then
  all remaining Function Numbers will be checked.

This patch does the opposite of what the first sentence recommends.

> > Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/x86/pci/legacy.c |    2 +-
> >  drivers/pci/probe.c   |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > --- a/arch/x86/pci/legacy.c
> > +++ b/arch/x86/pci/legacy.c
> > @@ -42,7 +42,7 @@ void pcibios_scan_specific_bus(int busn)
> >  	if (pci_find_bus(0, busn))
> >  		return;
> >  
> > -	for (devfn = 0; devfn < 256; devfn += 8) {
> > +	for (devfn = 0; devfn < 256; devfn++) {
> >  		if (!raw_pci_read(0, busn, devfn, PCI_VENDOR_ID, 2, &l) &&
> >  		    l != 0x0000 && l != 0xffff) {
> >  			DBG("Found device at %02x:%02x [%04x]\n", busn, devfn, l);
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2063,7 +2063,7 @@ unsigned int pci_scan_child_bus(struct p
> >  	dev_dbg(&bus->dev, "scanning bus\n");
> >  
> >  	/* Go find them, Rover! */
> > -	for (devfn = 0; devfn < 0x100; devfn += 8)
> > +	for (devfn = 0; devfn < 0x100; devfn++)
> >  		pci_scan_slot(bus, devfn);
> >  
> >  	/* Reserve buses for SR-IOV capability. */
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
