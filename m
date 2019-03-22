Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F171C10F03
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 08:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0AB21873
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 08:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfCVIUQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:20:16 -0400
Received: from sauhun.de ([88.99.104.3]:48670 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbfCVIUQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Mar 2019 04:20:16 -0400
Received: from localhost (p54B3303C.dip0.t-ipconnect.de [84.179.48.60])
        by pokefinder.org (Postfix) with ESMTPSA id 90FAE2C08C3;
        Fri, 22 Mar 2019 09:20:14 +0100 (CET)
Date:   Fri, 22 Mar 2019 09:20:14 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2 1/6] PCI: rcar: Clean up remaining macros defining bits
Message-ID: <20190322082014.GB1005@kunai>
References: <20190322023844.18574-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20190322023844.18574-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2019 at 03:38:39AM +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>=20
> Replace macros using constants with BIT()s instead, no functional change.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyUmr4ACgkQFA3kzBSg
KbYmLw/9FHc40IS4NJ24rvmvAxyzg9i8URsZIeSU1qQxwTCJJVtRaO9We8oUCSDH
huk7g5pkVi3/zvD3zMxbg5oq66Zsjo4vsx+u1ZchXjmYykvAYoVqPomQIAR5la/O
JPgLUimCEhZRSnmZ/i6U6ZM1s1bNWSavOJxQOXAMfyvD4lZlehCrCbNExY2FGaMI
dUbsMP82arDZg0A15qr/bjwJ0fjrb4ZF6IE6hIbd6Yaxn0RnAuieoaU0NxlSWhkd
BwBBmK5N1Yyo6UIdtXE0Bnxbfe3WuTCNFWVjnmoBKKFmyPyiitsM1zyEZqKXSeq0
+osH+5kyESJsvzdRDXiyGay+LgFQMUbOqUbSFqdw13FYW/e8uMenqkck2Tfja3vY
owuTb50v21Npi0Ql+hB0RWC9LgBvRnuoz6Uuip8egox/EQBqbej/yZgwSr+dkLZj
MeHt8bljjWIjrI7eJMcWv6i5fsA5F4BwJQWnBmLYqyDrKyA2mPF0woNVhvqQng+W
UEGW3V5jx1aI6Ec5ecLECZOsQLRScheUHxl5emhM9RDCMU/ljjc6Tjn3Bi+V88yC
yFjkzctfnBQ32mRHbclkblB75TCqw21VFlEitzNX8gyttkOdLgZOpSTNGTQqZjPT
knTdTboI27pb/splWrkMxLpCBOunNfsWJc9w+A7TdgQoN1gjd70=
=WsLH
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
