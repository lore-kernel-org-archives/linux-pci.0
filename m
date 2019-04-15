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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0914C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B57820880
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBvB/hm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfDOLBk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:01:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39797 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOLBk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 07:01:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so19837821wmk.4;
        Mon, 15 Apr 2019 04:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=imv8G5opJXB9mOuYAxOwzxVVpe4692D5MxxF91Ua/g0=;
        b=lBvB/hm9jLxIUVgL2P/5VUjdRhu7nA8ooCnZEsw4BXfKmhTKPFpkXzF7YTVX34JJ8D
         YKAou77FzJ/jnHDI2pUXB5UEJ0v2+am5raTAPge7FsWN7eSNCCPXhP5uil5F80BFq987
         07o5k3NdPH8FcAz7/is3hnjIX8imLk61CuFNo5c93GCniS68Waq0DWlwr1pOOKAd3g3v
         6vvrCfPX3UmXrO5xMsMh1J/t/eHcC1TwNLDjZH4ajrWvcQjU4/ePrsDl6z6LkDSi/6Nf
         V+sEWndsKD8tODHxRdXxMpe9QwRCfbUe6vb61kfmmcfVjALGWZdw/898eiS/4nqpeRA8
         Vnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=imv8G5opJXB9mOuYAxOwzxVVpe4692D5MxxF91Ua/g0=;
        b=Oe+qUlbgqRGu9GtBQSXGxkUK/1U+J5yYq33ThhmyTqDosVqAN7GxV/Mr5efRcU+A7H
         drc4zPIrVpGd9OhFH+35y5KtP/iSuYHPIF/bvxmVBAKbtREK7lmZD18QyscIVBXPSWjd
         QVTefB39UnpEAObLpCGXu7Cs2a/sXrFVh2J9KosscCbwuX9JD7akpbrlxE95gc9yD0qW
         s44eF6W57BS3NXth7u+/SRrWRAFjcFIgepfsRRmV2vA6EhmKeSbu6XYsifPcq9LuHM4J
         HZ0B5FESjVeU4lK/kNLpNG2HBlF8ZSqE5s7cRL19qSix3AdPWh+XF+S/9xb9uj6sWtjA
         Jalg==
X-Gm-Message-State: APjAAAWyM/PpAaAtadYj+6/WwfJ+5v1Zyi6BFKqKPQW1EPDXkO5np8Si
        yvJLsEkSy2eFrdy3z2Ai/eY=
X-Google-Smtp-Source: APXvYqzonr8tyAv7Y1bRouObvoHyNJtIQyHaHq1il/EEuDwIlt2lJxqMEd9bu3687Hl1OKn/3Y2mqA==
X-Received: by 2002:a1c:f115:: with SMTP id p21mr21285503wmh.93.1555326097848;
        Mon, 15 Apr 2019 04:01:37 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id a126sm16700127wmh.4.2019.04.15.04.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 04:01:37 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:01:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 02/30] PCI: tegra: Fix PCIe host power up sequence
