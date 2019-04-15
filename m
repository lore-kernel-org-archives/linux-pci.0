Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA8AC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF4D2087C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0LXdg2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbfDOOLF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:11:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43868 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfDOOLE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 10:11:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so17482232wrx.10;
        Mon, 15 Apr 2019 07:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fBDUWyJqP2EJW+L05b2k9Lc1qr2Y8C4hJl7GI58OsEs=;
        b=i0LXdg2mFedT5XQk1ACp5sRx5pEf128smyt9a94ptKaYfAVDTtYiaXRjRvACmuMdp/
         GtK0BlxXtC5SD2c3+KB+TV9dnU0XzDSuUQU7egdzkymAZSP8tzfTKSzCmHuvuUAvE9bF
         UEsirdetlqVKv3gKEWiLchOsgmkAkprtCA5zXCGAioD71kH0TJX/Jw6iypMP2KvhaJC/
         WiPtrOMq9uZ8TluGfeYNuDcpIQvHp5SNYblS+ENq3nqnjNIlgqvY2UbJb6HwKKQ+eKOw
         9Oe1xaEcwT4YPSh5aw1wJ7fE/LD5mid0xCxqfC2g82xIn8kzcEsP5Lb/uJEB4CGP6i4N
         Vq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fBDUWyJqP2EJW+L05b2k9Lc1qr2Y8C4hJl7GI58OsEs=;
        b=IE2/CJ0HmaR1Lxj7Uj18UaoBHdPh/iaGUkJspMMNt10knhTHGA836HdvkMMeOEfYCJ
         DIRcfogEJ7wQBdKNSD5LTzeWidRSpV7dMXb7v9Hg7LZU9MrnDaFyvjL+DHfUXSl40G90
         +vnX7wwbqX6KBADIYijHkvb39KefzL+HBuztupnjKKwrZKWYXK7YkdgeTaoVg8qPukPF
         NAa3abDfNpJKgt3TIvxMQHqtNs25LZF0gFzyJfmSouBLhVsGg2i00CsL5T9NgHGYgE++
         QF3kgk/oe/dQIJ/P0bCzDrT7qm9cf1eUn9UObWsGFbIi5P7vPxAS79gsdgATWmNuw9el
         7nRw==
X-Gm-Message-State: APjAAAWDJsz1FCXb6vIgef0UdcX4MEJjczqxMv49WR2GlSbZmEYJtMAV
        JSfoPU4b7fmLojPoSncShu8=
X-Google-Smtp-Source: APXvYqz99APRnIst9/p5U3effnlLf01e9swd6KqAzrQ/bVZ/pRt9/CRrV1pOchlnFRun4dQTg7VkZw==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr14638954wrq.218.1555337461879;
        Mon, 15 Apr 2019 07:11:01 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id s189sm37684694wmf.45.2019.04.15.07.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 07:11:01 -0700 (PDT)
Date:   Mon, 15 Apr 2019 16:11:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 25/30] PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
Message-ID: <20190415141100.GZ29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-26-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L4xCDQ7GT+ph8Lmk"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-26-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--L4xCDQ7GT+ph8Lmk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:50PM +0530, Manikanta Maddireddy wrote:
> In Tegra210 AFI design has clamp value for the BIAS pad as 0, which keeps
> the bias pad in non power down mode. This is leading to power consumption

s/bias/BIAS/

> of 2 mW in BIAS pad, even if the PCIe partition is power gated. To avoid

powergated

> unnecessary power consumption, put PEX CLK & BIAS pads in deep power down
> mode when PCIe partition is power gated.

You should validate, but I'm pretty sure there's a way to make this work
without any code (or very minimal code) in the driver if you're using
the standard pinctrl state names.

Thierry

