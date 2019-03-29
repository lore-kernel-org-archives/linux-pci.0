Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C55BC43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 18:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF422064A
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 18:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfC2S30 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:29:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36552 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbfC2S30 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 14:29:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5B4680D;
        Fri, 29 Mar 2019 11:29:25 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 343243F59C;
        Fri, 29 Mar 2019 11:29:23 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: msm8998: Add PCIe SMMU node
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
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
 <e7c8137a-2408-a71a-f722-199a86a75d13@free.fr>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5aa56120-b686-194b-36d6-8177b5749a19@arm.com>
Date:   Fri, 29 Mar 2019 18:29:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e7c8137a-2408-a71a-f722-199a86a75d13@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/03/2019 10:51, Marc Gonzalez wrote:
> On 28/03/2019 18:05, Marc Gonzalez wrote:
> 
>> ANOC1 SMMU filters PCIe accesses.
> 
> I'm not sure this description is entirely accurate...
> 
> ANOC likely stands for "Application Network-On-Chip"
> 
> 
>>   arch/arm64/boot/dts/qcom/msm8998.dtsi | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> index f9a922fdae75..5a1c0961b281 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> @@ -606,6 +606,21 @@
>>   			#thermal-sensor-cells = <1>;
>>   		};
>>   
>> +		anoc1_smmu: arm,smmu@1680000 {
>> +			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
> 
> Maybe I should instead use "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
> and define "qcom,msm8998-smmu-v2" in
> Documentation/devicetree/bindings/iommu/arm,smmu.txt ?

Yes please.

> (Would the Documentation change need to be in a separate patch?)

That's generally preferred, yes.

> 
>> +			reg = <0x01680000 0x10000>;
>> +			#iommu-cells = <1>;
> 
> I'm not sure about this property. IIRC, Robin said <0> is not valid,
> but I don't have any iommus prop, only iommu-map.

You have to join the dots between the various bindings a little, but the 
iommu-base part of each iommu-map entry is an IOMMU specifier, and IOMMU 
specifiers are #iommu-cells long.

To cut a long story short, 1 is definitely appropriate, because 
arm-smmu's definition of a 2-cell specifier wouldn't make much sense in 
the iommu-map context (and the current code for parsing iommu-map 
actually just assumes 1 anyway).

>> +
>> +			#global-interrupts = <0>;
>> +			interrupts =
>> +				<GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;
>> +		};
>> +
> 
> The rest of the node looks fairly straight-forward.

You should probably have some "bus" and "iface" clocks too, per the 
requirement of "qcom,smmu-v2". Maybe Vivek might know what's relevant 
for MSM8998?

> 
> DT code was adapted from:
> 
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm-arm-smmu-8998.dtsi?h=LE.UM.1.3.r3.25#n18
> 
> I left out the so-called implementation-defined init:
> 
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm-arm-smmu-impl-defs-8998.dtsi?h=LE.UM.1.3.r3.25#n123
> 
> Should I try to merge this part in mainline?
> (I don't have any documentation for it though.)

"pls no :("

I'm not sure what route the path takes from "DT describes the platform" 
to get to "DT lists opaque register addresses and magic data to write 
into them", but I imagine it might involve getting hit in the head along 
the way.

Robin.
