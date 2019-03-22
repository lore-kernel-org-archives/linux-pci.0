Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882B4C10F03
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 08:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D9F205F4
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 08:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfCVIUf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:20:35 -0400
Received: from sauhun.de ([88.99.104.3]:48686 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbfCVIUf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Mar 2019 04:20:35 -0400
Received: from localhost (p54B3303C.dip0.t-ipconnect.de [84.179.48.60])
        by pokefinder.org (Postfix) with ESMTPSA id EE93A2C08C3;
        Fri, 22 Mar 2019 09:20:33 +0100 (CET)
Date:   Fri, 22 Mar 2019 09:20:33 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2 2/6] PCI: rcar: Replace unsigned long with u32 in
 register accessors
Message-ID: <20190322082033.GC1005@kunai>
References: <20190322023844.18574-1-marek.vasut@gmail.com>
 <20190322023844.18574-2-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <20190322023844.18574-2-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2019 at 03:38:40AM +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>=20
> Replace unsigned long with u32 in register accessor functions,
> since they access 32bit registers.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyUmtEACgkQFA3kzBSg
KbazZQ//ZLF5h6Dst4bfw/W/O3sGUiQI0L74R6aE6fmUlzqyXX/o1KJbo2MtynwA
YUFqNzf6Xb5GCwBMlL7sH8sQdag6OcYLBv793V+ZX9r9iI+B4fE6dB2voE7TLXhp
lVOxfE1Sc4nW/LSwXLkVGseRCKh9tSL5CnFmicVbjbN3+Boe8VfDrivS490g/cPo
Hs1pHuiagRRO6voRHadlBirbfIeeGWpTp2BOluhWHx3MaZebp8pRKRwP3pwuIiTc
DaFiNhgdgfdQVCYyDE8L3oxOC46ixmWzHDw/6pSAUnAcgvY2q4YVawrsA1j1SGJu
kSoVOBhCGTXiaGCjHe38CNwrHpBVUEQcXHPVkS0QE54r9g/dTLX1UQgOBBIu+p55
i+vsEi5qzamIaZz0i8Wb1+lQxBkfpfyGob7dPetziw/+J48Ly028d6N2h1SRH9qD
l9Q8uc/AmQnfJWs4MDghDXO0uvAIc4zO6zfIG/w0lw7sRQt6+6+s6xKEkhpvPFBx
iZaGPvuP2KDDLgNztzyQIF5W4+xihs1MLltPh0NnNqiWQgA6DrP8WpA8pVVLZqld
Wb5so9CWotpekq8ZMPrzd47XIquQWj8XvqMpz6f2ImYDSk5vEcG+SPOVwimensYS
cbGnKP79y6XiIiHx64+M6frKCtjXrHPtl+iNPPrAGMg4y5nd0X4=
=KEZI
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
