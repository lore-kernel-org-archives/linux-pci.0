Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:36056 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757142AbeD0MAN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2018 08:00:13 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v8 4/9] bindings: PCI: designware: Add support for EP in DesignWare driver
Date: Fri, 27 Apr 2018 12:59:59 +0100
Message-Id: <270940114b0e84e700df792107b79b3fddd57016.1524829928.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
References: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
References: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add device tree binding documentation for the EP in PCIe DesignWare driver.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Change v1->v2:
 - Add a missing log description.
 - Add "snps,dw-pcie" compatible string following Kishon's suggestion.
Change v2->v3:
 - Reverted pcie_ep name to pcie.
Changes v3->v4:
 - Reverted "snps,dw-pcie-rc" compatible string requested by Rob Herring.
Changes v4->v5:
 - Removed device_type entry from EP requested by Rob Herring.
Changes v5->v6:
 - Nothing changed, just to follow the patch set version.
Changes v6->v7:
 - Nothing changed, just to follow the patch set version.
Changes v7->v8:
 - Patch description rework for an imperative verbal mode.

 Documentation/devicetree/bindings/pci/designware-pcie.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 7f9804d..c124f9b 100644
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
@@ -56,3 +57,14 @@ Example configuration:
 		#interrupt-cells = <1>;
 		num-lanes = <1>;
 	};
+or
+	pcie: pcie@dfc00000 {
+		compatible = "snps,dw-pcie-ep";
+		reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
+		      <0xdfc01000 0x0001000>, /* IP registers 2 */
+		      <0xd0000000 0x2000000>; /* Configuration space */
+		reg-names = "dbi", "dbi2", "addr_space";
+		num-ib-windows = <6>;
+		num-ob-windows = <2>;
+		num-lanes = <1>;
+	};
-- 
2.7.4
