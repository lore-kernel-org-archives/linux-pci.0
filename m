Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E181C10F05
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 09:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9B7218A1
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 09:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfCQJJE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Mar 2019 05:09:04 -0400
Received: from sauhun.de ([88.99.104.3]:52364 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfCQJJE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 17 Mar 2019 05:09:04 -0400
Received: from localhost (ip-109-41-130-14.web.vodafone.de [109.41.130.14])
        by pokefinder.org (Postfix) with ESMTPSA id A139E2C27DA;
        Sun, 17 Mar 2019 10:09:02 +0100 (CET)
Date:   Sun, 17 Mar 2019 10:09:01 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: rcar: Replace unsigned long with u32 for
 register values
Message-ID: <20190317090901.GA2268@kunai>
References: <20190317000608.24881-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20190317000608.24881-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2019 at 01:06:06AM +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>=20
> Replace unsigned long with u32 type for variables holding

s/unsigned long/various variable types/

> register values, since the registers are 32bit. Note that
> rcar_pcie_msi_irq() still uses unsigned long because both
> find_first_bit() and __fls() require unsigned long as an
> argument.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
=2E..

> -	int shift =3D 8 * (where & 3);
> +	u32 shift =3D 8 * (where & 3);

Minor nit: Since this is about shifting, maybe replace 8 with << 3 while
we are here?

There is also a 'shift' var in rcar_pcie_write_conf(). I think we should
convert this for consistency, too?


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyODqkACgkQFA3kzBSg
KbYsYxAAn5gTKZySGDXx6NihcdKocAs1T2J+FKUmI8K9eQtk/vzUMOECUaCqPf+3
xurHsrPdDVRhqXUoK0UAFbg1PXXpyER/5sigAnhS8IgEaV3l+/BSzphMeUPBzY6z
vcXEIq269tOmPiJ60jcEfNvY9el8Wlt6+ILWSzdLdpgIfNbAnRLXhZROa/ndLM5l
Xu9uhln4kpUlmHfAGTcr4lWuYr2daVfTzDCS7ECuJ/+loSbLRlrkOnC7qkFbAf//
1txYNrdaIAj6lromIUR6qUpINB0Dbggfv+8VPBLNgxS2Dp2rTU3khzgHz5LKraXk
ph9Huv3dg2lue2hpXs1/zQj0C61IJvRs9CMAXXW0gQWagw9K9RoRZY+E413ZFBgv
RCZV0opwXNPOe9LkU2MTOi2JzKuCPrSgRvxrkxvsS72lebEV+rC2QpV16B6YIKaV
oR1z5LsSOY5mcvyruOPnxAVJ1SbsQU3VaaD2a1vovKgaixSUjP6hKb/LYjDgeeG+
oALCxk1uRZQRWv/UCYSY66TKk4ziteP5/O+pLYsk4Q68uicF2wRSYpRcX+keH85s
mu6/AFm+emu0XG2Jk2fDB2WxIpK0EfKuwk0+IEn//xCAxMlTAHIqpsb+yoWo2/WL
CbdgOZ9K9VSUgzdWBrpkHvANRH0TUls/k6srugAy1T+qDll6xsk=
=RClu
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
