Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56792370AFC;
	Thu, 16 Jul 2026 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238696; cv=none; b=AUzNQhtZHGy3oRvAcfd1Z06YQpfadIeLpOgmpado0F86/fIy1zcUnVnRFNHXnYp4D9wCJXLYPpptJZ3t0NN3Tv4B510TgLlPSyI+sh1T6LBRFv00iFhkAHhAUTleYn0uk5g1pLJyNGzACE9iMOML2ZrRt3pOZkm2/UOI9MGlE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238696; c=relaxed/simple;
	bh=lyqvS+AVi3sHywfbtJvOGFiiAKSVsnmyWVOaYDKDq40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L7akpwA1aMNkkIQSnnxWq/xgfcIsGJLMmFWxzhNCLR7RcwJCPr47Ko2t3YP0qa4oyP9TVHMKCiFKtWCcCZDt0wCVOtPvAsdVU59pW4MOK5vOWVVClsuBF2MfU8r63PLIHZE4ntUUqOpBwb+5aKLmTj70DqrlsGXh2j9av7upTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coNLuF86; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coNLuF86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4CD1F000E9;
	Thu, 16 Jul 2026 21:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784238695;
	bh=GbX7hQULp7Wch61tN95rjuBkqHhHQEnobNyfyk5fLzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=coNLuF86gtm6fJvR+sL/tf86zpN/lHD/xbGDr+HW+PC0uukzjmFB0JDeV89+SwYyk
	 HBf7vXOvelpKNp9NQFL3Bg4qt+0+OkjbTfe1+eZxJD+SB1AxUH8p+wSrp0L8qnxcGr
	 o+jVEYXzbf3pAbDeuIYWdEP23FLoxKGFcOzY+bya6MflMVtiIfOWNSaqwTJmW7Kt2F
	 RQGyaXUrPpumKC13tkcqPW8C/SbLg+41+uE5PR6GNZ7QwL8jVs1KWpaUq2/kLbwRtG
	 hSlyV+ufi1Bi6jby3SIGrn1Zy4I905YwNL7oMQ5XRnNNsyctQRpLgCx89MwglXRu/y
	 oqXDl0CpS7oSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Keep Root Port MSI capability also for
 i.MX6Q
Reply-To: sashiko-reviews@lists.linux.dev
To: "Soeren Moch" <smoch@web.de>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260716214054.47372-1-smoch@web.de>
References: <20260716214054.47372-1-smoch@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 21:51:34 +0000
Message-Id: <20260716215134.AB4CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch applies the IMX_PCIE_FLAG_KEEP_MSI_CAP workaround to IMX=
6Q but fails to apply it to IMX6QP and IMX6SX, leaving endpoint MSIs broken=
 on those platforms.
--

--- Patch [1]: [PATCH v2] PCI: imx6: Keep Root Port MSI capability also for=
 i.MX6Q ---
commit c39e7347457d41f45ace38b5f670a9cded21c82b
Author: Soeren Moch <smoch@web.de>
PCI: imx6: Keep Root Port MSI capability also for i.MX6Q

This commit works around a hardware bug on the NXP i.MX6Q chipset where
endpoint MSIs are dropped if the Root Port MSI capability is disabled.
It achieves this by unconditionally applying the IMX_PCIE_FLAG_KEEP_MSI_CAP
flag to keep the Root Port MSI capability active.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 98e1db751132a..8130cf93c2bb4 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1995,7 +1995,8 @@ static const struct imx_pcie_drvdata drvdata[] =3D {
>  		.flags =3D IMX_PCIE_FLAG_IMX_PHY |
>  			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>  			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
> -			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
>  		.dbi_length =3D 0x200,
>  		.gpr =3D "fsl,imx6q-iomuxc-gpr",
>  		.ltssm_off =3D IOMUXC_GPR12,

[Severity: High]
This is a pre-existing issue, but should the IMX6QP and IMX6SX variants also
receive the IMX_PCIE_FLAG_KEEP_MSI_CAP workaround?

Looking at the drvdata definitions in this same file, the IMX6QP and IMX6SX
variants lack the IMX_PCIE_FLAG_KEEP_MSI_CAP flag:

        [IMX6SX] =3D {
                .variant =3D IMX6SX,
                .flags =3D IMX_PCIE_FLAG_IMX_PHY |
                         IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
                         IMX_PCIE_FLAG_SKIP_L23_READY |
                         IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
                ...

        [IMX6QP] =3D {
                .variant =3D IMX6QP,
                .flags =3D IMX_PCIE_FLAG_IMX_PHY |
                         IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
                         IMX_PCIE_FLAG_SKIP_L23_READY |
                         IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
                ...

Since they use the iMSI-RX controller and share the same DesignWare PCIe
integration as IMX6Q, dw_pcie_setup_rc() strips their Root Port MSI capabil=
ity
unless the keep_rp_msi_en flag is set.

Does leaving this flag off cause IRQ timeouts and complete functional failu=
re
of MSI-reliant PCIe devices on IMX6QP and IMX6SX platforms due to the same
hardware bug?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716214054.4737=
2-1-smoch@web.de?part=3D1
