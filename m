Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE2BC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2004820848
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+x3/7wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfDOLXZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:23:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37055 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfDOLXZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 07:23:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so21469051wrm.4;
        Mon, 15 Apr 2019 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nHcjOVw30PogXEEOxW4iy5vXlyCFmKZaxc6VZCTwk/U=;
        b=q+x3/7wtneF8ogRKokxqHQsniyMyxad45ny6qLIpKBCf4VUqoHDjDIfmq2g+D/62K4
         VorpZoqogeP4r82hYn5+Whg9pFdBBu0coU0pustFJ0DYcevcBKyeMrJarT9L88cobqez
         kBr/vWMVoq1GXTDzFpp95NmcN94VJwYx0iMS/J5vDANmOQLnIyYtFUiRdFRhiU52sRYy
         lw7EhluCYudEk2Pi8qIqZwdYsAFCl1U9bfuTNAsOPmy27+1o4XNbM/3akENIkM2lCrvh
         JR4N+2vnX1YjICCIHrpZt2vVdU5bjI7ryX0WrPlZ1S5Tneb7rk/Ai1AuUtLSC7hqcTS/
         HJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nHcjOVw30PogXEEOxW4iy5vXlyCFmKZaxc6VZCTwk/U=;
        b=F2Sh5JOiN+6sw9+0JMZOWVsQKAGJPyZ/D+P1uAWLSLuqaNPmqLScul5sm4XiLbUWXn
         yVD2BdJx3wrDbkoo2Ww/RimkKBkA3jAeRqz7Q480QIhxX1vJVmvVjr/JiMjFCRv26V4E
         Aak5G8xgjbi59vmWrQ3piu3EtnI1sHGGCEykw2eG4W24lTg1oNHUGKQtG5Gh7Sjrrc0f
         5kxFeGaq7R33+YiLr1IGyHsFZCe11PbAZZ43mB/wMJD/CB/9DzLk1sKILdXzeqAaMLTv
         H8wbg41DtNyY6fMU+Lbaly4UFaJQDttEgbRjQ07M8nfjGS52OZTkCyGQ8qnxJEjOWnsG
         AHsw==
X-Gm-Message-State: APjAAAXqfb9eD/j/szQZSO5vWj9MVijJU3myaQYmzUKWXkO/FoypBFD0
        NOBubtUsvx1NWpHM+a0pPYQwsYET
X-Google-Smtp-Source: APXvYqzEiNlmsgOpsjau/WRIAooQFPe3dDAwOMsJLecNLZKcoTG3shSSVbVRkr7LhTBxI5shZnYRtw==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr46756279wrn.148.1555327402858;
        Mon, 15 Apr 2019 04:23:22 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id i2sm18259284wmg.47.2019.04.15.04.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 04:23:21 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:23:21 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 05/30] PCI: tegra: Advertise PCIe Advanced Error
 Reporting (AER) capability
Message-ID: <20190415112321.GF29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-6-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-6-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:30PM +0530, Manikanta Maddireddy wrote:
> Default root port setting hides AER capability. This patch enables the
> advertisement of AER capability by root port.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 6ccda82735f8..9ff1a0e2797f 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -180,6 +180,9 @@
>  #define RP_VEND_XP	0x00000f00
>  #define  RP_VEND_XP_DL_UP	(1 << 30)
> =20
> +#define RP_VEND_CTL1	0x00000f48
> +#define  RP_VEND_CTL1_ERPT	(1 << 13)
> +
>  #define RP_VEND_CTL2 0x00000fa8
>  #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
> =20
> @@ -478,6 +481,16 @@ static void tegra_pcie_port_reset(struct tegra_pcie_=
port *port)
>  	afi_writel(port->pcie, value, ctrl);
>  }
> =20
> +static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)

Why not call this tegra_pcie_enable_aer()? Are you planning on adding a
lot more overrides to this function? If there aren't too many, you may
want to just have one small function per feature and drop the comment in
the function body.

If there's going to be a lot, the above seems okay.

Thierry

> +{
> +	u32 value;
> +
> +	/* Enable AER capability */
> +	value =3D readl(port->base + RP_VEND_CTL1);
> +	value |=3D RP_VEND_CTL1_ERPT;
> +	writel(value, port->base + RP_VEND_CTL1);
> +}
> +
>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>  {
>  	unsigned long ctrl =3D tegra_pcie_port_get_pex_ctrl(port);
> @@ -502,6 +515,8 @@ static void tegra_pcie_port_enable(struct tegra_pcie_=
port *port)
>  		value |=3D RP_VEND_CTL2_PCA_ENABLE;
>  		writel(value, port->base + RP_VEND_CTL2);
>  	}
> +
> +	tegra_pcie_enable_rp_features(port);
>  }
> =20
>  static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
> --=20
> 2.17.1
>=20

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0aagACgkQ3SOs138+
s6Gt0xAAsH3/KOaIFzrf/ALqAHBJzuxy5zQvI/swU8tbr/0EA7LgiHx9eQPME3Ox
6qQXloJi39VFHmTtLw2WmyIDSheobOqggSbbPJtBzK6TqWQ5VcJ+02Ax2IDc40qq
v7k1vJPL1uoqxyZcdv9o2myLyEkuI9KXWb/GgOaEF2g7/3DEbFZoxYqhfDLs2AZ1
A6YE6NajLaD2CrvVhEvAYM57NRG+BnA2SnpR3c9lXbtp+8xBX89EZrs+Q2v7okKR
9RplIhM7hVEm37nSgGMgQmS2yVvTtT2L+1WgHEFw8qWACa0ISpWkq6dAYYwaUzxy
Uz5HZwXvjBknbZYRgDYw79Pr8ueYu9jxEkO540BFl9njPl8v9nqZYxjTBTgpvEZ/
lP/mncGbPRIZ+HgpwFV0NTq1oUbUz81RcEKnz9DYhM+60OteEhnSKH81D7BgvEpn
z0GLrE2Tz22oxPOj8xZVFod3+oDSou2mpPw3NHTvbCzn3AjVBTUAKNw4SRLMlvl6
fTytaghShwQLF2Cp72JyPPd1f7PjKi6295t4HhMJr/eHF1grG3wJnCOT6oFHqWYj
0bHVhzC7Asil0/jTDhNaiVQTIEmcrZkQatCXCqueUHhHVdLSU+NAagpk2E4Suqg/
25eBTbFleAqofRz7MnB9g9wqbURMXPNld3hUtUUvzGwKvqSUNL0=
=KKUO
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--
