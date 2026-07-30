Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D14B3ACA41;
	Thu, 30 Jul 2026 05:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785389128; cv=none; b=oU8Jxl7HEn65EqojJR5jE1LntrkM26NMuc3FzXPzUJIfyzosEFy1/A9qReqesiS4qFrUoB30fBnbFgGJo7abSAGus887Zk/zEKV7EXJwnpbzD51QRd4MPsq9xKcNzDAnd8iJaM129ekcpqw+RFWxHoFnO5AVM3/obiblJK3oTt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785389128; c=relaxed/simple;
	bh=xyCar617cmmhCVJECcGayTWTS6VA9jcKiLtDDv8G+0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVxOHN2NkbsjBnLzK0oxhPTbCnoNF5pbqCKmOQ1q2rnq8X2/BltKrHfoyKT+X2txzonbKWUKI9F3lYrDgWtIJsSzmjtSGorzljFULIHJuumsNYP/bbAFgGE2vR2XexDyTEAHGmYVf5GChmghq4okx5RwskjQnqWPl3uEQ/djmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrdMSqcp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrdMSqcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741AE1F000E9;
	Thu, 30 Jul 2026 05:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785389127;
	bh=gV3Ds0hARqEtmj7Cb5deP/XtdIMZsQ0MjDAFBX2yjRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZrdMSqcp0/gNWjMdBhNsE2t4BFvk2wXamH0yY/FacsfFGfyS+04o0UsK8vN7L6glx
	 Mv2Xa2O3PyciZXvvd/nFKhVlcw03YHSFycYRsVKtgDMgbC4yjNQyB7bCr+icP+msko
	 a7hoaVtmnJZSMKeMOlVlOXec9t7n/nPD8jnpGfK4R5ofAv1U68z0mvJxrmzOAM5nsF
	 g5sm6FpN0VdI6fnU7YF5GNDhDZ2x8LCfHnSs7/dr/DR8S/gq61YSjAzHAgc34i5ZXn
	 40J5FyCjGLJRPUCumW/S1+vlWk5bWoLK8LIxHMU0Ps/EpFzqWOI0NZTWIcHXhrXk6i
	 damSieUJ2W1gA==
Date: Thu, 30 Jul 2026 07:25:18 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with
 TC9563 PCIe switch
Message-ID: <ofkvwrvfpyhjflrmbyi43gd4mltrqdmf3pzdvxwitrqshtttvo@r3xpfq3m42ha>
References: <20260730-eliza_evk-v6-0-40ece2d33114@oss.qualcomm.com>
 <20260730-eliza_evk-v6-3-40ece2d33114@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730-eliza_evk-v6-3-40ece2d33114@oss.qualcomm.com>

On Thu, Jul 30, 2026 at 10:18:55AM +0530, Krishna Chaitanya Chundru wrote:
> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
> 
> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
> 
> Override the base iommu-map with the expanded set covering all the
> switch's downstream ports (0x1400-0x1408 SID range).
> 
> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
> from the PCIe controller.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 113 ++++++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> index b35fffb50976..419e737c54e6 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> @@ -12,6 +12,26 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	vreg_0p9: regulator-0v9 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VREG_0P9";
> +
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vreg_1p8: regulator-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VREG_1P8";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
>  	vreg_pcie_m_3p3: regulator-3p3 {
>  		compatible = "regulator-fixed";
>  
> @@ -99,6 +119,99 @@ pcieport0_ep: endpoint {
>  	};
>  };
>  
> +&pcie1 {
> +	iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
> +		    <0x100 &apps_smmu 0x1401 0x1>,
> +		    <0x208 &apps_smmu 0x1402 0x1>,
> +		    <0x210 &apps_smmu 0x1403 0x1>,
> +		    <0x218 &apps_smmu 0x1404 0x1>,
> +		    <0x300 &apps_smmu 0x1405 0x1>,
> +		    <0x400 &apps_smmu 0x1406 0x1>,
> +		    <0x500 &apps_smmu 0x1407 0x1>,
> +		    <0x501 &apps_smmu 0x1408 0x1>;
> +
> +	status = "okay";
> +};
> +
> +&pcie1_phy {
> +	vdda-phy-supply = <&vreg_l1k>;
> +	vdda-pll-supply = <&vreg_l3k>;
> +
> +	status = "okay";
> +};
> +
> +&pcie1_port0 {
> +	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> +	/* Same GPIO is used for both PERST# and resx-gpio */
> +
> +	tc9563: pcie@0,0 {
> +		compatible = "pci1179,0623";
> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +
> +		device_type = "pci";
> +		ranges;
> +		bus-range = <0x2 0xff>;
> +
> +		vddc-supply = <&vreg_0p9>;
> +		vdd18-supply = <&vreg_1p8>;
> +		vdd09-supply = <&vreg_0p9>;
> +		vddio1-supply = <&vreg_1p8>;
> +		vddio2-supply = <&vreg_1p8>;
> +		vddio18-supply = <&vreg_1p8>;
> +
> +		i2c-parent = <&i2c4 0x77>;
> +
> +		resx-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
> +
> +		pcie@1,0 {
> +			reg = <0x20800 0x0 0x0 0x0 0x0>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			device_type = "pci";
> +			ranges;
> +			bus-range = <0x3 0xff>;
> +		};
> +
> +		pcie@2,0 {
> +			reg = <0x21000 0x0 0x0 0x0 0x0>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			device_type = "pci";
> +			ranges;
> +			bus-range = <0x4 0xff>;
> +		};
> +
> +		pcie@3,0 {
> +			reg = <0x21800 0x0 0x0 0x0 0x0>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			ranges;
> +			bus-range = <0x5 0xff>;
> +
> +			pcie@0,0 {
> +				reg = <0x50000 0x0 0x0 0x0 0x0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				device_type = "pci";
> +				ranges;

Sashiko pointed out that you are using bridge specific properties in EP node:
https://lore.kernel.org/linux-pci/20260730051031.20D8E1F000E9@smtp.kernel.org

- Mani

-- 
மணிவண்ணன் சதாசிவம்
