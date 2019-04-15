Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62410C10F12
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5942075B
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxjDMls+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfDOPb6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:31:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54951 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfDOPb5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:31:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so21196475wml.4;
        Mon, 15 Apr 2019 08:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9iFhvrVVjoIUoXK4/q5U0pcEF2R4cgYUV7pteeG2Fkc=;
        b=nxjDMls+D3pko3mLOcBxZRj+W+o6IhfkD+9xqSm91ozvdXthbKFeX20Et2EIK8XTTd
         YqQLM0zmM7GON0R8gH8ixgGYDgqj2e9vDA2NC5zyqFScb4TCB0+AF/9eckB5vFipnCRP
         eJo3Myeqh864Rkue0AINo2C2zzvNfQqlh6QHBLPs0pyajOClDJm8F83LVtiTGYi58Fc7
         GkTYGGmebysX0zY2IzOwmV57hAgYuAN7P1D1mKHRW7GbfgFe7GgJeou52uFFMEhNNvep
         O0d/NBMrsTc+4yeW4+gkDbj/iUYaWxBmum4qsL7ibyEf/6pXLHgPiNaEYKCSUUEk3lw+
         fKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9iFhvrVVjoIUoXK4/q5U0pcEF2R4cgYUV7pteeG2Fkc=;
        b=mb13nFHubsX7spbAYSLfaR14XscPKWW9B8hLjgGO9WHVI+nGTu8AMSPQpVb4naH/zM
         tcqLzGSBD1EfqUa3mqyIqRQB2JCPrZ/HmLINfeztp0e9nPEUV3R1SmxGz0GxN/5xP3/Z
         cd+f1kDoNsZZJ7teFJ5G9sP/TO7Vqw28/Qpc7TvuwX6UEWcCU0KP/YvxWA4EiKBKn/9/
         AQp3RfoKxaNUReogQgOSZstsry+DIACeBIsMjn/LpQ3uxuzF1QW9dG4Hh84hkJWldylP
         ArB/7GbzzwH2D0oJUAPA992UQw76gQaRhnn7dBZPn0A3S698tNiLn5VKIYoLVsMR3/qw
         eU+Q==
X-Gm-Message-State: APjAAAXbTIbXwTRY5tNgqQKiWIqiuOudw78zIVSTSHwrcgfvzzh0dXWQ
        v0t2KYzAoBcBKTCxbcNkF20wzNoV
X-Google-Smtp-Source: APXvYqwhy8Ar/XRfMpX2rKTTM8vk4Hjv7ZJULfcNMQYW/YxYeRbrCQk9SgpcvsUqbGplSdRPvyrDSg==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr23546762wml.110.1555342310717;
        Mon, 15 Apr 2019 08:31:50 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id z11sm18103090wmf.12.2019.04.15.08.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 08:31:49 -0700 (PDT)
Date:   Mon, 15 Apr 2019 17:31:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 14/16] phy: tegra: Add PCIe PIPE2UPHY support
Message-ID: <20190415153148.GJ29254@ulmo>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
 <1554407683-31580-15-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dYuLH7fbMjVsPkFl"
Content-Disposition: inline
In-Reply-To: <1554407683-31580-15-git-send-email-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--dYuLH7fbMjVsPkFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 01:24:41AM +0530, Vidya Sagar wrote:
> Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interface
> with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
> For each PCIe lane of a controller, there is a P2U unit instantiated at
> hardware level. This driver provides support for the programming required
> for each P2U that is going to be used for a PCIe controller.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v1]:
> * Added COMPILE_TEST in Kconfig
> * Removed empty phy_ops implementations
> * Modified code according to DT documentation file modifications
>=20
>  drivers/phy/tegra/Kconfig             |   7 ++
>  drivers/phy/tegra/Makefile            |   1 +
>  drivers/phy/tegra/pcie-p2u-tegra194.c | 120 ++++++++++++++++++++++++++++=
++++++
>  3 files changed, 128 insertions(+)
>  create mode 100644 drivers/phy/tegra/pcie-p2u-tegra194.c
>=20
> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
> index a3b1de953fb7..eb93ee72ecf0 100644
> --- a/drivers/phy/tegra/Kconfig
> +++ b/drivers/phy/tegra/Kconfig
> @@ -6,3 +6,10 @@ config PHY_TEGRA_XUSB
> =20
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called phy-tegra-xusb.
> +
> +config PHY_TEGRA194_PCIE_P2U
> +        tristate "NVIDIA Tegra P2U PHY Driver"
> +        depends on ARCH_TEGRA || COMPILE_TEST
> +        select GENERIC_PHY
> +        help
> +          Enable this to support the P2U (PIPE to UPHY) that is part of =
Tegra 19x SOCs.