Message-ID: <20190415110136.GC29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-3-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-3-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:27PM +0530, Manikanta Maddireddy wrote:
> PCIe host power up sequence involves programming AFI(AXI to FPCI bridge)
> registers first and then PCIe registers. Otherwise AFI register settings
> may not latch to PCIe IP.
>=20
> PCIe root port starts LTSSM as soon as PCIe xrst is deasserted.
> So deassert PCIe xrst after programming PCIe registers.
>=20
> Modify PCIe power up sequence as follows,
>   - Power ungate PCIe partition
>   - Enable AFI clock
>   - Deassert AFI reset
>   - Program AFI registers
>   - Enable PCIe clock
>   - Deassert PCIe reset
>   - Program PCIe registers
>   - Deassert PCIe xrst to start LTSSM
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 73 ++++++++++++++++++------------
>  1 file changed, 43 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index f4f53d092e00..0bf270bcea34 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -966,9 +966,6 @@ static int tegra_pcie_enable_controller(struct tegra_=
pcie *pcie)
>  		}
>  	}
> =20
> -	/* take the PCIe interface module out of reset */
> -	reset_control_deassert(pcie->pcie_xrst);
> -
>  	/* finally enable PCIe */
>  	value =3D afi_readl(pcie, AFI_CONFIGURATION);
>  	value |=3D AFI_CONFIGURATION_EN_FPCI;
> @@ -997,8 +994,6 @@ static void tegra_pcie_disable_controller(struct tegr=
a_pcie *pcie)
>  {
>  	int err;
> =20
> -	reset_control_assert(pcie->pcie_xrst);
> -
>  	if (pcie->soc->program_uphy) {
>  		err =3D tegra_pcie_phy_power_off(pcie);
>  		if (err < 0)
> @@ -1014,13 +1009,11 @@ static void tegra_pcie_power_off(struct tegra_pci=
e *pcie)
>  	int err;
> =20
>  	reset_control_assert(pcie->afi_rst);
> -	reset_control_assert(pcie->pex_rst);
> =20
>  	clk_disable_unprepare(pcie->pll_e);
>  	if (soc->has_cml_clk)
>  		clk_disable_unprepare(pcie->cml_clk);
>  	clk_disable_unprepare(pcie->afi_clk);
> -	clk_disable_unprepare(pcie->pex_clk);
> =20
>  	if (!dev->pm_domain)
>  		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> @@ -1036,58 +1029,59 @@ static int tegra_pcie_power_on(struct tegra_pcie =
*pcie)
>  	const struct tegra_pcie_soc *soc =3D pcie->soc;
>  	int err;
> =20
> -	reset_control_assert(pcie->pcie_xrst);
> -	reset_control_assert(pcie->afi_rst);
> -	reset_control_assert(pcie->pex_rst);
> -
> -	if (!dev->pm_domain)
> -		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> -

This code was in place to ensure that PCIe was in a known good state
before following the power up sequence below. You mentioned elsewhere
that there's a regression on Cardhu after applying this series, so
perhaps Cardhu relies on the above hunk?

>  	/* enable regulators */
>  	err =3D regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
>  	if (err < 0)
>  		dev_err(dev, "failed to enable regulators: %d\n", err);
> =20
> -	if (dev->pm_domain) {
> -		err =3D clk_prepare_enable(pcie->pex_clk);
> +	if (!dev->pm_domain) {
> +		err =3D tegra_powergate_power_on(TEGRA_POWERGATE_PCIE);
>  		if (err) {
> -			dev_err(dev, "failed to enable PEX clock: %d\n", err);
> -			return err;
> +			dev_err(dev, "power ungate failed: %d\n", err);
> +			goto regulator_disable;
>  		}
> -		reset_control_deassert(pcie->pex_rst);
> -	} else {
> -		err =3D tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
> -							pcie->pex_clk,
> -							pcie->pex_rst);
> +		err =3D tegra_powergate_remove_clamping(TEGRA_POWERGATE_PCIE);
>  		if (err) {
> -			dev_err(dev, "powerup sequence failed: %d\n", err);
> -			return err;
> +			dev_err(dev, "remove clamp failed: %d\n", err);
> +			goto powergate;
>  		}
>  	}
> =20
> -	reset_control_deassert(pcie->afi_rst);
> -
>  	err =3D clk_prepare_enable(pcie->afi_clk);
>  	if (err < 0) {
>  		dev_err(dev, "failed to enable AFI clock: %d\n", err);
> -		return err;
> +		goto powergate;
>  	}
> =20
>  	if (soc->has_cml_clk) {
>  		err =3D clk_prepare_enable(pcie->cml_clk);
>  		if (err < 0) {
>  			dev_err(dev, "failed to enable CML clock: %d\n", err);
> -			return err;
> +			goto afi_clk_disable;
>  		}
>  	}
> =20
>  	err =3D clk_prepare_enable(pcie->pll_e);
>  	if (err < 0) {
>  		dev_err(dev, "failed to enable PLLE clock: %d\n", err);
> -		return err;
> +		goto cml_clk_disable;
>  	}
> =20
> +	reset_control_deassert(pcie->afi_rst);
> +
>  	return 0;
> +
> +cml_clk_disable:
> +	if (soc->has_cml_clk)
> +		clk_disable_unprepare(pcie->cml_clk);
> +afi_clk_disable:
> +	clk_disable_unprepare(pcie->afi_clk);
> +powergate:
> +	if (!dev->pm_domain)
> +		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> +regulator_disable:
> +	regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
> +	return err;
>  }
> =20
>  static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
> @@ -2108,7 +2102,12 @@ static void tegra_pcie_enable_ports(struct tegra_p=
cie *pcie)
>  			 port->index, port->lanes);
> =20
>  		tegra_pcie_port_enable(port);
> +	}
> +
> +	/* Start LTSSM from Tegra side */
> +	reset_control_deassert(pcie->pcie_xrst);
> =20
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
>  		if (tegra_pcie_port_check_link(port))
>  			continue;
> =20
> @@ -2123,6 +2122,8 @@ static void tegra_pcie_disable_ports(struct tegra_p=
cie *pcie)
>  {
>  	struct tegra_pcie_port *port, *tmp;
> =20
> +	reset_control_assert(pcie->pcie_xrst);
> +
>  	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
>  		tegra_pcie_port_disable(port);
>  }
> @@ -2472,6 +2473,9 @@ static int __maybe_unused tegra_pcie_pm_suspend(str=
uct device *dev)
> =20
>  	tegra_pcie_disable_ports(pcie);
> =20
> +	reset_control_assert(pcie->pex_rst);
> +	clk_disable_unprepare(pcie->pex_clk);
> +
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		tegra_pcie_disable_msi(pcie);
> =20
> @@ -2501,10 +2505,19 @@ static int __maybe_unused tegra_pcie_pm_resume(st=
ruct device *dev)
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		tegra_pcie_enable_msi(pcie);
> =20
> +	err =3D clk_prepare_enable(pcie->pex_clk);
> +	if (err) {
> +		dev_err(dev, "failed to enable PEX clock: %d\n", err);
> +		goto disable_controller;
> +	}
> +	reset_control_deassert(pcie->pex_rst);
> +
>  	tegra_pcie_enable_ports(pcie);
> =20
>  	return 0;
> =20
> +disable_controller:
> +	tegra_pcie_disable_controller(pcie);
>  poweroff:
>  	tegra_pcie_power_off(pcie);
> =20

