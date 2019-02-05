Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B62C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFFF2083B
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549346537;
	bh=RVnQd+LbEOs+pQHWfLVBLe70RdxQZsy8uMbWTgER0TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PcBiLU7sNKFeCsJY7ve7pJt1HWrV5ym5OeIjeHMAJobirg8NvPr56X6KukJHBBIHR
	 O0s017uprdpfBLSdIgvoBENrWUeyHjxCNoKzKwvmPAGXTbqZEEYcD9CuIy3BDVggTQ
	 TD23GsWmn38PDa3OF7Lpt08JVaDjaBO39FEhyy8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfBEGCJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:02:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfBEGCJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Feb 2019 01:02:09 -0500
Received: from localhost (unknown [171.61.84.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CF292083B;
        Tue,  5 Feb 2019 06:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549346527;
        bh=RVnQd+LbEOs+pQHWfLVBLe70RdxQZsy8uMbWTgER0TQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0x3LAqR4xGO5ld7UWqScuZmcuJ/VGEPOGOHTMuI2xNGzBaXbdf/P7u7I+ZqpK17E
         4cRW5OsOuw0yDwxK6D2OSx+tdDftpQ5C5nBTNkSUR9Ns9GcsvtaioWRWc0G0tM0Zgb
         8ItZwFCstaVzt4l6Q7yY7OKDc7TNgVc3ce4u1IsY=
Date:   Tue, 5 Feb 2019 11:31:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 7/7] arm64: dts: qcom: qcs404: Add PCIe related nodes
Message-ID: <20190205060158.GY4296@vkoul-mobl>
References: <20190125234509.26419-1-bjorn.andersson@linaro.org>
 <20190125234509.26419-8-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125234509.26419-8-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25-01-19, 15:45, Bjorn Andersson wrote:
> The QCS404 has a PCIe2 PHY and a Qualcomm PCIe controller, add these to
> the platform dtsi and enable them for the EVB with the perst gpio
> and analog supplies defined.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 25 +++++++++
>  arch/arm64/boot/dts/qcom/qcs404.dtsi     | 67 ++++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index 50b3589c7f15..579ddaf4f5fa 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -21,6 +21,22 @@
>  	};
>  };
>  
> +&pcie {
> +	status = "ok";
> +
> +	perst-gpio = <&tlmm 43 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&perst_state>;
> +};
> +
> +&pcie_phy {
> +	status = "ok";
> +
> +	vdda-vp-supply = <&vreg_l3_1p05>;
> +	vdda-vph-supply = <&vreg_l5_1p8>;
> +};

I would prefer the patches be split to qcs404 adding PCIe nodes and then
add the board node for EVB... 

> +
>  &remoteproc_adsp {
>  	status = "ok";
>  };
> @@ -137,6 +153,15 @@
>  };
>  
>  &tlmm {
> +	perst_state: perst {
> +		pins = "gpio43";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;
> +	};
> +
>  	sdc1_on: sdc1-on {
>  		clk {
>  			pins = "sdc1_clk";
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 76699435c8bd..7b219865ba7e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -3,6 +3,7 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-qcs404.h>
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -377,6 +378,7 @@
>  			compatible = "qcom,gcc-qcs404";
>  			reg = <0x01800000 0x80000>;
>  			#clock-cells = <1>;
> +			#reset-cells = <1>;
>  
>  			assigned-clocks = <&gcc GCC_APSS_AHB_CLK_SRC>;
>  			assigned-clock-rates = <19200000>;
> @@ -405,6 +407,21 @@
>  			#interrupt-cells = <4>;
>  		};
>  
> +		pcie_phy: phy@7786000 {
> +			compatible = "qcom,qcs404-pcie2-phy", "qcom,pcie2-phy";
> +			reg = <0x07786000 0xb8>;
> +
> +			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
> +			resets = <&gcc GCC_PCIEPHY_0_PHY_BCR>,
> +				 <&gcc GCC_PCIE_0_PIPE_ARES>;
> +			reset-names = "phy", "pipe";
> +
> +			clock-output-names = "pcie_0_pipe_clk";
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>  		sdcc1: sdcc@7804000 {
>  			compatible = "qcom,sdhci-msm-v5";
>  			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
> @@ -771,6 +788,56 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		pcie: pci@10000000 {
> +			compatible = "qcom,pcie-qcs404", "snps,dw-pcie";
> +			reg =  <0x10000000 0xf1d
> +				0x10000f20 0xa8
> +				0x07780000 0x2000
> +				0x10001000 0x2000>;
> +			reg-names = "dbi", "elbi", "parf", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x81000000 0 0          0x10003000 0 0x00010000   /* I/O */
> +				  0x82000000 0 0x10013000 0x10013000 0 0x007ed000>; /* memory */
> +
> +			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +			clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>;
> +			clock-names = "iface", "aux", "master_bus", "slave_bus";
> +
> +			resets = <&gcc GCC_PCIE_0_AXI_MASTER_ARES>,
> +				 <&gcc GCC_PCIE_0_AXI_SLAVE_ARES>,
> +				 <&gcc GCC_PCIE_0_AXI_MASTER_STICKY_ARES>,
> +				 <&gcc GCC_PCIE_0_CORE_STICKY_ARES>,
> +				 <&gcc GCC_PCIE_0_BCR>,
> +				 <&gcc GCC_PCIE_0_AHB_ARES>;
> +			reset-names = "axi_m",
> +				      "axi_s",
> +				      "axi_m_sticky",
> +				      "pipe_sticky",
> +				      "pwr",
> +				      "ahb";
> +
> +			phys = <&pcie_phy>;
> +			phy-names = "pciephy";
> +
> +			status = "disabled";
> +		};
>  	};
>  
>  	timer {
> -- 
> 2.18.0

-- 
~Vinod
