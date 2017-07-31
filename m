Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38796 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750986AbdGaFkH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2017 01:40:07 -0400
From: Varadarajan Narayanan <varada@codeaurora.org>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v5 0/7] Add support for IPQ8074 PCIe phy and controller
Date: Mon, 31 Jul 2017 11:09:47 +0530
Message-Id: <1501479594-18285-1-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v5:
  dt-bindings: phy: qmp: Add support for QMP phy in IPQ8074
        Renamed phy_phy clock as common clock

  phy: qcom-qmp: Fix phy pipe clock name
        Moved the DT get into the registering function

  phy: qcom-qmp: Add support for IPQ8074
        Place the IPQ8074 related structs similar to existing SoC.
        Renamed phy_phy clock as common clock
v4:
  phy: qcom-qmp: Fix phy pipe clock name
	Based on Vivek's comments, return failure only for
	PCI/USB type of phys.
	Removed Ack.

  phy: qcom-qmp: Handle unavailable registers
	Removed this patch.
	Incorrectly used a block of code that is not applicable
	to IPQ8074, hence had to avoid an "unavailable" register.
	Since that is addressed using 'has_phy_com_ctrl' this
	patch is not needed.

  phy: qcom-qmp: Add support for IPQ8074
	Set 'has_phy_com_ctrl' to false
	Remove ipq8074_pciephy_regs_layout

v3:
  PCI: dwc: qcom: Add support for IPQ8074 PCIe controller
	Incoporate Stan's feedback:-
	 - Add SoC Wrapper and Synopsys Core IP versions

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

Varadarajan Narayanan (7):
  dt-bindings: phy: qmp: Add output-clock-names
  dt-bindings: phy: qmp: Add support for QMP phy in IPQ8074
  phy: qcom-qmp: Fix phy pipe clock name
  phy: qcom-qmp: Add support for IPQ8074
  PCI: dwc: qcom: Use block IP version for operations
  dt-bindings: pci: qcom: Add support for IPQ8074
  PCI: dwc: qcom: Add support for IPQ8074 PCIe controller

 .../devicetree/bindings/pci/qcom,pcie.txt          |  23 ++
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |  11 +
 drivers/pci/dwc/pcie-qcom.c                        | 378 +++++++++++++++++----
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 152 ++++++++-
 4 files changed, 488 insertions(+), 76 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
