Return-Path: <SRS0=OllH=CI=nvidia.com=treding@kernel.org>
Return-Path: <SRS0=OllH=CI=nvidia.com=treding@kernel.org>
Date: Fri, 10 Nov 2017 10:44:56 +0100
From: Thierry Reding <treding@nvidia.com>
To: subrahmanya_lingappa <l.subrahmanya@mobiveil.co.in>
CC: Bjorn Helgaas <helgaas@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	<bhelgaas@google.com>, <linux-tegra@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <kthota@nvidia.com>, <swarren@nvidia.com>,
	<mmaddireddy@nvidia.com>, Michal Simek <michal.simek@xilinx.com>,
	=?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>, Simon Horman
	<horms@verge.net.au>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: tegra: limit MSI target address to 32-bit
Message-ID: <20171110094456.GB25067@ulmo>
References: <1509991387-15951-1-git-send-email-vidyas@nvidia.com>
 <20171108212558.GC21597@bhelgaas-glaptop.roam.corp.google.com>
 <e993e1f8-b6b3-de07-759c-a56012e06a2a@nvidia.com>
 <20171109181435.GB7629@bhelgaas-glaptop.roam.corp.google.com>
 <1686e861-79ac-75eb-b905-769253c6f79e@mobiveil.co.in>
MIME-Version: 1.0
In-Reply-To: <1686e861-79ac-75eb-b905-769253c6f79e@mobiveil.co.in>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
List-ID: <linux-pci.vger.kernel.org>

--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2017 at 06:17:16AM +0530, subrahmanya_lingappa wrote:
> Bjorn,
>=20
> On 11/9/2017 11:44 PM, Bjorn Helgaas wrote:
> > [+cc Lorenzo]
> >=20
> > On Thu, Nov 09, 2017 at 12:48:14PM +0530, Vidya Sagar wrote:
> > > On Thursday 09 November 2017 02:55 AM, Bjorn Helgaas wrote:
> > > > On Mon, Nov 06, 2017 at 11:33:07PM +0530, Vidya Sagar wrote:
> > > > > limits MSI target address to only 32-bit region to enable
> > > > > some of the PCIe end points where only 32-bit MSIs
> > > > > are supported work properly.
> > > > > One example being Marvel SATA controller
> > > > >=20
> > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > ---
> > > > >  drivers/pci/host/pci-tegra.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-=
tegra.c
> > > > > index 1987fec1f126..03d3dcdd06c2 100644
> > > > > --- a/drivers/pci/host/pci-tegra.c
> > > > > +++ b/drivers/pci/host/pci-tegra.c
> > > > > @@ -1531,7 +1531,7 @@ static int tegra_pcie_enable_msi(struct teg=
ra_pcie *pcie)
> > > > >  	}
> > > > >  	/* setup AFI/FPCI range */
> > > > > -	msi->pages =3D __get_free_pages(GFP_KERNEL, 0);
> > > > > +	msi->pages =3D __get_free_pages(GFP_DMA, 0);
> > > > >  	msi->phys =3D virt_to_phys((void *)msi->pages);
> > >=20
> > > > Should this be GFP_DMA32?  See the comment above the GFP_DMA
> > > > definition.
> > >=20
> > > looking at the comments for both GFP_DMA32 and GFP_DMA, I thought GFP=
_DMA32
> > > is the correct one to use, but, even with that I got >32-bit addresse=
s.
> > > GFP_DMA always gives addresses in <4GB boundary (i.e. 32-bit).
> > > I didn't dig into it to find out why is this the case.
> >=20
> > This sounds worth looking into (but maybe we don't need the
> > __get_free_pages() at all; see below).  Maybe there's some underlying
> > bug.  My laptop shows this, which looks like it might be related:
> >=20
> >   Zone ranges:
> >     DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> >     DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> >     Normal   [mem 0x0000000100000000-0x00000004217fffff]
> >     Device   empty
> >=20
> > What does your machine show?
> >=20
> > > > Should we be using virt_to_phys() here?  Where exactly is the
> > > > result ("msi->phys") used, i.e., what bus will that address appear
> > > > on?  If it appears on the PCI side, this should probably use
> > > > something like pcibios_resource_to_bus().
> > >=20
> > > This address is written to two places.  First, into host's internal
> > > register to let it know that when an incoming memory write comes
> > > with this address, raise an MSI interrupt instead of forwarding it
> > > to memory subsystem.  Second, into 'Message Address' field of
> > > 'Message Address Register for MSI' register in end point's
> > > configuration space (this is done by MSI framework) for end point to
> > > know which address to be used to generate MSI interrupt.
> >=20
> > Hmmm, ISTR some past discussion about this.  Here's a little: [1, 2].
> > And this commit [3] sounds like it describes a similar hardware
> > situation with Tegra where the host bridge intercepts the MSI target
> > address, so writes to it never reach system memory.  That means that
> > Tegra doesn't need to allocate system memory at all.
> >=20
> > Is your system similar?  Can you just statically allocate a little bus
> > address space, use that for the MSI target address, and skip the
> > __get_free_pages()?
> >=20
> > > > Do rcar_pcie_enable_msi() and xilinx_pcie_enable_msi() have a
> > > > similar problem?  They both use GFP_KERNEL, then virt_to_phys(),
> > > > then write the result of virt_to_phys() using a 32-bit register
> > > > write.
> > >=20
> > > Well, if those systems deal with 64-bit addresses and when an end
> > > point is connected which supports only 32-bit MSI addresses, this
> > > problem will surface when __get_free_pages() returns an address that
> > > translates to a >32-bit address after virt_to_phys() call on it.
> >=20
> > I'd like to hear from the R-Car and Xilinx folks about (1) whether
> > there's a potential issue with truncating a 64-bit address, and
> > (2) whether that hardware works like Tegra, where the MSI write never
> > reaches memory so we don't actually need to allocate a page.
> >=20
>=20
> it is so, at least drivers/pci/host/pcie-xilinx.c driver, MSI data is nev=
er
> read from the msi_pages physical
> memory allocated, data is always intercepted, caught and fed from one of =
the
> HW FIFO register XILINX_PCIE_REG_RPIFR2. Here too __get_free_pages was us=
ed
> to allocate msi_pages just to get a real memory address to program in the
> MSI address in PCIe endpoints config register.
>=20
> MSI handling code from pcie-xilinx.c
>=20
> 	if (status & (XILINX_PCIE_INTR_INTX | XILINX_PCIE_INTR_MSI)) {
> 		.
> 		.
>=20
> 		/* Decode the IRQ number */
> 		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
> 			val =3D pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
> 				XILINX_PCIE_RPIFR2_MSG_DATA;
> 		} else {
> 			val =3D (val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
> 				XILINX_PCIE_RPIFR1_INTR_SHIFT;
> 			val =3D irq_find_mapping(port->leg_domain, val);
> 		}
> 	=09
> 		.
> 		.
> 	=09
> 		/* Handle the interrupt */
> 		if (IS_ENABLED(CONFIG_PCI_MSI) ||
> 		    !(val & XILINX_PCIE_RPIFR1_MSI_INTR))
> 			generic_handle_irq(val);
> 	}

