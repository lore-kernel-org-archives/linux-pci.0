Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 Nov 2015 11:29:56 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Thierry Reding <treding@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>,
	Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] PCI: pcie-rcar: Fix OF node passed to MSI irq domain
Message-ID: <20151123102956.GA1524@katana>
References: <20151110155232.GA25368@ulmo.nvidia.com>
 <20151111163802.3a96080c@arm.com>
 <PS1PR06MB11806B2B906CABB553B94442F5120@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151112203100.2e91da2a@arm.com>
 <PS1PR06MB11800B547C8957B226077B83F5110@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <564A2101.90600@arm.com>
 <PS1PR06MB11804FF05BBF30F2CA2083FCF51C0@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <564EECA9.9070400@arm.com>
 <PS1PR06MB1180D8114604DE8AC1125E96F5070@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151123101521.07e8dc9b@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
In-Reply-To: <20151123101521.07e8dc9b@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marc,

> > > Can you please give this hack a go and let me know if that helps?
> > Works for me!
>=20
> Cool. I'll post a patch with your Reported-by/Tested-by later today.

Please put me on CC as well.

Thanks,

   Wolfram


--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWUuqkAAoJEBQN5MwUoCm26JoQAJQuQOnV0+0+AdrJ53Ge2IKr
XUygCQrteY/5Y1wUsrgdUHz3qirCCcoT316SmeisQ1XAfrkLkRswBlJRdpn0dFfE
UeqO+E1Izl8HipTvMiZ/QiJ3+swDQ6hM05eIBhrgd1+mi/d8f7pn2ofQOetiCjXw
n6NylTNFrURcLfXbFDRxsK7if7CJLoRKhyRsLcuRZ3C5t+X1MpRfAZ4RgX00ECdH
xX7xc0ky5AwtGZzIGOlEk+gHertK5lafMHT4poEIECesh592enw/8UuSHEvieStK
sRPHfzH2esvLJ8VYQK3a5dRHl5GRhetyp3pOfpaW5mf0nV74M/P3Ezcetm+74RhN
Jy9zPT33EIL2LTu+uicgmYb8hK2axxBfJ/wzN8NRVri14eNx8P1JL/MBCoBsmoB4
nobO/4G+4PSK9W7FefQOzhBQbkuNBUtNQc42I4Te6thVit1aXcn5Mw8TArr352M2
XbbphT0Qpct9iHnoAtvJ+px/UNbrqmhc2FWHtDC6/Z35Poc1EICrnxYgojBhz237
FEsht9qIpt0PG8eua1LtbGzZjrSK63H6vKtQf+8eKWVAyFykZggKza+K/wD/pRM1
YJY8Axuax57//q/Mt9e96sW4ZaMwOEX6pvOiYWkZhjl+cum4Y5CpNrzlIOrIwB7C
+FO1WM3EKm3K8smdYdeg
=0i5M
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
