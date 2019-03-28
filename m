Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88499C4360F
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 17:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C7721773
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 17:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfC1RHg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:07:36 -0400
Received: from ns.iliad.fr ([212.27.33.1]:51246 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfC1RHf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Mar 2019 13:07:35 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 1B90320875;
        Thu, 28 Mar 2019 18:07:34 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 0AD66209CC;
        Thu, 28 Mar 2019 18:07:34 +0100 (CET)
Subject: [PATCH v1 1/3] PCI: qcom: Setup PCIE20_PARF_BDF_TRANSLATE_N
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
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
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
Message-ID: <958ae127-3aa2-6824-c875-e3012644ed3d@free.fr>
Date:   Thu, 28 Mar 2019 18:01:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Mar 28 18:07:34 2019 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Initialize PCIE20_PARF_BDF_TRANSLATE_N for ops_2_3_2.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0ed235d560e3..5e5522a427b8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -54,6 +54,7 @@
 #define PCIE20_PARF_LTSSM			0x1B0
 #define PCIE20_PARF_SID_OFFSET			0x234
 #define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
+#define PCIE20_PARF_BDF_TRANSLATE_N		0x250
 
 #define PCIE20_ELBI_SYS_CTRL			0x04
 #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
@@ -602,6 +603,9 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 	val |= BIT(31);
 	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
+	val = PCI_DEVID(1, 0);
+	writel(val, pcie->parf + PCIE20_PARF_BDF_TRANSLATE_N);
+
 	return 0;
 
 err_slave_clk:
-- 
2.17.1
