Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:58222 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbeC1Lio (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Mar 2018 07:38:44 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH 3/8] bindings: PCI: designware: Add support for the EP in designware driver
Date: Wed, 28 Mar 2018 12:38:33 +0100
Message-Id: <dd582bfc2780679b7a092d23547c316234a84c34.1522235224.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
References: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
References: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/devicetree/bindings/pci/designware-pcie.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 6300762..4bb2e08 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -3,6 +3,7 @@
 Required properties:
 - compatible:
 	"snps,dw-pcie" for RC mode;
+	"snps,dw-pcie-ep" for EP mode;
 - reg: Should contain the configuration address space.
 - reg-names: Must be "config" for the PCIe configuration space.
     (The old way of getting the configuration address space from "ranges"
@@ -56,3 +57,15 @@ Example configuration:
 		#interrupt-cells = <1>;
 		num-lanes = <1>;
 	};
+or
+	pcie_ep: pcie_ep@dfc00000 {
+		compatible = "snps,dw-pcie-ep";
+		reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
+		      <0xdfc01000 0x0001000>, /* IP registers 2 */
+		      <0xd0000000 0x2000000>; /* Configuration space */
+		reg-names = "dbi", "dbi2", "addr_space";
+		device_type = "pci";
+		num-ib-windows = <6>;
+		num-ob-windows = <2>;
+		num-lanes = <1>;
+	};
-- 
2.7.4
