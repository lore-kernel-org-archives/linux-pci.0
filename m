Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2D7C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 20:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FBD218A3
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 20:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfCTUSS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:18:18 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:1606 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfCTUSS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Mar 2019 16:18:18 -0400
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id F324219F4F8;
        Wed, 20 Mar 2019 21:17:56 +0100 (CET)
Subject: Re: WIP: PCIe on MSM8998
To:     Robin Murphy <robin.murphy@arm.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
References: <c97b6f4e-4b4c-027f-5a0b-80b3f7054177@free.fr>
 <fb5f2b94-34b7-d021-7ac9-832b08138ad4@free.fr>
 <6041e92f-4dbf-c6ce-d92a-220fc8239acb@free.fr>
 <e0a650ce-e7d4-a803-5e08-f998722bf15d@arm.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <b027ad18-f7f4-cf05-b8de-ea951e0dc457@free.fr>
Date:   Wed, 20 Mar 2019 21:17:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <e0a650ce-e7d4-a803-5e08-f998722bf15d@arm.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/03/2019 17:51, Robin Murphy wrote:

> On 12/03/2019 15:59, Marc Gonzalez wrote:
>
>> I still can't get the ethernet card to play ball. As soon as I set the link up,
>> the system hangs a few seconds, then reboots.
>>
>> Here are the relevant DT nodes:
>> (There's probably an error or 12 lurking in there)
>>
>> 		anoc1_smmu: arm,smmu@1680000 {
>> 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
>> 			reg = <0x01680000 0x10000>;
>> 			#iommu-cells = <0>;
> 
> That's almost certainly not what you want - note that the binding is 
> only defined for 1 or 2 cells. The current Linux driver does actually 
> happen to handle 0 cells, in which case it will assume every device uses 
> Stream ID 0, but if the funky mappings in the SDM845 patch are anything 
> to go by I doubt that's correct.
> 
>> 			#global-interrupts = <0>;
> 
> Ouch - not having a global fault interrupt will make this even more 
> painful to debug. At least with that you can figure out what Stream IDs 
> are in play by forcing stuff to fault.

Hello Robin,

Your insight is always appreciated!

I can't say I have wrapped my head around iommu-cells, iommu-map,
and iommu-map-mask (yet) or stream IDs.

FWIW, here is the DT node as it appears downstream:
https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm-arm-smmu-8998.dtsi?h=LE.UM.1.3.r3.25#n18

	anoc1_smmu: arm,smmu-anoc1@1680000 {
		status = "ok";
		compatible = "qcom,smmu-v2";
		reg = <0x1680000 0x10000>;
		#iommu-cells = <0>;
		qcom,register-save;
		qcom,skip-init;
		#global-interrupts = <0>;
		interrupts = <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
			   <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
			   <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
			   <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
			   <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
			   <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;
		qcom,msm-bus,name = "smmu-bus-client-anoc1";
		qcom,msm-bus,num-cases = <2>;
		qcom,msm-bus,active-only;
		qcom,msm-bus,num-paths = <1>;
		/* aggre1_noc_clk */
		qcom,msm-bus,vectors-KBps =
				<84 10062 0 0>,
				<84 10062 0 1000>;
	};

There's even a rationale for #iommu-cells=0, albeit for a different board:
https://source.codeaurora.org/quic/la/kernel/msm-4.4/commit/arch/arm/boot/dts/qcom?h=LE.UM.1.3.r3.25&id=f1fa301f977f06dcf990c0452d85e2f67d8cbbf1

> There's currently a placeholder stream ID of "1" in the PCIe RC
> device tree node. The PCIe RC doesn't actually attach and doesn't
> need a stream ID though, the "1" was put there to get around an error
> caused by the fact that #iommu-cells was equal to 1 for the
> anoc1_smmu, even though it should have actually been 0. Fix all this
> by making #iommu-cells = <0> for the anoc1 SMMU and removing the
> bogus placeholder stream ID.

I can't say I understand this blurb.

Regards.
