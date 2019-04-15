Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095F9C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F4A20825
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoMP+d2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfDOOQ6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:16:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37454 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfDOOQ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 10:16:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so20716690wmf.2;
        Mon, 15 Apr 2019 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9zfpoFlzNEXHsvpEewUzHSE9/nx70NMB9y9yUGz2VgA=;
        b=qoMP+d2xlCCgIVpY+VWMPt9jzRSG49Nhe13PJNTlp6B4AQQ+Z12XeGAgeeEEKH/3ey
         b/iPfNueZ7/iJEKPA7264LofxBqaBoFsWQSwEbAonPH4i5V3fipTDbfhMpi4XTx6fHOt
         DAdMEY5zg4aO1NfW02FeNjaENgdPZKGoMm492OuIFk5Kl5tCQRUOwxGIE+2+oGmacBtW
         IWjJW05ILVuxHRCQP9g53k8xkK163I0qVpCkmiPlsYiiGfyiJGnDlgX0IntZYIovcDcw
         79qzL6UweXKFCl/UN0CRJi909JPq1B2eIxFP5vUiQY/XwOgKRWYOsFjuJkzC7I3cFhbO
         eM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9zfpoFlzNEXHsvpEewUzHSE9/nx70NMB9y9yUGz2VgA=;
        b=G+trt2DSxiczK6XkMSSxuZ5Y3tC7s7gkGlYZVWyUszdp7YcT9Stw0AXVod7fthm8Lc
         FQK5WoPRBbJfAgDDDGVkUZWatWT++fhgDBNpH8HKqgFLO8zQD/tDLSmFdFMWgCcjPG5e
         JIiif/MhTa9uDrMrtplmS5f3QY0m+JZ++EmOXu4FT3mcOnKwWjlcot2sz71JiASHtmtg
         zejN2uwmsFcyPCpsUVZxJEtJEowHY7zLLbmdh/botwyV8gqCNSozenJJxjZ8xYuByGsF
         20UBAL6M/z4WFpfhiYFd07xBf+lRny79nVROHMBQygca/iYn6b/dggkgyccTXXBVLlBA
         M+jA==
X-Gm-Message-State: APjAAAVQWzmU/JlE1F9Ju5CR21Qp6mpnIvQGVnH5d31Xtss+K+y6cfRR
        h0Wt0Z3nj1zD4KpqXCjxemM7YEJY
X-Google-Smtp-Source: APXvYqz/X7I/qgnR5FMIuLZL8vyN8RweB/DZi5W+YsNvemvU1kXV+RW28wQvjawhZCYoaYlA0fBvZg==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr23146619wmg.14.1555337816237;
        Mon, 15 Apr 2019 07:16:56 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id v6sm64302932wrt.56.2019.04.15.07.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 07:16:55 -0700 (PDT)
Date:   Mon, 15 Apr 2019 16:16:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 26/30] dt-bindings: pci: tegra: Document
 nvidia,plat-gpios optional prop
Message-ID: <20190415141654.GA29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-27-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LG5jgFgJbJFFiAfj"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-27-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--LG5jgFgJbJFFiAfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:51PM +0530, Manikanta Maddireddy wrote:
> Document "nvidia,plat-gpios" optional property which supports configuring
> of platform specific gpios.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.tx=
t b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> index fbbd3bcb3435..dca8393b86d1 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> @@ -73,6 +73,8 @@ Optional properties:
>    pinctrl phandle to allow driver to explicitly put PCIe IO in DPD state.
>  - pinctrl-1: PCIe IO(bias & REFCLK) deep power down(DPD) enable state.
>    Pass pinctrl phandle to allow driver bring PCIe IO out of DPD state.
> +- nvidia,plat-gpios: A list of platform specific gpios which controls
> +  endpoint's internal regulator or PCIe logic.

We discussed this with Vidya during review of the Tegra194 PCIe device
tree bindings and arrived at the conclusion that all of the GPIOs that
need to be controlled for PCI to work can be modelled as proper device
nodes (I think regulator and GPIO-controlled muxes were the only two
use-cases for which we need this).

Can the same be done for this PCI controller? What use-cases are we
talking about?

>  Required properties on Tegra124 and later (deprecated):
>  - phys: Must contain an entry for each entry in phy-names.
> @@ -567,6 +569,7 @@ Board DTS:
>  		pci@2,0 {
>  			phys =3D <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
>  			phy-names =3D "pcie-0";
> +			nvidia,plat-gpios =3D <&gpio TEGRA_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
>  			status =3D "okay";
>  		};
>  	};

I recall this being the setup for Jetson Nano and the X.3 GPIO going to
an Ethernet device. Let's find out what exactly this GPIO is used for
and why we need it to be set up as part of the PCI controller driver
rather than the Ethernet device.

If it turns out we can't model this other than with a generic GPIO type
of property we need a better explanation than the above, and the Jetson
Nano use-case would provide that explanation.

And if indeed we cannot model this more accurately, I think we should
use something like the gpio-hog binding rather than some custom PCI
controller property.

Thierry

--LG5jgFgJbJFFiAfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0klYACgkQ3SOs138+
s6GeFA//YHggGmb+XMBk1EzBWehSNnWJ7EmZJI5JkHfeKClYo3JbGGjzhwviUnkE
DZ7bTeyzarxpODiYvcNRRVOdsv19adu2q9HFWbkVTWXHo9MyL8CRJaEfyopkzOUr
RzI1qEFrV6E9JnPodIBCW1Rl3f0P8usYdg9AaZp7BYBv98Lfjsi9Tmr6rkg5Bccs
xQ9CVtIUHvj7bc+hCe07ThxbRp9u9qSaqr92SpD4AIppm8pouOnWpDgRyBsuKeM6
GUyh1AxOZnOPjtESB/A2/g5SV3ThkOlBlcEJoZMfi4G6UbvVk6JININlgk2XbZnz
LQo/Yrz2RJDfvJj6F01IPldpi2RKMMr8cHz68P5b3871FoxPQbQTmaMrKsvPwIp4
BNp1I4SGPmieyL1Nop++WDDxAVG73ECFGiB+dAcHPbQSl32OE3KnyaIOgp38MfO2
uCH3/Q9rrNZL/sFrVn+nE4UEJ+EF9jbC+DH3mOsIRkkbFxRlapyP2Oy0szd41jca
DQb2aOtveT8mhFPz+VFulVXwZEwWjMQNKm6Wn3vYI5gyBjBljI2PReIurLPHm/O5
5SDVu3CoXpKWltDEwyGQQ88KiqlXh5DsllPhizpLUSDJC1+J5QUdJruppAI6Y0EI
B3ArLtLr5YigIzCjonKJSbJCyuGXpL4mKlfLMIrEkOI+ARwYQZc=
=GSCe
-----END PGP SIGNATURE-----

--LG5jgFgJbJFFiAfj--
