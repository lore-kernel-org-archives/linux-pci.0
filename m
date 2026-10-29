Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269811;
	b=xISH7vkMnPqaTWr8IEa8fDu+BHjCRvm3zPldSp+jNwQKwa7b/PY07xCAjHcUs94ur+vq
	 vL6U+hrgDO5UQMKWUjGfw7Mjge+u8dWUMVrd5x0ldQsaZ/T3csuExKh/p6yTbQa1DZRW3
	 QS4rOQHmezeDdisi41zKsDql7lZc8WrnzEMtYqA3Rv+KyP8Ev7uln6aorUjFzqXjeIuIo
	 faz04eWfIPAqK8CaSERRU0DC6J5cdLldqzzalCGwQhVaVIwAiZJSrySxYhxQdtmi4O+0p
	 tSTU9xD2n8AK3Xl9gT9Rvi2Xq34dobcCW7dbUtptQ7dnINArlU3oAC9j9UmMuVlABxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269811;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AZC7Kq+rNbABpnx+qnFFaseVBAn2cBmm3lL+yoxx9VU=;
	b=DoG6RmKYIjRyeXxw9S2mHdMBiC4FPkuxcn8p22u2QGBPPr1zNVL/U9ur8fMuHYEBmCyg
	 plOlsusjIFG1IInlEdHANYLnzC8gUV2LV5NWf3/salaQtE26nZnMl4ScJ2TLUDEaIiZqz
	 QNGw6z0U9dEttqX3ulk439g91TWMcjziNOv+GSvuDUlvjzCvpp08nYGxXdpeoWqV0jpUX
	 B+BUexAzsKIdUnNOde/E3mDdVSBGrWAKTM5QEh0rQLaKCv/Buq5turbQInxjkZ0hCmi9J
	 m/7lWxrOCDzXyGvSCrWV7e8Ruo2dT0NM2SIbZTGN4vwl0mApUNLlKfOt654Lk+16l4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BN+vbkXU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8171E606A320;
	Thu, 29 Oct 2026 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BN+vbkXU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A811D1F01829;
	Thu, 29 Oct 2026 10:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793269811;
	bh=AZC7Kq+rNbABpnx+qnFFaseVBAn2cBmm3lL+yoxx9VU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BN+vbkXUZxMvfKqEK4vfHBF3Zh23+Ao6r1kolOZus6Ff7M+SjPeiTopeWZ5OjX0lg
	 BQ1JvCHkAQBTL5Ii5H82Kj6oEQGxWdZbkfujTRa82d2dw25VfdzVwR/gBdQNML8iv9
	 iD/0n4ne1z7y1y2y4dhss5SJM17ldlzluVzvVTZN7BNGSd6bIcVqpPwELUz9BHvu7E
	 mTBT48bD38m0++YDOUhpX7lDIKTE+JDnJPs80Vs8GOTzfdB7T9hi96dg32wbmRpufX
	 91Xz8qvEeoa/XZR7q/ffxSbxkbOb4dUhC5vEg1oPvEaoK0Vf7RZrDD7KpZqEBwTDQn
	 /JYpNuGk/z88g==
Message-ID: <sashiko-outbox-189134@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] arm64: dts: qcom: sc8280xp: enable PCIe ECAM and
 64-bit memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029-q8b-dts-v4-1-e8e7438f5545@radxa.com>
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
 <20261029-q8b-dts-v4-1-e8e7438f5545@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 10:30:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] arm64: dts: qcom: sa8540p: missing reg and ranges on pcie2b, pcie3=
b, pcie4
--

commit 835660c7a888130654e80196f354e12277da4a3f
Author: Xilin Wu <sophon@radxa.com>

arm64: dts: qcom: sc8280xp: enable PCIe ECAM and 64-bit memory

This commit updates the SC8280XP PCIe nodes to use 64-bit ECAM configuration
spaces and adds 64-bit memory windows, while preserving the 32-bit address
map on SA8540P for PCIe2a.

> diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/=
qcom/sa8540p.dtsi
> index 23888029cc117..e5393a237497c 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> @@ -180,6 +180,15 @@ &gpu_smmu {
> =20
>  &pcie2a {
>  	compatible =3D "qcom,pcie-sa8540p";
> +	reg =3D <0x0 0x01c20000 0x0 0x3000>,
> +	      <0x0 0x3c000000 0x0 0xf1d>,
> +	      <0x0 0x3c000f20 0x0 0xa8>,
> +	      <0x0 0x3c001000 0x0 0x1000>,
> +	      <0x0 0x3c100000 0x0 0x100000>,
> +	      <0x0 0x01c23000 0x0 0x1000>;
> +
> +	ranges =3D <0x01000000 0x0 0x00000000 0x0 0x3c200000 0x0 0x100000>,
> +		 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>;

[Severity: High]
Should the legacy 32-bit reg and ranges properties also be preserved on
&pcie2b, &pcie3b, and &pcie4 in arch/arm64/boot/dts/qcom/sa8540p.dtsi?

This patch updates all five PCIe controllers in
arch/arm64/boot/dts/qcom/sc8280xp.dtsi (pcie4, pcie3b, pcie3a, pcie2b, and
pcie2a) to use the 64-bit ECAM config and MMIO address windows, but
arch/arm64/boot/dts/qcom/sa8540p.dtsi only preserves the 32-bit windows for
&pcie2a (and &pcie3a, which already overrides reg and ranges):

arch/arm64/boot/dts/qcom/sa8540p.dtsi:
    &pcie2b {
        compatible =3D "qcom,pcie-sa8540p";

        linux,pci-domain =3D <1>;

        interrupts =3D <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
        interrupt-names =3D "msi";
    };
    ...
    &pcie3b {
        compatible =3D "qcom,pcie-sa8540p";

        linux,pci-domain =3D <3>;

        interrupts =3D <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
        interrupt-names =3D "msi";
    };

    &pcie4 {
        compatible =3D "qcom,pcie-sa8540p";

        linux,pci-domain =3D <4>;

        interrupts =3D <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>;
        interrupt-names =3D "msi";
    };

Meanwhile, arch/arm64/boot/dts/qcom/sa8295p-adp.dts includes sa8540p.dtsi a=
nd
enables both &pcie3b and &pcie4 without overriding reg or ranges:

arch/arm64/boot/dts/qcom/sa8295p-adp.dts:
    &pcie3b {
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&pcie3b_default>;

        status =3D "okay";
    };
    ...
    &pcie4 {
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&pcie4_default>;

        status =3D "okay";
    };

As noted in commit b8bf63f8eb72 ("arm64: dts: qcom: sa8540p-ride: enable PC=
Ie
support"), accessing unconfigured PCIe address windows on SA8540P/SA8295P
TrustZone firmware causes the board to crash into ramdump mode. When
qcom_pcie_probe() -> dw_pcie_host_init() runs on SA8295P-ADP (or any SA8540P
board enabling pcie2b, pcie3b, or pcie4), won't those controllers inherit t=
he
SC8280XP 64-bit address ranges (0x4_00000000..0x4_ffffffff) and trigger a
crash at boot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-q8b-dts-v4=
-0-e8e7438f5545@radxa.com?part=3D1
