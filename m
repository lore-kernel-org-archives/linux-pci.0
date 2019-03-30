Return-Path: <SRS0=NgI7=SB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F251AC43381
	for <linux-pci@archiver.kernel.org>; Sat, 30 Mar 2019 14:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95032183F
	for <linux-pci@archiver.kernel.org>; Sat, 30 Mar 2019 14:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XmDsJuHO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eQu7VA8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfC3OTF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 30 Mar 2019 10:19:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37648 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730838AbfC3OTE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Mar 2019 10:19:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 70876608FC; Sat, 30 Mar 2019 14:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553955543;
        bh=XSBIGrKYq/HNtyPRsy92uBBfeOZ5Ahuh7HKEC7fyMEc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XmDsJuHOx04fXACGtPRy2jzpEExX+Gz+OBqtcPQryOyEJVJr9/CsgNnXFhnnNmH8O
         K3L6zMkif2YB0WHuqR9kRCoh/lhu+j8AZroT5WtMrufhCiQ4qNSN1xlyCONOZv4kZe
         //iZMAqrJGVs8tIK8xIHdhZspAeclH5gFrbphze4=
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B7C860907;
        Sat, 30 Mar 2019 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553955541;
        bh=XSBIGrKYq/HNtyPRsy92uBBfeOZ5Ahuh7HKEC7fyMEc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eQu7VA8xjXNolIo/GGIPuPsHepv3t5mzocKgOkuQQpbAgkFt5ALjRa/qNq0r69mIx
         guJVP0ATOF35ipn8N2kwvfrdNjxukZCSIe2JS7y+Hv2hQQFVkSsoFOPhRIJHSxOa2H
         W5Kc0t/Xxd2PVK/eIxhDLEf+vNRiqpDsm9ld7RBM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B7C860907
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f41.google.com with SMTP id p20so4412649eds.6;
        Sat, 30 Mar 2019 07:19:01 -0700 (PDT)
X-Gm-Message-State: APjAAAX22qCqfgnocvPg3M8H2Eu03EbkG5nXzIuNpDKCpWZ3iXAZWhSo
        fh0nZN7/7Yo6pV2dnM3XnnfmrB0jpeu2SX8yF9Y=
X-Google-Smtp-Source: APXvYqxTv1SqlRNZa9zPQt1k69tMcOOHtJ2vBDsNd79aaWJAW+br+MScKPszqPBtE8M0+ZwTGzNtfGCUNF2ip7oGTXg=
X-Received: by 2002:a05:6402:383:: with SMTP id o3mr22851924edv.173.1553955540226;
 Sat, 30 Mar 2019 07:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr> <82ab78ee-4a38-4eee-f064-272b6f964f17@free.fr>
 <e7c8137a-2408-a71a-f722-199a86a75d13@free.fr> <5aa56120-b686-194b-36d6-8177b5749a19@arm.com>
In-Reply-To: <5aa56120-b686-194b-36d6-8177b5749a19@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Sat, 30 Mar 2019 19:48:49 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHOwW5jJmdVWo-E7154xk2jpR4ZLRoXEJdPwu8_ZJg14Q@mail.gmail.com>
Message-ID: <CAFp+6iHOwW5jJmdVWo-E7154xk2jpR4ZLRoXEJdPwu8_ZJg14Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: msm8998: Add PCIe SMMU node
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On Fri, Mar 29, 2019 at 11:59 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 29/03/2019 10:51, Marc Gonzalez wrote:
> > On 28/03/2019 18:05, Marc Gonzalez wrote:
> >
> >> ANOC1 SMMU filters PCIe accesses.
> >
> > I'm not sure this description is entirely accurate...
> >
> > ANOC likely stands for "Application Network-On-Chip"

How about simply saying - "Add device node for ANOC1 SMMU" for
commit title.
Commit text -
ANOC1 smmu services a list of peripherals - USB, UFS, BLSP2, and PCIe.
Add the device node for this smmu.

> >
> >
> >>   arch/arm64/boot/dts/qcom/msm8998.dtsi | 15 +++++++++++++++
> >>   1 file changed, 15 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> >> index f9a922fdae75..5a1c0961b281 100644
> >> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> >> @@ -606,6 +606,21 @@
> >>                      #thermal-sensor-cells = <1>;
> >>              };
> >>
> >> +            anoc1_smmu: arm,smmu@1680000 {
> >> +                    compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
> >
> > Maybe I should instead use "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
> > and define "qcom,msm8998-smmu-v2" in
> > Documentation/devicetree/bindings/iommu/arm,smmu.txt ?
>
> Yes please.
>
> > (Would the Documentation change need to be in a separate patch?)
>
> That's generally preferred, yes.
>
> >
> >> +                    reg = <0x01680000 0x10000>;
> >> +                    #iommu-cells = <1>;
> >
> > I'm not sure about this property. IIRC, Robin said <0> is not valid,
> > but I don't have any iommus prop, only iommu-map.
>
> You have to join the dots between the various bindings a little, but the
> iommu-base part of each iommu-map entry is an IOMMU specifier, and IOMMU
> specifiers are #iommu-cells long.
>
> To cut a long story short, 1 is definitely appropriate, because
> arm-smmu's definition of a 2-cell specifier wouldn't make much sense in
> the iommu-map context (and the current code for parsing iommu-map
> actually just assumes 1 anyway).

Besides this,
Looking at the SID mappings for ANOC1 smmu, devices such as USB, and UFS
can very well enable iommu support, and thus iommu-cells = 1 seems
like the correct thingy.

>
> >> +
> >> +                    #global-interrupts = <0>;
> >> +                    interrupts =
> >> +                            <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
> >> +                            <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
> >> +                            <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
> >> +                            <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
> >> +                            <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
> >> +                            <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;
> >> +            };
> >> +
> >
> > The rest of the node looks fairly straight-forward.
>
> You should probably have some "bus" and "iface" clocks too, per the
> requirement of "qcom,smmu-v2". Maybe Vivek might know what's relevant
> for MSM8998?

As Jeffrey rightly mentioned, these clocks are not under the control of Linux.
So, we won't need to add clocks to this SMMU.

Thanks
Vivek

>
> >
> > DT code was adapted from:
> >
> > https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm-arm-smmu-8998.dtsi?h=LE.UM.1.3.r3.25#n18
> >
> > I left out the so-called implementation-defined init:
> >
> > https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm-arm-smmu-impl-defs-8998.dtsi?h=LE.UM.1.3.r3.25#n123
> >
> > Should I try to merge this part in mainline?
> > (I don't have any documentation for it though.)
>
> "pls no :("
>
> I'm not sure what route the path takes from "DT describes the platform"
> to get to "DT lists opaque register addresses and magic data to write
> into them", but I imagine it might involve getting hit in the head along
> the way.
>
> Robin.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
