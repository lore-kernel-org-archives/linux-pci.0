Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33195 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbdH2PJU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2017 11:09:20 -0400
Date: Tue, 29 Aug 2017 17:09:16 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: bhelgaas@google.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use PTR_ERR_OR_ZERO
Message-ID: <20170829150916.GA17659@ulmo>
References: <1504013940-16304-1-git-send-email-himanshujha199640@gmail.com>
 <20170829135517.GA30733@ulmo>
 <20170829141401.GA18389@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <20170829141401.GA18389@himanshu-Vostro-3559>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2017 at 07:44:01PM +0530, Himanshu Jha wrote:
> On Tue, Aug 29, 2017 at 03:55:17PM +0200, Thierry Reding wrote:
> > On Tue, Aug 29, 2017 at 07:09:00PM +0530, Himanshu Jha wrote:
> > > Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> > >=20
> > > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> > > ---
> > >  drivers/pci/host/pci-tegra.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegr=
a.c
> > > index 9c40da5..90cda5b 100644
> > > --- a/drivers/pci/host/pci-tegra.c
> > > +++ b/drivers/pci/host/pci-tegra.c
> > > @@ -1156,10 +1156,7 @@ static int tegra_pcie_resets_get(struct tegra_=
pcie *pcie)
> > >  		return PTR_ERR(pcie->afi_rst);
> > > =20
> > >  	pcie->pcie_xrst =3D devm_reset_control_get_exclusive(dev, "pcie_x");
> > > -	if (IS_ERR(pcie->pcie_xrst))
> > > -		return PTR_ERR(pcie->pcie_xrst);
> > > -
> > > -	return 0;
> > > +	return PTR_ERR_OR_ZERO(pcie->pcie_xrst);
> > >  }
> >=20
> > I'm not a big fan of this construct because it's a pain to undo this if
> > ever we need to add code to this function. But since we do have scripts
> > that will flag this, I guess this would pop up every now and again. The
> > driver is unlikely to change in this part, too, so:
>=20
> What do you suggest ? Shall I stop sending these patches ?

No, it's fine. I'm just saying that there are cases where this doesn't
make sense. In this case I think it's fine because the driver is fairly
mature and unlikely to change, so there is not a lot of potential for
churn later on. In other cases, use your best judgement.

Ultimately it is up to maintainers whether or not they apply this kind
of patch.

Thierry

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmlg5kACgkQ3SOs138+
s6HMxg/9FcmRwZMbZKG5CklkngzSeLIQUcvTvVsphfdQJ6A2KtO8ovbQLhzAnK5G
Bua2K/o2Md6p/jfOxP3qp9zQ+S4nfQbxOpWlvAFRWKTT/8Qy+61hSF9ahMe9QDEC
ZQQGnR5dX7Ler3CR7OXIIY4y7YJFSter5yJOMihP51IvDZJosi1d6yA02z5CXZqR
CI+wch0Zuun3n4TkZhuW/ZEEG2UNtRqOziAYdKgHKQ+ZaXmigcuCZarbcbbfYNVS
LFYA0cdTZgtmFlGWcwmVPkshUlkk+MICLBXdEUtpH2rbRcyzGXF4vswXhCu1esnN
/QfRjeAbA/B1GlaIsoQ70ovFNYD3JOKGqHPh+6QZj+K0cQy/LrU+1vMBZ3S9Nfv7
F3Z7S2kmBu39N8XK3SQZWxrcieiE+tmPGU57L636WbPcQaBUQbGhxaFftppfL0o8
mlvtn9utbslUja5aFtf0jp+kFQzODB17nXfGnDfUgzSpoKZvWPRj88YgNDMt8Wva
mFwE9UzXvs62GP1OKdlyZLsrX+bA1likRtAcGEdOO2gWvo+FRYl6x+dd/xRCQQ7F
eyf9CEC+hCH6NPEB0UbHie2uKVU96A8aZsqSEjTS19BPuGQb6/2JYdUpOtVg95Xc
KsBulpKUQe26iVH2BlwihPes1ycKtGDP9iMXQTfGkQv2ZeAuVoQ=
=kM1S
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
