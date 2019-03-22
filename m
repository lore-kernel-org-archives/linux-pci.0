Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD34C10F03
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 08:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A528205F4
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 08:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfCVIWc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:22:32 -0400
Received: from sauhun.de ([88.99.104.3]:48724 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbfCVIWc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Mar 2019 04:22:32 -0400
Received: from localhost (p54B3303C.dip0.t-ipconnect.de [84.179.48.60])
        by pokefinder.org (Postfix) with ESMTPSA id 7886B2C08C3;
        Fri, 22 Mar 2019 09:22:30 +0100 (CET)
Date:   Fri, 22 Mar 2019 09:22:30 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2 3/6] PCI: rcar: Replace various variable types with
 unsigned ones for register values
Message-ID: <20190322082229.GD1005@kunai>
References: <20190322023844.18574-1-marek.vasut@gmail.com>
 <20190322023844.18574-3-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <20190322023844.18574-3-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	int shift, ret;
> -	u32 data;
> +	int ret;
> +	u32 shift, data;

This 'shift' is u32 instead of 'unsigned int'.

Rest looks good.


--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyUm0UACgkQFA3kzBSg
KbZIeA//csxx98JWrWpe1dfgewOsaY9bnYPKnk6meu+v2YCC0K9VhI0CBOAMezUk
CLBDV1E7rZyhvVKTi4AP1EivAN+tEZKw3EWz8CosiXAaCZWhrI4nz84jDbbRUska
6jWv8GiU8r2ZH3kIE56n7wB0HKtSFUdGiFS7ykLfUGNKdubyWYk62C7ZQSPr5B2a
0xiq+/BVqHPkKPydqw2hDZ6H2Gf/BPVfFEiFBKVrWTbnB826GQISIjEMmEaYer8Y
VS5WJuaVdcC0hiGzyJfxdysBynD99Po8P2od2XcuRXzx6SnGQsCr+iQBtvy8eOqB
qFtJRIyfSrTsNd4Bj+6e/wTjfsLSCrrV3K4gtwRnYZ0coBmyz04op00S5As5bgzy
F5Yo77I5v87YGq6SKfOio8WVCiNIp3b+GDJ1xwO61Oq4JNNhjM4m4yH/W5l6qKGQ
gjEk8Xg4XWMwEsQo585JGyFJq11cjI7ZigB7L5SwNqg3SZq4gJhJ85z7QP5A7Zv2
b586xJ4jsvi2zpqTKA70GRUViBKJ4vXc14pPCZEf3kTzidZV9rJ1NAFPWsePYP5f
pdmulJG1922Y1oDAW92y5his1bdz56z9IhqgOkRKglAbg0Aptio3vOSxgfqrFo7t
BPT8pgDzuY0lY9KvSp6yG1Rxxnrc22f007jV/2CGzjdefbLABrg=
=kOo4
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
