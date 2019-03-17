Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FE6C10F05
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 09:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A916421738
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 09:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfCQJP0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Mar 2019 05:15:26 -0400
Received: from sauhun.de ([88.99.104.3]:52426 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfCQJP0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 17 Mar 2019 05:15:26 -0400
Received: from localhost (ip-109-41-130-14.web.vodafone.de [109.41.130.14])
        by pokefinder.org (Postfix) with ESMTPSA id 271702C27DA;
        Sun, 17 Mar 2019 10:15:24 +0100 (CET)
Date:   Sun, 17 Mar 2019 10:15:23 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: rcar: Clean up debug messages
Message-ID: <20190317091523.GC2268@kunai>
References: <20190317000608.24881-1-marek.vasut@gmail.com>
 <20190317000608.24881-3-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <20190317000608.24881-3-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2019 at 01:06:08AM +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>=20
> Drop useless casts from debug messages, they are no longer needed
> due to the data type cleanup.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyOECsACgkQFA3kzBSg
KbafuQ/+IDXhAF7GG5/jAjIYJ/5DDa9ht2TnLqyuMKp+OXPuJFRNZQsoby+GIDc2
fZ8Z3UDEJIORxgSBeU5FHW2pkP9x0Z28bPa4aRkXYWmgeH3khkwih4fsAxuwHOXW
zTrOhaAIn+ZHdpyMFKqy6Nls9iprN2dmmcjNgTOe7NhpPh10fwoFxDzaq5JAquoa
nO6swWo+ki3ivlVFVcfuAlyl0/fe7dKgGjNjvmylGc9dNIzZWXV03RUj6acKfIxf
xhxEcjM0slIWdVeVGLaS6eEPwIOhxiQf+dwIhGCGEMgW15dUe9Ezzitinp/9k9J0
gj3Jb+nWT10deiXlNTtm83EKC54k2tAhaUgICjajQfCjAvK3Z5tTqJC79mTj9Zz/
1gk7NAE1wZxTHFQO6uJCg1CS3dn1CRi1zK3UIu/BASaoShQH1wftt60nup405SxT
2XcVpZ9aKQuDbI9j+mSl8PGJ6S3gSEn5fhuTCLdWLo7pPSdGfVt0PuYyZSA/Rh6r
9tp0TAGkBBmoHzrgxRtEIKuxGP6tvzzPcAWU+hjzcOkn9lXzHfgJTJkjgw9KQMWu
YB8MLbqM9JWG2xETJZz+6GCUV/ON6Al7gJwni/DjBJnGOY5xqH1SDd0nzsXiYm3h
FmrY+3tbrQ1gGGjMut9EXIQZaFd0IXT0/LiwOE7bSurcVMjKZ/M=
=FB96
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
