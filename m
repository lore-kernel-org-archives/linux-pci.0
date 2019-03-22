Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF543C4360F
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 08:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBEF218E2
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 08:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfCVIlW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:41:22 -0400
Received: from sauhun.de ([88.99.104.3]:48906 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfCVIlV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Mar 2019 04:41:21 -0400
Received: from localhost (p54B3303C.dip0.t-ipconnect.de [84.179.48.60])
        by pokefinder.org (Postfix) with ESMTPSA id 493ED2C08C3;
        Fri, 22 Mar 2019 09:41:20 +0100 (CET)
Date:   Fri, 22 Mar 2019 09:41:19 +0100
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
Message-ID: <20190322084119.GI1005@kunai>
References: <20190322023844.18574-1-marek.vasut@gmail.com>
 <20190322023844.18574-3-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
Content-Disposition: inline
In-Reply-To: <20190322023844.18574-3-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> @@ -508,7 +509,7 @@ static void phy_write_reg(struct rcar_pcie *pcie,
>  				 unsigned int rate, unsigned int addr,
>  				 unsigned int lane, unsigned int data)

What about converting 'addr' and 'data' here? Other than those, I didn't
find other candidates in this driver.


--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyUn68ACgkQFA3kzBSg
KbaJ5RAApLWo+u9WHBNvCJDDs7FxNwFVaTsP0jlD/epD4D+nl+jhSWhQ/Zv5NDlK
/JyR42nkovmsOyJoVV9EfIRIyGUnftQTelp1ZJrR/hUqzC71zxYopT3Zk2B+VWDU
tCSETdtpIVBQG2kLw6IgoHxsueLSjn3c3nmU0JSKJHbrI2RtiCBlXhMTverBU+hP
D17qArnx8p/7fdtnuVbbAvJUZ6vW2CcV2zCd8D2SG0AdVozvBynTOLVwxcc+MWJx
n6YUJNInFn9Oede0yGMktQmO1FdPsKtf9juYSZiUpfWlChL6WwWJZ5NT9oJCEIOj
316Qcz9N2pJ1TtZESi9QaAXe+qUxgiR0q07Mf0xY0ltP//+Gg3L0xNnEj8Z4qBzu
aHi6nlEmq8k5WCoBkkywWuYuf7aMuGXfB+R3+x3JWDXyVDVPKaiKF1wd4yeJPRQ6
9C1xOP6zef6Xkt7KTaPWJdv+TRd6kWLVgt/Dg9RBhdNH4rlZp5Q5GD3l2Uf+bPiz
ijriXK91b+Zdyzz3h4q04IHJ6Z0phE8hnKc37PzTYA0qYkUICzHIoTGpXNC9XvKI
EH3RL1SOCSuAvIxcSAkqWKyNyB7tSyOAX7fIiGPbjbyCv4wSJ5QqebUdWEMoCvpN
nj7lVKFgHXohzhImNmdeY36e68U3bQu5vM4CH0tg1n/ChdYpg+4=
=1zbw
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--
