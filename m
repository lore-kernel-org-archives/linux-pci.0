Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880B414BF92
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 06:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579645; cv=none; b=kqVN9+AXNoU7zomyMMbAke8hET/HsPoqatC520I/eFpV7OT/QnYtKYhfL35hmYQDeZa5MPm8b9Vy6vka6e+vMqEB2BHPeDopS54ye+wnWpuYUWsxqvPqAQ39Kk9HbCboXogb0q738aDYQj+iwkBRCCoksff/jYr6tK1DwDhwfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579645; c=relaxed/simple;
	bh=o9OC6Voea88KkDZ5mwblcTSJ2w4CcPIZ1gri1yhYIAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EUvc0zQmdE5xMBjl+JRzk4taTGB2qKnzn8YjWXqocyrMmRe6yd+kjySDwHuF5NE/mLcavb+6Orw5L+bcGH/yDrBf1desXskn4NAkCeRgPbv+48zixLJBQeE/uY3jEvP21IfFwh16eXkRuYg8+NMC9mvPUdMmxKciQtyPgGeVxLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4nnBRh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4nnBRh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E1E1F000E9;
	Thu,  9 Jul 2026 06:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783579643;
	bh=SsYFFdO9cDqCFRx7TQyUXrUQZhNGlReqGwUVnOWNVhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T4nnBRh7pwKOzv4ejCc9qx8VjRuRQ4qJFpKY1Wisbe4Nchr5b/8ajwaZlD6H4X9hT
	 bGDXHokypLmxrUOWsW2SkRjy79eZtoPXUQEgnqSnmgios51kGBKYXE0Ju2ZHVepPSk
	 4n4kaWfKTtY6lxn8QKD3d4Po7RT5kt4v4j7GhB5OvXtr7n3v1v5ysO+mc37ry8C3ax
	 vqwTwHJ8qT0YcS+LZavfr8H+1K8GfzSsH5T4O3PyeOuzfOinrT8qxFrjFUHapdt2Y5
	 NHv2fH1RrCB7z6PtIRojxkOfAQQA1cM6aEg6bggaPz5bHEPs+P+B6V5BAnR7+nazNm
	 NlaonO3RQzq9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] phy: qcom: qmp-pcie: Skip PHY reset if already
 up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, olteanv@gmail.com, linux-phy@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20260709-link_retain-v3-1-81a9d187bb61@oss.qualcomm.com>
References: <20260709-link_retain-v3-0-81a9d187bb61@oss.qualcomm.com>
 <20260709-link_retain-v3-1-81a9d187bb61@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 06:47:22 +0000
Message-Id: <20260709064722.A5E1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `skip_reset` condition is evaluated independently in both `qmp=
_pcie_init()` and `qmp_pcie_power_on()`, which can lead to unbalanced reset=
 operations and leave the PHY permanently in reset.
--

--- Patch [1]: [PATCH v3 1/4] phy: qcom: qmp-pcie: Skip PHY reset if alread=
y up ---
commit 3002076fcac7c2d6108104d2911e0cbb6c6bf224
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

phy: qcom: qmp-pcie: Skip PHY reset if already up

This patch extends the skip_init handling by introducing a skip_reset
condition for the qmp-pcie phy. It skips asserting and deasserting the
no-csr reset if the bootloader has already powered up the PCIe PHY and
it is operational. This reuses the bootloader-initialized PHY state to
save boot time and avoid redundant PCIe link retraining.

> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualc=
omm/phy-qcom-qmp-pcie.c
> index d3effad7a074b..49e10151cb1e4 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -4862,6 +4862,7 @@ static int qmp_pcie_init(struct phy *phy)
>  	struct qmp_pcie *qmp =3D phy_get_drvdata(phy);
>  	const struct qmp_phy_cfg *cfg =3D qmp->cfg;
>  	void __iomem *pcs =3D qmp->pcs;
> +	bool skip_reset;
>  	int ret;
> =20
>  	/*
> @@ -4877,6 +4878,9 @@ static int qmp_pcie_init(struct phy *phy)
>  		qphy_checkbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_STA=
RT) &&
>  		qphy_checkbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], cfg->pwrdn=
_ctrl);
> =20
> +	skip_reset =3D qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PC=
S_STATUS],
> +							    cfg->phy_status);
> +
>  	if (!qmp->skip_init && !cfg->tbls.serdes_num) {
>  		dev_err(qmp->dev, "Init sequence not available\n");
>  		return -ENODATA;

[ ... ]

> @@ -4900,13 +4904,15 @@ static int qmp_pcie_init(struct phy *phy)
>  		}
>  	}
> =20
> -	ret =3D reset_control_assert(qmp->nocsr_reset);
> -	if (ret) {
> -		dev_err(qmp->dev, "no-csr reset assert failed\n");
> -		goto err_assert_reset;
> -	}
> +	if (!skip_reset) {
> +		ret =3D reset_control_assert(qmp->nocsr_reset);
> +		if (ret) {
> +			dev_err(qmp->dev, "no-csr reset assert failed\n");
> +			goto err_assert_reset;
> +		}
> =20
> -	usleep_range(200, 300);
> +		usleep_range(200, 300);
> +	}
> =20
>  	if (!qmp->skip_init) {
>  		ret =3D reset_control_bulk_deassert(cfg->num_resets, qmp->resets);

[ ... ]

> @@ -4956,8 +4962,11 @@ static int qmp_pcie_power_on(struct phy *phy)
>  	void __iomem *pcs =3D qmp->pcs;
>  	void __iomem *status;
>  	unsigned int mask, val;
> +	bool skip_reset;
>  	int ret;
> =20
> +	skip_reset =3D qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PC=
S_STATUS],
> +							    cfg->phy_status);

[Severity: High]
Will this lead to unbalanced reset operations if the hardware state changes
between qmp_pcie_init() and qmp_pcie_power_on()?

In qmp_pcie_init(), skip_reset is computed by reading the live PHY status
register. If it evaluates to false, nocsr_reset is asserted. However,
asserting the reset could alter the state of the PHY status register.

When qmp_pcie_power_on() subsequently executes, it reads the status register
again here. If the register now indicates the PHY is ready, skip_reset would
evaluate to true, and the driver would skip reset_control_deassert() below,
leaving the PHY permanently in reset.

Could we cache the skip_reset decision in struct qmp_pcie during init rather
than re-evaluating the live register here?

>  	/*
>  	 * Write CSR register for PHY that doesn't support no_csr reset or has =
not
>  	 * been initialized.
> @@ -4981,10 +4990,12 @@ static int qmp_pcie_power_on(struct phy *phy)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D reset_control_deassert(qmp->nocsr_reset);
> -	if (ret) {
> -		dev_err(qmp->dev, "no-csr reset deassert failed\n");
> -		goto err_disable_pipe_clk;
> +	if (!skip_reset) {
> +		ret =3D reset_control_deassert(qmp->nocsr_reset);
> +		if (ret) {
> +			dev_err(qmp->dev, "no-csr reset deassert failed\n");
> +			goto err_disable_pipe_clk;
> +		}
>  	}
> =20
>  	if (qmp->skip_init)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-link_retai=
n-v3-0-81a9d187bb61@oss.qualcomm.com?part=3D1
