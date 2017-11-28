Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43744 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbdK1OR7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Nov 2017 09:17:59 -0500
Received: by mail-pl0-f67.google.com with SMTP id s23so257040plk.10
        for <linux-pci@vger.kernel.org>; Tue, 28 Nov 2017 06:17:59 -0800 (PST)
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc: devicetree@vger.kernel.org, mingkai.hu@nxp.com,
        peter.newton@nxp.com, minghuan.lian@nxp.com, rajesh.raina@nxp.com,
        rajan.kapoor@nxp.com, prabhjot.singh@nxp.com,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: [PATCH v4 1/2] PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver DT bindings
Date: Tue, 28 Nov 2017 09:17:28 -0500
Message-Id: <1511878648-8188-1-git-send-email-l.subrahmanya@mobiveil.co.in>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds the DT bindings for Mobiveil PCIe Host Bridge
IP driver and updates the vendor prefixes file.

Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: bhelgaas@google.com
Cc: lorenzo.pieralisi@arm.com
Cc: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
Fixes:
- used git mailer, as tabs were converted to spaces by thunderbird before
- moved the entry to corrrect alphabetical order in vendor-prefixes.txt
- DT binding file was modified to take care of v3 review comments

 .../devicetree/bindings/pci/mobiveil-pcie.txt      | 73 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/mobiveil-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
new file mode 100644
index 0000000..9f3160d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
@@ -0,0 +1,73 @@
+* Mobiveil AXI PCIe Root Port Bridge DT description
+
+Mobiveil's GPEX 4.0 is PCIe gen4 a root port bridge IP. This configurable IP
+has upto 8 outbound and inbound windows for the address translation.
+
+Required properties:
+- #address-cells: Address representation for root ports, set to <3>
+- #size-cells: Size representation for root ports, set to <2>
+- #interrupt-cells: specifies the number of cells needed to encode an
+	interrupt source. The value must be 1.
+- compatible: Should contain "mbvl,gpex40-pcie"
+- reg: Should contain PCIe registers location and length
+	"config_axi_slave": PCIe controller registers
+	"csr_axi_slave"	  : Bridge config registers
+	"gpio_slave"	  : GPIO registers to control slot power
+	"apb_csr"	  : MSI registers
+
+- device_type: must be "pci"
+- apio-wins : number of requested apio outbound windows
+		default 2 outbound windows are configured -
+		1. Config window
+		2. Memory window
+- ppio-wins : number of requested ppio inbound windows
+		default 1 inbound memory window is configured.
+- bus-range: PCI bus numbers covered
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: specifies the number of cells needed to encode an
+	interrupt source. The value must be 1.
+- interrupt-parent : phandle to the interrupt controller that
+		it is attached to, it should be set to gic to point to
+		ARM's Generic Interrupt Controller node in system DT.
+- interrupts: The interrupt line of the PCIe controller
+		last cell of this fild is set to 4 to
+		denote it as IRQ_TYPE_LEVEL_HIGH type interrupt.
+- interrupt-map-mask,
+	interrupt-map: standard PCI properties to define the mapping of the
+	PCI interface to interrupt numbers.
+- ranges: ranges for the PCI memory regions (I/O space region is not
+	supported by hardware)
+	Please refer to the standard PCI bus binding document for a more
+	detailed explanation
+
+
+Example:
+++++++++
+	pcie0: pcie@a0000000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		compatible = "mbvl,gpex40-pcie";
+		reg =	<0xa0000000 0x00001000>,
+			<0xb0000000 0x00010000>,
+			<0xff000000 0x00200000>,
+			<0xb0010000 0x00001000>;
+		reg-names =	"config_axi_slave",
+				"csr_axi_slave",
+				"gpio_slave",
+				"apb_csr";
+		device_type = "pci";
+		apio-wins = <2>;
+		ppio-wins = <1>;
+		bus-range = <0x00000000 0x000000ff>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <1>;
+		interrupts = < 0 89 4 >;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pci_express 1>,
+				<0 0 0 2 &pci_express 2>,
+				<0 0 0 3 &pci_express 3>,
+				<0 0 0 4 &pci_express 4>;
+		ranges = < 0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
+
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 0994bdd..8263cc7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -197,6 +197,7 @@ lwn	Liebherr-Werk Nenzing GmbH
 macnica	Macnica Americas
 marvell	Marvell Technology Group Ltd.
 maxim	Maxim Integrated Products
+mbvl	Mobiveil Inc.
 mcube	mCube
 meas	Measurement Specialties
 mediatek	MediaTek Inc.
-- 
1.8.3.1