>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 65 +++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index c050687020f0..92c6daa0de84 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -30,6 +30,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/phy/phy.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
> @@ -323,6 +324,7 @@ struct tegra_pcie_soc {
>  	bool program_deskew_time;
>  	bool raw_violation_fixup;
>  	bool update_fc_threshold;
> +	bool config_pex_io_dpd;
>  	struct {
>  		struct {
>  			u32 rp_ectl_2_r1;
> @@ -385,6 +387,10 @@ struct tegra_pcie {
> =20
>  	const struct tegra_pcie_soc *soc;
>  	struct dentry *debugfs;
> +
> +	struct pinctrl *pex_pinctrl;
> +	struct pinctrl_state *pex_dpd_enable;
> +	struct pinctrl_state *pex_dpd_disable;
>  };
> =20
>  struct tegra_pcie_port {
> @@ -2154,6 +2160,37 @@ static int tegra_pcie_get_regulators(struct tegra_=
pcie *pcie, u32 lane_mask)
>  	return tegra_pcie_get_legacy_regulators(pcie);
>  }
> =20
> +static int tegra_pcie_parse_pinctrl(struct tegra_pcie *pcie)
> +{
> +	struct device *dev =3D pcie->dev;
> +	int err =3D 0;
> +
> +	pcie->pex_pinctrl =3D devm_pinctrl_get(dev);
> +	if (IS_ERR(pcie->pex_pinctrl)) {
> +		err =3D PTR_ERR(pcie->pex_pinctrl);
> +		dev_err(dev, "failed to get pinctrl handle: %d\n", err);
> +		return err;
> +	}
> +
> +	pcie->pex_dpd_enable =3D pinctrl_lookup_state(pcie->pex_pinctrl,
> +						    "pex-dpd-enable");
> +	if (IS_ERR(pcie->pex_dpd_enable)) {
> +		err =3D PTR_ERR(pcie->pex_dpd_enable);
> +		dev_err(dev, "missing pex-dpd-enable state: %d\n", err);
> +		return err;
> +	}
> +
> +	pcie->pex_dpd_disable =3D pinctrl_lookup_state(pcie->pex_pinctrl,
> +						     "pex-dpd-disable");
> +	if (IS_ERR(pcie->pex_dpd_disable)) {
> +		err =3D PTR_ERR(pcie->pex_dpd_disable);
> +		dev_err(dev, "missing pex-dpd-disable state: %d\n", err);
> +		return err;
> +	}
> +
> +	return err;
> +}
> +
>  static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  {
>  	struct device *dev =3D pcie->dev;
> @@ -2496,6 +2533,7 @@ static const struct tegra_pcie_soc tegra20_pcie =3D=
 {
>  	.program_deskew_time =3D false,
>  	.raw_violation_fixup =3D false,
>  	.update_fc_threshold =3D false,
> +	.config_pex_io_dpd =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> @@ -2524,6 +2562,7 @@ static const struct tegra_pcie_soc tegra30_pcie =3D=
 {
>  	.program_deskew_time =3D false,
>  	.raw_violation_fixup =3D false,
>  	.update_fc_threshold =3D false,
> +	.config_pex_io_dpd =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> @@ -2547,6 +2586,7 @@ static const struct tegra_pcie_soc tegra124_pcie =
=3D {
>  	.program_deskew_time =3D false,
>  	.raw_violation_fixup =3D true,
>  	.update_fc_threshold =3D false,
> +	.config_pex_io_dpd =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> @@ -2570,6 +2610,7 @@ static const struct tegra_pcie_soc tegra210_pcie =
=3D {
>  	.program_deskew_time =3D true,
>  	.raw_violation_fixup =3D false,
>  	.update_fc_threshold =3D true,
> +	.config_pex_io_dpd =3D true,
>  	.ectl.regs.rp_ectl_2_r1 =3D 0x0000000f,
>  	.ectl.regs.rp_ectl_4_r1 =3D 0x00000067,
>  	.ectl.regs.rp_ectl_5_r1 =3D 0x55010000,
> @@ -2607,6 +2648,7 @@ static const struct tegra_pcie_soc tegra186_pcie =
=3D {
>  	.program_deskew_time =3D false,
>  	.raw_violation_fixup =3D false,
>  	.update_fc_threshold =3D false,
> +	.config_pex_io_dpd =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> @@ -2753,6 +2795,12 @@ static int tegra_pcie_probe(struct platform_device=
 *pdev)
>  	INIT_LIST_HEAD(&pcie->ports);
>  	pcie->dev =3D dev;
> =20
> +	if (pcie->soc->config_pex_io_dpd) {
> +		err =3D tegra_pcie_parse_pinctrl(pcie);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	err =3D tegra_pcie_parse_dt(pcie);
>  	if (err < 0)
>  		return err;
> @@ -2866,6 +2914,8 @@ static int __maybe_unused tegra_pcie_pm_suspend(str=
uct device *dev)
>  		tegra_pcie_disable_msi(pcie);
> =20
>  	tegra_pcie_disable_controller(pcie);
> +	if (pcie->soc->config_pex_io_dpd)
> +		pinctrl_select_state(pcie->pex_pinctrl, pcie->pex_dpd_enable);
>  	tegra_pcie_power_off(pcie);
> =20
>  	return 0;
> @@ -2881,10 +2931,20 @@ static int __maybe_unused tegra_pcie_pm_resume(st=
ruct device *dev)
>  		dev_err(dev, "tegra pcie power on fail: %d\n", err);
>  		return err;
>  	}
> +
> +	if (pcie->soc->config_pex_io_dpd) {
> +		err =3D pinctrl_select_state(pcie->pex_pinctrl,
> +					   pcie->pex_dpd_disable);
> +		if (err < 0) {
> +			dev_err(dev, "disabling PCIe IO DPD failed: %d\n", err);
> +			goto poweroff;
> +		}
> +	}
> +
>  	err =3D tegra_pcie_enable_controller(pcie);
>  	if (err) {
>  		dev_err(dev, "tegra pcie controller enable fail: %d\n", err);
> -		goto poweroff;
> +		goto pex_dpd_enable;
>  	}
>  	tegra_pcie_setup_translations(pcie);
> =20
> @@ -2904,6 +2964,9 @@ static int __maybe_unused tegra_pcie_pm_resume(stru=
ct device *dev)
> =20
>  disable_controller:
>  	tegra_pcie_disable_controller(pcie);
> +pex_dpd_enable:
> +	if (pcie->soc->config_pex_io_dpd)
> +		pinctrl_select_state(pcie->pex_pinctrl, pcie->pex_dpd_enable);
>  poweroff:
>  	tegra_pcie_power_off(pcie);
> =20
> --=20
> 2.17.1
>=20

--L4xCDQ7GT+ph8Lmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0kPQACgkQ3SOs138+
s6GyJQ/9HYR3WnbJ5472esPwGC+75yX0fC/5fbeSEgCwjA+PU/wIzqjrT97/vzWq
RifFVbofE4DiEnBFfz+grF/apHAp0uJOYq4GBqTjWkOxm2X9UggGJPBmlmQEFUim
a/UYiG27VQODY8PPz1rnXM21v3/aWj35FCnaqLex9vCWmWkHPMrVFXwpvFOx9qL8
RKr8AteaPz51hha/34YzCRNu0FuQ+5fszlVI0l2MxiRqZjarh6Tqr2yh4uFnQmQD
EH3Y11uuSntU0oGeiHVEOB51eoxjJE5NRZZmBXSZMP6rCFTPmnd1+i9DylAF7ZGS
dR0Obj8gHXK/RzQlu0B7ImIeKiiHRGWPMDAljw7vaO7IUL2USZmGemQihHNaIoGq
4xHp+hhLf1DB5jc4bIO5UwnkwUvPiHPqXduwWZIijd/NjozwkKw1aDU7Q+fYFVVe
ByDGn+sMQHGR7N7pJfzrwNFGK+BvZNgFMbzR2WgUXmdG0YPwmGQukR+I6IcdLEo2
8swc57R67gKPWZSZOs84Z3RXCc5uXsu1FHf6eMJiu8CTwXLPpKMqB2Vf8Nhz6lyt
x/kHLWJoU2GmkTIcLzs1TG2wQ3FSYh4j5DvZzrXli9Ui4gH1pADLJJRtXyl3RxIS
k20MjGfyRWgvep3bIijOI9Gda9fyhNVxaPZNXMu1HDjNOHrz+u0=
=1XOz
-----END PGP SIGNATURE-----

--L4xCDQ7GT+ph8Lmk--
