Return-Path: <SRS0=8Jd2=ME=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C8DECE560
	for <linux-pci@archiver.kernel.org>; Sat, 22 Sep 2018 18:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6702150F
	for <linux-pci@archiver.kernel.org>; Sat, 22 Sep 2018 18:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6702150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeIWA1C (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 22 Sep 2018 20:27:02 -0400
Received: from sauhun.de ([88.99.104.3]:51798 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbeIWA1C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Sep 2018 20:27:02 -0400
Received: from localhost (i577B9590.versanet.de [87.123.149.144])
        by pokefinder.org (Postfix) with ESMTPSA id 54D5B2CF608;
        Sat, 22 Sep 2018 20:32:29 +0200 (CEST)
Date:   Sat, 22 Sep 2018 20:32:28 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Tho Vu <tho.vu.wh@rvc.renesas.com>,
        Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] DT: pci: rcar-pci: document R8A77990 bindings
Message-ID: <20180922183228.GA841@kunai>
References: <20180922150252.18754-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20180922150252.18754-1-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 22, 2018 at 05:02:52PM +0200, Marek Vasut wrote:
> From: Tho Vu <tho.vu.wh@rvc.renesas.com>
>=20
> Document the R-Car E3 (R8A77990) SoC in the R-Car PCIe bindings.
>=20
> Signed-off-by: Tho Vu <tho.vu.wh@rvc.renesas.com>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlumirgACgkQFA3kzBSg
KbZzfg//Q/liyzUnb+iQUhyiqexfw4hNGFpTaTHksVptOtHAVtCYd6K8UyDXyf2T
/3NbZN8D6d2tMrvk2qkkeELucakzKRDDj60FMU3hHJSqT3g98kIsWCSIb6hDBS+X
Pt3yTQDtN0lFcBGTRKXtSsqXY1RPthLkuWoQ1XNJOnuOMYInl7pu4iVGSEtQkaGE
QeoJiz8JmoTCpiGNjUmiclUhaEF0Rs/YQ7jBK5nJY91IsXI8IPJSI1HfjP8rJ+q2
aRc37JFApwY6JZbW46EkU8ib1hEhNRiiKts+hjWe6NZLec7sPgrmFu7hYuWWe09r
hLd0k8umHbb6SQJ/N/82PMwz+pDcJZxHvp0JgiupYLzXpdkaTSsr7/w+Gp6VA/CN
3P6p4Ot3PVICseOw94Jm+GhlOeEdaJ0nYFAC8E/WZqDCLT6ANW1zdsI53xOzJP2Z
xgriYdpGKgFup2NGWcoxcjWAtc2OU7+G9OETXIHFWRTl2wmyYdn20ik0ckkJ0M93
aBFMTL6Cm1xBCT8lyhy+qccW5zqWQXhNT12pN6nndHLLZ+9SDxXtxrWzLvIRbrHs
Wn+Vgwxdth0hqHWf7PeTV6ly5P+nfKp3kTO/eyd0pZGueyLmo4KAClGvhfc1iJhZ
+TrT0kc5PfdeOzC61sYyTlrHaq7iBt1HmjWoc3wMVkPy5T2qAVM=
=u2Ic
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
