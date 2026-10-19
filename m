Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7051123D
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419563; cv=none; b=I6P3MQlTdv1mRps/BWBRRAxDgQsm22RbAb9ssk3Wv8qA+oysZNZxZ/XRpdy1mMvPRdkWDxL6fg0GCSV93ueEyLoJQDwnwXyyi5sga5y/8wt6b9oKBA9eaMLl5/VX77YHKVrRajPETtpVnv0woWfgV/uTTURvTUrG14EJr76Y53A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419563; c=relaxed/simple;
	bh=XzV7lu/xbgBLDNykn+32ujXs3/OFGb0FkeI1FaQn8Kw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=C1VHV+BYRYUMaF+V+RLvA1430X4QdYJ+3XdZTVlw0j4gofb2fMqEPMVgfwnEhmt5j5TsN3nEeKjfq6jD39ME65JR3VWG8tvTTXHhqcsLpZTvTk4zw+0ynmu1t1auFkGzLierpM/ucuiKY50dYa3EKZ2/hUrNBfjTdCqdALJsXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFAw/Iw2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFAw/Iw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9FD1F000C6;
	Mon, 19 Oct 2026 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419560;
	bh=nRxnPsKL7bkoSGVTnkd4pyyhXCLsZzNMHEVV5aBbwDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HFAw/Iw2W+RrSR0CXIJytdThZF5sfE10q4kOra0TpTVNnVBd4XN9OgFbpyKA37RhJ
	 vkCKFVFbPVqEsf69bzZndpxOSE6LiA15OF5Y2Fe/D/HMUIu6NOJ3GBGcPa7c+0ANHS
	 krfDp9qDGgaazurvpxbsJ2lIsWIqLHtPPOPEB85cjYQrJWvxLyAuggOrHqiKPWMbyr
	 jxnq+hg3y49G+2ftXfTT+Q2CmUWh0K4NdgB8uSbqLmP5Qcbgn0nwN9KMTxKYcIobLw
	 XDYNSgdlYijcqxQJty4IKpWXLoxLABMlixVV4dHLGLqFLcBkopScobcynkdxBhZROx
	 Bjiyvy0hlSvzw==
Message-ID: <sashiko-outbox-177346@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] PCI: cadence: Add missing
 MODULE_DEVICE_TABLE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019135441.1420968-74-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-74-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:19:19 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: cadence: MODULE_DEVICE_TABLE() added to non-modular built-i=
n driver
--

commit 47a5cb89a268b5f62186006942f7b1da4567a7f3
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

PCI: cadence: Add missing MODULE_DEVICE_TABLE()

This commit adds MODULE_DEVICE_TABLE(of, cdns_plat_pcie_of_match) to
pcie-cadence-plat.c so that module alias information is generated for
OF-based module autoloading.

Link: https://patch.msgid.link/20260704122835.14277-1-pengpeng@iscas.ac.cn

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers=
/pci/controller/cadence/pcie-cadence-plat.c
> index 0456845dabb96..0f9cf2a9f0034 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -167,6 +167,7 @@ static const struct of_device_id cdns_plat_pcie_of_ma=
tch[] =3D {
>  	},
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, cdns_plat_pcie_of_match);
> =20
>  static struct platform_driver cdns_plat_pcie_driver =3D {
>  	.driver =3D {

[Severity: Medium]
Can this driver actually be built as a loadable module in this tree?

Upstream commit 611627a4e5e4a ("PCI: cadence: Add module support for
platform controller driver", merged in v6.19) converted the Kconfig symbols
from bool to tristate and switched the driver to module_platform_driver(),
but that prerequisite commit is not present in this v6.18 baseline.

In this tree, drivers/pci/controller/cadence/Kconfig defines the symbols as
bool:

config PCIE_CADENCE_PLAT
	bool

config PCIE_CADENCE_PLAT_HOST
	bool "Cadence platform PCIe controller (host mode)"

config PCIE_CADENCE_PLAT_EP
	bool "Cadence platform PCIe controller (endpoint mode)"

And drivers/pci/controller/cadence/pcie-cadence-plat.c registers
cdns_plat_pcie_driver as a built-in driver without including
linux/module.h, defining a .remove callback, or setting MODULE_LICENSE():

static struct platform_driver cdns_plat_pcie_driver =3D {
	.driver =3D {
		.name =3D "cdns-pcie",
		.of_match_table =3D cdns_plat_pcie_of_match,
		.pm	=3D &cdns_pcie_pm_ops,
	},
	.probe =3D cdns_plat_pcie_probe,
	.shutdown =3D cdns_plat_pcie_shutdown,
};
builtin_platform_driver(cdns_plat_pcie_driver);

Since pcie-cadence-plat can only be compiled built-in (never with -DMODULE),
MODULE_DEVICE_TABLE(of, cdns_plat_pcie_of_match) preprocesses to nothing
under !MODULE and relies on transitive inclusion of linux/module.h. Should
this backport be dropped from this branch, or is commit 611627a4e5e4a also
intended to be backported?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-74-sashal@kernel.org?part=3D1
