Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5863AC433ED
	for <linux-pci@archiver.kernel.org>; Tue, 20 Apr 2021 11:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E933613AE
	for <linux-pci@archiver.kernel.org>; Tue, 20 Apr 2021 11:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhDTLWT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:22:19 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:42994 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhDTLWS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 07:22:18 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 28650440DF1;
        Tue, 20 Apr 2021 14:21:43 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] arm64: IPQ6018 PCIe support
Date:   Tue, 20 Apr 2021 14:21:35 +0300
Message-Id: <cover.1618916235.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for the single PCIe lane on IPQ6018 SoCs. The code is 
ported from downstream Codeaurora v5.4 kernel. The main difference from 
downstream code is the split of PCIe registers configuration from .init to 
.post_init, since it requires phy_power_on().

Tested on IPQ6010 based hardware.

Baruch Siach (2):
  dt-bindings: phy: qcom,qmp: Add IPQ60xx PCIe PHY bindings
  dt-bindings: pci: qcom: Document PCIe bindings for IPQ6018 SoC

Selvam Sathappan Periakaruppan (3):
  PCI: qcom: add support for IPQ60xx PCIe controller
  phy: qcom-qmp: add QMP V2 PCIe PHY support for ipq60xx
  arm64: dts: ipq6018: Add pcie support

 .../devicetree/bindings/pci/qcom,pcie.txt     |  24 ++
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  25 ++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         | 109 +++++++
 drivers/pci/controller/dwc/pcie-qcom.c        | 279 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 147 +++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           | 132 +++++++++
 6 files changed, 716 insertions(+)

-- 
2.30.2

