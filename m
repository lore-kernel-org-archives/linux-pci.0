Return-Path: <SRS0=yQmJ=ZZ=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=yQmJ=ZZ=linuxfoundation.org=gregkh@kernel.org>
Date: Sun, 12 Feb 2017 17:50:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mason <slash.tmp@free.fr>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Pointers for writing a good PCIe driver
Message-ID: <20170212165033.GA31833@kroah.com>
References: <ff099b5f-efc8-bb5f-41e3-493398844cc0@free.fr>
 <05046a8a-ba9f-26f9-4c93-f657f9da6294@free.fr>
 <20170207200656.GA11659@bhelgaas-glaptop.roam.corp.google.com>
 <20170207214758.GC11659@bhelgaas-glaptop.roam.corp.google.com>
 <0f22720c-e47d-59f6-b5f7-5e40f4a1759d@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0f22720c-e47d-59f6-b5f7-5e40f4a1759d@free.fr>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 07, 2017 at 11:56:31PM +0100, Mason wrote:
> On 07/02/2017 22:47, Bjorn Helgaas wrote:
> > On Tue, Feb 07, 2017 at 02:06:56PM -0600, Bjorn Helgaas wrote:
> >> On Tue, Feb 07, 2017 at 04:55:28PM +0100, Mason wrote:
> >>> On 06/02/2017 16:54, Mason wrote:
> >>>
> >>>> My platform ( arch/arm/mach-tango ) provides a PCIe controller from PLDA.
> >>>>
> >>>> I do have access to a driver that works for a few PCIe boards, but it's
> >>>> an ancient out-of-tree driver (targeting v3.4). Also, I'm not sure it
> >>>> follows the best-practice guidelines (e.g. it hard-codes a few
> >>>> work-arounds directly in drivers/pci/probe.c)
> >>
> >> Indeed, having to change drivers/pci/probe.c doesn't sound like a best
> >> practice :)  If you can share details of what changes you need, people
> >> could probably suggest other ways to do it within the generic PCI
> >> framework.
> >>
> >>>> If I understand correctly, while PCIe is a standard, it is not codified
> >>>> as much as USB (XHCI) or SATA (AHCI), which means the register layout
> >>>> (and possibly other things) are left up to the integrator? Which means
> >>>> there cannot be some kind of "generic" driver that works for a random
> >>>> PCIe controller?
> >>
> >> There is no standardization of registers in MMIO or I/O port space.
> >> The size, location, and type of those registers is configurable in a
> >> generic way via the BARs, of course.  But that tells you nothing about
> >> the *functionality* of those MMIO or I/O port registers.
> >>
> >> For config space, the first 64 bytes (the PCIe r3.0 spec calls it the
> >> "PCI 3.0 Compatible Configuration Space Header") are completely
> >> standardized.  This is where device IDs, BARs, and other generic
> >> registers are.
> >>
> >> PCIe devices can implement up to 4096 bytes of config space.  The
> >> space after the 64-byte header can contain a list of standardized
> >> PCI/PCIe Capabilities, non-standardized device-specific registers, or
> >> both.  There is a way to include device-specific registers in a
> >> "Vendor Defined" Capability -- that way drivers can use generic
> >> mechanisms to find registers so they don't have to hard-code register
> >> layout assumptions.
> >>
> >>>> I guess my main question is: do you have pointers on getting started
> >>>> writing a PCIe driver good enough for upstream?
> >>>>
> >>>> Is Documentation/PCI/PCIEBUS-HOWTO.txt still a relevant resource?
> >>
> >> PCIEBUS-HOWTO.txt is still relevant, but only to drivers for services
> >> of PCIe ports, e.g., hotplug, error reporting, etc.  It's not relevant
> >> to PCIe endpoint drivers.
> >>
> >>>> Are there good resources to get up to speed on the PCIe terminology?
> >>>
> >>> I'm also wondering: in many Linux subsystems, there are often
> >>> several drivers of different quality; some are obsolescent and
> >>> have not been updated in a while, while some are recent and
> >>> follow all the latest best-practice guidelines (and the rest
> >>> is somewhere in the middle).
> >>>
> >>> Are there 1 or 2 very good PCIe drivers to take as examples
> >>> as good starting points? (Perhaps a simple driver, and a
> >>> more complex driver.)
> >>
> >> I'm not really the best person to ask about this because I deal more
> >> with the PCI core than with the drivers that use the core.  If I were
> >> looking, I might start with drivers/nvme/host/pci.c or
> >> drivers/usb/host/xhci-pci.c.
> > 
> > I should have also mentioned Documentation/PCI/pci.txt.  That's a
> > pretty good place to start.
> 
> Hello Bjorn,
> 
> Thanks for these pointers, I will study them with care.
> 
> Who would review my PCIe driver if I ever submitted one? :-)

It all depends on what subsystem it would belong to, what type of device
are you writing a driver for?

thanks,

greg k-h
