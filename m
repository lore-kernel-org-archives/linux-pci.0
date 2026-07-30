Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BEE422E25;
	Thu, 30 Jul 2026 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413451; cv=none; b=Bzx14L7YyFhu9+OZWGnv6lDHDftRlODfMn7jFXRA2R1qKpGqS3+Um2RFEXaxdN+adkrWGWXwj40nNUsOjNg2p+aogIwx2wFK5U40GsWjxs6Z/4aomHSsAE+jq3ul8i922l+V8lrCxMN8efBvk8uDxVGQQntliGzTAPjIDywt0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413451; c=relaxed/simple;
	bh=NeiLNU3A7gq9g0jGmL2hQ11c+fW+uN2L4o3Wam3qJjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AtGWajGBNeXGvYB+nVcQ2X+TEePm1ajF/N7CED6hlC5AxuQJops1+vckY2zYFZoeDO/byv7gHf+33NmT/GxdlKAeUsOHnajGIux0eRC1EfMsaAWKn7pTO65TSRYbdDI9b8DOpMj4lkvvLHPkj4pTm8hfrzVS5HcgMLrqnplYHiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2ed6qkS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2ed6qkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173F91F000E9;
	Thu, 30 Jul 2026 12:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785413450;
	bh=YQJTYrZZxsD4Ctzm3QhqyCxx3WlAzPxmBmYH6gea7+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i2ed6qkS9QkQwi3wBlbLJO7MkuL/3BeZyahs2AnOQDJX7qxxCuzusfIkGrU/EaRpg
	 tEP7x5aqXAh2UpVAQJZc2UuPkpr3fIcxs+OPrx1lYcbQkT15Sx4gUB5ZCtVnsJfYWA
	 BhtP+an5e3cWzB56iXDqL9kp3oJUrquw6o8gflYiZAS6jWD99UUg2LZTVGUFQSpV/G
	 X/6+NzZKpgqRXaWBRQYN+QFcJvx3HqYxm3uFx3sKSNceBvk2+31GS6Djzq8UloPxvd
	 CaPYu2JUcnGEPskscnMCzX5JsUzLoQPnvGvrTYHvyWrw67W1ba/beB07dyGZuUCD3T
	 z9ESS+C5la9GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2
 E key connector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260730-eliza_evk-v7-2-7ac7b66a3e6d@oss.qualcomm.com>
References: <20260730-eliza_evk-v7-0-7ac7b66a3e6d@oss.qualcomm.com>
 <20260730-eliza_evk-v7-2-7ac7b66a3e6d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:10:49 +0000
Message-Id: <20260730121050.173F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect GPIO polarity for w-disable2-gpios inverts M.2 Bluetoo=
th radio disable logic.
--

--- Patch [2]: [PATCH v7 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M=
.2 E key connector ---
commit 1b7021041bf505a0f78e56766606ecebc1d465b4
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector

This commit enables the PCIe0 root port and its QMP PHY for the Eliza EVK
board's M.2 E key connector. It provisions a 3.3V regulator supply via an
I2C GPIO expander and defines the connector to host a WLAN card over PCIe
and a Bluetooth device over UART.

> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dt=
s/qcom/eliza-evk.dtsi
> index e47b24f8b8277..b35fffb509765 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi

[ ... ]

> +	connector-0 {
> +		compatible =3D "pcie-m2-e-connector";
> +		vpcie3v3-supply =3D <&vreg_pcie_m_3p3>;
> +		w-disable1-gpios =3D <&tlmm 35 GPIO_ACTIVE_LOW>;
> +		w-disable2-gpios =3D <&pm8550vs_g_gpios 4 GPIO_ACTIVE_HIGH>;

[Severity: Medium]
Does this GPIO polarity correctly model the M.2 specification? The M.2 stan=
dard
defines W_DISABLE2# as an active-low signal, meaning a physical LOW disables
the radio.=20

If the pwrseq-pcie-m2 driver expects an active-low signal and de-asserts
the GPIO to enable the radio, specifying GPIO_ACTIVE_HIGH here will cause
the physical pin to be driven LOW instead, inadvertently holding the
Bluetooth radio in a disabled state.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-eliza_evk-=
v7-0-7ac7b66a3e6d@oss.qualcomm.com?part=3D2
