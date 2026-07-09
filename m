Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86843933F;
	Thu,  9 Jul 2026 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582981; cv=none; b=kI4/rs4j3E52WRdkYH3JLQUQn6Q+Uw6U0npxQPv8OCzVeWjAQFcyCnL4EuGt1pxq002mL9E/k2lJ3NRv432GIAqKSNjB0jRSiUzJXhVDYZWmRF64xvOovwEcygPNNkyL6UuNZhwsBOu1mxnfcNHTFGMtfRpiRqXDGKsCREFoe6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582981; c=relaxed/simple;
	bh=aSikInqk5P0RZtHbrm8vDJtjDm6Z+IOBYe/TsVun0pI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HpEvEd/UMmbi/YII6L4LlZbvPW+y6gmFY5bWe17d7zAPwv04hqgjO+JModJ1htw+gei9JagwKSCbsZY8LbSkZkhalBIl4BswkvdCY1dN/ZqPbPOSMeSgmjXcAN4zJRG5o5lDJUZJSG6i1UlscfnmssNwGiqUKlB0XTaudIQv34c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbMTOAZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbMTOAZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC0A1F00A3E;
	Thu,  9 Jul 2026 07:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783582979;
	bh=JWDbB4tFQQVm6LFsx1HEWq+7Iyj5XevK3edOKw3ZnZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HbMTOAZMnj8nGSjGPOsr2kXipXresv1uraKvw+Og/O/opO0js4jopnX+A4qido0jK
	 N9Cif8mwKJe6+P+CFN4EDDFMBdfXUh03ADq2uMaSgSGZ5miLH0RdrYnrmWkHmvllZC
	 Bt4c/R+CqRlVnYhF75LahpeMVQzAm1KYu2lMi9EmwJW08V13qYEcAUOeAiMPiK4dZ0
	 G2qVxEP3jkw4Wx905oReUZouqKEzMqbnI9ZTsXFWEmSiW8qmRjjCxqNFujc8Zhfbrl
	 i0Qr9RXm3EPSD2dDWCnqw0KfuhpOUJUSV5aXx2gOOCBqdKCBrSFzfYOD30w+o+usdL
	 UZaFGBekcMthw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe
 M.2 Key E connector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Deng" <wei.deng@oss.qualcomm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260709-fix-hamoa-m2-w-disable2-v1-1-5e725091266a@oss.qualcomm.com>
References: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
 <20260709-fix-hamoa-m2-w-disable2-v1-1-5e725091266a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 07:42:58 +0000
Message-Id: <20260709074259.5FC0A1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused dummy fixed regulators `vreg_wcn_0p95` and `vreg_wcn_1p9` ar=
e left orphaned in the device tree.
--

--- Patch [1]: [PATCH 1/3] arm64: dts: qcom: hamoa-iot-evk: Describe the PC=
Ie M.2 Key E connector ---
commit 3a5c700f021e92c47e3fa3997595501dd58c45d6
Author: Wei Deng <wei.deng@oss.qualcomm.com>

arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe M.2 Key E connector

This commit describes the PCIe M.2 Mechanical Key E connector in the hamoa =
IoT
EVK device tree, linking it to the PCIe 4 Root Port. It replaces the specif=
ic
wcn7850-pmu and static BT nodes with chip-agnostic pwrseq-pcie-m2 driver
endpoints.

> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot=
/dts/qcom/hamoa-iot-evk.dts
> index 9fa86bb6438ec..41c2004f0ef67 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts

[ ... ]

> @@ -676,65 +714,6 @@ usb_1_ss0_sbu_mux: endpoint {
>  			};
>  		};
>  	};
> -
> -	wcn7850-pmu {
> -		compatible =3D "qcom,wcn7850-pmu";
> -
> -		vdd-supply =3D <&vreg_wcn_0p95>;
> -		vddio-supply =3D <&vreg_l15b_1p8>;
> -		vddaon-supply =3D <&vreg_wcn_0p95>;
> -		vdddig-supply =3D <&vreg_wcn_0p95>;
> -		vddrfa1p2-supply =3D <&vreg_wcn_1p9>;
> -		vddrfa1p8-supply =3D <&vreg_wcn_1p9>;

[Severity: Low]
Since the wcn7850-pmu node is removed here and the wifi@0 node is removed
below, their consumers are gone.

Should the corresponding fixed regulator definitions for vreg_wcn_0p95 and
vreg_wcn_1p9 also be removed from the device tree?

Leaving them behind might cause the regulator core to needlessly instantiate
these dummy regulators.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-fix-hamoa-=
m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com?part=3D1
