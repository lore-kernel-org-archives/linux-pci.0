Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E020CC10F03
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFB32083D
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 08:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfCVIc7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:32:59 -0400
Received: from sauhun.de ([88.99.104.3]:48818 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfCVIc7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Mar 2019 04:32:59 -0400
Received: from localhost (p54B3303C.dip0.t-ipconnect.de [84.179.48.60])
        by pokefinder.org (Postfix) with ESMTPSA id 4F44B4A1346;
        Fri, 22 Mar 2019 09:32:57 +0100 (CET)
Date:   Fri, 22 Mar 2019 09:32:57 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2 5/6] PCI: rcar: Clean up debug messages
Message-ID: <20190322083256.GG1005@kunai>
References: <20190322023844.18574-1-marek.vasut@gmail.com>
 <20190322023844.18574-5-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Content-Disposition: inline
In-Reply-To: <20190322023844.18574-5-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2019 at 03:38:43AM +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>=20
> Drop useless casts from debug messages, they are no longer needed
> due to the data type cleanup.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyUnbgACgkQFA3kzBSg
KbaiuxAAgMC6OWJNngAdbswI67A6xenA8LfyvQo4dpp6oFnf/nzEFZRhHowyWzgs
HuHHfkcof0LlkXituhbhokWKJ6jDCas0SH8yFpBjJAoMSNNl9NgHs1tjYOQP3neb
kycvtJezqIiAD++6rcT2KNA4LM0jOvji/PRsmiVg1r4tmk7dIT1Knb6yXqnHpm63
LE0wgZucWMCpYc5DoxmYZd7uLdua36v7UQ77wZqVfcygzxdHyMB8RTMMrRY6IGl+
aqqkfmle3xAE3H7e9aKxjf/NkHwjWzPOWSK+wlvHPd3Yg5XMhnuwDac2A/uLR6eg
gFgZSa1NZfqB4jFvEifuOH+afZ9kjci3LjaX93/HKxn8LC92EBIreH5Hpy7hf12W
qlucObTPhxucaC1/kVpse0V5302sOrHuc7Z2K8nFBKYAlYcBBm/13GhsYh4/QN+m
LisH5cybz2vLxx8oxq7RzJLKl6nZZOzVG04QfmvChD6IgEHFvOUyQRTDrV6agskj
wscyjdLZDo7OxkpiA/vB0eKcwsmEJMphFR7JOGMn/eiJH78nVELIXetP+RgdN0Fk
8RBe78PTg2qdN5TsMA3w2LE5+Azz+p+ZItRwWA3gN2jO5+/M/blHk/zhPoIqlyMM
ujAUib+rnt/ty0ZEmbhd2yJZ6zPl9bWcSN+StMRT/TaISFnhVCc=
=Y+dP
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
