Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58680 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab2FYGfI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jun 2012 02:35:08 -0400
Date: Mon, 25 Jun 2012 08:34:56 +0200
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
Message-ID: <20120625063456.GB11469@avionic-0098.adnet.avionic-design.de>
References: <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de>
 <4FDA40A0.4030206@wwwdotorg.org>
 <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de>
 <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
 <4FE0EFBB.6090206@firmworks.com>
 <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6Bpfqm-0yGiBOXEhF4kD3PTDYvWVr0babLZ4GkBLXJiA@mail.gmail.com>
 <20120622110038.GA15212@avionic-0098.mockup.avionic-design.de>
 <4FE4A4B3.9010200@wwwdotorg.org>
 <4FE4AB2F.8090402@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
In-Reply-To: <4FE4AB2F.8090402@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2012 at 11:28:15AM -0600, Stephen Warren wrote:
> On 06/22/2012 11:00 AM, Stephen Warren wrote:
> > On 06/22/2012 05:00 AM, Thierry Reding wrote:
> > ...
> >> Stephen: can you try to find out whether the Tegra PCIe controller=20
> >> indeed implements ECAM, or if this scheme is actually just a
> >> proprietary variant?
> >=20
> > Sure. I have added this request to the bug I filed requesting more
> > complete PCIe host documentation.
>=20
> I've received unofficial confirmation that we do indeed implement a
> non-standard/non-ECAM mapping, and what's in our driver matches our HW.

What I don't quite see yet is how the extended configuration space is
supposed to work with the current driver. The PCIE_CONF_* macros don't
provide for registers >=3D 256. Passing a value higher than that will mess
with the device function field.

Thierry

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP6AaQAAoJEN0jrNd/PrOh5f0P/2UWCvxdUvUephO7nOcSOc70
+UVXN+rGxZmpCufEtCFKm0vFZIVjXsTII1HJygzexSFRKTLp8nhlw4iAFfSs+Z/7
RxiDcu/zcxwfMzEaCKwfk/nDeLrGgD/z2gjygr5dWfOM/8qj080Qzn++7s/YpS6h
we55DD1PGfiHVWzC5QYsWtukpghp0It4up4Oj8/vRTGJJrx5hgpoIQeb2AumN8Ou
cugRMxO2LrX9pHQXqqznoRW6O3XYVasyn5nhqcY5a79f0iY8FEkULv8ii5h+mGEo
EF4ny5qQ5wLzbyxosvLgpE0iZChVK8P2nbd0jZoYYX4MyNVeOo1SuUhd+viUL3TA
NUi8WJV63gVbIJW6UgzFXdr5tGqHCKZi/CbLKes/UYes0q6TGOz7Ulue7xfyN2Gr
8nMYJXZSJ3xyye2/wFtpeGPIKR5nZJE+czLkGSAlyUNz5fRG/rhT29pznH48VkM1
z5r38ayFkVBMh+0BWUHYc+D5RHWVCrQOvjpFx9VIxxKyHk9YNwdGc4j1c/mRrw3W
liKhbxTsV5CS2Ue/3LPAHaXisKLen7kDYhb39nzkNuuIfoHbN32KY/tibs+Sx/2N
hCEPdZCe7UjFR8WalH6xo2XHumfnTussUf8h2r34zOJUyDIjWTpKtrjUIPC5tGfJ
4Fw9cjlJWmE4BehareQ6
=VlSA
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
