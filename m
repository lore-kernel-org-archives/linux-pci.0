Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D4DC10F03
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 08:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC3C218E2
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 08:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfCVIc3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:32:29 -0400
Received: from sauhun.de ([88.99.104.3]:48804 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfCVIc3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Mar 2019 04:32:29 -0400
Received: from localhost (p54B3303C.dip0.t-ipconnect.de [84.179.48.60])
        by pokefinder.org (Postfix) with ESMTPSA id 527564A1346;
        Fri, 22 Mar 2019 09:32:27 +0100 (CET)
Date:   Fri, 22 Mar 2019 09:32:26 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2 4/6] PCI: rcar: Replace (8 * n) with (n << 3)
Message-ID: <20190322083226.GF1005@kunai>
References: <20190322023844.18574-1-marek.vasut@gmail.com>
 <20190322023844.18574-4-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Content-Disposition: inline
In-Reply-To: <20190322023844.18574-4-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2019 at 03:38:42AM +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>=20
> Replace (8 * n) with (n << 3) to make bit shift operations consistent.
> No functional change.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyUnZoACgkQFA3kzBSg
KbZpGxAAlRjiE6WrWnB4B1rGtOgbBlt0rTY4bBVVMernuEtZzgq2nn5VaF/4fsu/
uuttZZnXtiPD5fN+32bmvyhXM23LKKtFID+gek4r+tDoglghbfsH6y4fIaF5XyRu
3e0mQ5qvYNNhAEPTy92wXexcLy+ArQnZezA7eBGvKpCCMk/02fpV/6qTqP0ATn2v
RXokBKXQwr1IPRQn4sjdhbNAoZCQZieGBZJZq5AmjOAgXBPlqUCz0rznFU6bhjJZ
9YXkikJOTR2eWUNZFvp3pG7fNVq1LkKeF1NS01q9yYBAPSxfR7Cg7cyJF5A6pcWT
8WP4wz2gksaEXP91CKuGqjDzn+LWVzq1/C4Sy+nkdPUTLFwqgAT1RW4eLS9/8LHJ
lKTDCYSefJg16jfQqkWLEp9x6HAk4NjD2+6tkZ/sa3n6VYe0r+ILktjKemQYdotP
w5ZTvXF35Bo/X/FL+otwMSswkQcAuCmLYj0t5gpxjHc+pErJI0plVQhfX1shkSR5
Hr5R+drmyddt9MgfrMmPKEiZ8A85XxItRxDcpDvL80PFOcYjsa7HNkwTHz6qgSvD
OedRIVN/vRA+ihgeK5tu63SUyKetQzvrdfN2Zk2FmrUuhOCciW/flhkGLmALvtSW
to1kY278ShUF/uFDRvTWU6GaaGmTA27ORG/RnoWlPFa0Ro8vtJ0=
=VW2d
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--
