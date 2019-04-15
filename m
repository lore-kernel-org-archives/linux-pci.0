Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC45C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAED20880
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdudHnVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfDOOUQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:20:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37858 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDOOUQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 10:20:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so20731593wmf.2;
        Mon, 15 Apr 2019 07:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S3hgk8x8XLlZSOgO1hCE6ApryHJlORSTWgSoan5r5mQ=;
        b=kdudHnVqg3gH/ds/L8NUhkCZ+MMP6bjUTs+DbLXfN8BYvDVYNmtwTSisdzwr4hrhZC
         ucbZ8EiAYy6s1tq/zJA2nq7+Pbgj3vHSB+uND/37/qVk+ISdhMcBRUDaODB3VXR+QBGd
         D/I8tz81qg+OI+o/TI9I0h1NwlRD02yvIxAOVFnWe5uC6aEM8hgbcqxd6UW3i5mS1cf5
         2O/8SSXhvsAeSSk0SdiyfbwJ6ZL4fnvbCDl4eWHU3k1KsIoisCDnb/urh3Nb48Ql/t1b
         D/m/Av7JBbvnWm92uCO8eMFFZCT05o0gL4qqz5JUVdIZvF5YZKlOCgVwjT0CtrfoWai4
         7s2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S3hgk8x8XLlZSOgO1hCE6ApryHJlORSTWgSoan5r5mQ=;
        b=eHMhm8Bf/Us8JbmfjEhlycCmJi4+6DISSIqyLncF0rWxJNHW6RXQooA7QdqPU+fuph
         ZfjC5ojAOIbzegKWh6mVDE3Lghh1dFmopi2WZ7DB7NbpE4otkUT7pm1EvMkmRezemVfB
         Ut7F0Z3kTGRaLwrmPntUeFAYT/7ysUs7jGHlCbIC4Unvr0S8NRkXnHvTgdUH2aTeP2ky
         wFrt0hgMElGu9IUaPvthWJUhghT/bE6KgOOYHckeRfzZ7E3HaAnNIQZ4es6uOOQNDSto
         ad4NIa0gO8nXMYv6O8jJA2VgZlBGBgmQaQfmnAo+x7722+qDaioFu/24cFuT8DxWpqNc
         YAvQ==
X-Gm-Message-State: APjAAAWNDCtd9hBZDAt1wD7dETAZKjHRrxC+xKZHUjG2byfUHD6TWlvW
        qAh19Gh1vjmjokvDZun04o0=
X-Google-Smtp-Source: APXvYqyuHKpiJxPjpk491QVQcs/Szs+I/PugycqCIOlSoCZoAa6ikYXACjO0qq3hAg12vB6g6Tgv3Q==
X-Received: by 2002:a1c:62d4:: with SMTP id w203mr22364383wmb.54.1555338014341;
        Mon, 15 Apr 2019 07:20:14 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id c16sm21615874wme.31.2019.04.15.07.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 07:20:13 -0700 (PDT)
Date:   Mon, 15 Apr 2019 16:20:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 28/30] dt-bindings: pci: tegra: Document nvidia,rst-gpio
 optional prop
Message-ID: <20190415142012.GB29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-29-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qjo19A2vmS5T5MQB"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-29-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Qjo19A2vmS5T5MQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:53PM +0530, Manikanta Maddireddy wrote:
> Document "nvidia,rst-gpio" optional property which supports GPIO based
> PERST# signal.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.tx=
t b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> index dca8393b86d1..23928fd59538 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> @@ -75,6 +75,8 @@ Optional properties:
>    Pass pinctrl phandle to allow driver bring PCIe IO out of DPD state.
>  - nvidia,plat-gpios: A list of platform specific gpios which controls
>    endpoint's internal regulator or PCIe logic.
> +- nvidia,rst-gpio: If GPIO is used as PERST# signal instead of available
> +  SFIO, add this property with phandle to GPIO controller and GPIO numbe=
r.

GPIO properties are pretty much standardized, so this should really be
called just "reset-gpio".

Also it looks like this is documented in the wrong place. In the example
below you set this property for the root port, that is inside a child
node of the PCI controller, but if I understand correctly, and it's hard
to say from the context, the above is documented as part of the
properties of the host bridge node.

Thierry

> =20
>  Required properties on Tegra124 and later (deprecated):
>  - phys: Must contain an entry for each entry in phy-names.
> @@ -671,6 +673,7 @@ Board DTS:
> =20
>  		pci@1,0 {
>  			nvidia,num-lanes =3D <4>;
> +			nvidia,rst-gpio =3D <&tegra_main_gpio TEGRA_MAIN_GPIO(A, 3) 0>;
>  			status =3D "okay";
>  		};
> =20
> --=20
> 2.17.1
>=20

--Qjo19A2vmS5T5MQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0kxwACgkQ3SOs138+
s6EOzw/5ATuYJ27momrmqb3VkwBwBsPFsX9ccnecMg59wUWTPByb7ZiyKgXVchoT
GRNJEHdjrcyiMVwQa037+3T/6N9oEYzBSrK+48uqLgR+Y8rdkMqfNMpf2f+iGeXj
v61oxrdwx3W2KQ9lJOoD2/PHoQ0vF7sJwGdQAeGl5RPgH8dCLxdCrxwM6drn/9zz
BlA2ZklWcW0xDCus77vY/cQUGRqD4PtwvcOs2QmefsmXg45QO3ra6mVRbGn98Svp
e8yb+nKlngE3GtmlpxS0PQJUte/LB+mkcvndU5frGwC8bzXeE6s+7H2AXysdK/O2
gxAdmx2MUOWiG8J81uL5DYAi0OuP0ajBq7SV+CV8ce29viOEu4PqQ/3hfVOugI9X
kN3AIOOEKKahENb+l9qqVMHEZuxbwP0xploOO/5NIR6wtTYBslqc4c0M3xmDnAdu
2KPM7mikqqoO6VNX0FRSBBrV3IodDgKp0388AWK4GeupjhExOlOU53+2qhj6WZbU
SDkcWC0zkVEl/PgYoiEApI+IxeKBjdevlqF7r3L5VNPbBr+FzR8zKZP59n3oK0ep
J1P1PXSSb0LltIdMmtkZj/bczEGUpBTEutaQCFZaZEdEK2tidIlayAy8cQnjjSDO
qxCTzeTMAtIsttvWAlgU13iLYGxGsevxOSYjmXQ82VXVWlw9P2M=
=kTHp
-----END PGP SIGNATURE-----

--Qjo19A2vmS5T5MQB--
