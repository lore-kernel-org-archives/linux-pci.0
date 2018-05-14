Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:38185 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932681AbeENQRk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2018 12:17:40 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 3/4] bindings: PCI: designware: Add support for EP in DesignWare driver
Date: Mon, 14 May 2018 17:17:27 +0100
Message-Id: <d14a48a1c9f554d78a8a93532f288259de032fc5.1526314398.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1526314398.git.gustavo.pimentel@synopsys.com>
References: <cover.1526314398.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1526314398.git.gustavo.pimentel@synopsys.com>
References: <cover.1526314398.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add device tree binding documentation for the EP in PCIe DesignWare driver.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
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
