Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Hauke Mehrtens <hauke@hauke-m.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH 6/8] PCI: iproc: Update iProc PCIe device tree bindings
Date: Tue, 15 Sep 2015 17:39:20 -0700
Message-ID: <1442363962-29805-7-git-send-email-rjui@broadcom.com>
In-Reply-To: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch updates the iProc PCIe device tree bindings with added
support for outbound mapping configurations

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt      | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
index f7ce50e..45c2a80 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -17,6 +17,21 @@ Optional properties:
 - phys: phandle of the PCIe PHY device
 - phy-names: must be "pcie-phy"
 
+- brcm,pcie-ob: Some iProc SoCs do not have the outbound address mapping done
+by the ASIC after power on reset. In this case, SW needs to configure it
+
+If the brcm,pcie-ob property is present, the following properties become
+effective:
+
+Required:
+- brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
+address used by the iProc PCIe core (not the PCIe address)
+- brcm,pcie-ob-window-size: The outbound address mapping window size (in MB)
+
+Optional:
+- brcm,pcie-ob-oarr-size: Some iProc SoCs need the OARR size bit to be set to
+increase the outbound window size
+
 Example:
 	pcie0: pcie@18012000 {
 		compatible = "brcm,iproc-pcie";
@@ -38,6 +53,11 @@ Example:
 
 		phys = <&phy 0 5>;
 		phy-names = "pcie-phy";
+
+		brcm,pcie-ob;
+		brcm,pcie-ob-oarr-size;
+		brcm,pcie-ob-axi-offset = <0x00000000>;
+		brcm,pcie-ob-window-size = <256>;
 	};
 
 	pcie1: pcie@18013000 {
-- 
1.9.1

