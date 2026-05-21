Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B935133DEE9
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369793; cv=none; b=UVpng+DLpzwFsNI4dK6lKcVX1XjFx+8m3v8ZbAAFwBYwVS1UhHVu14r1vkrKyY9opfL0f21Kp+W+T24iDvee++Xd0Ci2ere8+RFUBMMKVSrlrvDI0Ht1Q68cKUyfo56W9VAj2ogVl68+f6DYs6Z4aGsN6mu0OWpkAj2X4OY/gQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369793; c=relaxed/simple;
	bh=5iERjIdB45bNFMTo5WXsIu8w+0SabzOEBT+WywHs9jA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U4nmCQN5B8vQqoU8jmFoZd5KnvkwLIN2xuWbd1PiGV5zn8VS+1AWVvLR0KFvbr/wBtJsFPJdRiuKIKaFN+eLM3tiZhl0td7HguXflJujJ2fcSYUd3HS6Ofo0WIPd450k7flqJJKoi62fUIJtvw5QDrh/yOJbl5bkOrKVT7Blbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CryeF+Sn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CryeF+Sn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE411F000E9;
	Thu, 21 May 2026 13:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779369792;
	bh=CCA0VnX7Ghmy4xN500xEKq8KmrkgMT0X8UtNB/bc4a0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CryeF+SnK5mYh/PNskZuXBZoVpHQKh1RJlA4AIPDzVgnpEJOFhipDNdvc81TbR/SQ
	 uVYdGXpcQZMMyTff6bJy5ma35TQyA1Ie5p08DmkiQbybRUex7LSp2CCa1dvqaUk6y/
	 xyVBHAMNsWB0cI6qZ2ZVnb2a8BGO6xkgLMA4IW4/iwioi6jgNj5c5e7bbUqMc90uyN
	 /mKdZ8g5JOQuRgrJippczOkpe2h+D5SaBokWZZi4yFjIqrPxvf3tk0qkJTMxHm2jpy
	 Y9qbin0MpVHVA1QNU3WLETRyxbWdN11z+gpMaHZOSC4ZokXD6iNtXGsEFh4Prt+Olv
	 uXxoyeic7T3tQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] phy: qcom: qmp-pcie: Skip PHY reset if already
 up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, vkoul@kernel.org, linux-pci@vger.kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20260521-link_retain-v2-1-08ed448b081c@oss.qualcomm.com>
References: <20260521-link_retain-v2-1-08ed448b081c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 13:23:10 +0000
Message-Id: <20260521132311.4DE411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `skip_reset` condition is evaluated twice using a live hardwar=
e register, risking unbalanced reset operations if the PHY status changes b=
etween init and power_on.
--

commit 7deef03fab352fea4d882c35e253738b3fad392c
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

phy: qcom: qmp-pcie: Skip PHY reset if already up

This patch skips the nocsr reset during initialization if the bootloader
has already powered up the PCIe PHY and its status indicates it is up.
This avoids redundant initialization and link retraining delays during
boot.

> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualc=
omm/phy-qcom-qmp-pcie.c
> index fed2fc9bb3110..1458ac1478c7e 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c

[ ... ]

> @@ -4744,6 +4745,9 @@ static int qmp_pcie_init(struct phy *phy)
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

> @@ -4823,8 +4829,11 @@ static int qmp_pcie_power_on(struct phy *phy)
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
Since skip_reset is evaluated dynamically in both qmp_pcie_init() and
qmp_pcie_power_on() by reading the live QPHY_PCS_STATUS hardware register,
could this lead to an unbalanced reset?

If qmp->skip_init is true but the PHY status bit indicates initialization is
not complete, skip_reset will be false in qmp_pcie_init(), causing
nocsr_reset to be asserted.

Once the reset is asserted, the hardware state changes. When
qmp_pcie_power_on() later re-evaluates skip_reset, reading the status
register of a PHY held in reset might return 0. This would make skip_reset
evaluate to true here, skipping the reset_control_deassert() call and leavi=
ng
the PHY permanently stuck in reset.

Should the decision to skip the reset be evaluated exactly once and cached =
in
the device context instead of reading the live register twice?

>  	/*
>  	 * Write CSR register for PHY that doesn't support no_csr reset or has =
not
>  	 * been initialized.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-link_retai=
n-v2-0-08ed448b081c@oss.qualcomm.com?part=3D1
