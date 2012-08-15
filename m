Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60836 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757033Ab2HOUJP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2012 16:09:15 -0400
Date: Wed, 15 Aug 2012 22:09:05 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
Message-ID: <20120815200905.GD12870@avionic-0098.mockup.avionic-design.de>
References: <50201E1D.5060200@wwwdotorg.org>
 <20120813174003.GA2527@avionic-0098.mockup.avionic-design.de>
 <50294BCA.1070807@wwwdotorg.org>
 <CAErSpo7og1XgOSv_mFCQ=hP7pq0j3gXWh2QFL2wBJjz7kcAq=g@mail.gmail.com>
 <502AA96B.2050709@wwwdotorg.org>
 <20120814195834.GA10431@avionic-0098.mockup.avionic-design.de>
 <CAErSpo4Bm_Ryx=OK+svjqAwD4N8v0vrheLVdc-N1ijx8i_-N3w@mail.gmail.com>
 <502AD82F.3080702@wwwdotorg.org>
 <502AE485.8060307@wwwdotorg.org>
 <502BF2B4.9030401@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
In-Reply-To: <502BF2B4.9030401@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 15, 2012 at 01:04:20PM -0600, Stephen Warren wrote:
> On 08/14/2012 05:51 PM, Stephen Warren wrote:
> > On 08/14/2012 04:58 PM, Stephen Warren wrote:
> ...
> >> Can't we make the call to pci_bus_add_devices() optional in
> >> pci_scan_root_bus() somehow; one of:
> >=20
> > Sigh, that turns out not to work correctly; it solves at least this part
> > of the problem when booting using device tree, but when booting using a
> > board file, it causes the IRQ number passed to the PCIe device to be
> > bogus:-(
> >=20
> > I give up for now.
>=20
> I think the appropriate workaround for Tegra in 3.6 is to simply make
> any drivers for PCIe-based devices be modules instead of built-in, as
> Thierry hinted at much earlier in the thread. I've validated that the
> Ethernet works just fine on TrimSlice with that change, booting v3.6-rc1
> using either board files or device tree.

That's certainly the easiest and least error-prone solution.

> For 3.7, we should continue the discussion about a real fix; I'll look
> into the change Bjorn requested and see if it works, although given that
> hacking pci_scan_root_bus as described immediately previously in this
> thread caused a regression when booting using a board file, and the fact
> that board files are no longer supported on Tegra, I'm not too confident
> in the outcome...

I don't understand this last part. If the problem is there when booting
=66rom board files and the board files are removed, doesn't that remove
the problem as well? =3D)

Thierry

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLAHhAAoJEN0jrNd/PrOhl0AP/ixBffxY1ShxsIuGhE3iVIVr
E9tFY4p6zWSJ/P6y3UOOdn+LNiyFfMRKRTjz2alvQAPcWd8SIlezJxYAN8CN0N63
s5WToWptIrpt/CHY9kzLzjjJsIXOQ6y9O2twNZ6hCxHt8t/BV6yuESF725qFOIGx
idaE8EuQY6qIc7hpc0AwaBmvemWqbMPjah7Bdz3HhSaJVMWI/NDIrlX3rBmNNUFC
YvNc9zzquUBn3fXzKnoLrUsyP7UiOomoo18ZnapHfuTbdIRJQbi6V5avXpPqxnJ3
vAVQsFvMvMwqGsg4qf0P+PXdvNCwgDntCYePJR7v2LJcxoN0w89dVuwoW7U8XfCG
AjqRvjjwjeJuxk6R3xg4zeKmfA5M2TueSYS/iuP6DtGrL0BQOAtDh68INhwsepr3
jfRMpoKamPSx9CtOmJoDDF+4VCvhslZ9KL5vAMz5ELzr3hEi0JlJ6u3QqoCxgROz
d4FAsiHM5sECngnZnWpe2kLkPzM9raEwgi1p3NV8sv7oHZGMDwobNbryE0Q2mR8F
UIr/mqa+fGZ2exrPb8zw3TiWYlYlzvF7bH5BZtCvazYYzGchBTTnuu8sUwWqXU28
GX5CGe3t+7c7FadtUbYkECZ0oJWqyKb0NTmg9ZjbYup8drSBtx+6ZC41goNEMoiE
Hi6btlHHiyR4sfrfkEjr
=mUp/
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
