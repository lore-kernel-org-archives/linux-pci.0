Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F27C3E0C70;
	Thu, 18 Jun 2026 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776778; cv=none; b=TLwmDinKDZYaeDkPQ/2EL134svTb95f6PqX2Suz++pTTn/tpLyQwkfFLLPMAoHtpcvxgsKg7AYcyJu1Na9TIfMgDdA4OqVfKFzp5j2ExlaP1Z6ZvN3XOF8zRXtppVmHPmph1+e8q4S0It6J9fQKR7UMKybwt524bjd5WPofJQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776778; c=relaxed/simple;
	bh=7C/OA5z0IQIRfz86y+jfvJMeqBXn2YzwIG4IUj2FfmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NF7rOySzP8aBO4ezayATkFp5PFq9ag9cDk6ViGxHFeJ7evLrNd0UnUMDcesmRUI2WW562rum0TCBfDUNaariZwQ8ch9f4F/klLP0VS3l8dbVU+u1iGWgDbtstXKKr2HIyBlfMC80M9wxy77HJCt4ZPpqb5SHvpGMG421zUwTZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsu3Klwr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsu3Klwr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73E11F000E9;
	Thu, 18 Jun 2026 09:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781776777;
	bh=XG0QT6N38IMcbcbgkYLCIm69WHvPjarWkkV0QqGePRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nsu3KlwrMEdW37XmonSx6lJ4nLTxjiqn4XAOb3M2KlbPoBfAmMDlRVahAsoHwKZBU
	 gpUH4/fnNuZoFxoUU0Vii/lRXADuhAg8FG6chr2SwMM1lTLj3+5ecG2DdsyCJKwo42
	 xNuVJPiuh5WSeOOmPGXBtXr8ipG+JQEucAryhMamPX2TcaLb2VGA9jTS6DqpTh3lkc
	 KAbB69sFKpsXFrJVbeMfrMX52Ad0Rfv9HB7VD9FQ6KA2VcZuhcZyS0RtW/P/ihlJif
	 xasICeqoN7fixYRUadyq4nnwYmnTB0NdE6yl8wTirXSiIbcl+lwuPWMFNrMPxxnv2y
	 D+bMWXAQlZfmg==
Date: Thu, 18 Jun 2026 11:59:27 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	quic_chezhou@quicinc.com, cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 2/2] arm64: dts: qcom: lemans-evk: Describe the PCIe M.2
 Key E connector
Message-ID: <qi54cx7walxakugovw57fchqoixh4dkxekufsknpdj7hgmraee@sx32jtqpz6k6>
References: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
 <20260608091702.3797437-3-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608091702.3797437-3-wei.deng@oss.qualcomm.com>

On Mon, Jun 08, 2026 at 02:47:02PM +0530, Wei Deng wrote:
> The lemans EVK has the PCIe M.2 Mechanical Key E connector to connect
> wireless connectivity cards over PCIe and UART interfaces. Hence,
> describe the connector node and link it with the PCIe 0 Root Port and
> UART17 nodes through graph port/endpoint.
> 
> Also add 'compatible = "pciclass,0604"' to the pcieport0 node in
> lemans.dtsi to allow the PCI subsystem to associate the DT node with
> the PCI-to-PCI bridge device.
> 
> The M.2 Key E connector is powered by a 3.3V fixed regulator
> (vreg_wcn_3p3) which is sourced from the board's 12V DC input rail
> (vreg_dcin_12v). Both regulators are always-on and are required by the
> pcie-m2-e-connector binding.
> 
> Also add the serial1 = &uart17 alias, which is required for the
> Bluetooth serdev device to be enumerated on the UART17 interface.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 75 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/lemans.dtsi    |  1 +
>  2 files changed, 76 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index 34dfc8d22b6a..b2967cb53760 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -21,6 +21,7 @@ aliases {
>  		ethernet0 = &ethernet0;
>  		mmc1 = &sdhc;
>  		serial0 = &uart10;
> +		serial1 = &uart17;
>  		serial2 = &uart0;
>  	};
>  
> @@ -88,6 +89,38 @@ usb2_con_hs_ep: endpoint {
>  		};
>  	};
>  
> +	connector-3 {
> +		compatible = "pcie-m2-e-connector";
> +		vpcie3v3-supply = <&vreg_wcn_3p3>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				m2_e_pcie_ep: endpoint@0 {
> +					reg = <0>;
> +					remote-endpoint = <&pcieport0_ep>;
> +				};
> +			};
> +
> +			port@3 {
> +				reg = <3>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				m2_e_uart_ep: endpoint@0 {
> +					reg = <0>;
> +					remote-endpoint = <&uart17_ep>;
> +				};
> +			};
> +		};
> +	};
> +
>  	edp0-connector {
>  		compatible = "dp-connector";
>  		label = "EDP0";
> @@ -178,6 +211,17 @@ vmmc_sdc: regulator-vmmc-sdc {
>  		regulator-max-microvolt = <2950000>;
>  	};
>  
> +	vreg_dcin_12v: regulator-dcin-12v {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_DCIN_12V";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
>  	vreg_sdc: regulator-vreg-sdc {
>  		compatible = "regulator-gpio";
>  
> @@ -191,6 +235,19 @@ vreg_sdc: regulator-vreg-sdc {
>  
>  		startup-delay-us = <100>;
>  	};
> +
> +	vreg_wcn_3p3: regulator-wcn-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_WCN_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		vin-supply = <&vreg_dcin_12v>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
>  };
>  
>  &apps_rsc {
> @@ -742,6 +799,14 @@ &pcie1_phy {
>  	status = "okay";
>  };
>  
> +&pcieport0 {
> +	port {
> +		pcieport0_ep: endpoint {
> +			remote-endpoint = <&m2_e_pcie_ep>;
> +		};
> +	};
> +};
> +
>  &pmm8654au_0_pon_resin {
>  	linux,code = <KEY_VOLUMEDOWN>;
>  	status = "okay";
> @@ -970,6 +1035,16 @@ &uart10 {
>  	status = "okay";
>  };
>  
> +&uart17 {
> +	status = "okay";
> +
> +	port {
> +		uart17_ep: endpoint {
> +			remote-endpoint = <&m2_e_uart_ep>;
> +		};
> +	};
> +};
> +
>  &ufs_mem_hc {
>  	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
>  	vcc-supply = <&vreg_l8a>;
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index 353a6e6fd3ac..9afd6e8ebcdb 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -2779,6 +2779,7 @@ pcie0: pcie@1c00000 {
>  			status = "disabled";
>  
>  			pcieport0: pcie@0 {
> +				compatible = "pciclass,0604";
>  				device_type = "pci";
>  				reg = <0x0 0x0 0x0 0x0 0x0>;
>  				bus-range = <0x01 0xff>;
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
