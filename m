Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61267 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab2HPEz6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 00:55:58 -0400
Date: Thu, 16 Aug 2012 06:55:39 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>
Subject: Re: [PATCH v3 10/10] ARM: tegra: pcie: Add device tree support
Message-ID: <20120816045539.GA17067@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo7c4L=Ny=CtZwLB_XWTcN8tVWs_quuE_T+XLEGyhWwHkg@mail.gmail.com>
 <20120815145708.GA11331@avionic-0098.mockup.avionic-design.de>
 <201208152025.25252.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
In-Reply-To: <201208152025.25252.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 15, 2012 at 08:25:25PM +0000, Arnd Bergmann wrote:
> On Wednesday 15 August 2012, Thierry Reding wrote:
> > Yes, that was my understanding as well. So currently I haven't seen any
> > problems with this because I only use one of the two host bridges. But I
> > suppose I should add code to initialize the bus number aperture properly
> > either via platform device resources (for the non-DT case) and the
> > device tree otherwise.
>=20
> I think when we last discussed this, the assumption was that each
> root port has its own config space range and its own pci domain,
> so you don't have to worry about bus apertures because each root port
> can then have all 255 bus numbers. Has that turned out to be incorrect
> now?

At least for the config space this is incorrect. There's a single region
to access the configuration space for all devices below the PCIe
controller. So it is shared by both (Tegra20) or all three (Tegra30)
root ports.

I'm not sure about PCI domains. Do you have any good pointers as to
where I could read up on them? If they need special hardware support,
then I think Tegra doesn't support them either. At least I haven't come
across any mention of domains while going through the, admittedly some-
what sparse on PCIe, Tegra documentation.

Thierry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLH1LAAoJEN0jrNd/PrOhIHUP/1sOotMJa3z1fX+uxtQju+6D
vi144oZ8Bnt6TrwcXfY9uF6GNwH1gwUb5lDqt09axW8kPipsJCwIdx3PIh2tUfsV
rEmznl33DkbybXaHfC8N9DMHvcehkrTikev5DYrBif+4gXC2WUfjbjzlv1kUP0y8
hedhqpVRIAxTCfcgeQgFhSJouzZWqUI2F0e8vGVZTd/NmBXhWdg7Xqjoz3GFk6yu
bXmidOv5j/3tArrAPM5d1dmKvbzDGQCB6Z7nFX5m0AD0/3f/vpWMq9/MUiZqUjws
0ziTwYUQP2lLzlnwu67jKHK25W4uFGylTy35DBQrPvJ5Y9kD0qiRTNDKvHBUOdaI
qZnfruEYEu2M9W/DpHOcnZ0nkwQMcybx7lyknU6TWiOF8nSOxdy62E1KKYYjJ5Cy
K5/bSIaKFhiewOwawdLYULFguudnCsgtOcmJWlLdrat7rKJSFDGsqfbJCJjY0Dan
HQ597/I8o2lqh0i+Nl4xo0KexyFm6KxeWK2B5/870jZsBzbemcN3Ka0MCORxtDmp
JY3/PW3Fc2znMm7WFFbi/5rwNe5M4cXQLxOTBLA0Itp5AjREIkmmp/Ruus8N0bH3
1NVWh65ZwCB1Tw5CO+WndWMgm6IuolKCBdCtpMN8BNAoORZVaZS+PuzyNaukZGiL
ltBBCoPWa/4wHFTMwsXF
=POl0
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
