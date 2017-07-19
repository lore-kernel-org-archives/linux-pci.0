Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50140 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752788AbdGSIn6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2017 04:43:58 -0400
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v2 0/8] Add support for IPQ8074 PCIe phy and controller
Date: Wed, 19 Jul 2017 14:13:31 +0530
Message-Id: <1500453819-5223-1-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v2:
  dt-bindings: phy: qmp: Add output-clock-names
	Added Rob H's Ack

  dt-bindings: phy: qmp: Add support for QMP phy in IPQ8074
	Removed example
	Added IPQ8074 specific details

  phy: qcom-qmp: Fix phy pipe clock name
	Added Vivek's Ack

  phy: qcom-qmp: Handle unavailable registers
	No changes

  phy: qcom-qmp: Add support for IPQ8074
	No changes

  PCI: dwc: qcom: Use block IP version for operations
	Added new patch to use block IP version instead of v1, v2...

  dt-bindings: pci: qcom: Add support for IPQ8074
	Removed example
	Added IPQ8074 specific details

  PCI: dwc: qcom: Add support for IPQ8074 PCIe controller
	Incorporated Bjorn's feedback:-
	 - Removed reset names, helper function to assert/deassert, helper
	   function to R/M/W register.
	 - Renamed sys_noc clock as iface clock
	 - Added deinit if phy power on fails

v1:
Add definitions required to enable QMP phy support for IPQ8074.

Add support for the IPQ8074 PCIe controller.  IPQ8074 supports
Gen 1/2, one lane, two PCIe root complex with support for MSI and
legacy interrupts, and it conforms to PCI Express Base 2.1
specification.

Varadarajan Narayanan (8):
  dt-bindings: phy: qmp: Add output-clock-names
  dt-bindings: phy: qmp: Add support for QMP phy in IPQ8074
  phy: qcom-qmp: Fix phy pipe clock name
  phy: qcom-qmp: Handle unavailable registers
  phy: qcom-qmp: Add support for IPQ8074
  PCI: dwc: qcom: Use block IP version for operations
  dt-bindings: pci: qcom: Add support for IPQ8074
  PCI: dwc: qcom: Add support for IPQ8074 PCIe controller

 .../devicetree/bindings/pci/qcom,pcie.txt          |  23 ++
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |  11 +
 drivers/pci/dwc/pcie-qcom.c                        | 369 +++++++++++++++++----
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 186 +++++++++--
 4 files changed, 506 insertions(+), 83 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
