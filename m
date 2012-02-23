Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy1-pub.bluehost.com ([66.147.249.253]:41408 "HELO
	oproxy1-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752609Ab2BWQRE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2012 11:17:04 -0500
Date: Thu, 23 Feb 2012 08:16:58 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@nvidia.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Olof Johansson (olof@lixom.net)" <olof@lixom.net>,
	linux-pci@vger.kernel.org
Subject: Re: PCIe device tree support
Message-ID: <20120223081658.42af61a3@jbarnes-desktop>
In-Reply-To: <20120223060355.GA21091@avionic-0098.mockup.avionic-design.de>
References: <20120220191804.GA14499@avionic-0098.adnet.avionic-design.de>
	<74CDBE0F657A3D45AFBB94109FB122FF17BD8BC302@HQMAIL01.nvidia.com>
	<20120222082449.GA15157@avionic-0098.adnet.avionic-design.de>
	<CAErSpo4TfpGmx+HZ1ZnZwj3ZP_cQMCzkMT+6JK6ztYp2zWJcxw@mail.gmail.com>
	<20120223060355.GA21091@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/O9WQZq4rUoZ44siT93zTBkC"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/O9WQZq4rUoZ44siT93zTBkC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Feb 2012 07:03:55 +0100
Thierry Reding <thierry.reding@avionic-design.de> wrote:

> * Bjorn Helgaas wrote:
> > On Wed, Feb 22, 2012 at 12:24 AM, Thierry Reding
> > <thierry.reding@avionic-design.de> wrote:
> > > [Adding Jesse Barnes and the linux-pci mailing list to CC.]
> > >
> > > * Stephen Warren wrote:
> > >> Thierry Reding wrote at Monday, February 20, 2012 12:18 PM:
> > >> > I would like to add device tree support for the Tegra2 PCIe contro=
ller. From
> > >> > what I understand this will require the PCIe code to be rewritten =
as a proper
> > >> > platform driver in order to be able to instantiate it via the devi=
ce tree. Is
> > >> > that correct?
> > >>
> > >> That's probably the cleanest way, yes.
> > >>
> > >> Is there a drivers/ directory for PCI/PCIe host controllers? Moving =
the
> > >> code there might be nice if so, although IIRC when I asked Olof about
> > >> that a number of months back, he said quite a few host controllers w=
ere
> > >> in arch/...
> > >
> > > Most PCI/PCIe host controller drivers seem to currently be in arch/. =
Is there
> > > a specific reason for this? Would it be acceptable to put any new dri=
vers
> > > below drivers/pci/?
> >=20
> > PCI host bridges aren't architected, so discovering them and their
> > properties has historically been mostly architecture-specific.  ACPI
> > is one exception (with a driver in drivers/acpi/pci_root.c) and it
> > sounds like device tree might be a similar exception.  If you can make
> > a non-arch-specific driver and put it somewhere other than arch/, I'm
> > all in favor of that, especially if you can make it usable by other
> > arches that use device tree.  Where to put it?  I dunno.  drivers/pci/
> > sounds like a reasonable possibility.
>=20
> I don't think it would be possible to write a driver that works for all
> device tree based boards or architectures. As you said the implementation=
 is
> very hardware specific and probably couldn't even be generalized among two
> chipsets of the same architecture.
>=20
> However there has recently been a lot of work to move out arch-specific
> drivers for PWM, GPIO and others out of arch/ and into respective directo=
ries
> below drivers/. The reason I asked was because I think the same could be =
done
> for PCI/PCIe.

I think that makes sense for stuff that may be shared between arches,
but host bridges are generally part of the core architecture of the
system, so factoring them out would just be code shuffling without any
real gain.

But for shared code, drivers/pci is definitely the right place.

Thanks,
Jesse

--Sig_/O9WQZq4rUoZ44siT93zTBkC
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRmZ6AAoJEIEoDkX4Qk9hzc0P/j8iuofmrwfHcJR+jDak0WfY
4Or6xTbdzahh8owgcYrgefLPFq/VtIJ8cdhhEPC2JlQ2ybXVLgGZzgjIiSj/2jMi
RR6is5QjRe64c025X0rEMe/bWPffrAzyxMFt8hguqlx2uG2AiLW5adGMfuhpIFEg
4w1b0+jGDuKJvU2Q1E/Pvbzq19oa9Gxyu1YE0cGUfN3OQjeit9d0yJsr+XuL5WBx
tI6tRu7BrGUPq69nz7enU698LBA2RJ66gS1eJAO5lMqt1RwXyAk4oX20eMofDb9F
EjmwCTkdR6OnR34zBs0IhvR4TVtnrBYRqaHiPkUn6xq3rh6mOaYBlO2TMxUtJmSa
BzuEPz0Up9X+QpMd8pJWU8ZwU1U1bxlxXLAtfNZkm81qKIJnHAEw0BoZW3U7e2YP
MYywHGKYXd0b/rKPrdq7Kiuva2Pg1SBZW1ilBUA1Cu5lbSRo4HsV9f7h8HpGDJ8m
385ihYwq8W2zP52l3akag9hWFaXFGYfmlvGUruZ0z3CCkOtpy3ojLuD84YUMdU/u
mMm90EfmlZhQVUKH/Ln3CzcWBfBtcVGP433UHKpiTZHz+jihj/AGbLBwEq1wVscu
XDd2Mxpn03wleSNsOG7dXjHjqRrkzleum2aSt4sXqjk7wjsSQ3aFOKVTjw2PpEMT
VaTbGJf/udb3Au0LcwZe
=T44v
-----END PGP SIGNATURE-----

--Sig_/O9WQZq4rUoZ44siT93zTBkC--
