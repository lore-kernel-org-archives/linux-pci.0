Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:44671 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbdF2BYd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jun 2017 21:24:33 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/3] dt-bindings: PCI: rockchip: Add vpcie12v-supply for Rockchip PCIe controller
Date: Thu, 29 Jun 2017 09:21:28 +0800
Message-Id: <1498699288-63944-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe connector provide a optional 12V power supply for high
power downstream components, so we add this as a optional
one if we need to control it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 Documentation/devicetree/bindings/pci/rockchip-pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
index 1453a73..9b88959 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
@@ -47,6 +47,7 @@ Optional Property:
 	using 24MHz OSC for RC's PHY.
 - ep-gpios: contain the entry for pre-reset gpio
 - num-lanes: number of lanes to use
+- vpcie12v-supply: The phandle to the 12v regulator to use for PCIe.
 - vpcie3v3-supply: The phandle to the 3.3v regulator to use for PCIe.
 - vpcie1v8-supply: The phandle to the 1.8v regulator to use for PCIe.
 - vpcie0v9-supply: The phandle to the 0.9v regulator to use for PCIe.
-- 
1.9.1
