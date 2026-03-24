Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E093D6CB4
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342564; cv=pass; b=sX4mncMce8nu6Bi598E1PGGF96CcP9Veoh35AobJ0X8rcNkEjDOebaI856JErVh4Mr8pzHZrmkr3kZqQ38gYynQKRQo4JwuBiLRf8445LUiWr9DdEJf8U5WFTo09kKBK/w0KrMmOckm/2/imlYs6gVv8av9+Lj4iCs29vmrKhz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342564; c=relaxed/simple;
	bh=lEShR4rKMkSELt26ZwA0I/2Ez956QiPoKGzLj/Dt6xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ui2uo4c6pnExJ3ytng2WINvoKb3rPJ8fa6D8OddOtQEcwhq+hmIMRbnehNdOnZXBBS9HdlFhIQ7InEKbq9I/1ONH8wE48h73glMAlf7fN305ZXuPNEgoPJgkaKoSlSVOKgYFFsid9qfeC+7EGZn3NJ6UfO23IzEnBvEzg2Yi8dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CkmfMalO; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CkmfMalO"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a27daa652fso5043097e87.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 01:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774342559; cv=none;
        d=google.com; s=arc-20240605;
        b=JBJCYmyq45X5jkWkiLrLavN2c1tk2EJuurCZGVQt25M0N2nZl2/k+QINYktEiDz5EY
         qJ62gqM1lGU48oQzhRL+GXwfvAdn+s6GqtuWfVvhNLHV2Dv6z4GM6b0JhJs8UbCwkM4L
         4ksXyNwmHmZwc5CfPPvcJjPwa/f1JgdQ6SG6OISghVf/78V/CqSkPQOsIMbhnHoWemJG
         Av8Q3b0gIVG2OsI+L8/10tRmZIjWDmaWjALw6+TCRS+yxbL+CSiEUsnBUPSzb2bzZwpW
         GYHsyY8LxlwLmp9hgSCJV8ln3rBckKK+x4A9GHcxBZndaP0/Im8WVQNAXldtMOMuNrN7
         O1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=npDd530fJxsPD1tz+PH0aZPhJF217S6JmKkun0w5HYU=;
        fh=1fTbkKf9Nd3mTt3M4WTQ6k6PaqVNE2Z6Lhvx238SSEI=;
        b=BsJiGQY+XzIMDZI9EDtLAQlb1fY4rFe4a9FHB+DToqJ1P1hkpAch9Fp1nBAJqzjjlr
         01xH7X1H6rcayFwJuYmHANG1WW0ig5EOcQxupAlNbXWsisaIOaY4KX4k1176+raHxATs
         3QrfDTsoJpkambqRACXbon5cb7CRQQk3EWKPjn08W8osXzNWYA+A+3fAtZE7wObYgxcH
         ztSe7kvdC3kF/C9Tyq1T25hUjHpBvLpu7frd+Y4KdLReU/QB4PxdghpEofwz+rmn+QAt
         BI+4jO7YpamDG0WzNhnFOgYvkRuGauGoCZd2axK6RXl/2rsTMEhNNq2MuVzOcyMB3V7c
         pZXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774342559; x=1774947359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npDd530fJxsPD1tz+PH0aZPhJF217S6JmKkun0w5HYU=;
        b=CkmfMalO8dxKouSLCD2s4YUXCjNyT81HWktD/r11gbEAQbBtwNevxO4Si3O9PULmog
         rWP+f9rYg++p/IsBeqiuskhgPGUApqWXFqlEDmPmCmYkmOKeZbztm5/pVA2lXbAk43b3
         U3OOtz/+x+T2I4s1JceTvVJgsrhj8+BANW3/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774342559; x=1774947359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npDd530fJxsPD1tz+PH0aZPhJF217S6JmKkun0w5HYU=;
        b=svPNgUite53BCrr28PjQMnqsRKi55DF1stho66mc017fRREqq9gV3xxo3mDSBZWqtH
         4HsbJUR5R+nAOO1uv6uZ5aiu/v0ZpCth0+qPOtCE2UrtxZMupPVoO6rnavBXEU6Rv2jg
         ZbXNEG7sGOlvSiF1Fm6i2mA+IIPqR2fi1fyVOP6wfZkc04JC+vlglwM7Id/k7zieudZd
         +ks+leYJpCcdWS9KO4bzwI9HmwFq9MEpVyvhrjXyn1SZc1bYsU8m7mIwqe20p7MZwnQm
         H7v/Ap2Q5euojaq+N5kmlBHUiD+ibvvE4RSHCrNYE6R/flk8yfQilFtSqzxii1FM5iFz
         e+PA==
X-Forwarded-Encrypted: i=1; AJvYcCUp+7TP6K6X7PTPiHSzpvvJKsp5iHPyb7r9Qenj5CGVY51rsnfsvb+gs5XBp1Z8izY9RW3Yy4xLEeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz043eQBNtN6oD7XXNJQ3jaN03LLX5RF+WjKimhPCgR80/ztrcF
	lHv/jWxC3x2aU3SxG/LjDqUSjtqpruzc1UsVChoS31HJTCmcgYPmNNEfG+xM7o925w0sp1xHlgv
	OU/UUUHYi0IjvaZ4Hxbuqh7mP9/3TLzajOVOHWq6r
