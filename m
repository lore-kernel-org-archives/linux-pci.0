Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F56C10F03
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 08:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3AB2083D
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 08:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfCVIeO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:34:14 -0400
Received: from sauhun.de ([88.99.104.3]:48842 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbfCVIeO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Mar 2019 04:34:14 -0400
Received: from localhost (p54B3303C.dip0.t-ipconnect.de [84.179.48.60])
        by pokefinder.org (Postfix) with ESMTPSA id 116AB4A1346;
        Fri, 22 Mar 2019 09:34:12 +0100 (CET)
Date:   Fri, 22 Mar 2019 09:34:11 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2 6/6] PCI: rcar: Allow 64bit MSI addresses
Message-ID: <20190322083411.GH1005@kunai>
References: <20190322023844.18574-1-marek.vasut@gmail.com>
 <20190322023844.18574-6-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="82evfD9Ogz2JrdWZ"
Content-Disposition: inline
In-Reply-To: <20190322023844.18574-6-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
> +	rcar_pci_write_reg(pcie, base >> 32, PCIEMSIAUR);

Seeing the in-depth discussion between you and Geert, I'll leave this to
you guys :)


--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyUngMACgkQFA3kzBSg
KbZ98hAArSvy+hoynSwa2H6GEMKapIIX6pHGRgr1ejoDju89xK9oG2nAJpkwa1B0
/iATYzxIjOsQDtcoOy0YBV9n0AUpuLhgduwdR1M8B6G8WzF884mGDenD+zUffFS/
66J6y234n/7zGlx21eerR00TsPaPaWJ0PdACkUEE71S8JaqlgmS5HF+dHGvAAfAN
2oJoqHC+nAj9MSQogXsa0IyU//FlffUidG+A8VxKc5ZagFL84TH/xynieNtiX2FO
ShcEawmChz3ousLB24Nr4Lrzsts2QfjZK52cyU/YsJIX8A3gxObyKf+GbNCtLD7P
6Ef0veyg8fKip/irT80NfiV9DTChjur42shplJXKHlx5iF9cOLG0+WrvWegrpPUC
jK0GBf1UWmAAJ/XphdxizpcIzxz53IWx+N2IkrBk8pI3lTgI2bHPj8mBtoVPeeA6
qpZYiith5n9lRF3tyle4wC5/0jfDuhgL4rbxoiAhiqzY45i55cg4Zu3swKHtGHnO
hO+iWdxNn0d8kYPTyEq8Zj9qm4L3UpW9uAYXo7aAHlAzlJb5dSst63ft9Ad3W5/t
zryBiC51cvEiUXLZCqAw8JcBoixx66Tn7y5SGnOarQczG1VhqnyGJogxIXV5dN/a
3m4afYiAeABhDxGxqmv6H7Jm0540Pj1n+POBvzR0SxlRfopcQ0A=
=1cQN
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--
