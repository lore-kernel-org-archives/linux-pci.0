Return-Path: <SRS0=KCwd=BS=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=KCwd=BS=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bjorn Helgaas' <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Martin Mares
	<mj@ucw.cz>
Subject: RE: lspci reports 'stale' BAR info after a card reset
Date: Thu, 19 Oct 2017 09:08:45 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD009C04A@AcuExch.aculab.com>
References: <063D6719AE5E284EB5DD2968C1650D6DD009AD46@AcuExch.aculab.com>
 <20171018170429.GA6332@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171018170429.GA6332@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas
> Sent: 18 October 2017 18:04
> [+cc Martin]
>=20
> On Wed, Oct 18, 2017 at 01:23:53PM +0000, David Laight wrote:
> > I'm doing some experiments that generate errors on a PCIe link.
> > (I'd like to get AER reporting things - but that is a different
> > problem.)
> >
> > If I force 'link down' (by shorting the TX lines with a screwdriver!)
> > the card side resets everything to do with the PCIe links including
> > all of config space - particularly the BARs.
> >
> > The kernel doesn't know this has happened, so the bridge is left
> > configured and the device driver (hopefully) doesn't crash the
> > kernel when it gets 0xffffffff back from reads!
> >
> > If I then run 'lspci -vx' I get:
> > 09:00.0 Class 0004: Device 12d9:001e (rev 01) (prog-if 02)
> >         Subsystem: Device 12d9:0001
> >         Flags: fast devsel, IRQ 16, NUMA node 0
> >         [virtual] Memory at fa200000 (32-bit, non-prefetchable) [size=
=3D1M]
> >         [virtual] Memory at fa100000 (32-bit, non-prefetchable) [size=
=3D1M]
> >         [virtual] Memory at fa300000 (32-bit, non-prefetchable) [size=
=3D8K]
> >         ...
> > 00: d9 12 1e 00 00 00 10 00 01 02 04 00 00 00 00 00
> > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 20: 00 00 00 00 00 00 00 00 00 00 00 00 d9 12 01 00
> > 30: 00 00 00 00 50 00 00 00 00 00 00 00 00 01 00 00
> >
> > Note that the hexdump shows the BARs as all zero, but the text shows th=
e
> > values that the kernel thinks are being used.
> > This doesn't make it obvious that something has gone badly wrong.
> >
> > AFAICT most of the info lspci outputs comes from decoding config space.
> > I suspect it is getting the BAR info from the kernel (linux 4.14.0-rc4 =
ish)
> > in order to print the size.
> > It would be better if it reported the inconsistency.
>=20
> I agree, it does seem odd that the hexdump reflects the hardware but
> the text does not.  I don't know whether that's intentional; maybe
> Martin does.
...

Actually, looking at the lspci code, the "[virtual]" is output
when the value read from the BAR is zero.
I'm not sure what this is supposed to mean.
It won't be output for an unconfigured IO address (low bit set)
and it is technically valid to map a BAR to address zero.

	David
