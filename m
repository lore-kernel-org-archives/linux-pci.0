Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A35C3D3CE6;
	Wed, 29 Jul 2026 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338445; cv=none; b=qQwCzNfYKOE9jNwdjZj6DJ/PrvkecBM5ag+swZWRmsZKDK1ooDGbfhdfuC41YFCnuLnJNW2zbbY3BS3EsH6sQcawGZ/1PFTP/UgUkTfmqlgkzH85bkdjdcHF0KWmr8UzQmsXxc+udA2hy3UKMqKPkcxGbbnBGeKNQ3HnJFNiKsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338445; c=relaxed/simple;
	bh=PS/285Fsf0E3mozO+egv8/vPNb/+haQD1LENPjqWL9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cut3XvyU+TSzkPimlEE71y3BO0wNi9QedryrHd5eSryGqLfLrZaT+TzGuS2I3gLP1/wRSTpxMTynXUiTqWHWmjHo/Pm66V1RPisDmKwWagmo9bTEZp2ts2p3ey2oJLApDtEb1Wx3g4JRS9oSQL/E+GmzHRIeU+ieV341Axo2SfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ys0QeK+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys0QeK+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556161F000E9;
	Wed, 29 Jul 2026 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785338443;
	bh=17H9ozvAIFb+ZEt9w87V6eBUZpHlEql3bHbrF8RjZSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ys0QeK+x9du2Re6sNa5be9BP8V8e9gV0wS1Mum9kot2tDDrG5OLdKerg+WO5S8ACA
	 0HI9gEY1JI8snpMayE2RUKt1X4FtS9H/yHCckK4j4TnHI4i/0NXC5qRvoFYXz04mqO
	 IV607T9MXLsOrmRjJfnLUJh3lGNi8YLhrIBMylFFL3aWlos29fnw7sw720TAst5cTV
	 PY7ZLH1mYwIzq0w4FhZgVW9amXGAZ2M+b/tp7JVi/oSQSRKPcFl/0apfljdVnI11Om
	 f6gOAwtgNAvKMgxr0h5uFDFSq3wMY7u32tZn2bfLhJC8XJJoWZq95o+URsh6v6zJnS
	 nY74qSr8mUAgA==
Date: Wed, 29 Jul 2026 17:20:34 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with
 TC9563 PCIe switch
Message-ID: <6zb6dkjgl3r5usnmwlm77lgtxgo4pvrmw2dnvambjlyxn5yud3@2ziearnv54uo>
References: <20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com>
 <20260729-eliza_evk-v5-3-41790a5a24de@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260729-eliza_evk-v5-3-41790a5a24de@oss.qualcomm.com>

On Wed, Jul 29, 2026 at 08:18:38PM +0530, Krishna Chaitanya Chundru wrote:
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
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 113 ++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/eliza.dtsi     |   1 +
>  2 files changed, 114 insertions(+)
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
> +			};
> +
> +			pcie@0,1 {
> +				reg = <0x50100 0x0 0x0 0x0 0x0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				device_type = "pci";
> +				ranges;
> +			};
> +		};
> +	};
> +};
> +
>  &uart13 {
>  	compatible = "qcom,geni-debug-uart";
>  
> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
> index c99bcccae00c..2ecfeddea496 100644
> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
> @@ -2104,6 +2104,7 @@ opp-16000000-3 {
>  			};
>  
>  			pcie1_port0: pcie@0 {
> +				compatible = "pciclass,0604";
>  				device_type = "pci";
>  				reg = <0x0 0x0 0x0 0x0 0x0>;
>  				bus-range = <0x01 0xff>;
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
