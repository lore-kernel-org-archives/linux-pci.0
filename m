Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78A1538D73
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879904; cv=none; b=OKsopLQcCbTv7ZBoGTWveyxQHyNA05mFRV06/CXJlmYpPSRbXjozEgCN9DP6bYl50paCxDcatpJU30pCB45WdQqxyYTr18XocR5Of0V4nAqQUljA6z9qVJpkO/TTD+4OI/QAQPWDnAlaTeRjOHqYV5HKZrVi4lh0/Lvd3wJ0aXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879904; c=relaxed/simple;
	bh=CarrlqDuSEum0mmllFGpHtYMVjVDhGNEwx0HvaV77oY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pV1s7XPKKwpUh+kJqZOQxrKhrrBTD0PsoWI39XW7iRKm6dvVSV4u7UHEFiCXg9x/mQyeD9mqxoqBnIEVsgazVUU2r8ueOXOeNEY/r95BdQODIqjSLDDYVtQMWQgrpDZsFLjdJHWky53HMjiI1DwnHsLMRpnrfjzLv28OIne2D8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iErr/nhN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iErr/nhN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDF71F00A3A;
	Tue,  8 Sep 2026 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788879891;
	bh=EzwLETX9Put4bvR/MLm2qBEypo2I3uespony3YnUayU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iErr/nhN5SPbQ0mUAn9rD0XKBCBcCf73fpIT5U/B6fvZHF5hwpbd421enmRtRCSLg
	 SzqFzjxSv7hdDMjcaTLAzOaSVmNtdQrMy/qv48VXBIDQNoKOjnrcs+C30nH+WMxvX3
	 7Og6R04ToFVsl+NPQFNb9ZX8YkD93QX9bdBMNjQoj9lR06d+3Sv1ds4ZT2oq81Wzgb
	 4uIPZ8JgVWbjeP9N0evzRYlAJGX7SckUG7AZcHs4GGE3UBb3Mq5b10wF0h7LJZr5/7
	 RFQMesCrd4GJK0IOFbVRBF0UA0v+az8kkRP3wTHkWEeeMR22HFNjLYbP+8FmfTVqZl
	 TtNHcCo71KKiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/10] PCI: dw-rockchip: Clear debug buffer before
 entering L2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-10-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-10-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:04:50 +0000
Message-Id: <20260908150451.4CDF71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect arguments passed to rockchip_pcie_writel_apb() swap regi=
ster offset and value.
- [Medium] Undocumented modification of controller DBI state during suspend.
--

commit 8a75a527ec46d932d4c3b6e7ed428836e9df376b
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

PCI: dw-rockchip: Clear debug buffer before entering L2

This commit aims to clear the debug buffer before entering the L2 state to
ease debugging link training issues on resume. It introduces a helper to cl=
ear
the general debug register and invokes it during suspend.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index e675918ba1848..a508f4fffd2ac 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -77,6 +77,9 @@
>  #define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
>  #define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
> =20
> +/* General Debug Register */
> +#define PCIE_CLIENT_GENERAL_DEBUG	0x104
> +

[ ... ]

> @@ -1043,6 +1046,11 @@ static int rockchip_pcie_rc_reset_root_port(struct=
 pci_host_bridge *bridge,
>  	return ret;
>  }
> =20
> +static inline void rockchip_pcie_link_status_clear(struct rockchip_pcie =
*rockchip)
> +{
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_GENERAL_DEBUG, 0x0);

[Severity: High]
Are the arguments to rockchip_pcie_writel_apb() swapped here?

Looking at the function definition earlier in the file, the signature expec=
ts
the value before the register offset:

static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip, u32 va=
l,
				     u32 reg)

This call passes the register offset (PCIE_CLIENT_GENERAL_DEBUG, which is
0x104) as the data value to be written to register offset 0x0. This fails to
clear the intended debug register and might unexpectedly corrupt the contro=
ller
register at offset 0x0.

> +}
> +
>  static int rockchip_pcie_suspend(struct device *dev)
>  {
>  	struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
> @@ -1056,6 +1064,11 @@ static int rockchip_pcie_suspend(struct device *de=
v)
> =20
>  	rockchip->intx =3D rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_M=
ASK_LEGACY);
> =20
> +	/* All sub-devices are in D3hot by PCIe stack */
> +	dw_pcie_dbi_ro_wr_dis(pci);

[Severity: Medium]
Is this modification of the DBI state intentional for this commit?

This introduces an undocumented change to disable the controller's DBI=20
read-only writes unconditionally during the suspend sequence. Since there i=
s no
explanation in the commit message and no matching enable call, could this b=
e an
accidental inclusion unrelated to clearing the debug buffer?

> +
> +	rockchip_pcie_link_status_clear(rockchip);
> +
>  	ret =3D dw_pcie_suspend_noirq(pci);
>  	if (ret)
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rockchip-p=
cie-system-suspend-v6-0-fbabcca9921b@collabora.com?part=3D10