X-Gm-Gg: ATEYQzx9IkZISD2zcYEs9lsXQDo9Kv/J9gkrG5Sjx8JiDxjk0TWynwQPKykkmQBnEtJ
	RPLl59tocmCTVNZA0b/iVOtE970wPcEd6W6PV5q2mgeZqyjUnLKJ46PUfS1cANuK0IpY3a5CMKv
	YFj2mYpxpt5b+gT44QzNCFbGrfhcjtaOa22mpXbJVqhRZxGQ1QXcPVM6odwXHYMwvSW6hsURcc6
	Bk9O41weQmxyHyjngI1CwNCaXj7xA46BVJtBZz2L2psg7Dp941yR2AOX6O9Ypuk2Wczxztojdsz
	iwNF5CaKST2HleoFXOZm1TFFDiEuNBAnCsBfag==
X-Received: by 2002:a05:6512:615:10b0:5a2:86a5:99bb with SMTP id
 2adb3069b0e04-5a286a59a60mr3605567e87.21.1774342558506; Tue, 24 Mar 2026
 01:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324052002.4072430-1-wenst@chromium.org> <20260324052002.4072430-6-wenst@chromium.org>
In-Reply-To: <20260324052002.4072430-6-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 24 Mar 2026 16:55:47 +0800
X-Gm-Features: AQROBzDtsFjuWuhP_OPV3b4K-uNoyhsBQxaUmf0C6sBX9QxTV8gpdW8yF1FtVHE
Message-ID: <CAGXv+5Gg90cDAV5ntBet9QTnyxrpzoMSNTvJJs0da2C32AFE1w@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] PCI: mediatek-gen3: Split out device power helpers
To: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 1:20=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> In preparation for adding full power on/off control with the pwrctrl
> API, split out the existing code that only partially deals with device
> power sequencing into separate helper functions. The existing code only
> handles PERST#.
>
> This is purely moving code around, and brings no functional changes.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 87 ++++++++++++---------
>  1 file changed, 52 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/co=
ntroller/pcie-mediatek-gen3.c
> index 22a16e4ebc76..526db8815401 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -403,6 +403,54 @@ static void mtk_pcie_enable_msi(struct mtk_gen3_pcie=
 *pcie)
>         writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
>  }
>
> +static int mtk_pcie_devices_power_up(struct mtk_gen3_pcie *pcie)
> +{
> +       int err;

Sashiko pointed out that this addition would cause an unused variable
warning. This line should be added in the last patch instead.

Do you want me to respin? Or is it fine since the end result is the same?

Sorry about this.


ChenYu


> +       u32 val;
> +
> +       /*
> +        * Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB si=
gnal
> +        * causing occasional PCIe link down. In order to overcome the is=
sue,
> +        * PCIE_RSTB signals are not asserted/released at this stage and =
the
> +        * PCIe block is reset using en7523_reset_assert() and
> +        * en7581_pci_enable().
> +        */
> +       if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> +               /* Assert all reset signals */
> +               val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> +               val |=3D PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
> +                      PCIE_PE_RSTB;
> +               writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +
> +               /*
> +                * Described in PCIe CEM specification revision 6.0.
> +                *
> +                * The deassertion of PERST# should be delayed 100ms (TPV=
PERL)
> +                * for the power and clock to become stable.
> +                */
> +               msleep(PCIE_T_PVPERL_MS);
> +
> +               /* De-assert reset signals */
> +               val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB =
|
> +                        PCIE_PE_RSTB);
> +               writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +       }
> +
> +       return 0;
> +}
> +
> +static void mtk_pcie_devices_power_down(struct mtk_gen3_pcie *pcie)
> +{
> +       u32 val;
> +
> +       if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> +               /* Assert the PERST# pin */
> +               val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> +               val |=3D PCIE_PE_RSTB;
> +               writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +       }
> +}
> +
>  static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>  {
>         struct resource_entry *entry;
> @@ -489,33 +537,9 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pci=
e *pcie)
>                         return err;
>         }
>
> -       /*
> -        * Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB si=
gnal
> -        * causing occasional PCIe link down. In order to overcome the is=
sue,
> -        * PCIE_RSTB signals are not asserted/released at this stage and =
the
> -        * PCIe block is reset using en7523_reset_assert() and
> -        * en7581_pci_enable().
> -        */
> -       if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> -               /* Assert all reset signals */
> -               val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> -               val |=3D PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
> -                      PCIE_PE_RSTB;
> -               writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> -
> -               /*
> -                * Described in PCIe CEM specification revision 6.0.
> -                *
> -                * The deassertion of PERST# should be delayed 100ms (TPV=
PERL)
> -                * for the power and clock to become stable.
> -                */
> -               msleep(PCIE_T_PVPERL_MS);
> -
> -               /* De-assert reset signals */
> -               val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB =
|
> -                        PCIE_PE_RSTB);
> -               writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> -       }
> +       err =3D mtk_pcie_devices_power_up(pcie);
> +       if (err)
> +               return err;
>
>         /* Check if the link is up or not */
>         err =3D readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val=
,
> @@ -1270,7 +1294,6 @@ static int mtk_pcie_suspend_noirq(struct device *de=
v)
>  {
>         struct mtk_gen3_pcie *pcie =3D dev_get_drvdata(dev);
>         int err;
> -       u32 val;
>
>         /* Trigger link to L2 state */
>         err =3D mtk_pcie_turn_off_link(pcie);
> @@ -1279,13 +1302,7 @@ static int mtk_pcie_suspend_noirq(struct device *d=
ev)
>                 return err;
>         }
>
> -       if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> -               /* Assert the PERST# pin */
> -               val =3D readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> -               val |=3D PCIE_PE_RSTB;
> -               writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> -       }
> -
> +       mtk_pcie_devices_power_down(pcie);
>         dev_dbg(pcie->dev, "entered L2 states successfully");
>
>         mtk_pcie_irq_save(pcie);
> --
> 2.53.0.983.g0bb29b3bc5-goog
>
