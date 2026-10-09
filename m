Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEB84A64EB;
	Fri,  9 Oct 2026 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533577; cv=none; b=pgNTSW+jxL4ISwKOPNmlXg+TIkbFJcFvZgZ1/BZwDthBftLDGsyBl1U9I6jjNhe5o8rXPvAvkap/WchITamq3X9W4si2CSMjl9+BTHeM1w5Uk5G9+VdSipVQT4jVusgZekZdYuo+Qon2sDndgdcaNcgN6XkoGppaIM27rBeYvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533577; c=relaxed/simple;
	bh=2FC5aAknaIEM4yTPfxfihpc5ozeHt8sCM3EdFHQQ9o8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GRPEzOstgi+9gWNj3supTgQV8OuHrXLC7RqU/+artlsOXL6HaXbTB7eqYvP6ar6I5aYYSZoqRyo2KMlJzhAYvXnrUMXPI+yBwbJFXse8Ga7cLi9718+MzZPDqxcE9rZoeh1dB7DoQ5oNLcNmXQCCcYnKoPvCD7G9YY3RalKBV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzJ7wGDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzJ7wGDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD8A1F000FF;
	Fri,  9 Oct 2026 08:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791533572;
	bh=X1cf1XRY96NZF0/0mJlvdPw4ueD3LtuwRBXDO6KPtEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UzJ7wGDYamxF/Oe+2y/8+9Pux0EoH6rJtroTIIdC+1c/dDyV5fGKWs+mp10E0mcU4
	 zKdFWBccaY0gf2uIeo0kSet9NpP3z79myNk+r/JNY1XrkEt1ectH9O20mvpc6QNTY/
	 pBtr9xLBNWKVItnRP2q//NUWFNxLudJzTao1x9NoYI4J22E1bNP8Z+I/l9vxmgwfV7
	 aKD5h1us1FhHJz5JIUJ6FrcFk6YWFn98xnQA8oP49GosTK5kRCY83ed3Sx2mJMZVpo
	 ac5HhVXAZ+WwkipVFx9ZpUWNXHZdhTCziwUlz4DGMcy9OO+bxrZJMvf5hOxzjMTnZv
	 kbG7oKTh3DGnQ==
Message-ID: <sashiko-outbox-165058@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20261009-q8b-dts-v2-4-eda11e5dea8b@radxa.com>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-4-eda11e5dea8b@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 08:12:51 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] arm64: dts: qcom: swapped vdda-phy-supply and vdda-pll-supply in m=
dss0_dp2_phy
--

commit 1ed6dcf998cee616c10f9c98d191dd8e63e625e3
Author: Xilin Wu <sophon@radxa.com>

arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B

This commit adds initial device tree support for the Radxa Dragon Q8B
single-board computer. It describes various hardware components including
storage, PCIe, USB-C, HDMI output, audio, and multiple regulators.

> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts b/arc=
h/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts
> new file mode 100644
> index 0000000000000..322b66de6ef68
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-radxa-dragon-q8b.dts
> @@ -0,0 +1,2102 @@
[ ... ]
> +		vreg_l3b: ldo3 {
> +			regulator-name =3D "vreg_l3b";
> +			regulator-min-microvolt =3D <1200000>;
> +			regulator-max-microvolt =3D <1200000>;
> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-boot-on;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes =3D <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
[ ... ]
> +		vreg_l6b: ldo6 {
> +			regulator-name =3D "vreg_l6b";
> +			regulator-min-microvolt =3D <880000>;
> +			regulator-max-microvolt =3D <880000>;
> +			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-boot-on;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes =3D <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
[ ... ]
> +&mdss0_dp2_phy {
> +	vdda-phy-supply =3D <&vreg_l3b>;
> +	vdda-pll-supply =3D <&vreg_l6b>;

[Severity: High]
Are the core analog PHY supply and PLL supply swapped here?

The vdda-phy-supply is connected to <&vreg_l3b> (which is configured as 1.2V
above), and vdda-pll-supply is connected to <&vreg_l6b> (configured as 0.88=
V).
For Qualcomm DisplayPort PHYs, the core analog PHY supply requires the lower
voltage rail (0.88V), and the PLL supply requires the higher voltage rail
(1.2V).=20

Could this apply 1.2V to the 0.88V core domain, potentially preventing the =
PHY
from initializing or causing overvoltage damage? For comparison, usb_0_qmpp=
hy
in this same file correctly uses the lower voltage for vdda-phy-supply and =
the
higher voltage for vdda-pll-supply.

> +
> +	status =3D "okay";
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-q8b-dts-v2=
-0-eda11e5dea8b@radxa.com?part=3D4
