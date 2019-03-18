Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D308AC10F00
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 07:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC792083D
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 07:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfCRHdu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:33:50 -0400
Received: from sauhun.de ([88.99.104.3]:33644 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfCRHdu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Mar 2019 03:33:50 -0400
Received: from localhost (p54B330C6.dip0.t-ipconnect.de [84.179.48.198])
        by pokefinder.org (Postfix) with ESMTPSA id A8F8B2C2817;
        Mon, 18 Mar 2019 08:33:47 +0100 (CET)
Date:   Mon, 18 Mar 2019 08:33:47 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: rcar: Replace unsigned long with u32 for
 register values
Message-ID: <20190318073347.GB1047@kunai>
References: <20190317000608.24881-1-marek.vasut@gmail.com>
 <20190317090901.GA2268@kunai>
 <1e6b0726-e767-600c-7725-72db9312d105@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <1e6b0726-e767-600c-7725-72db9312d105@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > There is also a 'shift' var in rcar_pcie_write_conf(). I think we should
> > convert this for consistency, too?
>=20
> OK, I might as well collect this and the other cleanup series and repost
> it together as a V2 to make it easier to pick.

Sounds good!


--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyPSdsACgkQFA3kzBSg
KbYEkQ/+NDRl7eldfeGBM5FKNPlKkBx9Ac4pgySG0L1n+c6L52t0Nx9z6F+t8N9V
KI/XO4reqEEQ1/ZRpc3EEXpirbF0Opxr2IIfxYKPnbhyFUYYu5B5fRMRgj3cinjY
L0yUj/rdc0X34J80bg0OLkaimB76yvobqo70ibY5/k2nopSeEHznLh19jVWG6vfv
g7gq30ZzxJblNATyTXDFto/VCWEBhCgH6TxJEVH39w55EbwOcnxg5tGOafF0J0LT
JOnMoSIjrQ/rBxw9hPAsxZvixckPLg5ALwXGCfvtOOwUxGVDk0mV3zFBWTWJHoLg
u5ScmhRulKOK2sWVknTvicAU66aCf2iMVEbrrp+3Cz2ge6ct1IujoeUq9D4RMrlI
5KdnaAxq5/nn97XZMc/LaaPAcUBcTe+5FKL68PbJ+h3xF3VGQrjGBjny9oPu9RRV
Hk6w51zWsHsK8mo5wH3IhAq5C+bJQCg8N246kYD6jOnYQvaula7FlBOzCZ6Vqk/n
IfOUWnJi3GD0mJINgEZXWLMhxbOhJJbcf/QG24WxC8NxH/LltUQD4TMLtNQikFhP
SEF/s5c+FBPtD4VhyKlDBLzKR0H7jEpQAKfJVcu2C6PxuSLGVnvuzoUVoQNSc1Oq
LdDskA3w3j2hG0SShz10JPsbdsokr5tKvxNd4OdO9giJGpU8N7s=
=xO+l
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
