Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55647 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab2BWGEK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2012 01:04:10 -0500
Date: Thu, 23 Feb 2012 07:03:55 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@nvidia.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Olof Johansson (olof@lixom.net)" <olof@lixom.net>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org
Subject: Re: PCIe device tree support
Message-ID: <20120223060355.GA21091@avionic-0098.mockup.avionic-design.de>
References: <20120220191804.GA14499@avionic-0098.adnet.avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC302@HQMAIL01.nvidia.com>
 <20120222082449.GA15157@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4TfpGmx+HZ1ZnZwj3ZP_cQMCzkMT+6JK6ztYp2zWJcxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
In-Reply-To: <CAErSpo4TfpGmx+HZ1ZnZwj3ZP_cQMCzkMT+6JK6ztYp2zWJcxw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Bjorn Helgaas wrote:
> On Wed, Feb 22, 2012 at 12:24 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > [Adding Jesse Barnes and the linux-pci mailing list to CC.]
> >
> > * Stephen Warren wrote:
> >> Thierry Reding wrote at Monday, February 20, 2012 12:18 PM:
> >> > I would like to add device tree support for the Tegra2 PCIe controll=
er. From
> >> > what I understand this will require the PCIe code to be rewritten as=
 a proper
> >> > platform driver in order to be able to instantiate it via the device=
 tree. Is
> >> > that correct?
> >>
> >> That's probably the cleanest way, yes.
> >>
> >> Is there a drivers/ directory for PCI/PCIe host controllers? Moving the
> >> code there might be nice if so, although IIRC when I asked Olof about
> >> that a number of months back, he said quite a few host controllers were
> >> in arch/...
> >
> > Most PCI/PCIe host controller drivers seem to currently be in arch/. Is=
 there
> > a specific reason for this? Would it be acceptable to put any new drive=
rs
> > below drivers/pci/?
>=20
> PCI host bridges aren't architected, so discovering them and their
> properties has historically been mostly architecture-specific.  ACPI
> is one exception (with a driver in drivers/acpi/pci_root.c) and it
> sounds like device tree might be a similar exception.  If you can make
> a non-arch-specific driver and put it somewhere other than arch/, I'm
> all in favor of that, especially if you can make it usable by other
> arches that use device tree.  Where to put it?  I dunno.  drivers/pci/
> sounds like a reasonable possibility.

I don't think it would be possible to write a driver that works for all
device tree based boards or architectures. As you said the implementation is
very hardware specific and probably couldn't even be generalized among two
chipsets of the same architecture.

However there has recently been a lot of work to move out arch-specific
drivers for PWM, GPIO and others out of arch/ and into respective directori=
es
below drivers/. The reason I asked was because I think the same could be do=
ne
for PCI/PCIe.

Thierry

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9F1ssACgkQZ+BJyKLjJp/cdACggvsxcINrwjylNZd6lILAGhTB
j0gAoJPv/UThttCMTSJYMj3KyUNU3Yqp
=kmj+
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
