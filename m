Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB5EC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 15:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2302083E
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 15:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="ck5XxTcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfDJPcX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:32:23 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:33604 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730505AbfDJPcX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 11:32:23 -0400
Received: from [192.168.27.209] (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 9F555CE4B;
        Wed, 10 Apr 2019 18:32:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1554910340; bh=XXPgJMJyJt7h/9ISOTmKgP9FjHwXVVgG5f9Snk+ArQI=;
        h=Subject:To:Cc:From:Date:From;
        b=ck5XxTcYCBFY26wp3mq+zxNNEP9d/LefJLUAdna7ppWJp9l5+/L+kPV1l/MNPSVlF
         +kCtQnVAwie8CYS7KD5p6ALDmfId4LKvTM0HG7Uf9/XSYDTOZXisQ3TFh1/oavSGk8
         nLTZq731W/x3XWXcyOyfduXNL4uMsCXir1hQMoCKvNUvYhVUp8/xt+S2i/PZguUSDh
         DRygISSTA6zz7KdphnT0RG5AY3gUCczx0f9KHk3wUygTqhmDXxf2x+fKjfKaAdodN8
         qhjVBfftNQSd+IBF280ysEcvUM330AG8B0hwQ4znjt55AXhAEItCM0j+4ydpQCfCQv
         0NsH3LNlCHnog==
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: msm8998: Add PCIe PHY and RC
 nodes
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
 <186f7ca2-84e2-a37e-79e6-f1fec8e25374@free.fr>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <3f32cfb9-6528-9f5e-85db-cee89fdcfc5d@mm-sol.com>
Date:   Wed, 10 Apr 2019 18:32:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <186f7ca2-84e2-a37e-79e6-f1fec8e25374@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

Few comments inline.

On 3/28/19 7:06 PM, Marc Gonzalez wrote:
> Add MSM8998 PCIe QMP PHY and PCIe root complex DT nodes.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 78 +++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 5a1c0961b281..9f979a51f679 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -621,6 +621,84 @@
>  				<GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
> +		pcie0: pci@1c00000 {
> +			compatible = "qcom,pcie-msm8996";
> +			reg-names = "parf", "dbi", "elbi", "config";
> +			reg =	<0x01c00000 0x2000>,
> +				<0x1b000000 0xf1d>,
> +				<0x1b000f20 0xa8>,
> +				<0x1b100000 0x100000>;

could you please populate reg property and after that reg-names property.

> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			power-domains = <&gcc PCIE_0_GDSC>;
> +
> +			num-lanes = <1>;
> +			phy-names = "pciephy";
> +			phys = <&pciephy>;
> +
> +			ranges =
> +			/*** downstream I/O ***/

could you make this a standard kernel comment or completely drop it

> +			<0x01000000 0x0 0x1b200000 0x1b200000 0x0 0x100000>,
> +			/*** non-prefetchable memory ***/

ditto

> +			<0x02000000 0x0 0x1b300000 0x1b300000 0x0 0xd00000>;
> +
> +			#interrupt-cells = <1>;
> +			interrupt-names = "msi";
> +			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map =
> +				<0 0 0 1 &intc 0 135 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

move this to a line upper

> +				<0 0 0 2 &intc 0 136 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +				<0 0 0 3 &intc 0 138 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +				<0 0 0 4 &intc 0 139 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			clock-names = "pipe", "bus_master", "bus_slave", "cfg", "aux";
> +			clocks =
> +				<&gcc GCC_PCIE_0_PIPE_CLK>,

move this to a line upper

> +				<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				<&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				<&gcc GCC_PCIE_0_AUX_CLK>;

please swap the order clocks and clock-names

> +
> +			iommu-map = <0x100 &anoc1_smmu 0x1480 1>;

iommu-map-mask? It is optional but I had to ask :)

> +
> +			/* PCIe Fundamental Reset */

this comment is useless :) please drop it

> +			perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		phy@1c06000 {
> +			compatible = "qcom,msm8998-qmp-pcie-phy";
> +			reg = <0x01c06000 0x18c>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clock-names = "aux", "cfg_ahb", "ref";
> +			clocks =
> +				<&gcc GCC_PCIE_PHY_AUX_CLK>,
> +				<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				<&gcc GCC_PCIE_CLKREF_CLK>;\

please, swap the order of clocks and clock-names, and move first clock a
line upper. Also delete '\' symbol at the end of last line.

> +
> +			reset-names = "phy", "common";
> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>, <&gcc GCC_PCIE_PHY_BCR>;

resets prop and after that reset-names, please.

> +
> +			vdda-phy-supply = <&vreg_l1a_0p875>;
> +			vdda-pll-supply = <&vreg_l2a_1p2>;
> +
> +			pciephy: lane@1c06800 {
> +				reg = <0x01c06200 0x128>, <0x01c06400 0x1fc>, <0x01c06800 0x20c>;
> +				#phy-cells = <0>;
> +
> +				clock-names = "pipe0";
> +				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;

please, swap clocks and clock-names

> +				clock-output-names = "pcie_0_pipe_clk_src";
> +				#clock-cells = <0>;
> +			};
> +		};
> +
>  		tcsr_mutex_regs: syscon@1f40000 {
>  			compatible = "syscon";
>  			reg = <0x1f40000 0x20000>;
> 

-- 
regards,
Stan
