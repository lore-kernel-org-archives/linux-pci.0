Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0055.outbound.protection.outlook.com ([104.47.38.55]:51712
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751334AbcBKQ22 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 11 Feb 2016 11:28:28 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <bhelgaas@google.com>, <michals@xilinx.com>,
	<lorenzo.pieralisi@arm.com>, <paul.burton@imgtec.com>,
	<yinghai@kernel.org>, <wangyijing@huawei.com>, <robh@kernel.org>,
	<russell.joyce@york.ac.uk>, <sorenb@xilinx.com>,
	<jiang.liu@linux.intel.com>, <arnd@arndb.de>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>
CC: <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	"Bharat Kumar Gogada" <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: [PATCH V4 4/5] PCI: xilinx: Updating Zynq PCI binding documentation  with  Microblaze node.
Date: Thu, 11 Feb 2016 21:58:10 +0530
Message-ID: <1455208091-15556-5-git-send-email-bharatku@xilinx.com>
In-Reply-To: <1455208091-15556-1-git-send-email-bharatku@xilinx.com>
References: <1455208091-15556-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Updated Zynq PCI binding documentation with Microblaze node.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>

Acked-by: Rob Herring <robh@kernel.org>
---
Changes:
Adding Microblaze device tree node Documnetation.
---
 .../devicetree/bindings/pci/xilinx-pcie.txt        | 32 ++++++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
index 02f979a..ad7c7bf 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
@@ -17,7 +17,7 @@ Required properties:
 	Please refer to the standard PCI bus binding document for a more
 	detailed explanation
 
-Optional properties:
+Optional properties for Zynq/Microblaze:
 - bus-range: PCI bus numbers covered
 
 Interrupt controller child node
@@ -38,13 +38,13 @@ the four INTx interrupts in ISR and route them to this domain.
 
 Example:
 ++++++++
-
+Zynq:
 	pci_express: axi-pcie@50000000 {
 		#address-cells = <3>;
 		#size-cells = <2>;
 		#interrupt-cells = <1>;
 		compatible = "xlnx,axi-pcie-host-1.00.a";
-		reg = < 0x50000000 0x10000000 >;
+		reg = < 0x50000000 0x1000000 >;
 		device_type = "pci";
 		interrupts = < 0 52 4 >;
 		interrupt-map-mask = <0 0 0 7>;
@@ -60,3 +60,29 @@ Example:
 			#interrupt-cells = <1>;
 		};
 	};
+
+
+Microblaze:
+	pci_express: axi-pcie@10000000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		compatible = "xlnx,axi-pcie-host-1.00.a";
+		reg = <0x10000000 0x4000000>;
+		device_type = "pci";
+		interrupt-parent = <&microbalze_0_intc>;
+		interrupts = <1 2>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie_intc 1>,
+				<0 0 0 2 &pcie_intc 2>,
+				<0 0 0 3 &pcie_intc 3>,
+				<0 0 0 4 &pcie_intc 4>;
+		ranges = <0x02000000 0x00000000 0x80000000 0x80000000 0x00000000 0x10000000>;
+
+		pcie_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+		};
+
+	};
-- 
2.1.1

