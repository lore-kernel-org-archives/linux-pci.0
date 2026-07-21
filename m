Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC63CB540;
	Tue, 21 Jul 2026 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627187; cv=none; b=Q5DjpfBhTXdCgFfL2ZAhdYFBAEqpSNTuxcsXb35BQW/ZccxmvvhPx9ZqZ4MGm8zoLWZHufOHMOIBgUlbm2u+uWofJyc7S065M5hP81zm+YeQLutFpkmtlfdxuiDyTvH+VG0nQw2UPsR6ibt6jBQLG/jn3d1u0HBFp6Fj4M/+Y68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627187; c=relaxed/simple;
	bh=ytLdntutVQ0Sr5w/sKJoZefWR9TRxWCNxNc1e899VKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O4m5h2MBdsNjPzPZIWAhVBpy6eg9IzeOddVo+d0hVF/Y06OLQuninLcRFpxYLwz/61N1djd2PX/il0vVzS4Gw/j0NOs4/r2UpwR5nxcRt21a0A6ZXpoIMimim9hha/RUZ9dWA3ryR4feuFQZ1zmEBz6oBKjv7AlNAxeMkILjvnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kisp7MpB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kisp7MpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498E31F000E9;
	Tue, 21 Jul 2026 09:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784627186;
	bh=BdEU/iAe+H+ch0kX1YnQC64NhGhzAnmYpo0G73hD4lg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kisp7MpB9j4KXjQ7ls/X84n6NjAED0yZ9UZjPyTqXbInA8r+7y65V1hZx8rr57RCe
	 n64JcWyy7dKMSJlNDRaoGE86uqpWCTLuH+uJMGzIj+RHEVddcFiAm5ty5HJTfr5RWy
	 y0XzXodZMSTbNObDzTtgGNtyM7wsyoqRTjSwY2A5AjPsQ+mwu7Ri0XQDC5QAJ3xX4e
	 Vav6tNoaiZ1ysuKCJAB8FJHF6Pmf/pgMfSz3YJmcG9e0NngY82a8vuGn5VzS7QPJzR
	 0FzE52dABgD91hOne+7StDsCLTN0gy/f6aDnDnnfJnR5gp91yOXryNaesc0GfE26eB
	 P0d57D2mPJbUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2
 E key connector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260721-eliza_evk-v3-2-92b10038f13d@oss.qualcomm.com>
References: <20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com>
 <20260721-eliza_evk-v3-2-92b10038f13d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 09:46:25 +0000
Message-Id: <20260721094626.498E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect GPIO polarity for the M.2 W_DISABLE2# pin (`w-disable2=
-gpios` configured as `GPIO_ACTIVE_HIGH`).
--

--- Patch [2]: [PATCH v3 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M=
.2 E key connector ---
commit 43876fd73356779d2e58bee01e3cfd92db672b22
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector

This commit enables the PCIe0 root port and its QMP PHY for the Eliza EVK
board. It also adds an M.2 E key connector node to support a WLAN and
Bluetooth card, wiring up the necessary regulator and W_DISABLE GPIOs.

> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dt=
s/qcom/eliza-evk.dtsi
> index e47b24f8b8277..6d76715ccffbe 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
[ ... ]
> +	connector-0 {
> +		compatible =3D "pcie-m2-e-connector";
> +		vpcie3v3-supply =3D <&vreg_pcie_m_3p3>;
> +		w-disable1-gpios =3D <&tlmm 35 GPIO_ACTIVE_LOW>;
> +		w-disable2-gpios =3D <&pm8550vs_g_gpios 4 GPIO_ACTIVE_HIGH>;

[Severity: Medium]
According to the PCI Express M.2 Specification, W_DISABLE2# is an electrica=
lly
active-low signal, similar to W_DISABLE1#.

With w-disable2-gpios set to GPIO_ACTIVE_HIGH, asserting the GPIO will
physically drive it high, which enables the radio when it should be disable=
d.
Does this inverted polarity break the power sequencing logic for the Blueto=
oth
radio managed by the pwrseq-pcie-m2 driver? Should this be configured as
GPIO_ACTIVE_LOW?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-eliza_evk-=
v3-0-92b10038f13d@oss.qualcomm.com?part=3D2
