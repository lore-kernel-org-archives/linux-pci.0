Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B26C10F00
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 17:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A652084D
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 17:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfBSRYX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:24:23 -0500
Received: from sauhun.de ([88.99.104.3]:48026 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbfBSRYW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Feb 2019 12:24:22 -0500
Received: from localhost (p54B338D8.dip0.t-ipconnect.de [84.179.56.216])
        by pokefinder.org (Postfix) with ESMTPSA id A21612CF689;
        Tue, 19 Feb 2019 18:24:20 +0100 (CET)
Date:   Tue, 19 Feb 2019 18:24:20 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq
Message-ID: <20190219172420.d4reyw3zwgmc3a7g@ninjato>
References: <20190217132441.15139-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gy6fxjdrc3g626lw"
Content-Disposition: inline
In-Reply-To: <20190217132441.15139-1-marek.vasut@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--gy6fxjdrc3g626lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 17, 2019 at 02:24:41PM +0100, marek.vasut@gmail.com wrote:
> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>=20
> Reestablish the PCIe link very early in the resume process in case it
> went down to prevent PCI accesses from hanging the bus. Such accesses
> can happen early in the PCI resume process, in the resume_noirq, thus
> the link must be reestablished in the resume_noirq callback of the
> driver.
>=20
> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

I am not a deep PCI expert. Still, the patch looks good to me and I
double checked with the documentation.

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Minor nit would be 'CONFIG_PM' protection around the new code. But I
have no strong opinion on that.


--gy6fxjdrc3g626lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxsO8MACgkQFA3kzBSg
KbbOSA/+IKN2C5oxVuVPF0mk4QllDJUJJX6k3dV2Ug4w2HPRQz6gg1hU34X69zm3
J62cWEO+PmCTYVnXDOXyeePtgvFGTZAq804ucDs1XoUgAWfNDQ4qF6ghoXa74zSH
QUno7ZsvMpcTyNHLD1amNGefhz57lbKvLihNynocCHcZ8fki+Z7527z3UHwO8BFO
DPy6AeAnpmcmUN/kt7rMFjghE352o7sEy8iZOARmSDgEkNQa3PCmDVumlZVtsH6h
ZkC9dspl0FA3TD1Bsta1HAa4ZN+t5IO+MIOtHADcxpC64aUPpdFJnoa6/daJXtCU
aWdg8v9dEahAaimKt5gvUgA9zpSizAduouXkK1uCPNU5VEC7Tq8+nCRyNE4DTVwc
pSnqJ3MfjKfYb+mp+JSrcz319tg4/ybvpaqLLhTNXmdQo/ApsMPxFBTlb1NwD4c+
UoTr9YgOeqmP01ZLAQFEcU9b5wElPc+SwDnTvDK49EYs0BfaLzOJ3ZJdlc310Lr1
t221F+HkalQ+wskx0pMslTu6CdIXNLbVpUgrC5tGKDOm/HVZIho4eZoHFa1/kqrj
tgR8aRmmGQuicOdfpMK4rooK+gpWIaimWUjHOiLOtAqcBCKAWfZd/IdhHoyo+xFz
VhJDYlBW49bLN07Xa4lJLeWcfh0/CieaTPutJqHV0QkoE9qGl4I=
=UKSc
-----END PGP SIGNATURE-----

--gy6fxjdrc3g626lw--
