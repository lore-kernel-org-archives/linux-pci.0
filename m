Return-Path: <SRS0=OllH=CI=nvidia.com=treding@kernel.org>
Return-Path: <SRS0=OllH=CI=nvidia.com=treding@kernel.org>
Date: Fri, 10 Nov 2017 14:07:05 +0100
From: Thierry Reding <treding@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
	<helgaas@kernel.org>, Vidya Sagar <vidyas@nvidia.com>, <bhelgaas@google.com>,
	<linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<kthota@nvidia.com>, <swarren@nvidia.com>, <mmaddireddy@nvidia.com>, "Michal
 Simek" <michal.simek@xilinx.com>, =?utf-8?B?U8O2cmVu?= Brinkmann
	<soren.brinkmann@xilinx.com>, Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] PCI: tegra: limit MSI target address to 32-bit
Message-ID: <20171110130704.GA31316@ulmo>
References: <1509991387-15951-1-git-send-email-vidyas@nvidia.com>
 <20171108212558.GC21597@bhelgaas-glaptop.roam.corp.google.com>
 <e993e1f8-b6b3-de07-759c-a56012e06a2a@nvidia.com>
 <20171109181435.GB7629@bhelgaas-glaptop.roam.corp.google.com>
 <20171110112201.GA25235@red-moon>
 <3887d62c-98bb-04d5-5b40-96d5b7b43e63@arm.com>
MIME-Version: 1.0
In-Reply-To: <3887d62c-98bb-04d5-5b40-96d5b7b43e63@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
List-ID: <linux-pci.vger.kernel.org>

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2017 at 12:04:21PM +0000, Robin Murphy wrote:
> On 10/11/17 11:22, Lorenzo Pieralisi wrote:
> > [+Robin]
> >=20
> > On Thu, Nov 09, 2017 at 12:14:35PM -0600, Bjorn Helgaas wrote:
> > > [+cc Lorenzo]
> > >=20
> > > On Thu, Nov 09, 2017 at 12:48:14PM +0530, Vidya Sagar wrote:
> > > > On Thursday 09 November 2017 02:55 AM, Bjorn Helgaas wrote:
> > > > > On Mon, Nov 06, 2017 at 11:33:07PM +0530, Vidya Sagar wrote:
> > > > > > limits MSI target address to only 32-bit region to enable
> > > > > > some of the PCIe end points where only 32-bit MSIs
> > > > > > are supported work properly.
> > > > > > One example being Marvel SATA controller
> > > > > >=20
> > > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > > ---
> > > > > >   drivers/pci/host/pci-tegra.c | 2 +-
> > > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pc=
i-tegra.c
> > > > > > index 1987fec1f126..03d3dcdd06c2 100644
> > > > > > --- a/drivers/pci/host/pci-tegra.c
> > > > > > +++ b/drivers/pci/host/pci-tegra.c
> > > > > > @@ -1531,7 +1531,7 @@ static int tegra_pcie_enable_msi(struct t=
egra_pcie *pcie)
> > > > > >   	}
> > > > > >   	/* setup AFI/FPCI range */
> > > > > > -	msi->pages =3D __get_free_pages(GFP_KERNEL, 0);
> > > > > > +	msi->pages =3D __get_free_pages(GFP_DMA, 0);
> > > > > >   	msi->phys =3D virt_to_phys((void *)msi->pages);
> > > >=20
> > > > > Should this be GFP_DMA32?  See the comment above the GFP_DMA
> > > > > definition.
> > > >=20
> > > > looking at the comments for both GFP_DMA32 and GFP_DMA, I thought G=
FP_DMA32
> > > > is the correct one to use, but, even with that I got >32-bit addres=
ses.
> > > > GFP_DMA always gives addresses in <4GB boundary (i.e. 32-bit).
> > > > I didn't dig into it to find out why is this the case.
> > >=20
> > > This sounds worth looking into (but maybe we don't need the
> > > __get_free_pages() at all; see below).  Maybe there's some underlying
> > > bug.  My laptop shows this, which looks like it might be related:
> > >=20
> > >    Zone ranges:
> > >      DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> > >      DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> > >      Normal   [mem 0x0000000100000000-0x00000004217fffff]
> > >      Device   empty
> > >=20
> > > What does your machine show?
>=20
> The great thing about ZONE_DMA is that it has completely different meanin=
gs
> per platform. ZONE_DMA32 is even worse as it's more or less just an x86
> thing, and isn't implemented (thus does nothing) on most other
> architectures, including ARM/arm64 where Tegra is relevant.
>=20
> Fun.
>=20
> > > > > Should we be using virt_to_phys() here?  Where exactly is the
> > > > > result ("msi->phys") used, i.e., what bus will that address appear
> > > > > on?  If it appears on the PCI side, this should probably use
> > > > > something like pcibios_resource_to_bus().
> >=20
> > I had a quick chat with Robin (CC'ed, who has dealt/is dealing with most
> > of the work this thread relates to) and I think that as things stand,
> > for MSI physical addresses, an offset between PCI->host address shift is
> > not really contemplated (ie 1:1 host<->pci is assumed).
>=20
> I think the most correct way to generate an address would actually be via
> the DMA mapping API (i.e. dma_map_page() with the host bridge's PCI devic=
e),
> which would take any relevant offsets into account. It's a bit funky, but
> there's some method in the madness.
>=20
> > > > This address is written to two places.  First, into host's internal
> > > > register to let it know that when an incoming memory write comes
> > > > with this address, raise an MSI interrupt instead of forwarding it
> > > > to memory subsystem.  Second, into 'Message Address' field of
> > > > 'Message Address Register for MSI' register in end point's
> > > > configuration space (this is done by MSI framework) for end point to
> > > > know which address to be used to generate MSI interrupt.
> > >=20
> > > Hmmm, ISTR some past discussion about this.  Here's a little: [1, 2].
> > > And this commit [3] sounds like it describes a similar hardware
> > > situation with Tegra where the host bridge intercepts the MSI target
> > > address, so writes to it never reach system memory.  That means that
> > > Tegra doesn't need to allocate system memory at all.
> > >=20
> > > Is your system similar?  Can you just statically allocate a little bus
> > > address space, use that for the MSI target address, and skip the
> > > __get_free_pages()?
> >=20
> > IIUC, all these host bridges need is a physical address that is routed
> > upstream to the host bridge by the PCIe tree (ie it is not part of the
> > host bridge windows), as long as the host bridge intercepts it (and
> > endpoints do _not_ reuse it for something else) that should be fine, as
> > it has been pointed out in this thread, allocating a page is a solution
> > - there may be others (which are likely to be platform specific).
> >=20
> > > > > Do rcar_pcie_enable_msi() and xilinx_pcie_enable_msi() have a
> > > > > similar problem?  They both use GFP_KERNEL, then virt_to_phys(),
> > > > > then write the result of virt_to_phys() using a 32-bit register
> > > > > write.
> > > >=20
> > > > Well, if those systems deal with 64-bit addresses and when an end
> > > > point is connected which supports only 32-bit MSI addresses, this
> > > > problem will surface when __get_free_pages() returns an address that
> > > > translates to a >32-bit address after virt_to_phys() call on it.
> > >=20
> > > I'd like to hear from the R-Car and Xilinx folks about (1) whether
> > > there's a potential issue with truncating a 64-bit address, and
> > > (2) whether that hardware works like Tegra, where the MSI write never
> > > reaches memory so we don't actually need to allocate a page.
> > >=20
> > > If all we need is to allocate a little bus address space for the MSI
> > > target, I'd like to figure out a better way to do that than
> > > __get_free_pages().  The current code seems a little buggy, and
> > > it's getting propagated through several drivers.
>=20
> The really neat version is to take a known non-memory physical address li=
ke
> the host controller's own MMIO region, which has no legitimate reason to
> ever be used as a DMA address. pcie-mediatek almost gets this right, but =
by
> using virt_to_phys() on an ioremapped address they end up with nonsense
> rather than the correct address (although realistically you would have to=
 be
> extremely unlucky for said nonsense to collide with a real DMA address gi=
ven
> to a PCI endpoint later). Following on from above, dma_map_resource() wou=
ld
> be the foolproof way to get that right.

