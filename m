Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594EAC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A5020880
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhEXZT/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfDOOVD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:21:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52945 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOOVD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 10:21:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so20896107wma.2;
        Mon, 15 Apr 2019 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fNjFsUC8Qc6z+v4JL5PemqWEZShEuTE9d8yyNYAJWOk=;
        b=EhEXZT/Izdas/MmF5xI+y/CqClskrE5zWDvZemwbOguwJ+WAnZGRZ0MTLKK3wHJV78
         G7HWLLkpTVhhY34BRuVsptdL1lPBojfFj9AOWd/XKpdLQ1BqUJNxZ9IoOv+HkdN3XpAA
         H8WBAnzpw3OK698seF/q5yfYpgxRYI+CrIA+hLzDuqC4m2E+BayYiaCovBj1KrFKgveE
         MZiO/WvdxQg/T+woqxjR5bYWXaDNCmovUypzZ1QN+7TXRFGXAvCQk1dKsROTdSQGgM+y
         xdfb/8W4QlxQ2UDb5RkUwXr+5VX+vw3Um/W0Jj626fuGH5d3OV2fs3uhvhbnNTLO4dM4
         Hm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fNjFsUC8Qc6z+v4JL5PemqWEZShEuTE9d8yyNYAJWOk=;
        b=ZKFmmY7aHhG3DQBmhiviMu//dH2WIolsZR67MU0rY4r+E9wPuAU3SmhyelWW1VOJC6
         ox/1rTwnkts24Rg5iPDoOFvceONJhkLBLtgOZB9MxZMIeCwsXbk+2uwckuKfFR6Ad+5W
         irDd6u42EyxCwpXVXein6BT2NHNilTBHTb+Wo7jvHn6+01cJ+EmwgQybyBGxCFdw6ehV
         IO3BLD7+ZjxWeHF/MvGREYf97e7Qkzjw4ILQsR5/xuQP6Ny9PaF1FXSQ6sWsMXbEjcBG
         XDYXUBzVPo0K+5XgfrxIF1bJLcx59j03azZfAroSNRcEJMKTAP9RTzsvAzGMXuwOpFJ6
         6UeQ==
X-Gm-Message-State: APjAAAX0Iy2NVV80+3W6eUjnXPYDkr7DFV9JM5MPYgtOad1LRyYDGnuc
        zVfa67d0rvStfeLWgRYuSDE=
X-Google-Smtp-Source: APXvYqyBDJ3sYzV5kZ0mZs/y/yCJdBQrYEnUKxPQa5KixWxtN0zL/8JMrjT1nhQ1BXZMcRdCrbE0Hg==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr23088467wmc.124.1555338060463;
        Mon, 15 Apr 2019 07:21:00 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id 204sm25855392wmc.1.2019.04.15.07.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 07:20:59 -0700 (PDT)