There's quite a bit going on in this patch in general and I find it hard
to review because not all the changes seem related to what you described
in the commit message.

Can you perhaps try to split out the error cleanup changes into a
separate patch where it makes sense? It seems to me like at least for
tegra_pcie_power_on() we're currently missing all of the cleanup code.
You could make that a preparatory patch that goes before this particular
patch, which will hopefully make this patch easier to review.

Thierry

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0ZI0ACgkQ3SOs138+
s6GoshAAvjU4jv5Et69Zf0fio32hbjKN+Ue9KkrT8KPqxxCn3nQbzmFs0Z7OzLEo
gB/OLktbScWy3EmI26/iPdNBhepnyfCsm8LkSTgd9I7V0BETQ3pADuug7dGqAtJK
83ZbO4eUrbvApcTajP9a1DK/XSLwkitNWJWy1yaGL1+C/bitaQ8DH4S4b5xiyIK/
oEhmEtuqPKPlf3elMbSs2MsC+F3rr0TC2cnpXVBGZRTYjEhtfL4KsXWbA1r5NxTC
29jQHEx0aqZTe6NslbouTerhTGTCUjujsiVnoZfeqWPfJDIz7Xo4Tv/KC+KBr9xD
w5qcLHGexLz1Q1OCU72vb1DbWhNtNaHcfKWmd/yqBF56rAe1ZuNqSHIdOjkH5iWr
Ew7UWhbaffAnfwhb1bVdUYU8XQ1OFra46bA03Js2unaLow9Azpl0/nvN9JJJEZTW
asfSCFDmaTniXT+SUX3rQf03PLI6q/xEDvlFJ8C7b9RKdapA5RNXnlhOQu5AXtay
Iggwukqqwqj9YyKtSkD8y2Y8I76qAiaL2xiV2XBq38kNYhnTI6EnbTTcZed0xQsI
Z+0pYk5jiqZ0NZczW2IMVsgY/VKwzsZn8KOJoMhfj1EMzzH7R6bWa2d0lnRsfJJ7
lZBAYn739kAXo7m6zojf3XHj09Spnaa9/cog4JhhlOIPpcBJ34w=
=Vuq/
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