Yes, that was our intention as well. Our initial plan was to use an
address from the PCI aperture within Tegra that wasn't being used for
any other purpose. However, we ran into some odd corner cases where this
wasn't working as expected. As a temporary solution we wanted to move to
GFP_DMA32 (or GFP_DMA) in order to support 32-bit only MSI endpoints.

Eventually we'll want to get rid of the allocation altogether, we just
need to find a set of values that work reliably. In the meantime, it
looks as though GFP_DMA would be the right solution as long as we have
to stick with __get_free_pages().

Alternatively, since we've already verified that the MSI writes are
never committed to memory, we could choose some random address pointing
to system memory as well, but I'm reluctant to do that because it could
end up being confusing for users (and developers) to see some random
address showing up somewhere. A physical address such as the beginning
of system memory should always work and might be unique enough to
indicate that it is special.

Thierry

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloFpHYACgkQ3SOs138+
s6E0lQ//eBrr/YR8xVrk7uujpFWccXlrqDVvP+7NP3bmM5BPJcqUXixtmOtEzbjj
FZSMbuKFq9f26zbNWuPASRYDYjCBDC7VYwJYz7K+caO7GwGUg7VZ3slz7pU8rQp6
39WPpbKxAsb2DbHUDrnVkwe94k/bDtHvZq8l856YkoQ7T4nfYr5ExYvXgZ/b2DB8
v/SEvAhcQ8p9xg3+azro+b+gRTR/2xpJz2xkBMyLqfrneETQdODz4UBCMnQze5Xq
IfYfZdMYLwk3bGxsG5vYMsiHUniPTGu8oKZsdlhlULWuRe14PhB76ucE+Ty0xRFQ
0SZM+cHjFA4xpRgzo8Zp0bI264ey1gQmciPb6jezQDyvYk1JRTswYGvUGMKktSju
cLFFWggB9R9fR7Nip6R0EM/wlUb5hJst2IKbjL+qvbU/e60xpZxhvm0QDvhr0ois
eJJpIbHoBS6vWlqiVtU0zpWQyJyKcIFHgfXrq2V6RjMHE1TJVbqUpXeXdRix83c4
k2yqQcILUD6DpI66Y8kU0k9/P4wBKd0tPRvouZgLw9X8BekNyuvO9Fy5bq82NxU7
snUxXVtpiDuzxdv3tO3sLTh9QUDBOHN4hsOnsDUr2V53KT1QzdGwWaJ8sOcOxWzw
XPhrEFOtVwYEa4rZeIZI8LkSvzkDU9pX6k2IzL5xIIWC2wDJ1O8=
=RSqs
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
