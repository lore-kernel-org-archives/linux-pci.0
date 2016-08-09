Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56380 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932460AbcHINo6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Aug 2016 09:44:58 -0400
Date: Tue, 9 Aug 2016 08:44:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Benedikt Spranger <b.spranger@linutronix.de>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: x86/PCI: Scan all functions during probing
Message-ID: <20160809134452.GA27301@localhost>
References: <alpine.DEB.2.20.1608091318530.5388@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1608091318530.5388@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lukas]

On Tue, Aug 09, 2016 at 01:22:30PM +0200, Thomas Gleixner wrote:
> From: Benedikt Spranger <b.spranger@linutronix.de>
> 
> PCI and PCIBIOS probing only scans devices at function number 0/8/16/...
> Subdevices (e.g. multiqueue) have function numbers which are not a
> multiple of 8.
> 
> Simple hypervisors (e.g. Jailhouse) pass subdevices directly w/o providing
> virtual PCI mappings like KVM. As a consequence a simple PCI passthrough from
> Jailhouse to a linux guest is not able to detect such devices.
> 
> Changing the probe functions to scan all function numbers makes it work. This
> has no side effects and there is no reason to force the 0/8/16... probing
> scheme.

"devfn" here is a 8-bit field (5 bits of device number and 3 bits of
function number), so incrementing by 8 is really a way of looking at
function 0 of each device number.  I'm pretty sure this is based on
something in the spec that says a multi-function device must implement
function 0.  Please look that up and include a reference in the
changelog so we have a more complete story here.

It's possible there are other assumptions in the code about
multi-function devices always having a function 0.  It would take a
little more research to be certain that this wouldn't break anything.

As Lukas pointed out, it does increase the number of probe attempts by
a factor of 8.  I don't know how much that will affect boot time, but
it's certainly something to consider and hopefully quantify.

> Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/pci/legacy.c |    2 +-
>  drivers/pci/probe.c   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/pci/legacy.c
> +++ b/arch/x86/pci/legacy.c
> @@ -42,7 +42,7 @@ void pcibios_scan_specific_bus(int busn)
>  	if (pci_find_bus(0, busn))
>  		return;
>  
> -	for (devfn = 0; devfn < 256; devfn += 8) {
> +	for (devfn = 0; devfn < 256; devfn++) {
>  		if (!raw_pci_read(0, busn, devfn, PCI_VENDOR_ID, 2, &l) &&
>  		    l != 0x0000 && l != 0xffff) {
>  			DBG("Found device at %02x:%02x [%04x]\n", busn, devfn, l);
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2063,7 +2063,7 @@ unsigned int pci_scan_child_bus(struct p
>  	dev_dbg(&bus->dev, "scanning bus\n");
>  
>  	/* Go find them, Rover! */
> -	for (devfn = 0; devfn < 0x100; devfn += 8)
> +	for (devfn = 0; devfn < 0x100; devfn++)
>  		pci_scan_slot(bus, devfn);
>  
>  	/* Reserve buses for SR-IOV capability. */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
