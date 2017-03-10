Return-Path: <SRS0=Soie=2T=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=Soie=2T=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Robin Murphy' <robin.murphy@arm.com>, Mason <slash.tmp@free.fr>
CC: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Marc
 Zyngier" <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, linux-usb
	<linux-usb@vger.kernel.org>, Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: Neophyte questions about PCIe
Date: Fri, 10 Mar 2017 15:35:16 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFE7C9B9@AcuExch.aculab.com>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <1092d971-5d81-2da7-4b34-0a88637c0ec5@arm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFE7C8BA@AcuExch.aculab.com>
 <c4712e19-863c-16b8-6920-5ad7dd178929@free.fr>
 <4f37cc08-d4fd-b207-63d2-4ac038d2fcec@arm.com>
In-Reply-To: <4f37cc08-d4fd-b207-63d2-4ac038d2fcec@arm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

From: Robin Murphy=20
> Sent: 10 March 2017 15:23
...
> >> So you have 128MB (max) of system memory that has cpu physical
> >> addresses 0x80000000 upwards.
> >> I'd expect it all to be accessible from any PCIe card at some PCIe
> >> address, it might be at address 0, 0x80000000 or any other offset.
> >>
> >> I don't know which DT entry controls that offset.
> >
> > This is a crucial point, I think.
>=20
> The appropriate DT property would be "dma-ranges", i.e.
>=20
> pci@... {
> 	...
> 	dma-ranges =3D <(PCI bus address) (CPU phys address) (size)>;
> }

Isn't that just saying which physical addresses the cpu can assign
for buffers for those devices?
There is also an offset between the 'cpu physical address' and the
'dma address'.
This might be implicit in the 'BAR0' base address register.
=20
> The fun part is that that will only actually match the hardware once the
> magic BAR has actually been programmed with (bus address), so you end up
> with this part of your DT being more of a prophecy than a property :)

The BAR0 values could easily be programmed into the cpld/fpga - so
not need writing by the cpu at all.

	David
