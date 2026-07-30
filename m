Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0EA377ED7;
	Thu, 30 Jul 2026 05:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785388130; cv=none; b=R62G92Q8Kk6SAnHY5NygDmPrZpZwgDTSsXB4qmggDpR8m5lENhbykcijgaEuYWLkSyAmJC1eS8cVDsbGIBJRRMaMwNDjjFYo1W7OXn3QbkN5JlBW8sQNqRr39LiCjZlsi8+w4VDiFuHXXgVKD9ENZfdAHsuaAVep6TyM1G0OLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785388130; c=relaxed/simple;
	bh=w3RNhY8T7AAkT0oL5eFQJk0juwISMg/vLwZO2uP6Ltw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvw45t/SyuUjNcpv6D8lFiXfx9OJ5UPye9onRhb2vusXEpj6RXV4G7hjGXaukbvEjTI9ugwLZOv1kG2VdmLFdvO9d/iF8yGUZhU/vZT8cLbVkMFMQ5iO8/7KtrZOvLFp5xyCCRG60k2PR4LHb/bDlAr4Kg1I09J3Lzzrwzuc5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J55ZNzvV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J55ZNzvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0A51F000E9;
	Thu, 30 Jul 2026 05:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785388129;
	bh=c20U8o5u3vtQTLB4Ygx6a5wNvee/y72tJCfxUAblbdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J55ZNzvVoC8KR+Rwtov0ygdHWS0GAnXT2c3UJyZB5zTWfVQ3GKBSBKd+6lpGObhR1
	 WxtAEtHUyofasLOxLtxHJtNtKuVqnXrHO5ffQvWZC+QSBSvxN4wNhLkUd1PLzKsDB1
	 WVA0tZWuaFbXbGBnMrBJfb/UtYOlfnE4KBM6oXaxApu1K2k68QRUN19s32a3CNtX0R
	 IUZlnV89ix/gvEqNjAIUQpAyDaVefTUcGg8z1jkmcGpa5eG4uGGKM1hZthNZEM7Eqn
	 eIiDBPM06jSpxeUsAyyzGdkxionNA03s/4gr46E/vVYONQrI1zn0UKUszrW2tRnlyU
	 YNiEg3H1sPnyA==
Date: Thu, 30 Jul 2026 07:08:40 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E
 key connector
Message-ID: <vatryeq6qsan342wow42rosabjofi6cqkom7aczllko4kw7n4t@v7k3fxat7nfi>
References: <20260730-eliza_evk-v6-0-40ece2d33114@oss.qualcomm.com>
 <20260730-eliza_evk-v6-2-40ece2d33114@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730-eliza_evk-v6-2-40ece2d33114@oss.qualcomm.com>

On Thu, Jul 30, 2026 at 10:18:54AM +0530, Krishna Chaitanya Chundru wrote:
> The Eliza EVK board features an M.2 E key connector connected to PCIe0.
> Enable the PCIe0 root port and its QMP PHY with the necessary RPMH
> regulator supplies. The M.2 slot's 3.3V supply rail is GPIO-controlled
> via a TCA9538 I/O expander on I2C4.
> 
> The M.2 E key slot hosts a WLAN card connected over PCIe and a Bluetooth
> device connected over UART. Model the connector using the
> pcie-m2-e-connector binding, wiring the PCIe root port and UART5 for
> the respective interfaces.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 116 ++++++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> index e47b24f8b827..b35fffb50976 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> @@ -11,6 +11,92 @@ aliases {
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	vreg_pcie_m_3p3: regulator-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "vreg_3p3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&gpio_expander1 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	connector-0 {
> +		compatible = "pcie-m2-e-connector";
> +		vpcie3v3-supply = <&vreg_pcie_m_3p3>;
> +		w-disable1-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
> +		w-disable2-gpios = <&pm8550vs_g_gpios 4 GPIO_ACTIVE_HIGH>;

Hmm, Sashiko pointed out the polarity issue here, GPIO_ACTIVE_HIGH. Is it a
mistake?

- Mani

> +
> +		pinctrl-0 = <&m2_w_disable1>, <&m2_w_disable2>;
> +		pinctrl-names = "default";
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
> +					remote-endpoint = <&uart5_ep>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	pinctrl-0 = <&qup_i2c4_data_clk>;
> +	pinctrl-names = "default";
> +
> +	clock-frequency = <400000>;
> +
> +	status = "okay";
> +
> +	gpio_expander1: gpio@3c {
> +		compatible = "ti,tca9538";
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		reg = <0x3c>;
> +	};
> +};
> +
> +&pcie0 {
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	vdda-phy-supply = <&vreg_l1k>;
> +	vdda-pll-supply = <&vreg_l3k>;
> +
> +	status = "okay";
> +};
> +
> +&pcie0_port0 {
> +	wake-gpios = <&tlmm 114 GPIO_ACTIVE_LOW>;
> +	reset-gpios = <&tlmm 78 GPIO_ACTIVE_LOW>;
> +
> +	port {
> +		pcieport0_ep: endpoint {
> +			remote-endpoint = <&m2_e_pcie_ep>;
> +		};
> +	};
>  };
>  
>  &uart13 {
> @@ -18,3 +104,33 @@ &uart13 {
>  
>  	status = "okay";
>  };
> +
> +&uart5 {
> +	status = "okay";
> +
> +	port {
> +		uart5_ep: endpoint {
> +			remote-endpoint = <&m2_e_uart_ep>;
> +		};
> +	};
> +};
> +
> +&pm8550vs_g_gpios {
> +	m2_w_disable2: m2-w-disable2-state {
> +		pins = "gpio4";
> +		function = "normal";
> +		input-disable;
> +		output-enable;
> +		bias-disable;
> +		power-source = <2>;
> +	};
> +};
> +
> +&tlmm {
> +	m2_w_disable1: m2-w-disable1-state {
> +		pins = "gpio35";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +};
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
