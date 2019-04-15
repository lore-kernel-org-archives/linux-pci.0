Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D87C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620CD20880
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnlnhsW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfDOLGd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:06:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45750 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOLGd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 07:06:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so21330396wra.12;
        Mon, 15 Apr 2019 04:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K6oTZSCqNbKbRN9iarnjdc28aBz3y9yQ/eUleDmqNMU=;
        b=pnlnhsW0kkIjHQNQrN2Wzx4Jpb5v3RSL3GggMV3oWESeWFpGyhZATBmKkj+Vox/9mI
         9XZeqvjvKe5bUaM40rylblx3+IBaI7XNej6JIu7Z5CWuGOC2QHmykDv0TvIj28p81Pgh
         Ejgk5oBJKZMqxOIVRVnLr/7m5oanOVT1YLK5aLUZxBmTRP77sQRkSKiUO+W8VWEhiiD2
         YezrzS8w4x/GOMo63a9W+5k22fZJh+37W6vcG6ydtMiQOqpbL9HECAxLFJXLd2dWVrXJ
         baNowXjTgya8SoKcMMRkJ1Aiyu8lj7/iB1ryGmzrrGqiVMAg2dyfjdazpzb67ctLQZEw
         3wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K6oTZSCqNbKbRN9iarnjdc28aBz3y9yQ/eUleDmqNMU=;
        b=YkjKAm4cvU/XsgBrKyFEvgWL/J8WcBO7C7AR1rjJQRvfUQdTYJGaulNEHDhbnTmCOc
         aTyNG1TCllXSXprITSIt+KvrAHJvkJWZUknr3GlTvpPJIGxDcgArPAsFQBlAgRziKkHu
         1stI4XhOnj6xpe02TnlclZ8WOUUPfnnJBQX9rugrIxHDBwzuFPbQoOYKgx9wSMYGuO4j
         vka/X0VpcYJ3WJumQFBDgGhHU0i3TNwVX3lzpn2NuyndIDpBV9dOkh95QZzT2vnga0N5
         NQDLf+vkCC8fsqBEG6aQqauEDKmnplr3k99U1MlRIIrwna7dLZA5I51czbkzi5DNBSHN
         0AVA==
X-Gm-Message-State: APjAAAXm9tTC5cMIFkZdQqgFqsLsubOuFSjoioI1lTz3tN1X2tV/lkVn
        80CdTXaec/uBOYinrQ42S2A=
X-Google-Smtp-Source: APXvYqxiPWHcdiYdD5p83GQjOvnZtFr2dTkJ65fDtVQSNIP8bj2YImln26Xcx8CAocYizq/Bh92NiA==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr17402980wrr.275.1555326390777;
        Mon, 15 Apr 2019 04:06:30 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id s16sm44527302wrw.58.2019.04.15.04.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 04:06:29 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:06:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 03/30] PCI: tegra: Move REFCLK pad settings out of
 phy_power_on()
Message-ID: <20190415110628.GD29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-4-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-4-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:28PM +0530, Manikanta Maddireddy wrote:
> In Tegra186 PHY programming is done by BPMP-FW, so PHY calls are skipped
> in driver. REFCLK pad settings are independent of PHY and should be
> programmed by driver. So move REFCLK pad settings out of phy_power_on().
> These pad settings tune REFCLK peak to peak amplitude.
>=20
> Fixes: cf5d31801278 ("PCI: tegra: Program PADS_REFCLK_CFG* always, not
> just on legacy SoCs")
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 0bf270bcea34..a61ce9d475b4 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -852,7 +852,6 @@ static int tegra_pcie_port_phy_power_off(struct tegra=
_pcie_port *port)
>  static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
>  {
>  	struct device *dev =3D pcie->dev;
> -	const struct tegra_pcie_soc *soc =3D pcie->soc;
>  	struct tegra_pcie_port *port;
>  	int err;
> =20
> @@ -878,12 +877,6 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie=
 *pcie)
>  		}
>  	}
> =20
> -	/* Configure the reference clock driver */
> -	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
> -
> -	if (soc->num_ports > 2)
> -		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
> -
>  	return 0;
>  }
> =20
> @@ -2092,11 +2085,24 @@ static bool tegra_pcie_port_check_link(struct teg=
ra_pcie_port *port)
>  	return false;
>  }
> =20
> +static void tegra_pcie_apply_pad_settings(struct tegra_pcie *pcie)
> +{
> +	const struct tegra_pcie_soc *soc =3D pcie->soc;
> +
> +	/* Configure the reference clock driver */
> +	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
> +
> +	if (soc->num_ports > 2)
> +		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
> +}
> +
>  static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>  {
>  	struct device *dev =3D pcie->dev;
>  	struct tegra_pcie_port *port, *tmp;
> =20
> +	tegra_pcie_apply_pad_settings(pcie);
> +
>  	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
>  		dev_info(dev, "probing port %u, using %u lanes\n",
>  			 port->index, port->lanes);

This also seems to move the programming of these registers to a
different point in time. Was that intentional? If so, please mention it
in the commit message and describe why that's necessary.

If that was not intentional, it seems like the right place to call this
would be right after the call to tegra_pcie_enable_controller() in
tegra_pcie_pm_resume().

Thierry

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0ZbQACgkQ3SOs138+
s6EsXA//YGIAqdBfaxL2OO3F+GGjri8dGsbGAvScPXPlFpgBrny/KS0XmEoqAUsB
Tql8lEvjRZoW/Yy/7xw8SIPyEIZS4LQySrbI8fMsgFtw5qGElc9b61Q25WN4nFYZ
LSGmQ8HmtCTlmtx8Z3OY/GAYxlm5kq2uVuS0iEGfq+BC3eRllPkzGOkBAoDDNjDl
aimHH2rhly8Yb76pCVkoBNY3gMqt1KGKN0Iplm0PBAjcMRirz15qg2YttAe8Dpoe
Z77QmmfRfBOL08SsR7VU/n+nRNSPQrb9YQePaZv4mjkWOnGyofgbn7o5jbdaXczj
91ylB44mDfndTgkszNWQCy3cPDaSCWJfJ9Xyl9NcShNzYIvpW7A99fB2KyFnRAab
VXuBKHAzr7pJQQR8qbidO51ZT664400Iexh6/dZGy8DPZd3mYpSwsAAqlE4NGyHU
xykEe0d7lCrpCPk6CChEscgmOt7ssAe4pB2j9tAcRWMmpf/FDnTlL6uC7LbaG862
IHo9hczy8/l3qYDta+SQUc0aQ+yIrp7SDb6Qs9gMHwb0F741b50nC1MjkdYmInKA
1TXNf7Z89DLb4iOyKJOYPM3C4FDiAlapkXvtfPf87rvp+z665QRwCvC9bDeJ56xZ
rlG8CJq0g+SAnVu9V/MlV14YFC4KRPT2BmJ6KIDE1wkF2m+KiGc=
=Jqbg
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