Date:   Mon, 15 Apr 2019 16:20:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 29/30] PCI: tegra: Add support for GPIO based PCIe reset
Message-ID: <20190415142058.GC29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-30-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A1Iwnsx6rNfRhs6P"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-30-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--A1Iwnsx6rNfRhs6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:54PM +0530, Manikanta Maddireddy wrote:
> Add support for GPIO based PERST# instead of SFIO mode controller by AFI.
> GPIO number comes from per port PCIe device tree node.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 37 +++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 4a91c9fb3a9d..75873e6627f9 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -17,6 +17,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/export.h>
> +#include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/irq.h>
> @@ -26,6 +27,7 @@
>  #include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
> +#include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
> @@ -406,6 +408,7 @@ struct tegra_pcie_port {
> =20
>  	int n_gpios;
>  	int *gpios;
> +	int rst_gpio;

This should be using GPIO descriptor APIs.

Thierry

>  };
> =20
>  struct tegra_pcie_bus {
> @@ -589,15 +592,23 @@ static void tegra_pcie_port_reset(struct tegra_pcie=
_port *port)
>  	unsigned long value;
> =20
>  	/* pulse reset signal */
> -	value =3D afi_readl(port->pcie, ctrl);
> -	value &=3D ~AFI_PEX_CTRL_RST;
> -	afi_writel(port->pcie, value, ctrl);
> +	if (gpio_is_valid(port->rst_gpio)) {
> +		gpio_set_value(port->rst_gpio, 0);
> +	} else {
> +		value =3D afi_readl(port->pcie, ctrl);
> +		value &=3D ~AFI_PEX_CTRL_RST;
> +		afi_writel(port->pcie, value, ctrl);
> +	}
> =20
>  	usleep_range(1000, 2000);
> =20
> -	value =3D afi_readl(port->pcie, ctrl);
> -	value |=3D AFI_PEX_CTRL_RST;
> -	afi_writel(port->pcie, value, ctrl);
> +	if (gpio_is_valid(port->rst_gpio)) {
> +		gpio_set_value(port->rst_gpio, 1);
> +	} else {
> +		value =3D afi_readl(port->pcie, ctrl);
> +		value |=3D AFI_PEX_CTRL_RST;
> +		afi_writel(port->pcie, value, ctrl);
> +	}
>  }
> =20
>  static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
> @@ -2241,6 +2252,20 @@ static int tegra_pcie_parse_plat_dt(struct tegra_p=
cie_port *port,
>  		}
>  	}
> =20
> +	port->rst_gpio =3D of_get_named_gpio(np, "nvidia,rst-gpio", 0);
> +	if (gpio_is_valid(port->rst_gpio)) {
> +		err =3D devm_gpio_request(dev, port->rst_gpio, "pex_rst_gpio");
> +		if (err < 0) {
> +			dev_err(dev, "rst_gpio request failed: %d\n", err);
> +			return err;
> +		}
> +		err =3D gpio_direction_output(port->rst_gpio, 0);
> +		if (err < 0) {
> +			dev_err(dev, "rst_gpio set o/p failed: %d\n", err);
> +			return err;
> +		}
> +	}
> +
>  	return 0;
>  }
> =20
> --=20
> 2.17.1
>=20

--A1Iwnsx6rNfRhs6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0k0oACgkQ3SOs138+
s6EBqg/9HY0M/JN1fAO6sl66qb0NYQ5yNCjb3to4paOgMuRilUWaK6N3qaW6ABRX
YlQjlnrUK46GfC8rZt2ZFe83K8FEnsLHDffzqLAoHK1VKnN4fB9+RbIi71D/+1L3
Dun+2u4W07YkIzBZNbk7MSAx6cLDicOM3/MYGwOR+0VTi+1VNpQFgZrzu1NmNjMb
+gxkEi/GBV01OStpuE/0NajZeQI9PVcZ7o7miYafKwSMLIcZOM8yAW+AwIsTD1q5
ygFzMK8C9zuKMB3XqDNTcuIYkolRvEtVlAwhthNARFeJnuqRrDcpjfXxK4Xt9kP1
ngyqZAzvf9AGdXGhh/nWiWDlRnXt/cJglXvfBEPpqRuEFC4JUCvBYnJ9ngvvdvwr
JCeYlDugI3WAYyaKixuJdG9nzW5u+IYQ8wBOl1K11TIoffhYHL7662h4zNPAKFWx
KZsMy0noPMZ/EjAuGabiWAUN2dSmfRk4rPeXWMCUJaDy6Vitjh6Z8ZKlpWsaJlgH
IC3EqlRR39Ej7dTcs2C0IoRg9p0sfn/+DmWh6FwueoEP9yDGqZfFBRrRZkVnss9t
wsDJSrp3L/HJsg//2vG/wkE4V2mYCGRcm5jNaqgWnrO4n0dShK24/GhjAwR4qOsb
0VP/G9NnLSo+yn48nrnRV1ZwVUDemZs7SufyZw24XCmyWaEiTZA=
=DO+r
-----END PGP SIGNATURE-----

--A1Iwnsx6rNfRhs6P--
