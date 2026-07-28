Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713243CE49E;
	Tue, 28 Jul 2026 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223330; cv=none; b=qTF7zR2ekR+zyLfP7yFW78Tp3kX1F6HJWQ4xU93OLsUCJS6MJic+86P/IRV2155lpWx3FSeXnmC1os6QkqBT4ql4qEcQx9XgOmabG0IEY1wA0ZycmDvkslWR4YomtRioeiWfhw/WyFU2ZQ0q0HkTWQbRsZTUspGp8NW1/cZ/Thk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223330; c=relaxed/simple;
	bh=4g2YfF1ECFWfp1JKfcIUT1QcNAWnNbSVIX21NjlAHhM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C/X9gqyfMi5bATCz4QFcBXWr42GnuhrrccXWc9YgLNI1thSuZxyGJshrKLTSK+oz9ea/XrGoSbf6HizIA5dvy/ThoshvtT9hNXessi3V8RJQooFBRTNZQ1Pq+zOgAeU7zccp+n4pGzF+VIWZQs2GaeSs/VUOl0/w29zK31Z5xTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEuJPWuh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEuJPWuh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58C11F000E9;
	Tue, 28 Jul 2026 07:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785223329;
	bh=v+bbyNR1SWaJXNeym3tl+BN6H7mrNXqMRgquP/wJDeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FEuJPWuh5/nwIkVpC0HUosXiASlRWvqJN8mmhxP+Nts0D5hcbAxS4RFsz+pMdbG1s
	 mvttMmGlRTWsLSa+TffY2reIZDu154745QquMgiC3W6n/TjlOvBDz6gdOZKVSg1Wmf
	 oW/aAuwCDuamTd2fVl7E+zneisJWEg/BLvsk+16K7gBsypcylvj+Puercg2Az/eFZw
	 QKFRZhaDWORB9dg++u+eNGCweK18aYegmfVkXGi3f7XSV65ROWJ8uEhEUu6xC3rSDT
	 S/ZYDBkfplbeNrtV30t8gnr9xwITG/GCx5qK2kYLrSRlvStYRn3Ku4ikAlilpH7KF6
	 4IHHfE67sEmiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2
 E key connector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260728-eliza_evk-v4-2-decc7fe5246e@oss.qualcomm.com>
References: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
 <20260728-eliza_evk-v4-2-decc7fe5246e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 07:22:07 +0000
Message-Id: <20260728072208.B58C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `w-disable2-gpios` property is incorrectly configured as `GPIO=
_ACTIVE_HIGH`, inverting the required active-low semantics for the M.2 Blue=
tooth RF kill signal.
--

--- Patch [2]: [PATCH v4 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M=
.2 E key connector ---
commit 292c3ed97364c0f7209a33809d46b9f2b7cf145a
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector

This commit models the M.2 E key connector connected to PCIe0 on the Eliza
EVK board. It enables the PCIe0 root port, its QMP PHY, and configures the
M.2 slot's 3.3V supply rail via a TCA9538 I/O expander.

> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dt=
s/qcom/eliza-evk.dtsi
> index e47b24f8b8277..b35fffb509765 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> @@ -11,6 +11,92 @@ aliases {
>  	chosen {
>  		stdout-path =3D "serial0:115200n8";
>  	};

[ ... ]

> +	connector-0 {
> +		compatible =3D "pcie-m2-e-connector";
> +		vpcie3v3-supply =3D <&vreg_pcie_m_3p3>;
> +		w-disable1-gpios =3D <&tlmm 35 GPIO_ACTIVE_LOW>;
> +		w-disable2-gpios =3D <&pm8550vs_g_gpios 4 GPIO_ACTIVE_HIGH>;

[Severity: High]
Does this GPIO polarity accidentally invert the active-low semantics for the
M.2 Bluetooth RF kill signal?

The M.2 specification defines W_DISABLE2# as an active-low signal. Since
the pwrseq-pcie-m2 driver initializes this GPIO with GPIOD_OUT_HIGH (logica=
l 1)
and enables the Bluetooth device by writing a logical 0, configuring it as
GPIO_ACTIVE_HIGH means a logical 0 translates to a physical LOW signal.

This physical LOW would then disable the radio in hardware right when the
driver intends to enable it. Should this be GPIO_ACTIVE_LOW to match the
w-disable1-gpios polarity and the specification?

> +
> +		pinctrl-0 =3D <&m2_w_disable1>, <&m2_w_disable2>;
> +		pinctrl-names =3D "default";

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-eliza_evk-=
v4-0-decc7fe5246e@oss.qualcomm.com?part=3D2
