Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03743C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 09:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C597A2184B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 09:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="gpgM/DsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfDKJXg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:23:36 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:49458 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfDKJXg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 05:23:36 -0400
Received: from [192.168.27.209] (unknown [37.157.136.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 9EDBCCE4E;
        Thu, 11 Apr 2019 12:23:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1554974614; bh=EZrulKRBtwk7fssi2bkC6LKGUxs78JXg0zOI32+SdmE=;
        h=Subject:To:Cc:From:Date:From;
        b=gpgM/DsYcwmVaAh48sXvZaYfsAKEDnZkiTLtI1xTIm5A5iZyxyvloLfr+rP8lXsIQ
         Y6rYqfqSw5kFqtCiIj89x5ToMsvJRd/ng7YtHZm9CbJNSjMPalRXZtJKWumQ8YIEzh
         RmbAXek2KCSEPNA/zv8Dq/hYqnvIiHoYn9WG0ORuX624G35fWnvPHK45HXuEzk1Bd+
         Qn+TfDurqNWJ/qL2YpvpDGUp7pjpUHxiwbBEAaVrTy5nVSfKvs88EELyybmYEONl/F
         fEHBb9e+IyHomnqKrU18YGun5em8J7Rfn052Wxw2EIvN0oSQ7kMRCof+HbEfqZy9xW
         sSM/8F9+aUjTQ==
Subject: Re: [PATCH v3] arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
References: <f9d9afc3-06cb-a0bf-e420-8188f8255a88@free.fr>
 <c41c4057-8352-3b8e-1bdb-631df1ec3cd8@free.fr>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <a435823e-a5e1-a55c-9040-f494de21323c@mm-sol.com>
Date:   Thu, 11 Apr 2019 12:23:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c41c4057-8352-3b8e-1bdb-631df1ec3cd8@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 4/11/19 11:50 AM, Marc Gonzalez wrote:
> Add MSM8998 PCIe QMP PHY and PCIe root complex DT nodes.
> 
> Based on the following DTS downstream:
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm8998.dtsi?h=LE.UM.1.3.r3.25#n2537
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> Changes from v2:
> 	- Move all X-names props *after* corresponding X(s) prop
> 	- Drop comments
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 69 +++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index f807ea3e2c6e..dab3333e21f4 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -621,6 +621,75 @@
>  				<GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
> +		pcie0: pci@1c00000 {
> +			compatible = "qcom,pcie-msm8996";
> +			reg =	<0x01c00000 0x2000>,
> +				<0x1b000000 0xf1d>,
> +				<0x1b000f20 0xa8>,
> +				<0x1b100000 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			num-lanes = <1>;
> +			phys = <&pciephy>;
> +			phy-names = "pciephy";
> +
> +			ranges = <0x01000000 0x0 0x1b200000 0x1b200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x1b300000 0x1b300000 0x0 0xd00000>;
> +
> +			#interrupt-cells = <1>;
> +			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map =	<0 0 0 1 &intc 0 135 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 136 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 138 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 139 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_AUX_CLK>;
> +			clock-names = "pipe", "bus_master", "bus_slave", "cfg", "aux";
> +
> +			power-domains = <&gcc PCIE_0_GDSC>;
> +			iommu-map = <0x100 &anoc1_smmu 0x1480 1>;
> +			perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;

where are pinctrl properties? Probably in board .dts files?


-- 
regards,
Stan
