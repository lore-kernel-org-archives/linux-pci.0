Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C65A3CBE7C
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539425; cv=none; b=KRU/MzgIOO4D/FWcJDyC+tnIeTx4xZiP3EM+PGsk20r54Pl0qPPwpyR+mbir4orN+yv+ZQbk0I9UYb0B0tltcoQ/Ht5koYrmCfyNx/Ga3PIZZGfEvSbH5DiKbZ4PpEFXttujc78r9hAXoBH97X8mHWqeDkkGedG75WIQBNmHAZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539425; c=relaxed/simple;
	bh=EzlN4mRHijKBMn2ktzQ/aax0nldjxNN36Bvs2XAUN1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NbAumfqalVL4FVIX6JPqRzpKid5dBet8H1jrkjsSH+IYu3vZsq9nLB0CxejqU8LeEaMRNJ268KY+tfl40dyIUf+v6PTlohVDQsXy0JEABkfzQTpSejxtAh2MDhkUO44LztXtPVT8guLUs/nEwj0blHluS2C/xbOLWduPM+wSHic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMHWlkYJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMHWlkYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F02C1F000FF;
	Wed, 16 Sep 2026 06:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539423;
	bh=lYUL43qC1fa3U1LOOBs0pqpAXFYLD6HLTTr9i50HNws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WMHWlkYJENdJ1pss0rtlpdQtU3icvWkVQYL3fugjfTf58N6RUMGT+Mrtv/B9QEXzc
	 3XhyjgPmqFQKaWZu0PSPKzBq4pATyk77lkqS8hOTIROV911Rhef1wyxKBkoTQbHKPB
	 dmsqCptC/qOPVzoYVYSc1Sz+CDuCL7FwHXyMVwxqEnsnHaiGL4XmoJ6GFa2LB/gCOV
	 mj5ru5E0SK7M+9FpVHU2x/NHWULw5kQUT50jHBz/s5W79lo5LLr9X9tVnEt5LA5GG3
	 mwHr3xm2kfzujsPdRvfk0biq2RJ9uV2M+6iAC0rNt2agjP4R52RGR2j3hQsO27dxNT
	 mHc5XV4u6MfjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] phy: qcom-qmp-pcie: Split phy_ops into
 init/exit/reset/power_on
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiang Yu" <qiang.yu@oss.qualcomm.com>
Cc: olteanv@gmail.com, vkoul@kernel.org, linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20260915-align_pcie_init_sequence_0916-v1-4-0b2195836f30@oss.qualcomm.com>
References: <20260915-align_pcie_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com>
 <20260915-align_pcie_init_sequence_0916-v1-4-0b2195836f30@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:17:02 +0000
Message-Id: <20260916061703.5F02C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] phy: qcom-qmp-pcie: nocsr_reset left asserted when skip_init is fa=
lse
--

commit 09fee607f4ad44d50cee755a3e356ff08d5879e2
Author: Qiang Yu <qiang.yu@oss.qualcomm.com>

phy: qcom-qmp-pcie: Split phy_ops into init/exit/reset/power_on

This commit splits the combined power_on and power_off operations into
separate init, exit, reset, and power_on functions. It reorders regulator,
clock, and reset toggling to align with HPG requirements. It also introduces
a skip_reset field to share the initialization state between functions.

> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualc=
omm/phy-qcom-qmp-pcie.c
> index d30194c6ed17f..2b6741a4120c5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c

[ ... ]

> @@ -5833,12 +5809,62 @@ static int qmp_pcie_exit(struct phy *phy)
>  		reset_control_bulk_assert(cfg->num_resets, qmp->resets);
> =20
>  	clk_bulk_disable_unprepare(ARRAY_SIZE(qmp_pciephy_clk_l), qmp->clks);
> +	clk_bulk_disable_unprepare(qmp->num_pipe_clks, qmp->pipe_clks);
> =20
>  	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
> =20
>  	return 0;
>  }
> =20
> +static int qmp_pcie_reset(struct phy *phy)
> +{
> +	struct qmp_pcie *qmp =3D phy_get_drvdata(phy);
> +	const struct qmp_phy_cfg *cfg =3D qmp->cfg;
> +	int ret;
> +
> +	if (qmp->skip_reset)
> +		return 0;
> +
> +	if (qmp->skip_init) {
> +		ret =3D reset_control_assert(qmp->nocsr_reset);
> +		if (ret) {
> +			dev_err(qmp->dev, "no-csr reset assert failed\n");
> +			return ret;
> +		}
> +
> +		usleep_range(200, 300);
> +
> +		ret =3D reset_control_deassert(qmp->nocsr_reset);
> +		if (ret) {
> +			dev_err(qmp->dev, "no-csr reset deassert failed\n");
> +			return ret;
> +		}
> +
> +		return 0;
> +	}
> +
> +	/*
> +	 * Toggle BCR reset for PHY that doesn't support no_csr reset or has not
> +	 * been initialized.
> +	 */
> +	ret =3D reset_control_bulk_assert(cfg->num_resets, qmp->resets);
[Severity: High]
Does this fallback path in qmp_pcie_reset() fail to deassert nocsr_reset
when skip_init evaluates to false?

Since qmp_pcie_exit() explicitly asserts nocsr_reset on exit, if skip_init
is false on the next initialization (for example, after a system suspend or
resume where power loss clears PHY CSRs like QPHY_START_CTRL), wouldn't this
execution path only toggle the bulk resets and leave nocsr_reset stuck in
the asserted state?

> +	if (ret) {
> +		dev_err(qmp->dev, "reset assert failed\n");
> +		return ret;
> +	}
> +
> +	usleep_range(200, 300);
> +
> +	ret =3D reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
> +	if (ret) {
> +		dev_err(qmp->dev, "reset deassert failed\n");
> +		reset_control_bulk_assert(cfg->num_resets, qmp->resets);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int qmp_pcie_power_on(struct phy *phy)
>  {
>  	struct qmp_pcie *qmp =3D phy_get_drvdata(phy);

[ ... ]

> @@ -5870,22 +5893,6 @@ static int qmp_pcie_power_on(struct phy *phy)
>  	qmp_pcie_init_registers(qmp, &cfg->tbls);
>  	qmp_pcie_init_registers(qmp, mode_tbls);
> =20
> -skip_tbls_init:
> -	ret =3D clk_bulk_prepare_enable(qmp->num_pipe_clks, qmp->pipe_clks);
> -	if (ret)
> -		return ret;
> -
> -	if (!skip_reset) {
> -		ret =3D reset_control_deassert(qmp->nocsr_reset);
> -		if (ret) {
> -			dev_err(qmp->dev, "no-csr reset deassert failed\n");
> -			goto err_disable_pipe_clk;
> -		}
> -	}
> -
> -	if (qmp->skip_init)
> -		goto skip_serdes_start;
> -
>  	/* Pull PHY out of reset state */
>  	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
[Severity: High]
With the explicit nocsr_reset deassertion removed from qmp_pcie_power_on(),
does the code now rely entirely on qmp_pcie_reset() to deassert it?

Since qmp_pcie_reset() doesn't seem to deassert nocsr_reset when skip_init
is false, this appears to set the PHY up to silently fail or time out on
initialization.

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-align_pcie=
_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com?part=3D4
