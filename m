Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52173433041;
	Mon, 21 Sep 2026 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989912; cv=none; b=PN+2HObwW5cQwvrPbM95n0omZomVs/G7xQJLQ0Bd79zJftjETdo1rCxR85CDYp/60MEl7KaeUEYMXHZVCeVvZEbvdyK6fRBUs8H+PK7p4gnDyO2vuAd7zkD3KuKL/6VOHSGL3A6tCW1vN5rSDfRmW5LhAJGu4F71tRmx1mqezkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989912; c=relaxed/simple;
	bh=zIbxUhHiOk+UOgFTXmySQz74d0N7667nt/IJ4QkySW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jifZAogQljBrzSxa/1+3mTNDKyu9Ujmlx8Ghcen/tZsp+sbsiTORL5QBWPhMcV/Kht47s21aOcVRWIUFcKyvGgvda2PpdcUUj7xlevFMJsDOlv7ScVkGVysAOHWexFSyjR+hKb/EBErtxImwM2j9K02Wfbqr/pAwbQLeC1WnSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNxdAN3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNxdAN3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE301F000FF;
	Mon, 21 Sep 2026 11:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789989908;
	bh=pwGbfa4XDRdA5s26mD9xo5152xD2yWXB/AA5gq/QG8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZNxdAN3FpAxG9ZY3pOpeuJ8MIv4X7T4KQE2YWeJyrW64p7rQez77c8xzlc/viFTNc
	 i/1/MHvHA2bkByhKCZwk/m/ki2gjTOYqDf+fAaWciphn4LE48dB5KYKXti/HONO2VL
	 77sv9VB3rDXyYsAb9SaXMYIaDykA3PW9atjiydY5QJWZIFdbDvgicrKa39HYRxuOgG
	 drJwB/qk0/lQNHe4ACiphrBHAWgCOrQttY83SSKNWK5/8rQugn3q3lO4/zhlLO5jk0
	 L4daeD/BKD1+6dBRkx5HGG168EdNs3C3FZRqR6FCXNWsJYAEtyaFBAd0ySeEe5Sq4P
	 WB8uHgWD0pEWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] PCI: qcom-ep: Set initial interconnect bandwidth
 before enabling clocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, olteanv@gmail.com, linux-phy@lists.infradead.org, vkoul@kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260921-monaco_ep-v1-4-63c5282fb0db@oss.qualcomm.com>
References: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
 <20260921-monaco_ep-v1-4-63c5282fb0db@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:25:07 +0000
Message-Id: <20260921112507.DBE301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: asymmetric resource teardown in qcom_pcie_disable_resources()
--

commit e8d1ed8b0977eb318a03b77e20d6636bb30f02d4
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: qcom-ep: Set initial interconnect bandwidth before enabling clocks

Some Qualcomm platforms require the interconnect bandwidth constraints
to be set before enabling the interconnect clocks, otherwise some
clocks get stuck in the off state. Move the icc_set_bw() call before
clk_bulk_prepare_enable() so the bandwidth vote is in place first.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/cont=
roller/dwc/pcie-qcom-ep.c
> index 56184e6ca6e69..0b23d7181539d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -331,9 +331,23 @@ static int qcom_pcie_enable_resources(struct qcom_pc=
ie_ep *pcie_ep)
>  	struct dw_pcie *pci =3D &pcie_ep->pci;
>  	int ret;
> =20
> +	/*
> +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> +	 * to be set before enabling interconnect clocks.
> +	 *
> +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> +	 * for the pcie-mem path.
> +	 */
> +	ret =3D icc_set_bw(pcie_ep->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
>  	ret =3D clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
>  	if (ret)
> -		return ret;
> +		goto err_disable_icc;

[ ... ]

> @@ -351,28 +365,14 @@ static int qcom_pcie_enable_resources(struct qcom_p=
cie_ep *pcie_ep)
>  	if (ret)
>  		goto err_phy_exit;
> =20
>  	return 0;
> =20
> -err_phy_off:
> -	phy_power_off(pcie_ep->phy);
>  err_phy_exit:
>  	phy_exit(pcie_ep->phy);
>  err_disable_clk:
>  	clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
> +err_disable_icc:
> +	icc_set_bw(pcie_ep->icc_mem, 0, 0);
> =20
>  	return ret;
>  }

[Severity: High]
Does qcom_pcie_disable_resources() also need to be updated to match this new
LIFO teardown ordering?

Since this patch moves the interconnect bandwidth enablement to be the first
step in qcom_pcie_enable_resources(), LIFO ordering requires it to be the l=
ast
step disabled. The error path here handles it correctly, but
qcom_pcie_disable_resources() still drops the interconnect bandwidth constr=
aint
before disabling the PHY and clocks:

drivers/pci/controller/dwc/pcie-qcom-ep.c:qcom_pcie_disable_resources() {
	...
	icc_set_bw(pcie_ep->icc_mem, 0, 0);
	phy_power_off(pcie_ep->phy);
	phy_exit(pcie_ep->phy);
	clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
}

When the host asserts PERST, qcom_pcie_disable_resources() is called. Could
this order of teardown lead to bus hangs, NOC errors, or clocks getting stu=
ck
in an invalid state if the interconnect powers down while dependent clocks =
are
still active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-monaco_ep-=
v1-0-63c5282fb0db@oss.qualcomm.com?part=3D4
