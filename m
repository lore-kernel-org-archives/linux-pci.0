Return-Path: <mathias.koehrer@etas.com>
Return-Path: <mathias.koehrer@etas.com>
From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "hjk@hansjkoch.de"
	<hjk@hansjkoch.de>, "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH] Introducing kernel option to force all PCI memory
 resources to be page aligned. Fixes issues with uio based drivers.
Date: Wed, 8 Jun 2016 08:32:52 +0000
Message-ID: <ef1a9c8e1ef0439a84ad43c1a8f92d79@FE-MBX1012.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Greg,
> > > > The issue is not the firmware. The issue is that the Linux uio
> > > > driver
> > > > (here: uio_cif) does not work as uio_mmap() -> uio_mmap_physical()
> > > > does not do a mmap on physical memory that is not page aligned...
> > >
> > > Then why not fix the uio_cif driver?
> > The fix might be in uio and not in uio_cif. However
> > uio_mmap_physical() in uio.c has introduced checks to reject non page-
> aligned addresses.
>=20
> Yes, because we had real problems with that in the past.
>=20
> > These checks have been introduced somewhere in between kernel V3.2 and
> kernel V3.18.
> > Removing these checks again does not sound to me like a good idea...
>=20
> I agree, you should fix your hardware :)
>=20
> > The overall question is now if the UIO system is working at all with
> > non page aligned PCI memory resources. For me it looks as if this is no=
t the
> case.
>=20
> How is your system ending up with such alignment in the first place?
> What is the resource list after booting?
Here is the resource list of the relevant PCI board. The first memory resou=
rce has a size of 128k and is not page aligned.

0f:05.0 Bridge: PLX Technology, Inc. PCI9030 32-bit 33MHz PCI <-> IOBus Bri=
dge (rev 01)
	Subsystem: PLX Technology, Inc. Hilscher CIF50-PB/DPS Profibus
	Flags: medium devsel, IRQ 23
	Memory at eae4f400 (32-bit, non-prefetchable) [size=3D128]
	I/O ports at 9800 [size=3D128]
	Memory at eae4c000 (32-bit, non-prefetchable) [size=3D8K]
	Capabilities: [40] Power Management version 1
	Capabilities: [48] CompactPCI hot-swap <?>
	Capabilities: [4c] Vital Product Data
	Kernel driver in use: hilscher

Regards

Mathias
