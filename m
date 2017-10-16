Return-Path: <SRS0=Y/az=BP=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=Y/az=BP=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bjorn Helgaas' <helgaas@kernel.org>
CC: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>
Subject: RE: PCIe error reporting
Date: Mon, 16 Oct 2017 14:23:22 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0097D9F@AcuExch.aculab.com>
References: <063D6719AE5E284EB5DD2968C1650D6DD008D9F2@AcuExch.aculab.com>
 <20171010211035.GY25517@bhelgaas-glaptop.roam.corp.google.com>
 <063D6719AE5E284EB5DD2968C1650D6DD0090E73@AcuExch.aculab.com>
 <063D6719AE5E284EB5DD2968C1650D6DD00911C9@AcuExch.aculab.com>
 <20171011132525.GF25517@bhelgaas-glaptop.roam.corp.google.com>
 <063D6719AE5E284EB5DD2968C1650D6DD009155B@AcuExch.aculab.com>
 <20171011172113.GJ25517@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171011172113.GJ25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas
> Sent: 11 October 2017 18:21
> On Wed, Oct 11, 2017 at 04:00:04PM +0000, David Laight wrote:
> > From: Bjorn Helgaas
> > > Sent: 11 October 2017 14:25
> > ..
> > > The current Linux behavior is based on the spec I cited above, which
> > > says
> > >
> > >   If any bits in the Control Field are returned cleared (masked to
> > >   zero) by the _OSC control method, the respective feature is
> > >   designated unsupported by the platform and must not be enabled by
> > >   the operating system. Some of these features may be controlled by
> > >   platform firmware prior to operating system boot or during runtime
> > >   for a legacy operating system, while others may be
> > >   disabled/inoperative until native operating system support is
> > >   available.
> >
> > That is a strange statement.
> >
> > What an earth have 'legacy operating system' and 'native operating
> > system' got to do with whether the ACPI features can be enabled.
> > How are we supposed to write the os support if the features are
> > disabled until it is available!
>=20
> I wasn't involved in writing that spec, but my guess is that some
> platforms want to do AER logging themselves, in a consistent way
> regardless of what OS is running or whether that OS has AER support.
> That means there has to be some way to coordinate control of the AER
> registers between the platform (BIOS) and the OS, and _OSC is the ACPI
> way to do that.
>
> Linux should be setting OSC_PCI_EXPRESS_AER_CONTROL to request control
> of AER, and apparently on your system the BIOS explicitly cleared that
> bit to tell us "no, you're not allowed to use AER."  If the BIOS
> cleared it unnecessarily, that's really a BIOS problem, not a Linux
> problem.

I'm beginning to suspect that the BIOS has AER disabled in order to
stop people complaining about AER error messages spamming the logs!

> It would be interesting to know what Windows does about AER on that
> platform.  I would expect Windows to respect the platform's wishes as
> expressed by _OSC, so if Windows does AER recovery, there might be a
> problem in the way Linux uses _OSC.

I've booted server 2012, difficult to say whether AER gets logged.
There are some recent WHEA logs - but not from when I was generating
errors.  The event viewer doesn't decode the data that might say
what is being reported.

I've 'bodged' the Linux kernel to think that the BIOS gave it control
of AER (set OSC_PCI_EXPRESS_AER_CONTROL into *mask and
root->osc_control_set in acpi_pci_osc_control_set()).
I think this is the earliest place the info is saved.
This is enough to the 'pcieport ... AER enabled with IRQ nn' messages
(It is sharing the interrupt with PME).

I've made sure my card is beneath one of the cpu bridges (the companion
chip host bridges don't support AER).
I've also bodged the driver to ioremap() an area larger than one of the
BARs so I can generated PCIe read and write TLP that are outside the
BAR ranges.
Reads set CESta: NonFatalError.
Writes set UESTA: UnsepReq and save the TLP header.
No interrupts to aerdrv are generated.
I can clear the status bits using setpci.
Should I expect these errors to raise interrupts?

	David
