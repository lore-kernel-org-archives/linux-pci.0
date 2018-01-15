Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55348 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbeAOKnT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jan 2018 05:43:19 -0500
Date: Mon, 15 Jan 2018 11:43:16 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Fabio Estevam <festevam@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ian Ray <ian.ray@ge.com>, Nandor Han <nandor.han@ge.com>
Subject: Re: Regression due to "PCI: Do not allocate more buses than
 available in parent"
Message-ID: <20180115104316.k7xsu3qnnmzvlkpd@earth.universe>
References: <20180112150744.sjntmpas5noaub6g@earth.universe>
 <CAOMZO5BpJDoeZVaD+c600ci5rmEJ0kh_er1voJxsyXR4BdjFpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ngn6m3bj3rwuclms"
In-Reply-To: <CAOMZO5BpJDoeZVaD+c600ci5rmEJ0kh_er1voJxsyXR4BdjFpw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ngn6m3bj3rwuclms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

On Fri, Jan 12, 2018 at 01:17:26PM -0200, Fabio Estevam wrote:
> Hi Sebastian,
>=20
> On Fri, Jan 12, 2018 at 1:07 PM, Sebastian Reichel
> <sebastian.reichel@collabora.co.uk> wrote:
> > Hi,
> >
> > I have an ARM/DT based system [0], that no longer finds its ethernet ca=
rds
> > behind a PCIe switch. I bisected the problem and ended up on
> > a20c7f36bd3d. I tried providing some space using the suggested "pci=3Dh=
pbussize=3D<N>",
> > but it does not seem to work.
> >
> > I added dmesg for working, broken and broken + parameter below. At
> > the moment I would say this is a regression and the commit should be
> > reverted.
>=20
> Does this patch fix the problem?
> https://patchwork.ozlabs.org/patch/857566/

Yes, that fixes the issue. Thanks for the hint.

-- Sebastian

--ngn6m3bj3rwuclms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpchcAACgkQ2O7X88g7
+pqV3w//blFbcgZ9oXiVkb6kh4vEPTdaZSNR7Jw0QO8iatrGqyBZ4HlWEpJMF8TE
Sebga+F12AIgAnrBkmRvpvrB5Vws11u18PrxxE3bIoxTPzAzRT1maqBfompM+aQN
FmAFU/Rl2IK0VOuz+mP3GeXVsN/6qCrsvkF28whMgGrn8tC2oYvWWSxrrEk2Kasp
W/feDDu590XHMVT03CYnF1Cd1oSgthjw8Yd1AHNGT2Xld8WeIeMZEA3VDX1XFw2W
bSA1a0OUh3C7BAadep7EDQGA4shMLRfEqPqZABxNZsdDmBWGSpMJeszg843806Cz
93VlDSGDNLmqvjt83v93l2qDIriSsCowz2sX8i4M32s3rDFLxy63rNRGnQqp2ylc
GPuyC3YobL485914YNi1nrlO2OwpNT7UTJTwSl0HcPHbgaVX8gfZUECR7VEnLjXy
w7Td7ZHQsWvErNg4v+1tmEQTZc23YWRnjwlbZUrt0RZ+pXf/3jhHq7workRqNlir
OuKc1YDphjKyEISxCOugbRXlj77HwKJFs1dEau1JQnxoxx7aXrZdqJ/8O76DQSS4
9BoTgq0N7cMyQQ6rt9zcL0ypzLelCHhgEoz5gW4VUxXXQPIbn6w1zMMzb4Y0Q1g7
Hy35EqH/jo+KJ51bIHP2TxwxjtVwIM1iRbRprb+5e25mCQizZuk=
=s2tQ
-----END PGP SIGNATURE-----

--ngn6m3bj3rwuclms--
