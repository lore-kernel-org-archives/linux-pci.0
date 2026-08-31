Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0132D5C7A;
	Mon, 31 Aug 2026 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162071; cv=none; b=bkLcZiF67c9ddu9IR7+8XTjuWTHWYqlyJnuDrLsEnen0xQVD1zp874PQeuf7mSyqx+xeF1ZJwCA6aAVE3jI7zofKCV76ECgPr3c5VPzBJDbYdcsWSzcyBRB6RqR8t3Y55FlWpD7Z19Fc1c83+PrypVpBJO/3t6/8ZOc2BV83pYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162071; c=relaxed/simple;
	bh=5oGxLWkH/qCkatfytWH3n6IefE+CRwM4cDHWGcCBYJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h4zOWXNICDByHbeiFfyVybQo/SUlIWUFFTr62Gjwv7GjXCN9yneJT2Qg2mTu1sN9qVpb9803r24pMg1NxmciJWRSoDdR4hvp9ZgbBZAQOCkaG3+wRxlEm29UenYXsNMQ+ngTCgPUaVL1hykHtgZWEvCysS25XGMrlqr1WYlxsA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0H0Ckmp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0H0Ckmp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B49A1F000E9;
	Mon, 31 Aug 2026 07:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788162069;
	bh=hAQf/CQngepy0W8MxHagRxfGYVAMUeLDnXbzOXAWQdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e0H0Ckmpk7b3Ki7hs6f7+mKvRhJA+xZCcJ0a5w5JDJNfo8pzoqa67c5J5t4y35eWL
	 7J/97+hoLgmgg8NDPlNRQl87ny+LS0Riw0uwT8x/Ljfd54c5QPtf36yOmILuhyeiLt
	 525ipmyMPqASYB/9Zn7tN8mnR7Xqkiy1rz9jzGt8rERmMgbrKk/95rKeRBFejaVxo8
	 6rdR1YyBnFAuZofnTkYCwH5Qmu9WqE2jdX6PGNUDp9L6AYeyto3SFg7E81H+1BeFfN
	 5oPU8dFqu/Y3RxKzfPvsE+iWfZN7eYkeB/32Ito2D/odI0rN8w+x/j2y/ajXlknRsl
	 oQLdvfqYSFbkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: shikra: Add PCIe PHY and
 controller nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sushrut Shree Trivedi" <sushrut.trivedi@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260831-shikra-upstream-v2-5-406661d75afa@oss.qualcomm.com>
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
 <20260831-shikra-upstream-v2-5-406661d75afa@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:41:08 +0000
Message-Id: <20260831074109.4B49A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `interrupt-map` property is malformed because it provides an i=
ncorrect number of cells for the parent interrupt specifier.
- [Low] The `pcie_phy` node violates the 'qcom,shikra-qmp-gen2x1-pcie-phy' =
DT binding schema by defining 6 clocks and using an invalid clock name 'phy=
_aux'.
--

commit 6b2a25b57b5360f808aceb407d09c81df6f4cd71
Author: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>

arm64: dts: qcom: shikra: Add PCIe PHY and controller nodes

This commit adds the PCIe controller and PHY nodes for the single 5GT/s x1
link instance on Shikra. It limits the maximum link speed to PCIe Gen2 to
match the PHY capabilities and avoid link-up failures.

> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/q=
com/shikra.dtsi
> index 92d22e3b6931c..9e1810c715099 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi

[ ... ]

> @@ -1013,6 +1013,163 @@ tsens0: thermal-sensor@4411000 {
>  			#thermal-sensor-cells =3D <1>;
>  		};
> =20
> +		pcie: pcie@45e8000 {
> +			device_type =3D "pci";
> +			compatible =3D "qcom,shikra-pcie";

[ ... ]

> +			interrupt-map =3D <0 0 0 1 &intc 0 0 0 499 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 0 500 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 0 501 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 0 502 IRQ_TYPE_LEVEL_HIGH>;

[Severity: High]
Does this interrupt-map provide an incorrect number of cells for the parent
interrupt specifier?

The kernel parser expects 4 cells for the parent interrupt specifier because
&intc has #interrupt-cells =3D <4> and lacks #address-cells (defaulting to 0
for the parent address). However, 5 cells (0 0 0 499 IRQ_TYPE_LEVEL_HIGH)
are provided here.

Will this misalignment cause phandle resolution to fail for subsequent
entries, parsing cells like 2 or 4 as phandles and breaking PCIe interrupt
routing on this platform?

[ ... ]

> +		pcie_phy: phy@45ee000 {
> +			compatible =3D "qcom,shikra-qmp-gen2x1-pcie-phy";
> +			reg =3D <0x0 0x045ee000 0x0 0x1000>;
> +
> +			clocks =3D <&gcc GCC_PCIE_AUX_CLK>,
> +				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_RCHNG_PHY_CLK>,
> +				 <&gcc GCC_PCIE_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_SLEEP_CLK>;
> +			clock-names =3D "aux",
> +				      "cfg_ahb",
> +				      "ref",
> +				      "refgen",
> +				      "pipe",
> +				      "phy_aux";

[Severity: Low]
Does this node violate the qcom,shikra-qmp-gen2x1-pcie-phy DT binding schem=
a?

The schema qcom,sc8280xp-qmp-pcie-phy.yaml limits the maximum number of clo=
cks
to 5 for qcom,shikra-qmp-gen2x1-pcie-phy and does not allow the phy_aux clo=
ck
name.

While the driver optionally fetches this clock so the hardware still functi=
ons,
will this cause dtbs_check schema validation to fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-shikra-ups=
tream-v2-0-406661d75afa@oss.qualcomm.com?part=3D5
