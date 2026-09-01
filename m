Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CF47206A;
	Tue,  1 Sep 2026 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253558; cv=none; b=mpJHaynmFzsVzDTtsQ7WDtxaI73eCyleJTvGfOOn6kcfadIm3O6+x+DrvzWGbOrLIJRo/ljn/wz5x+KmU0pFx6B8gGGK1AWmyg1Oii5TQbujCymWop5ayKQaBynxM4KypmSY0CGPHweLrqgxkKcksWa1g06RY8l72ybcTtKCyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253558; c=relaxed/simple;
	bh=m96ggSPGYoHfEu2xH8uJqZzmILJe7qP9A0NWhEwB/cU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qRTj9JxnYuPzdomcFKhBCZu8TPWAS/S74HSBc2YZh6BVjCpqa34m4NzqF9zadQ4wURCEzAj1Jdpj2qtRhZwr2nNLek+WK0g3fiAzQ8lPsPCnXNgwACLRIgpDRmKHEBiO5k7yQDUUmmDHEaww0TFH+3EpXnU5jqQZGYtshT78uL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2Suoa56; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2Suoa56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CD21F000E9;
	Tue,  1 Sep 2026 09:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788253554;
	bh=KuVUUMiVWKPGBNQcqJbw1KvuVeRdOIBJTa4lJGyOfAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G2Suoa56LmItPitqcrgmvFckWKptoO4z7yocRcIxj937eqUwo0x/iJoOn0K2tNBQN
	 KQWZb8Z2HdW799daWVCNCaeAeYd8/ZevbFQPRHLQs3mK7wW4m01g8dcxDu+8jBi4rm
	 lhLcct79lWraRpaExVCi5ymsfcNRxzuBKlkyMJIylakx9dhlkQxHgv9QgmTWM40sbJ
	 uQ1pPpX7uvrxyVjMDGJyYje6/IhnUDj8hDIXlcUsGvYq4MZSALW+/yLwEEDwauR3kY
	 ZpItviWB7+X4FXrvYg+MrLDz65rGBk6BXLu6grOsdfd0aCBCuIBZIUrYBLsvFwGIjg
	 wvZ0C2C8wOiFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260901-q8b-dts-v1-6-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-6-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:05:52 +0000
Message-Id: <20260901090553.74CD21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Swapped voltage regulators for the DP2 PHY.
--

commit be4c87024201f57f02fd6174d5602a08840ba63a
Author: Xilin Wu <sophon@radxa.com>

arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B

This commit adds initial device tree support for the Radxa Dragon Q8B, based
on the Qualcomm Snapdragon 8cx Gen 3 SC8280XP platform. It describes various
hardware components including storage, PCIe interfaces, USB, HDMI output, a=
nd
audio.

> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts b/arc=
h/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts
> new file mode 100644
> index 0000000000000..1c0e94bba4d7d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts

[ ... ]

> +&mdss0_dp2_phy {
> +	vdda-phy-supply =3D <&vreg_l3b>;
> +	vdda-pll-supply =3D <&vreg_l6b>;

[Severity: High]
Are these voltage regulators swapped for the DP2 PHY? vreg_l3b provides
1.2V and vreg_l6b provides 0.88V, but the PHY requires ~0.88V and the PLL
requires 1.2V.

If vdda-phy-supply receives 1.2V, it violates the physical hardware
configuration which expects ~0.88V. This could cause the DP PHY to fail,
preventing DisplayPort output, and potentially risk hardware damage due to
overvoltage on the PHY rail.

> +
> +	status =3D "okay";
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-q8b-dts-v1=
-0-7de0b6a73d08@radxa.com?part=3D6
