Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918683EB10D
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539247; cv=none; b=FLdUAr9fKG8FdXsr7c2presyw6gqoO597Tz+cxzwuWeTNcOE8kw7VQX7D7kJbTKRmiEkOLfyVyWTSRrT9cn+vYe8LOYQiR0ZCpySgJ7CA4ELq1zaKgpSu+E+I0QtffsIyjdCChYqUu4OTBEBuGF+u65DxAFd0WHSMkwxsc8grlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539247; c=relaxed/simple;
	bh=AnrNYJglQv/2pbbLc4vqYxNmjIJ64BzNRnZH742IB1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fwF20qzDxmuiodW1VKu7IYHSsAm4FJzQpa1pKEj6+e01GkCHVOthrjbZkNOIT7sDDyTybz0ElaL34ZG/qM8dHDawcmeLEdOEEVanbnURgwwRAOaz4Vzyh1DuA1+FltybIR23Ei/VVvG6blhVc8A+++xjac5g/kHTKW3OLgfTXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+pnYP5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+pnYP5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF5F1F000FF;
	Wed, 16 Sep 2026 06:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539246;
	bh=N7iHGxJ3EDpCz2+2PoSdrKev3wTjp+MNYuW0fV77Y8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e+pnYP5gxO6wK/7QYJNdByQ5pvWu1/F+TGyJjZUxn1IZIUt2bWouPlMurc/aB6+7Q
	 XJG/qdjPMgbUMzVsTp53Te7ek7J2lkLLBmX96MKn/46owuSwOqNzvtYoGk+AXAz84Y
	 fQRHyzSssrpE7riaJf4Cl3LREVSCLfbyeQRHtahZd9wfLIQwXfXXqo+W8s0XAMEEMr
	 PuamwqcC9aVaY39doEMA9VWBFt5tyQjdbXKOqSdX3cJPpUhZMBItCYvLG5lB36YhyL
	 T3xaUa3gCtHZU9t5pwF2O3UkV0k1A+HuFsdkJnFOdHqNaIlYSZuzrgRtmZUr5exZOX
	 wpQJjqKIoko3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] PCI: qcom-ep: Move PHY init and drive PHY reset to
 align with HPG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiang Yu" <qiang.yu@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com, vkoul@kernel.org
In-Reply-To: <20260915-align_pcie_init_sequence_0916-v1-2-0b2195836f30@oss.qualcomm.com>
References: <20260915-align_pcie_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com>
 <20260915-align_pcie_init_sequence_0916-v1-2-0b2195836f30@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:14:05 +0000
Message-Id: <20260916061405.DCF5F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: qcom-ep: missing PARF_DEVICE_TYPE relocation
--

commit 5b56bf58f9d475d704bc41d4161818703cac582d
Author: Qiang Yu <qiang.yu@oss.qualcomm.com>

PCI: qcom-ep: Move PHY init and drive PHY reset to align with HPG

This patch rearranges the PHY initialization and reset sequences to
align with the hardware programming guide (HPG). It moves phy_init()
before the controller clock enable and folds phy_reset() into the
core reset assert/deassert sequence.

> PCI: qcom-ep: Move PHY init and drive PHY reset to align with HPG
>=20
> HPG requires the GDSC to be powered up and all PHY/controller clocks
> enabled before the controller's core reset and the PHY's reset are toggled
> together as one atomic group, with PARF_DEVICE_TYPE set right after that
> reset group, same as the RC-mode change.
>=20
> Move phy_init() ahead of the controller's own clock enable, and fold
> phy_reset() into the core reset assert/deassert. phy_power_on() keeps
> running afterwards. Also move the PARF_DEVICE_TYPE write out of
> qcom_pcie_perst_deassert() to right after the reset group, in
> qcom_pcie_enable_resources().

[Severity: Medium]
The commit message explicitly states the PARF_DEVICE_TYPE write is being
moved out of qcom_pcie_perst_deassert() to right after the reset group in
qcom_pcie_enable_resources(). However, the diff does not seem to include th=
is
change.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/cont=
roller/dwc/pcie-qcom-ep.c
> index 8364696a1b980..cd7725d277c5d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c

[ ... ]

> @@ -332,25 +338,25 @@ static int qcom_pcie_enable_resources(struct qcom_p=
cie_ep *pcie_ep)
>  	struct dw_pcie *pci =3D &pcie_ep->pci;
>  	int ret;
> =20
> -	ret =3D clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
> +	ret =3D phy_init(pcie_ep->phy);
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D qcom_pcie_ep_core_reset(pcie_ep);
> +	ret =3D clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
>  	if (ret)
> -		goto err_disable_clk;
> +		goto err_phy_exit;
> =20
> -	ret =3D phy_init(pcie_ep->phy);
> +	ret =3D qcom_pcie_ep_phy_core_reset(pcie_ep);
>  	if (ret)
>  		goto err_disable_clk;
> =20
>  	ret =3D phy_set_mode_ext(pcie_ep->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_EP);

[Severity: Medium]
Was the write to PARF_DEVICE_TYPE accidentally omitted from this patch?

Based on the commit message and HPG requirements, it looks like a write to
PARF_DEVICE_TYPE was intended to be inserted right here in
qcom_pcie_enable_resources().

Looking at the code in qcom_pcie_perst_deassert(), the write remains
untouched:

drivers/pci/controller/dwc/pcie-qcom-ep.c:qcom_pcie_perst_deassert() {
	...
	/* Configure PCIe to endpoint mode */
	writel_relaxed(PARF_DEVICE_TYPE_EP, pcie_ep->parf + PARF_DEVICE_TYPE);
	...
}

Could this mismatch between the HPG sequence and the actual implemented code
cause endpoint initialization failures when the hardware requires the device
type to be set immediately after reset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-align_pcie=
_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com?part=3D2
