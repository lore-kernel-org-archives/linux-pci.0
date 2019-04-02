Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C384AC4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 10:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB5E2070D
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 10:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfDBKoD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:44:03 -0400
Received: from ns.iliad.fr ([212.27.33.1]:45008 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbfDBKoC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Apr 2019 06:44:02 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id DE44A207AE;
        Tue,  2 Apr 2019 12:44:00 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id BB421201BA;
        Tue,  2 Apr 2019 12:44:00 +0200 (CEST)
Subject: Re: [PATCH v1 1/3] PCI: qcom: Setup PCIE20_PARF_BDF_TRANSLATE_N
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
 <958ae127-3aa2-6824-c875-e3012644ed3d@free.fr>
 <58b4db00-a0fa-5058-99ee-c11c8e2fa529@mm-sol.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <46bfbfd7-a650-f78f-fd2f-32f84e434382@free.fr>
Date:   Tue, 2 Apr 2019 12:44:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <58b4db00-a0fa-5058-99ee-c11c8e2fa529@mm-sol.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Apr  2 12:44:00 2019 +0200 (CEST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02/04/2019 10:08, Stanimir Varbanov wrote:

> On 3/28/19 7:01 PM, Marc Gonzalez wrote:
> 
>> Initialize PCIE20_PARF_BDF_TRANSLATE_N for ops_2_3_2.
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 0ed235d560e3..5e5522a427b8 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -54,6 +54,7 @@
>>  #define PCIE20_PARF_LTSSM			0x1B0
>>  #define PCIE20_PARF_SID_OFFSET			0x234
>>  #define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
>> +#define PCIE20_PARF_BDF_TRANSLATE_N		0x250
>>  
>>  #define PCIE20_ELBI_SYS_CTRL			0x04
>>  #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
>> @@ -602,6 +603,9 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
>>  	val |= BIT(31);
>>  	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>>  
>> +	val = PCI_DEVID(1, 0);
>> +	writel(val, pcie->parf + PCIE20_PARF_BDF_TRANSLATE_N);
> 
> I wonder, shouldn't this register manipulation happen in common code
> e.g. pcie-designware-host.c

I don't think so. PARF (PCIe Auxiliary Register File) appears to be
a vendor-specific area. Perhaps someone with access to the Designware
documentation could check. (Though it is possible that several vendors
have implemented exactly the same PARF layout.)

> and of course the manipulation should be conditional because
> not all platforms might have iommu.

My patch tweaks PCIE20_PARF_BDF_TRANSLATE_N in qcom_pcie_init_2_3_2()
which means 8996 and 8998 only (and possibly sdm660)

$ git grep smmu-exist vendor -- arch/arm/boot/dts/qcom
vendor:arch/arm/boot/dts/qcom/msm8996.dtsi:             qcom,smmu-exist;
vendor:arch/arm/boot/dts/qcom/msm8996.dtsi:             qcom,smmu-exist;
vendor:arch/arm/boot/dts/qcom/msm8996.dtsi:             qcom,smmu-exist;
vendor:arch/arm/boot/dts/qcom/msm8998-interposer-sdm660.dtsi:           qcom,smmu-exist;
vendor:arch/arm/boot/dts/qcom/msm8998.dtsi:             qcom,smmu-exist;

https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/pci/host/pci-msm.c?h=LE.UM.1.3.r3.25#n3880


> Also, could we have more generic iommu-map description like the one for
> sdm845 at [1] ?

I assume you meant https://patchwork.kernel.org/patch/10831293/

I don't think that such a map is quite right for msm8998 -- and even
for sdm845 :-p

There is only a single PCIe master, other than the root complex:

# lspci
00:00.0 PCI bridge: Qualcomm Device 0105
01:00.0 Ethernet controller: Qualcomm Atheros AR8151 v2.0 Gigabit Ethernet (rev c0)

Hence iommu-map = <0x100 &anoc1_smmu 0x1480 1>;
i.e. map stream-id 0x1480 to device-id 01:00.0

We could pick a different stream-id for 0x100 but I don't see any
advantage (??) in doing so...

If a SoC designer took the msm8998 and added a PCIe bridge to support
multiple PCIe EPs, then they would override the iommu-map in their
board-specific DTS.


I do have a nagging feeling that this patch is not perfect for 3 reasons:

1) Did msm8996 PCIe work without tweaking PCIE20_PARF_BDF_TRANSLATE_N?
If so, why? What is the difference with msm8998 PCIe?
"MSM8998 does not have static SID configuration for PCIe."
What about MSM8996?

2) OF: /soc/pci@1c00000: no iommu-map translation for rid 0x0 on           (null)
The kernel warns that the root complex has no asssigned stream-id.
I'm not sure that's actually an issue...

3) I just blindly write PCI_DEVID(1, 0) to PCIE20_PARF_BDF_TRANSLATE_N

To be really generic, I would have to walk the iommu-map and do

for_each_iommu_map_entry
	offset = PCIE20_PARF_BDF_TRANSLATE_N + (out_base - 0x1480) * 4;
	writel(rid_base, pcie->parf + offset);

Perhaps do this in of_pci_iommu_init() ?
Maybe have to tweak of_map_rid() or duplicate some code...

On first approximation, maybe I can just do the blind write, but only
for 8998. That way, I don't change anything for the other platforms.

Comments?

Regards.
