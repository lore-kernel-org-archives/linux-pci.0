Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54398D5E
	for <linux-pci@vger.kernel.org>; Thu, 23 Nov 2023 23:07:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6QHT-0004Gl-Hg; Fri, 24 Nov 2023 08:07:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6QHS-00BDOv-Cm; Fri, 24 Nov 2023 08:07:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6QHS-007Fr0-3c; Fri, 24 Nov 2023 08:07:14 +0100
Date: Fri, 24 Nov 2023 08:07:13 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, lkp@intel.com,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kernel@pengutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] PCI: host-generic: Convert to platform remove callback
 returning void
Message-ID: <20231124070713.gsgocfztrc5jg5dr@pengutronix.de>
References: <20231123171236.tksz4lhpj5jbwfxm@pengutronix.de>
 <20231124032535.GA351419@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xvn5blfgsm7ljc2m"
Content-Disposition: inline
In-Reply-To: <20231124032535.GA351419@bhelgaas>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org


--xvn5blfgsm7ljc2m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

On Thu, Nov 23, 2023 at 09:25:35PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 23, 2023 at 06:12:36PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Nov 20, 2023 at 03:56:18PM -0600, Bjorn Helgaas wrote:
> > > Applied to "enumeration" for v6.8, thanks!
> > >=20
> > > [1/1] PCI: host-generic: Convert to platform remove callback returnin=
g void
> > >       commit: d9dcdb4531fe39ce48919ef8c2c9369ee49f3ad2
> >=20
> > Thanks! This branch isn't included in next. Is this on purpose?
>=20
> To reduce the workload of the folks maintaining "next", I wait for the
> 0-day bot to build test a branch before merging it into the PCI "next"
> branch.

If this isn't a mistake (or a hint to me that there are problems with
the patch) everything is fine on my side.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xvn5blfgsm7ljc2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVgS6EACgkQj4D7WH0S
/k5tbAgAi/6NUCGWuLxEg+u4b/aPGRdppofCSlzeqZ/pci6wfExOXSrO5GV++emj
dAcGR1a+plkIKJXMY+6MiSAB2UGgUthPOuGabHTJvstqbj2PGjjKNsvoWC+xXgSN
Lu3q3WB6qN4hNAuLI08Zs9XUgijg5kBIrmdRyv6oMO0b/isbyGX/NXz6+O3MqRH9
ZFPtyRNfFA1UcW7tBoWakBtzxr7D6IDg02NzpLuHpUbSyDpMWpizWz7pNILVf69k
9pYcRCiTPRMv7TzyYB6bIfZZ1kRHmEnvVxW1rPtGpY7Qeb+gAmtoIDYvBL5FVTgB
jjEuDlE5nTvxzBazYxfLIO1yRzg4mA==
=vxwM
-----END PGP SIGNATURE-----

--xvn5blfgsm7ljc2m--
