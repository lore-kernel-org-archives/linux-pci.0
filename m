Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:54327 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbbLDRel (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2015 12:34:41 -0500
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Marc Zyngier <marc.zyngier@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH v5 3/5] PCI: iproc: Add iProc PCIe MSI device tree binding
Date: Fri, 4 Dec 2015 09:35:00 -0800
Message-ID: <1449250502-10679-4-git-send-email-rjui@broadcom.com>
In-Reply-To: <1449250502-10679-1-git-send-email-rjui@broadcom.com>
References: <1449250502-10679-1-git-send-email-rjui@broadcom.com>
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
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
index 06eae0f..acbdbad 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -35,6 +35,28 @@ Optional:
 - brcm,pcie-ob-oarr-size: Some iProc SoCs need the OARR size bit to be set to
 increase the outbound window size
 
+MSI support (optional):
+
+For older platforms without MSI integrated in the GIC, iProc PCIe core provides
+an event queue based MSI support. The iProc MSI uses host memories to store
+MSI posted writes in the event queues
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
+
+Optional properties:
+- brcm,pcie-msi-inten: Needs to be present for some older iProc platforms that
+require the interrupt enable registers to be set explicitly to enable MSI
+
 Example:
 	pcie0: pcie@18012000 {
 		compatible = "brcm,iproc-pcie";
@@ -61,6 +83,19 @@ Example:
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
+		};
 	};
 
 	pcie1: pcie@18013000 {
-- 
1.9.1

