Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933976AbdBQOiH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Feb 2017 09:38:07 -0500
Date: Fri, 17 Feb 2017 08:38:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Pointers for writing a good PCIe driver
Message-ID: <20170217143803.GA10663@bhelgaas-glaptop.roam.corp.google.com>
References: <ff099b5f-efc8-bb5f-41e3-493398844cc0@free.fr>
 <05046a8a-ba9f-26f9-4c93-f657f9da6294@free.fr>
 <20170207200656.GA11659@bhelgaas-glaptop.roam.corp.google.com>
 <20170207214758.GC11659@bhelgaas-glaptop.roam.corp.google.com>
 <0f22720c-e47d-59f6-b5f7-5e40f4a1759d@free.fr>
 <20170212165033.GA31833@kroah.com>
 <0d785dab-c830-b887-d9f3-a2cd5338695c@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0d785dab-c830-b887-d9f3-a2cd5338695c@free.fr>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 17, 2017 at 10:20:20AM +0100, Mason wrote:
> On 12/02/2017 17:50, Greg KH wrote:
> > On Tue, Feb 07, 2017 at 11:56:31PM +0100, Mason wrote:
> >> On 07/02/2017 22:47, Bjorn Helgaas wrote:
> >>> On Tue, Feb 07, 2017 at 02:06:56PM -0600, Bjorn Helgaas wrote:
> >>>> On Tue, Feb 07, 2017 at 04:55:28PM +0100, Mason wrote:
> >>>>> On 06/02/2017 16:54, Mason wrote:
> >>>>>
> >>>>>> My platform ( arch/arm/mach-tango ) provides a PCIe controller from PLDA.
> >>>>>>
> >>>>>> I do have access to a driver that works for a few PCIe boards, but it's
> >>>>>> an ancient out-of-tree driver (targeting v3.4). Also, I'm not sure it
> >>>>>> follows the best-practice guidelines (e.g. it hard-codes a few
> >>>>>> work-arounds directly in drivers/pci/probe.c)
> >>>>
> >>>> Indeed, having to change drivers/pci/probe.c doesn't sound like a best
> >>>> practice :)  If you can share details of what changes you need, people
> >>>> could probably suggest other ways to do it within the generic PCI
> >>>> framework.
> >>>>
> >>>>>> If I understand correctly, while PCIe is a standard, it is not codified
> >>>>>> as much as USB (XHCI) or SATA (AHCI), which means the register layout
> >>>>>> (and possibly other things) are left up to the integrator? Which means
> >>>>>> there cannot be some kind of "generic" driver that works for a random
> >>>>>> PCIe controller?
> >>>>
> >>>> There is no standardization of registers in MMIO or I/O port space.
> >>>> The size, location, and type of those registers is configurable in a
> >>>> generic way via the BARs, of course.  But that tells you nothing about
> >>>> the *functionality* of those MMIO or I/O port registers.
> >>>>
> >>>> For config space, the first 64 bytes (the PCIe r3.0 spec calls it the
> >>>> "PCI 3.0 Compatible Configuration Space Header") are completely
> >>>> standardized.  This is where device IDs, BARs, and other generic
> >>>> registers are.
> >>>>
> >>>> PCIe devices can implement up to 4096 bytes of config space.  The
> >>>> space after the 64-byte header can contain a list of standardized
> >>>> PCI/PCIe Capabilities, non-standardized device-specific registers, or
> >>>> both.  There is a way to include device-specific registers in a
> >>>> "Vendor Defined" Capability -- that way drivers can use generic
> >>>> mechanisms to find registers so they don't have to hard-code register
> >>>> layout assumptions.
> >>>>
> >>>>>> I guess my main question is: do you have pointers on getting started
> >>>>>> writing a PCIe driver good enough for upstream?
> >>>>>>
> >>>>>> Is Documentation/PCI/PCIEBUS-HOWTO.txt still a relevant resource?
> >>>>
> >>>> PCIEBUS-HOWTO.txt is still relevant, but only to drivers for services
> >>>> of PCIe ports, e.g., hotplug, error reporting, etc.  It's not relevant
> >>>> to PCIe endpoint drivers.
> >>>>
> >>>>>> Are there good resources to get up to speed on the PCIe terminology?
> >>>>>
> >>>>> I'm also wondering: in many Linux subsystems, there are often
> >>>>> several drivers of different quality; some are obsolescent and
> >>>>> have not been updated in a while, while some are recent and
> >>>>> follow all the latest best-practice guidelines (and the rest
> >>>>> is somewhere in the middle).
> >>>>>
> >>>>> Are there 1 or 2 very good PCIe drivers to take as examples
> >>>>> as good starting points? (Perhaps a simple driver, and a
> >>>>> more complex driver.)
> >>>>
> >>>> I'm not really the best person to ask about this because I deal more
> >>>> with the PCI core than with the drivers that use the core.  If I were
> >>>> looking, I might start with drivers/nvme/host/pci.c or
> >>>> drivers/usb/host/xhci-pci.c.
> >>>
> >>> I should have also mentioned Documentation/PCI/pci.txt.  That's a
> >>> pretty good place to start.
> >>
> >> Hello Bjorn,
> >>
> >> Thanks for these pointers, I will study them with care.
> >>
> >> Who would review my PCIe driver if I ever submitted one? :-)
> > 
> > It all depends on what subsystem it would belong to, what type of device
> > are you writing a driver for?
> 
> Hello Greg,
> 
> There might be some kind of misunderstanding.
> 
> I don't plan to write a driver for a device that plugs into a PCIe slot.
> 
> I intend to write a driver for the PCIe controller itself, which is
> embedded in the SoC. (In order to support different types of PCIe
> devices, with their respective drivers already upstream.)
> 
> I think the controller driver belongs in drivers/pci/host ?

Sorry, I indeed misunderstood you.

The native PCI host controller drivers indeed live in
drivers/pci/host/.

I don't know anything about your hardware or environment, but I highly
encourage you to use ACPI (drivers/acpi/pci_root.c, with a little bit
of arch support) or generic DT (drivers/pci/host/pci-host-generic.c)
instead of writing a custom host controller driver.

The native drivers in drivers/pci/host are a huge maintenance hassle
for no real benefit.

Bjorn
