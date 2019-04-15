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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F425C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597BF206BA
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbWD39lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfDONUf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:20:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50970 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfDONUf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 09:20:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so20742404wmi.0;
        Mon, 15 Apr 2019 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=57faGXy9bR8/80IRSkDxfwvAM7wXl75MVr/ILf01esQ=;
        b=AbWD39lw8yIHD7nPGkANl7vmftDnEtNNsl3bdx19FqTMclGMzxE3JBdhNSAk5T701Z
         ijJgke6dtRUeeBLIMxZnyDOFvA4N9gERY2aV6581cwPFx1cHih5rT2ACNvpq2B1MNwwY
         V+Agptxf+kwxqbajEncxWWgyoWSEcuLvnN9FChc+IIIt0TGxijvYZnkmDHMpDSpjILko
         +wggnVMyNGmguGYhPG7W+tMkZHfQIqGeE8x7fzOqA63f+gJQgu07iacVY9s4BT12+VxZ
         arSAsSgKmcVe+YQETmwZ8YqEdqyMToVRxq5yYoUONLcagUUgB96aRlBrPAmffNaV9vjA
         N0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=57faGXy9bR8/80IRSkDxfwvAM7wXl75MVr/ILf01esQ=;
        b=VhH2BGUULWeuxiQpGZjBdUHVNhPqMhXmFsilSe4HwZOUUiL5SzbbEm5tR7q/+oagoT
         pKDIh6XfoBQLR/3LNlvnykPXBlw8ebfNDsFuwlxVA8K9JfXxc64qVkmCgKGS/VBdaEQK
         lS/OIARyb4NuFYChxXV48jpsRAKzWC11hY56v0/fvitYNM/Fe0kXni7EEGlEBOo8W4aZ
         L+NKrr61lZ/gCQgVt0oSBmWQgfNoYAeGoIZqQz7YhCD+dV47q9M8fxm2vFWYiu2sh2qi
         cVnRzI/kvezyM4vScoUeddqzicrkUW4lHhs/f3UHW/4IgYwlWww/nVAgB2Ya2Sovh8RL
         JY1Q==
X-Gm-Message-State: APjAAAWYJj401FeLNu8g6r7RGjkrKXGDEC5rThoG1VtOyA9uHDhOYrFi
        fITVBR1yxrfuVeYWaMW4+js=
X-Google-Smtp-Source: APXvYqxgHLD2f5oJtoz+AyAXctI2xZcgbQi+AlkS3I0mSfEuFDbkAFcaqpr6dLBgxVvFOWqIidZ/Mg==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr22582wmc.1.1555334433258;
        Mon, 15 Apr 2019 06:20:33 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id n13sm54051810wrw.67.2019.04.15.06.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 06:20:32 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:20:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 16/30] PCI: tegra: Program AFI_CACHE* registers only for
 Tegra20
Message-ID: <20190415132031.GR29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-17-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VdnGiXwuH6t1Tqzo"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-17-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--VdnGiXwuH6t1Tqzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:41PM +0530, Manikanta Maddireddy wrote:
> AFI_CACHE* registers are available only in Tegra20, program them only
> for Tegra20.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 8e5fdc8ce3d6..cdaaf13a9fd7 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -887,6 +887,7 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
>   */
>  static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
>  {
> +	struct device_node *np =3D pcie->dev->of_node;
>  	u32 fpci_bar, size, axi_address;
> =20
>  	/* Bar 0: type 1 extended configuration space */
> @@ -927,11 +928,13 @@ static void tegra_pcie_setup_translations(struct te=
gra_pcie *pcie)
>  	afi_writel(pcie, 0, AFI_AXI_BAR5_SZ);
>  	afi_writel(pcie, 0, AFI_FPCI_BAR5);
> =20
> -	/* map all upstream transactions as uncached */
> -	afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
> -	afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
> -	afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
> -	afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
> +	if (of_device_is_compatible(np, "nvidia,tegra20-pcie")) {

At this point we've already matched on that compatible string, so we
could probably get that information from the SoC structure. Why are
these registers not available on later chips? How would we mark
transactions as uncached on later generations of Tegra?

Also, typically writing to non-existing registers on Tegra186 would
cause an SError exception, but I haven't seen any of those with PCIe
on Tegra186. So do these really not exist, or are they simply not used?

Thierry

> +		/* map all upstream transactions as uncached */
> +		afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
> +		afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
> +		afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
> +		afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
> +	}
> =20
>  	/* MSI translations are setup only when needed */
>  	afi_writel(pcie, 0, AFI_MSI_FPCI_BAR_ST);
> --=20
> 2.17.1
>=20

--VdnGiXwuH6t1Tqzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0hR8ACgkQ3SOs138+
s6Gu/w//Twhzo5kuCqVUznoiRP4rcPIQrkat0gCVVlx8jm+WeltFsZfyqCRXg587
hQGyyfyhsQI6/zdUYSv/pCAuI5Ko3pGe1dIri6b2M80+KZNq62Cx95rqt7+Mlt5J
W8CAp9OkjiyCnzVI2ozX+UmkHgupaXqB+XEFyphsjWeLVeZjijZ+p8X9kuX5ON5Z
jDM2H0OhUcApT1vTABQ4mMK5rztiv5NBU48XzMd7JcT4Jn6dPfvznEEJ/29BzJUU
9JcQ6q0LpXTa5ziSFxqZ2ikk7Vg0FXd2HPJeOd8q65wnDoyEnp3whKowJuIhOf0E
oZ2VsD0HQ0TIOvZhR4fgSXz6kucVF/lBjeOgGudhqPTdzd/Gt6/U7GuamkAllEqs
AXdgB2uGrp61UFeEpBUB70mZMQV3raB6LX7eNTec0R0m+qepBWp4X1tEOi5M4zTh
34ocxkz8/H2g6n2VykULUqdklfC8IuYjsvOETrk9JJyqwpMd6bv/TAOBkiUbT6VJ
qZJsyfcy6CG1UNkOvdjy/DXBUA084a+g/RmDaL4slS89MnyOwG4tW7qdcJiK6UR4
zrSe17iyUDh270lkUnthXqaBgGQSYCsUAzcNbcwW/stTVYr/zVuoZ1NyAgpU/Tgo
J8M267lsbJ08ExDMdEKytZpDDE7WpJ1NDhxhUAgQEqceKoWIqeQ=
=LsI6
-----END PGP SIGNATURE-----

--VdnGiXwuH6t1Tqzo--