This should be using tabs for indentation.

> diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
> index 898589238fd9..f85b2c86643d 100644
> --- a/drivers/phy/tegra/Makefile
> +++ b/drivers/phy/tegra/Makefile
> @@ -4,3 +4,4 @@ phy-tegra-xusb-y +=3D xusb.o
>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) +=3D xusb-tegra124.o
>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) +=3D xusb-tegra124.o
>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) +=3D xusb-tegra210.o
> +obj-$(CONFIG_PHY_TEGRA194_PCIE_P2U) +=3D pcie-p2u-tegra194.o
> diff --git a/drivers/phy/tegra/pcie-p2u-tegra194.c b/drivers/phy/tegra/pc=
ie-p2u-tegra194.c
> new file mode 100644
> index 000000000000..d4df8bfa9979
> --- /dev/null
> +++ b/drivers/phy/tegra/pcie-p2u-tegra194.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * P2U (PIPE to UPHY) driver for Tegra T194 SoC
> + *
> + * Copyright (C) 2019 NVIDIA Corporation.
> + *
> + * Author: Vidya Sagar <vidyas@nvidia.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/of.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/of_platform.h>
> +#include <soc/tegra/bpmp-abi.h>

It's a good idea to keep these sorted alphabetically. That makes it a
lot easier to insert new ones in the right place subsequently.

> +
> +#define P2U_PERIODIC_EQ_CTRL_GEN3	0xc0
> +#define P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN		BIT(0)
> +#define P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
> +#define P2U_PERIODIC_EQ_CTRL_GEN4	0xc4
> +#define P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN	BIT(1)
> +
> +#define P2U_RX_DEBOUNCE_TIME				0xa4
> +#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK	0xFFFF

Use consistent case for hexadecimal. All other register definitions use
lower-case, so this one should, too.

> +#define P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL		160
> +
> +struct tegra_p2u {
> +	void __iomem		*base;

I personally wouldn't bother with the extra padding. A single space is
enough and avoid extra churn if you ever add something here that doesn't
fit into the existing padding space.

> +};
> +
> +static int tegra_p2u_power_on(struct phy *x)
> +{
> +	u32 val;
> +	struct tegra_p2u *phy =3D phy_get_drvdata(x);

It's often common to structure these as "reverse christmas tree" so that
the longest lines go first, followed by shorter lines. Not sure if
Kishon cares, though.

> +
> +	val =3D readl(phy->base + P2U_PERIODIC_EQ_CTRL_GEN3);
> +	val &=3D ~P2U_PERIODIC_EQ_CTRL_GEN3_PERIODIC_EQ_EN;
> +	val |=3D P2U_PERIODIC_EQ_CTRL_GEN3_INIT_PRESET_EQ_TRAIN_EN;
> +	writel(val, phy->base + P2U_PERIODIC_EQ_CTRL_GEN3);
> +
> +	val =3D readl(phy->base + P2U_PERIODIC_EQ_CTRL_GEN4);
> +	val |=3D P2U_PERIODIC_EQ_CTRL_GEN4_INIT_PRESET_EQ_TRAIN_EN;
> +	writel(val, phy->base + P2U_PERIODIC_EQ_CTRL_GEN4);
> +
> +	val =3D readl(phy->base + P2U_RX_DEBOUNCE_TIME);
> +	val &=3D ~P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_MASK;
> +	val |=3D P2U_RX_DEBOUNCE_TIME_DEBOUNCE_TIMER_VAL;
> +	writel(val, phy->base + P2U_RX_DEBOUNCE_TIME);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops ops =3D {
> +	.power_on	=3D tegra_p2u_power_on,
> +	.owner		=3D THIS_MODULE,
> +};
> +
> +static int tegra_p2u_probe(struct platform_device *pdev)
> +{
> +	struct tegra_p2u *phy;
> +	struct phy *generic_phy;
> +	struct phy_provider *phy_provider;
> +	struct device *dev =3D &pdev->dev;
> +	struct resource *res;
> +
> +	phy =3D devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctl");
> +	phy->base =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(phy->base))
> +		return PTR_ERR_OR_ZERO(phy->base);
> +
> +	platform_set_drvdata(pdev, phy);
> +
> +	generic_phy =3D devm_phy_create(dev, NULL, &ops);
> +	if (IS_ERR(generic_phy))
> +		return PTR_ERR_OR_ZERO(generic_phy);
> +
> +	phy_set_drvdata(generic_phy, phy);
> +
> +	phy_provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate=
);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR_OR_ZERO(phy_provider);
> +
> +	return 0;
> +}
> +
> +static int tegra_p2u_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