A side-note: this looks like a bug to me. In case of an MSI, the val
variable will have been overwritten by the MSI decode branch above, so
it seems to me like the conditional down here isn't guaranteed to work
and depends on what MSI was actually received?

Don't you need to store the interrupt status in a variable separate from
the value that you're using to find which interrupt was received?

Thierry

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloFdRcACgkQ3SOs138+
s6EAcQ/7BAQt8ZPpv4Xdh2hk5u4+RXaFvQXRLuFzdC5p69dwOmllBpWvatk6/WWb
dCYjc96wRLTGrUgvfMMIrcd4DKfkOFdcS+Ok5haoOftMhuWM05FCSFqgmQLnz9Mo
mXusMYSVVxtPMZ9VDh9gUNjWd51tjZmiOEmOnfbBzW2n8BnQQz5W+6JNRkeLX+dx
NfiD3Hv0M217lLJPNaD10KHS2RPaPzUzlvWktNvt1gq3vZHkLHKTMutgm0n1Ps6z
joJFjWUAA0rlV59NEde9w93mXR5ra2+uDGosqZfBKnmg+WLyw4jZUvHbwgzPsKWY
y2qNgg1BnK+tsBX+mgKqot3wR4rHdhx6NaCwyi2fcVLLqLGvlrD83wUSzty+4+t+
dplbavwbFUOxZX2/xghlplXhDtr8bTnx7vQUPdPxd4/IigQKcFZV/rzivsXRNzNK
AQXXprSa2XNG6rRt/0GFMZjpQj6aymnvHxtXUhvITXrV+np/+MwBXk38vqhiX3Ir
EijOV1thB7bpMKI2iPGT/DFRFTj0yImDddggkKxRjTEb0HwUT5klmF+nKbiKp5PL
agsCAfFOLbKrovroVzcjJ+5BR7oVofzG0LrRETKEvb0yoFPUTz9EliT2K3YW/K5s
THsoEALGohT7wRMJPs0n5dypB+MPi/rmpDreGhztPm0lXbVynWw=
=B8Q2
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
