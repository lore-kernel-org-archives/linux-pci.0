Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:50281 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757222Ab3HLQQR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2013 12:16:17 -0400
Date: Mon, 12 Aug 2013 18:16:13 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 00/14] Rewrite Tegra PCIe driver
Message-ID: <20130812161612.GA8282@ulmo>
References: <1376059772-16669-1-git-send-email-treding@nvidia.com>
 <20130809150831.GF25111@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
In-Reply-To: <20130809150831.GF25111@titan.lakedaemon.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2013 at 11:08:31AM -0400, Jason Cooper wrote:
> On Fri, Aug 09, 2013 at 04:49:18PM +0200, Thierry Reding wrote:
> > Hi Stephen,
> >=20
> > This is the latest version of the Tegra PCIe driver patch series. I've
> > dropped the PCI xclk clamping code as discussed and successfully tested
> > on Beaver. The patches that touch the PCI subsystem have Bjorn's
> > Acked-by and I've tested this on top of next-20130809, which has Jason's
> > common branch. Once he's comfortable with making the branch stable you
> > should be able to merge that branch and apply these patches on top.
>=20
> Just an FYI, I'm mostly happy with what we have now, except that I'd
> like to confirm that the build failure Randy discovered isn't caused by
> us:
>=20
> Randy wrote some time later:
> > On 08/08/13 00:08, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Changes since 20130807:
> > >
> >=20
> > on i386 and x86_64:
> > when CONFIG_PCI_MSI is not enabled:
> >=20
> > There are many of these errors:
> > include/linux/msi.h:65:6: error: expected identifier or '(' before 'voi=
d'
> > include/linux/msi.h:65:6: error: expected ')' before numeric constant
> >=20
> > because arch/x86/include/asm/pci.h defines:
> > #define default_teardown_msi_irqs NULL
>=20
> I'm having a helluva time reproducing it :(
>=20
> The next run of linux-next isn't until Sunday evening (AUS Monday
> morning), so we have some time to figure it out.
>=20
> Also, I've renamed the branch mvebu/msi_pci to more accurately describe
> the changes it contains.

Has there been any progress on this? If not I'll take a look at it
tomorrow.

Thierry

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSCQpMAAoJEN0jrNd/PrOhb6cP/0KK/Gsi1GIXPPKczSYQcAhz
vZb+rvYxwkUUYP+5eMqkFRhTz7Fuk9tE3Mij19Pl4+Dwue9xVvs4yNlQqpNqW4Td
FDPeDw7Db2BlHk/gB+BI3QHrQiN7UjRWeIYuFIfVo1GG8XGZMPtgNbk/oikSWbAa
n3a7dzI3/ws9AoSwzbPg0Kji2+O4lB2NC7tFziDoI7Vhe2LL22lFrnQGtPdNdvpN
MZMFMI8M/MmMkCCtkHWEdIaNur5PHxi0AhZVl8lR1WA1v7LF3kcLGTTDRSkgiIoh
7k6Q31fzyIPfC1td9zuLPZWDpCge1avJ4Ewj0lPAsvkYsKVKHOCXC2v3itUA0KrO
FKYzUPYUgnn7X14njUOKCijXUPTJLXi0TNxaktLng4WKc9hGKQnUpy5bCyqnj3CY
dXXb9PeGq6PXNujVq8SoAZD1Xe8+09C/M4MRq/Fuafq6POiTELJjUTlzpH4PDCfD
/TyZm1H9xd0Qd0Mm+UPtg+AJb+oAg9bwIWZx3hmdBeelT8bql9DDeO/mtwXmFONQ
ZwWaYqG+eKuz400ZA3q3s+FZF6lmKzmD1shODYxjgwGmT4ULepQMjQPrA7DX2Ng7
iVzuZ/1nPTrRjDiCK/LS7dkxNIXz6x1yl6ACYEJBTv9iALFyW9VpB8joZ/xaNNqV
k0OooymdN/idzSZ+k80a
=Y90y
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
