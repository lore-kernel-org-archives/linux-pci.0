Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ED53A7F4D;
	Thu, 30 Jul 2026 05:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785388020; cv=none; b=eezQK4hDHAiYAjCATx89Sr4a3O4C3dZI+fW89iPz0xaK+Z7HwQTwgH2XoOa4A4cfaOBnbFDK8o3pbhJVCINekmuv8Qvf+xvm2HWt8IDph7vaM756IxJAta7pPN2ILb/RP0z6+bJk4ZVWR5ZGx8veHW1PwXd+KrZg9qnopiGVUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785388020; c=relaxed/simple;
	bh=HFF402LdV8VqDDuDQePhu4xuN8mla+Ngn4fmk4lvLKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ceq54SBxzjh+Qy1PuNjjo+UEO+Z/SCpTKNnZdCGuJg9LhDwETZ7PSv5r31OUArhvlL+SYNTjo7QdHszvRv95mDMCuor/y1nxU1LXqdsAOidTOpOnV7xF26keVEdcbc4AfsaVEF1HOdbNoBP7NufP3EzN8a0+Psj3isolXcN6a2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViBvFcto; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViBvFcto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44661F000E9;
	Thu, 30 Jul 2026 05:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785388019;
	bh=E1oyoCJAJQ40RnShV/CaxTj8u5weqsgoRSQNHdy9Ncw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ViBvFctoNmPYU5JUdgwtnN2WcfxPW2W5teQ474XUGGEuBnIDwpKlJIWbqYXVpP/pp
	 zsJQhqU7hvxdbVBFTtFc9bNjWADdFF1P01wKQEhf5DeB5Ijgu2xd3gnMlUbl5GNwPz
	 tQzhHCMFe62aAVq0Gb2tjRWeOwPQRWwcJNXguteSwlVVFrlZS7pmYW2E3MGMYqefbV
	 GHqiEKPhyLprA8cslB8wJdMhoq1BKmLaIFjd1oKG0AaYgD9/7A0GNzTZFugajWD0LX
	 GMX0p5E9QYLXzxOSaBanzHVN/VYd7h0J12crexdZmLsG3eBj2VmDPj8jBphMmfT1vK
	 O/6wd9vOO3c8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2
 E key connector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260730-eliza_evk-v6-2-40ece2d33114@oss.qualcomm.com>
References: <20260730-eliza_evk-v6-0-40ece2d33114@oss.qualcomm.com>
 <20260730-eliza_evk-v6-2-40ece2d33114@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 05:06:58 +0000
Message-Id: <20260730050658.B44661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] W_DISABLE2# GPIO polarity is inconsistently configured as GPIO_A=
CTIVE_HIGH, likely inverting the intended PCIe M.2 power sequencing logic.
--

--- Patch [2]: [PATCH v6 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M=
.2 E key connector ---
commit b91f81c61ce6e56f3f53636edf8015143cf5ed8b
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector

The Eliza EVK board features an M.2 E key connector connected to PCIe0.
This commit enables the PCIe0 root port and its QMP PHY with the necessary
RPMH regulator supplies. It models the connector using the pcie-m2-e-connec=
tor
binding to support a WLAN card and a Bluetooth device.

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
Is the GPIO_ACTIVE_HIGH polarity for w-disable2-gpios correct here?

The pwrseq-pcie-m2 driver attempts to enable the Bluetooth UART interface
by setting the logical value of w-disable2-gpios to 0. Unless there is an
inverting level shifter involved for this specific PMIC GPIO, wouldn't an
active-high configuration invert the intended PCIe M.2 power sequencing log=
ic?

This could cause the Bluetooth device to be disabled during the power-on
sequence and enabled when it should be disabled, which would break Bluetooth
functionality.

> +
> +		pinctrl-0 =3D <&m2_w_disable1>, <&m2_w_disable2>;
> +		pinctrl-names =3D "default";
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-eliza_evk-=
v6-0-40ece2d33114@oss.qualcomm.com?part=3D2
