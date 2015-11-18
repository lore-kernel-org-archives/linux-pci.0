Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:36979 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932482AbbKRAb6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2015 19:31:58 -0500
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Marc Zyngier <marc.zyngier@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH 3/5] PCI: iproc: Add iProc PCIe MSI device tree binding
Date: Tue, 17 Nov 2015 16:31:53 -0800
Message-ID: <1447806715-30043-4-git-send-email-rjui@broadcom.com>
In-Reply-To: <1447806715-30043-1-git-send-email-rjui@broadcom.com>
References: <1447806715-30043-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch updates the iProc PCIe device tree bindings with added
binding information for MSI

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
index 06eae0f..701d626 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -35,6 +35,31 @@ Optional:
 - brcm,pcie-ob-oarr-size: Some iProc SoCs need the OARR size bit to be set to
 increase the outbound window size
 
+MSI support (optional):
+
+For older platforms without MSI integrated in the GIC, iProc PCIe core provides
+an event queue based MSI support. The iProc MSI uses host memories to store
+MSI posted writes and event queues
+
+- msi-parent: Link to the device node of the MSI controller. On newer iProc
+platforms, the MSI controller may be gicv2m or gicv3-its. On older iProc
+platforms without MSI support in its interrupt controller, one may use the
+event queue based MSI support integrated within the iProc PCIe core
+
+When the iProc event queue based MSI is used, one needs to define the
+following properties in the MSI device node:
+- compatible: Must be "brcm,iproc-msi"
+- msi-controller: claims itself as an MSI controller
+- interrupt-parent: Link to its parent interrupt device
+- interrupts: List of interrupt IDs from its parent interrupt device
+- brcm,num-eq-region: Required number of 4K aligned memory region for MSI event
+queue
+- brcm,num-msi-msg-region: Required number of 4K aligned memory region for MSI
+posted writes
+Optional:
+- brcm,pcie-msi-inten: Needs to be present for some older iProc platforms that
+require the interrupt enable registers to be set explicitly to enable MSI
+
 Example:
 	pcie0: pcie@18012000 {
 		compatible = "brcm,iproc-pcie";
@@ -61,6 +86,21 @@ Example:
 		brcm,pcie-ob-oarr-size;
 		brcm,pcie-ob-axi-offset = <0x00000000>;
 		brcm,pcie-ob-window-size = <256>;
+
+		msi-parent = <&msi0>;
+
+		/* iProc event queue based MSI */
+		msi0: msi@18012000 {
+			compatible = "brcm,iproc-msi";
+			msi-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_NONE>,
+				     <GIC_SPI 97 IRQ_TYPE_NONE>,
+				     <GIC_SPI 98 IRQ_TYPE_NONE>,
+				     <GIC_SPI 99 IRQ_TYPE_NONE>,
+			brcm,num-eq-region = <1>;
+			brcm,num-msi-msg-region = <1>;
+		};
 	};
 
 	pcie1: pcie@18013000 {
-- 
1.9.1

