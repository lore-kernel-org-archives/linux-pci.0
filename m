Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F83C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 10:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4969821773
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 10:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfC2Kvy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:51:54 -0400
Received: from ns.iliad.fr ([212.27.33.1]:39018 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728869AbfC2Kvy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 06:51:54 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 75C3020BBC;
        Fri, 29 Mar 2019 11:51:51 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 5A4CC20BAC;
        Fri, 29 Mar 2019 11:51:51 +0100 (CET)
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: msm8998: Add PCIe SMMU node
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
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
 <82ab78ee-4a38-4eee-f064-272b6f964f17@free.fr>
Message-ID: <e7c8137a-2408-a71a-f722-199a86a75d13@free.fr>
Date:   Fri, 29 Mar 2019 11:51:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <82ab78ee-4a38-4eee-f064-272b6f964f17@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Fri Mar 29 11:51:51 2019 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/03/2019 18:05, Marc Gonzalez wrote:

> ANOC1 SMMU filters PCIe accesses.

I'm not sure this description is entirely accurate...

ANOC likely stands for "Application Network-On-Chip"


>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index f9a922fdae75..5a1c0961b281 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -606,6 +606,21 @@
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> +		anoc1_smmu: arm,smmu@1680000 {
> +			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";

Maybe I should instead use "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
and define "qcom,msm8998-smmu-v2" in
Documentation/devicetree/bindings/iommu/arm,smmu.txt ?
(Would the Documentation change need to be in a separate patch?)

> +			reg = <0x01680000 0x10000>;
> +			#iommu-cells = <1>;

I'm not sure about this property. IIRC, Robin said <0> is not valid,
but I don't have any iommus prop, only iommu-map.

> +
> +			#global-interrupts = <0>;
> +			interrupts =
> +				<GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;
> +		};
> +

The rest of the node looks fairly straight-forward.

DT code was adapted from:

https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm-arm-smmu-8998.dtsi?h=LE.UM.1.3.r3.25#n18

I left out the so-called implementation-defined init:

https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm-arm-smmu-impl-defs-8998.dtsi?h=LE.UM.1.3.r3.25#n123

Should I try to merge this part in mainline?
(I don't have any documentation for it though.)

Regards.
