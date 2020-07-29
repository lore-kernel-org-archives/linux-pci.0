Return-Path: <SRS0=EmHj=BI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DA2C433E0
	for <linux-pci@archiver.kernel.org>; Wed, 29 Jul 2020 15:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06212083E
	for <linux-pci@archiver.kernel.org>; Wed, 29 Jul 2020 15:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG2PbG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:31:06 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:50912 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgG2PbF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 11:31:05 -0400
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Jul 2020 08:31:04 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg04-sd.qualcomm.com with ESMTP; 29 Jul 2020 08:30:56 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id DDE50219AB; Wed, 29 Jul 2020 21:00:54 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        svarbanov@mm-sol.com, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, sivaprak@codeaurora.org,
        mgautam@codeaurora.org, smuthayy@codeaurora.org,
        varada@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Subject: [PATCH V2 2/7] dt-bindings: phy: qcom,qmp: Add ipq8074 PCIe Gen3 phy
Date:   Wed, 29 Jul 2020 21:00:02 +0530
Message-Id: <1596036607-11877-3-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596036607-11877-1-git-send-email-sivaprak@codeaurora.org>
References: <1596036607-11877-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe phy compatible for Gen3 PCIe port found in ipq8074 devices.

Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index e4cd4a1..63025b0 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - qcom,ipq8074-qmp-pcie-phy
+      - qcom,ipq8074-qmp-pcie-gen3-phy
       - qcom,ipq8074-qmp-usb3-phy
       - qcom,msm8996-qmp-pcie-phy
       - qcom,msm8996-qmp-ufs-phy
-- 
2.7.4

