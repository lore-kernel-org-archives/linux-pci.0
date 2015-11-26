Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:52922 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbbKZWhC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2015 17:37:02 -0500
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Marc Zyngier <marc.zyngier@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH v3 1/5] PCI: iproc: Update iProc PCIe device tree binding
Date: Thu, 26 Nov 2015 14:37:06 -0800
Message-ID: <1448577430-16428-2-git-send-email-rjui@broadcom.com>
In-Reply-To: <1448577430-16428-1-git-send-email-rjui@broadcom.com>
References: <1448577430-16428-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a new compatible string "brcm,iproc-pcie-paxc", for PAXC based iProc
PCIe root complex. A PAXC based PCIe root complex is connected to
emulated endpoint devices internal to the ASIC

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
index 45c2a80..06eae0f 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -1,7 +1,10 @@
 * Broadcom iProc PCIe controller with the platform bus interface
 
 Required properties:
-- compatible: Must be "brcm,iproc-pcie"
+- compatible: Must be "brcm,iproc-pcie" for PAXB, or "brcm,iproc-pcie-paxc"
+  for PAXC. PAXB based root complex is used for external endpoint devices.
+  PAXC based root complex is connected to emulated endpoint devices
+  internal to the ASIC
 - reg: base address and length of the PCIe controller I/O register space
 - #interrupt-cells: set to <1>
 - interrupt-map-mask and interrupt-map, standard PCI properties to define the
-- 
1.9.1

