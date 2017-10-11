Return-Path: <SRS0=ztmW=BK=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=ztmW=BK=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: David Laight <David.Laight@ACULAB.COM>, 'Bjorn Helgaas'
	<helgaas@kernel.org>
CC: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>
Subject: RE: PCIe error reporting
Date: Wed, 11 Oct 2017 12:50:04 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00911C9@AcuExch.aculab.com>
References: <063D6719AE5E284EB5DD2968C1650D6DD008D9F2@AcuExch.aculab.com>
 <20171010211035.GY25517@bhelgaas-glaptop.roam.corp.google.com>
 <063D6719AE5E284EB5DD2968C1650D6DD0090E73@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD0090E73@AcuExch.aculab.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

From: David Laight
> Sent: 11 October 2017 11:04
...
> > > On that system (XEON E5-2600) dmesg contains (retyped):
> > >   acpi: PNP0A08:00: _OSC: platform does not support [AER]
> >
> > Per the PCI Firmware spec r3.0, sec 4.5.1, on ACPI platforms, the OS
> > is supposed to use _OSC to ask the firmware for permission before
> > using AER.  In this case, the firmware declined to grant us
> > permission, so we're not supposed to do anything at all with AER.
>=20
> I read that as 'BIOS knows nothing about AER' rather than 'BIOS
> refused to hand over control' - but I could be wrong.
>=20
> I'm not sure where to look to see if the actual hardware does.
> I'm guessing that Intel Haswell-E should.

I've four Haswell root port bridges with the AER block at offset 148.
None of them have anything in the three 'root error registers'.

So the firmware/bios can't be using the registers - which means the
OS could use them.

	David
