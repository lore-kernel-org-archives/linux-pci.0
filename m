Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48020 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdGQMEa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 08:04:30 -0400
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH 0/7] Add support for IPQ8074 PCIe phy and controller
Date: Mon, 17 Jul 2017 17:33:56 +0530
Message-Id: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add definitions required to enable QMP phy support for IPQ8074.

Add support for the IPQ8074 PCIe controller.  IPQ8074 supports
Gen 1/2, one lane, two PCIe root complex with support for MSI and
legacy interrupts, and it conforms to PCI Express Base 2.1
specification.

Varadarajan Narayanan (7):
  dt-bindings: phy: qmp: Add output-clock-names
  dt-bindings: phy: qmp: Add support for QMP phy in IPQ8074
  phy: qcom-qmp: Fix phy pipe clock name
  phy: qcom-qmp: Handle unavailable registers
  phy: qcom-qmp: Add support for IPQ8074
  dt-bindings: pci: qcom: Add support for IPQ8074
  PCI: dwc: qcom: Add support for IPQ8074 PCIe controller

 .../devicetree/bindings/pci/qcom,pcie.txt          |  67 ++++++
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |  31 +++
 drivers/pci/dwc/pcie-qcom.c                        | 259 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 186 +++++++++++++--
 4 files changed, 522 insertions(+), 21 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
