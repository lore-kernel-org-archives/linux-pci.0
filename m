Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63AFC43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 17:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C861206B6
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 17:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfC1RHf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:07:35 -0400
Received: from ns.iliad.fr ([212.27.33.1]:51220 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfC1RHf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Mar 2019 13:07:35 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 015B5209A8;
        Thu, 28 Mar 2019 18:07:34 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id E1C8E20875;
        Thu, 28 Mar 2019 18:07:33 +0100 (CET)
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v1 0/3] PCIe and AR8151 on APQ8098/MSM8998
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
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
Message-ID: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
Date:   Thu, 28 Mar 2019 17:59:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Mar 28 18:07:34 2019 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello everyone,

After a lot of poking, I am finally able to use the AR8151 ethernet on the APQ8098 board.
The magic bits are the iommu-map prop and the PCIE20_PARF_BDF_TRANSLATE_N setup.

The WIP thread is archived here:
https://marc.info/?t=155059539200004&r=1&w=2


Marc Gonzalez (3):
  PCI: qcom: Setup PCIE20_PARF_BDF_TRANSLATE_N
  arm64: dts: qcom: msm8998: Add PCIe SMMU node
  arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes

 arch/arm64/boot/dts/qcom/msm8998.dtsi  | 93 ++++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c |  4 ++
 2 files changed, 97 insertions(+)

-- 
2.17.1
