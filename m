Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55138 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab2F0GTw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jun 2012 02:19:52 -0400
Date: Wed, 27 Jun 2012 08:19:44 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Message-ID: <20120627061944.GB8496@avionic-0098.adnet.avionic-design.de>
References: <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de>
 <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
 <4FE0EFBB.6090206@firmworks.com>
 <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6Bpfqm-0yGiBOXEhF4kD3PTDYvWVr0babLZ4GkBLXJiA@mail.gmail.com>
 <20120622110038.GA15212@avionic-0098.mockup.avionic-design.de>
 <4FE4A4B3.9010200@wwwdotorg.org>
 <4FE4AB2F.8090402@wwwdotorg.org>
 <20120625063456.GB11469@avionic-0098.adnet.avionic-design.de>
 <4FE9EFD8.6010608@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
In-Reply-To: <4FE9EFD8.6010608@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2012 at 11:22:32AM -0600, Stephen Warren wrote:
> On 06/25/2012 12:34 AM, Thierry Reding wrote:
> > On Fri, Jun 22, 2012 at 11:28:15AM -0600, Stephen Warren wrote:
> >> On 06/22/2012 11:00 AM, Stephen Warren wrote:
> >>> On 06/22/2012 05:00 AM, Thierry Reding wrote: ...
> >>>> Stephen: can you try to find out whether the Tegra PCIe
> >>>> controller indeed implements ECAM, or if this scheme is
> >>>> actually just a proprietary variant?
> >>>=20
> >>> Sure. I have added this request to the bug I filed requesting
> >>> more complete PCIe host documentation.
> >>=20
> >> I've received unofficial confirmation that we do indeed implement
> >> a non-standard/non-ECAM mapping, and what's in our driver matches
> >> our HW.
> >=20
> > What I don't quite see yet is how the extended configuration space
> > is supposed to work with the current driver. The PCIE_CONF_* macros
> > don't provide for registers >=3D 256. Passing a value higher than
> > that will mess with the device function field.
>=20
> The current downstream driver is incorrect for that case. We should be
> updating it (at least, I filed a bug to do this).
>=20
> Here's how the HW works (I believe this information should be in some
> future version of the TRM):

Definitely. I'm having a hard time grasping all of this by just looking
at the code. Some sort of functional description (like what you provide
here) would be really useful.

> There are 3 address spaces:
>=20
> * The CPU bus.
>=20
> * An internal (to the PCIe controller) 40-bit address space.
> Apparently the layout is HyperTransport-based. Whether HT defines
> this, or whether our HW engineers are referring to our particular
> implementation of HT, I'm not sure.
>=20
> * The PCIe external bus.
>=20
> Accesses from the CPU to the PCIe controller's 1GB aperture are mapped
> into the 40-bit bus using the BAR configurations in the PCIe
> controller; I believe this is what tegra_pcie_setup_translations() is
> configuring in our downstream driver.
>=20
> Accesses are then mapped from this 40-bit bus to the external 32-bit
> bus, I believe using a hard-coded mapping, which I believe may be
> inherited from (our implementation of?) HyperTransport

This seems to be what is referred to as the FPCI in the TRM and the
driver.

> For config and extended config accesses the mapping from the internal
> to external bus is as follows:
>=20
> In the case of PCICFG space,
> addr[39:28]=3D12'hFDF,
> addr[27:24]=3D4'hE means type 0 and addr[27:24]=3D4'hF means type 1,
> addr[23:16]=3Dbus number
> addr[15:11]=3Ddevice number
> addr[10:8]=3Dfunction number
> addr[7:0]=3Dregister number
>=20
> In the case of EXTCFG space,
> addr[39:32]=3D8'hFE,
> addr[31:28]=3D4'h0 means type 0 and addr[31:28]=3D4'h1 means type 1,
> addr[27:24]=3Dupper register number (i.e. register number[11:8])
> addr[23:16]=3Dbus number
> addr[15:11]=3Ddevice number
> addr[10:8]=3Dfunction number
> addr[7:0]=3Dregister number (i.e. register number[7:0])
>=20
> (in actual fact, the HW matches the top 16 or 12 bits to determine
> config/ext-config and transaction type, so the top two fields in the
> lists above should really be considered merged)

Yes, this actually matches with the driver. Config space accesses are
mapped to 0xfdff0000 and ext. config space accesses go to 0xfe100000.

> I hope this helps!

I don't know how this works out for what Bjorn had in mind, but at least
it'll allow the driver to be fixed for extended config space accesses.

Thierry

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP6qYAAAoJEN0jrNd/PrOhs+IP/jJLloVEBWU9WhLNIAMvwPGw
mL7t4k5gjDfA2qVyD+/BEXu+sOvEPoy3h6zKl7OHJZxO+KFKXoZZtbxBuDjhzkeP
pDcWzC48AX9iQAJq+XISBIrm0BriUCUyyewF5QjxFaEuBg523tdYHRAjLheppLC5
+lKCSN0npEFUG4sYFGUv5TynASIA0OUT3U5lBqnFUM5isqSWd0bcQAcrU2x6N0g1
N95ecZYUY/ynV6p1wY2H3byGSiMyRn7dQLie6TKoZbLZ4tCwy9t+RtISmwQldAYm
TxZLA/G0zRM/6O7+Vn1tj2zSpell291fxz6gas1Uo4rqGb3rHmihIs3q62oLyXqz
BjADb1oSGQzds2t+IiXcYml88vVYDbxmJLy0kDzhQgrtxvI0LAKA7jaisd27j3hh
jfcExEA41NytcFqRSTklmCs7kshwA0g8EHRs0mdGtfXtuehktp3GK6QpS5fayIay
RH9jIEFVJJnsz/tvAYKdcGEWB/BmCQeiyK0JgZ4yr+EOrXYJ5RmF/TvXWBydC/vj
LQYUSZ3CwKiXIPoJP9efOQPW0tE+YeCAfU49pGRfkmbpcxQUSrpnGOYwfZr41VQJ
qv6I9+KImXJMGe4e6KFIL7mOwYkQ7mPatV17nHb+MX2retkIvJ8+r6vX/o++5jP1
7tJYnhzcTBy7/hdrvqC+
=Aa/N
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
