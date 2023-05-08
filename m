Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2958BC77B7F
	for <linux-pci@archiver.kernel.org>; Mon,  8 May 2023 16:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjEHQZV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 May 2023 12:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjEHQZU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 12:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0972106;
        Mon,  8 May 2023 09:25:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB02964097;
        Mon,  8 May 2023 16:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925DEC433D2;
        Mon,  8 May 2023 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683563118;
        bh=ntMVLklWTobkx69XvR0+I4wi/FAAJ1m3ERqFuATQQQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxX6IQlzNGbYN9tSP8RjJbPGEBMFIkFBQOPJKOpw7hr7MECoANvBFw+YMkCnlLl08
         XSZ6QTPIixKYcmgn4yXpwlG5SrnG6RCumi/UFTiacUjbJgYTHWGp+iQsSSB1RIaz/k
         C+BwfSqJ5M9HJolIN43KqwB4UeglsmQN/QKENZuf79GdBkcgIg2nwUZX3wUHxpsnRF
         JBaeruJoYriTll8d4nx9DiC4hQy2De2xzV6edhyG8an8FLAF4Ahjfk9JNfkNOAQ5dy
         fS+NmdfNd8LywY10vYKdABwqjpATJNbQMykaz0ZskJo2+Xy2SYtdPKm2cUIRnsivqR
         00fWIdVZd08gA==
Date:   Mon, 8 May 2023 17:25:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH fixes] dt-bindings: PCI: fsl,imx6q: fix assigned-clocks
 warning
Message-ID: <20230508-herbicide-sweep-0fc4febf4509@spud>
References: <20230508071837.68552-1-krzysztof.kozlowski@linaro.org>
 <20230508-purely-radar-8fb16747ba60@wendy>
 <ef700424-5805-b44d-7256-4bfa932cf92d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nfxYBGp4aLbqkd/e"
Content-Disposition: inline
In-Reply-To: <ef700424-5805-b44d-7256-4bfa932cf92d@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--nfxYBGp4aLbqkd/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 11:22:36AM +0200, Krzysztof Kozlowski wrote:
> On 08/05/2023 10:23, Conor Dooley wrote:
> > On Mon, May 08, 2023 at 09:18:37AM +0200, Krzysztof Kozlowski wrote:
> >> @@ -49,6 +62,31 @@ required:
> >>  allOf:
> >>    - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> >>    - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          enum:
> >> +            - fsl,imx8mq-pcie-ep
> >=20
> > How come this is enum rather than const (and same for the other
> > single-compatible ones below)?
>=20
> I assume the list might grow, so enum will spare one indentation change.

Figured it'd be either that or consistency across the entries.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--nfxYBGp4aLbqkd/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFkiZwAKCRB4tDGHoIJi
0u9KAP43SYkDUGduOMM2DscoKUWSK9wn99GW18cl2lzq67/0BQD/Rsp0JmBcVdSk
weC2aDQTfnST/L8U4PaAM5VkN902eg0=
=XFbJ
-----END PGP SIGNATURE-----

--nfxYBGp4aLbqkd/e--
