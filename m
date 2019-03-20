Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40565C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 23:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF18218A5
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 23:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfCTXID (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:08:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47856 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfCTXID (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Mar 2019 19:08:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BE01374;
        Wed, 20 Mar 2019 16:08:02 -0700 (PDT)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E84303F71A;
        Wed, 20 Mar 2019 16:07:59 -0700 (PDT)
Subject: Re: WIP: PCIe on MSM8998
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
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
 <b027ad18-f7f4-cf05-b8de-ea951e0dc457@free.fr>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2e7d4564-01ea-d0bc-51c8-2bc2c116c4cc@arm.com>
Date:   Wed, 20 Mar 2019 23:07:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <b027ad18-f7f4-cf05-b8de-ea951e0dc457@free.fr>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-03-20 8:17 pm, Marc Gonzalez wrote:
> On 20/03/2019 17:51, Robin Murphy wrote:
> 
>> On 12/03/2019 15:59, Marc Gonzalez wrote:
>>
>>> I still can't get the ethernet card to play ball. As soon as I set the link up,
>>> the system hangs a few seconds, then reboots.
>>>
>>> Here are the relevant DT nodes:
>>> (There's probably an error or 12 lurking in there)
>>>
>>> 		anoc1_smmu: arm,smmu@1680000 {
>>> 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
>>> 			reg = <0x01680000 0x10000>;
>>> 			#iommu-cells = <0>;
>>
>> That's almost certainly not what you want - note that the binding is
>> only defined for 1 or 2 cells. The current Linux driver does actually
>> happen to handle 0 cells, in which case it will assume every device uses
>> Stream ID 0, but if the funky mappings in the SDM845 patch are anything
>> to go by I doubt that's correct.
>>
>>> 			#global-interrupts = <0>;
>>
>> Ouch - not having a global fault interrupt will make this even more
>> painful to debug. At least with that you can figure out what Stream IDs
>> are in play by forcing stuff to fault.
> 
> Hello Robin,
> 
> Your insight is always appreciated!
> 
> I can't say I have wrapped my head around iommu-cells, iommu-map,
> and iommu-map-mask (yet) or stream IDs.
> 
> FWIW, here is the DT node as it appears downstream:
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm-arm-smmu-8998.dtsi?h=LE.UM.1.3.r3.25#n18
> 
> 	anoc1_smmu: arm,smmu-anoc1@1680000 {
> 		status = "ok";
> 		compatible = "qcom,smmu-v2";
> 		reg = <0x1680000 0x10000>;
> 		#iommu-cells = <0>;
> 		qcom,register-save;
> 		qcom,skip-init;
> 		#global-interrupts = <0>;
> 		interrupts = <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
> 			   <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
> 			   <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
> 			   <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
> 			   <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
> 			   <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;
> 		qcom,msm-bus,name = "smmu-bus-client-anoc1";
> 		qcom,msm-bus,num-cases = <2>;
> 		qcom,msm-bus,active-only;
> 		qcom,msm-bus,num-paths = <1>;
> 		/* aggre1_noc_clk */
> 		qcom,msm-bus,vectors-KBps =
> 				<84 10062 0 0>,
> 				<84 10062 0 1000>;
> 	};
> 
> There's even a rationale for #iommu-cells=0, albeit for a different board:
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/commit/arch/arm/boot/dts/qcom?h=LE.UM.1.3.r3.25&id=f1fa301f977f06dcf990c0452d85e2f67d8cbbf1
> 
>> There's currently a placeholder stream ID of "1" in the PCIe RC
>> device tree node. The PCIe RC doesn't actually attach and doesn't
>> need a stream ID though, the "1" was put there to get around an error
>> caused by the fact that #iommu-cells was equal to 1 for the
>> anoc1_smmu, even though it should have actually been 0. Fix all this
>> by making #iommu-cells = <0> for the anoc1 SMMU and removing the
>> bogus placeholder stream ID.
> 
> I can't say I understand this blurb.

Unfortunately, having looked around the code, I think I do. 4.4 long 
predates the iommu-map binding, and in the absence of anything other 
than the hard-coded SID==RID assumption of arm-smmu at the time, they 
apparently went and did their own wacky thing[1]. AFAICS the Stream ID 
appears to be pretty much derived from the PCI topology as I would hope, 
but it looks like it might depend on some sort of lookup table being 
programmed appropriately as well.

Bear in mind that the this is _The Qualcomm Android Kernel_ we're trying 
to reason about here - playing true to the stereotype, the diff against 
the mainline driver is significantly bigger than the entire mainline 
driver itself; the line count of arm-smmu.c alone is pushing 
2-and-a-half times that of the file in 4.4.y ;)

Since the curiosity had set in, I finally got round to dumping the ACPI 
tables from my Snapdragon 835 laptop, and judging by the IORT it seems 
like the EFI firmware for Windows machines does provide some set of 
static ID mappings which could probably transcribe to an iommu-map (if 
indeed it's valid at all - Windows itself doesn't seem to be even 
touching PCI here), but I guess the Android BSP might not be so 
generous. That'll be a question for the Qualcomm folks. FWIW mine 
interestingly claims that its SMMU instances are all sharing SPI 231 as 
a global fault interrupt, but whether that's true and/or depends on the 
runtime firmware, again I really have no idea.

Robin.

[1] 
https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/pci/host/pci-msm.c?h=LE.UM.1.3.r3.25&id=f1fa301f977f06dcf990c0452d85e2f67d8cbbf1#n4687
