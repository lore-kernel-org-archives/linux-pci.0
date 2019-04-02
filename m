Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C454C10F00
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 06:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A36620857
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 06:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfDBGYe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:24:34 -0400
Received: from sauhun.de ([88.99.104.3]:37286 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDBGYe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Apr 2019 02:24:34 -0400
Received: from localhost (p5486CD10.dip0.t-ipconnect.de [84.134.205.16])
        by pokefinder.org (Postfix) with ESMTPSA id 0E7122CF606;
        Tue,  2 Apr 2019 08:24:32 +0200 (CEST)
Date:   Tue, 2 Apr 2019 08:24:31 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V5 3/6] PCI: rcar: Replace various variable types with
 unsigned ones for register values
Message-ID: <20190402062431.GA998@kunai>
References: <20190402013307.20912-1-marek.vasut@gmail.com>
 <20190402013307.20912-3-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20190402013307.20912-3-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 03:33:04AM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>=20
> Replace various variable types with u32 or unsigned int type for
> variables holding register values, since the registers are 32bit.
> Note that rcar_pcie_msi_irq() still uses various variable types
> because both find_first_bit() and __fls() require various variable
> types as an argument.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Good that you found phy_write_reg meanwhile. I wanted to comment on that
back then but forgot the mail in the Draft folder :(

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyjABYACgkQFA3kzBSg
KbbLRw/6AyTSpYSyPPN9jWqJYQpehZY2k/RseaQL5kRtcisFoANLjyh6NBNmrkZg
FnlClBU/kW/mGxBqiITYDR8FkREIj1xNx+PHOUAqG4lwE2KnSG5H+HMZF7ItyX60
yQv0mISJNiRxYJt6FIdE7/lR5IdDWn701y9TPBdLqY1WXhKI4t7sBgXgm7mx3GqM
e/mGYYDJTzwlrXDZHSwJBaEcYcek0UcuXZs8Y3/CDNJ0OxirdNtTaNPrVwN0ck7f
5t/X2h4zsSYwlo+xweHqOR3nYffkqtKjoZCLld1QK7y7/9t6moCM0QzlPR1CpdZA
0amIsXuxIu3+mDr4I0BkaJ3/Hc+00bRRCtfAPtc29s3k5zxJUhNeXRSHFiq8FZW3
xQYlPist0pmb/7oLsQ80ZHZiGt+b6SonoJyvzrVC9EqJgvDet7eaHkMOKVWXmYL9
tu6yzZMmr3rBLSugL29dB31AHPQC/RwNAQr0y0h1XwtuVIZUugjVpG+6jgsuQeGr
a7QFclH4aqUd6BTQ1v2MCrIQmSAcp86uBnhYQxi9siIHxvcuyE65FzPAtbcC4rKq
4pSexygTtJc2ChOLNFX4zd3ocGzHQ5US5WkRfetT+PxGHN5H9Dia0o9ti/9YoPyi
+UiJGH84mZQx/p6KoqgAXOEXpQEUe82IH40Arll83MfIHUes4Vs=
=2B8W
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