I think you can drop this.

> +
> +static const struct of_device_id tegra_p2u_id_table[] =3D {
> +	{
> +		.compatible =3D "nvidia,tegra194-p2u",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, tegra_p2u_id_table);
> +
> +static struct platform_driver tegra_p2u_driver =3D {
> +	.probe		=3D tegra_p2u_probe,
> +	.remove		=3D tegra_p2u_remove,
> +	.driver		=3D {
> +		.name	=3D "tegra194-p2u",
> +		.of_match_table =3D tegra_p2u_id_table,
> +	},
> +};
> +
> +module_platform_driver(tegra_p2u_driver);
> +
> +MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
> +MODULE_DESCRIPTION("NVIDIA Tegra PIPE_To_UPHY phy driver");

The driver description is somewhat odd here. Perhaps something like:

	"NVIDIA Tegra PIPE to UPHY PHY driver"

?

Thierry

> +MODULE_LICENSE("GPL v2");
> --=20
> 2.7.4
>=20

--dYuLH7fbMjVsPkFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0o+IACgkQ3SOs138+
s6HhyQ//UKiUEowXHp0BFmUd21SMPKoP2xSU7ZMFYWLZHkA9d/9tKOY8uo/dwc0R
Egs8rig5OXSaGAw7spYF4kJyNearqYofiB3LpiwqbLLXgM+sPuX7NWoNyKf2pb+n
xBXTi9n85xxInR8RKtaBga3ae+QgpuzvimDGYxB9XxINL5Dg+J+L/itQV6OW/4qE
4GaZKdWKzaB9aLJYEnvQxHSmABmxVjkMG6tlSN/oEjlr4fvbxQHXPMJDRBPeb/GZ
Gd9cnSbYZEU4sxIdSkBjGNswL6+cdjva7LUrfxhg8BJsAyft5WLL3QSrmiDoZcVK
xOnanEChdFHu2PbOb1sP3ai9cJx7PhHapqUTBKcErSHl7S5UUKMxqbZA24AwprQk
WpuBVDeCFVv/Z2QDsGTmYndWRE/yJVSIOJEW5U5rzWuf/a+hfGOLhvMUypQ0nIZe
xrgfGNUt5ovmfd+FX/YC7pPOU7a3VN6SNHBm1QDtCgcqFqzwra9w5EkHIjuo59eP
sRa6v+PyC/tJ38FuLHaBOfYxlJcGPvkO66Jy7xVs6CIivZ0F9+QeqJm2v+fpp5qZ
3CNr1NpdXYvGPNT2Ni9ew04NdqwKhvOvrnitllw/4X09BHaL5XHbt8mN9fQMIshf
aDXMTkkVaKSfO3lsK6OSh2Z5cWPrh2zBmyCtcpVPpW9V4n08LyU=
=4GOh
-----END PGP SIGNATURE-----

--dYuLH7fbMjVsPkFl--
