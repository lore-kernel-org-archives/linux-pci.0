Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC525C282CB
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 14:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21652177B
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 14:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIDw0l7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfBHOui (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:50:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36454 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbfBHOuf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 09:50:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so3248814ljk.3
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 06:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6y6kQl9GCBehhUPm/krJdMDnib11mcotObtoaGQnZkI=;
        b=oIDw0l7wxeTot+6FmGxANf6Lc9+3bIKQWPGGGpnA5PS29jfSsfE3OTkxH1tjsnBZeB
         YTmVEoNNrsKNeAZ46lk7i68X3kEQrVWgeR5Gl0Dvi7aiCJaWJz/2efM3Qrpt9PVDZrT2
         I20xGSP1ATeS/RaGSIQBRKfRib8bTm/k/WFQiPg/LnhmlbvWXYYoMxS5SJDcYyXW9aZ3
         DPhSOmm7i/bUDWpS8CQmKY76kaO1DuvtL4M7XbKS8kNYzf/rHEbJqVpNEV9RC0lbcBNT
         KAdx3RJ1mKREIJjIrHGYkBj5uwLjyzMNDyORhX8sWY5XC6wopsP30Uw913kBGriW8S/O
         bv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6y6kQl9GCBehhUPm/krJdMDnib11mcotObtoaGQnZkI=;
        b=GoYrfyF8RfTjPEKSGlgC0dSUbxFMt/RUv7iBJXSDvekDIhqD+Z/m0yjSLdsHHMv/hX
         lCAXGABfp8xAlucga4dMxJRCGOLP9ow3HbyxAKDPJ7JnGkvzQqAQNP6orwCf5QfFCQlK
         GoaV6QMmkQtiCn172bB+9CyElhCnMpWPqPR8S+5ogrOYYbu9is3dGzKua80XGrgSHuU/
         Mi3eRgLMCn1F7J2mKqohJ58u65aNglubtEX+dplmakf18813/phcgmI+BNc/29I2EmCc
         wbcd63udpTzako5Odj3MItTKuWs4/ItMQUrymlQPwRPqZ9vBhrGYh8U1tCD0DFj2iKJl
         sW0w==
X-Gm-Message-State: AHQUAuYn0qSRph7VqVHDrc+HjigXesnDp1DGiNi+fNpOWVKzSUVnX4CO
        0y85LtlTh2/IXMPJxeY07hXLsw==
X-Google-Smtp-Source: AHgI3Iag7eBVQbYf4Kg4qOo10hKVO3UTgsEK3C0q8RrQRsUrBn/rnZh9cQcMB6nf/mMr/yU235R8Lg==
X-Received: by 2002:a2e:9956:: with SMTP id r22-v6mr10340090ljj.120.1549637431693;
        Fri, 08 Feb 2019 06:50:31 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id d23sm404512lfc.11.2019.02.08.06.50.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 08 Feb 2019 06:50:30 -0800 (PST)
Date:   Fri, 8 Feb 2019 15:50:28 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 7/7] arm64: dts: qcom: qcs404: Add PCIe related nodes
Message-ID: <20190208145028.GD773@centauri.lan>
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

On Fri, Jan 25, 2019 at 03:45:09PM -0800, Bjorn Andersson wrote:
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

Since we only have single PCIe controller,
I don't think we need to specify a pci-domain.

With that:
Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>


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
> 
