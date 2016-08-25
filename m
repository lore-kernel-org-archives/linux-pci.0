Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:34058 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbcHYWIo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2016 18:08:44 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: <bhelgaas@google.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Niklas Cassel <niklass@axis.com>
Subject: [PATCH RESEND] bindings: PCI: artpec: correct pci binding example
Date: Fri, 26 Aug 2016 00:01:56 +0200
Message-ID: <1472162516-8966-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Niklas Cassel <niklas.cassel@axis.com>

 - Increase config size. When using a PCIe switch,
   the previous config size only had room for one device.
 - Add bus range. Inherited optional property.
 - Map downstream I/O to PCI address 0. We can map it to any
   address, but let's be consistent with other drivers.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
index 330a45b..5ecaea1 100644
--- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
@@ -24,16 +24,17 @@ Example:
 		compatible = "axis,artpec6-pcie", "snps,dw-pcie";
 		reg = <0xf8050000 0x2000
 		       0xf8040000 0x1000
-		       0xc0000000 0x1000>;
+		       0xc0000000 0x2000>;
 		reg-names = "dbi", "phy", "config";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
 			  /* downstream I/O */
-		ranges = <0x81000000 0 0x00010000 0xc0010000 0 0x00010000
+		ranges = <0x81000000 0 0 0xc0002000 0 0x00010000
 			  /* non-prefetchable memory */
-			  0x82000000 0 0xc0020000 0xc0020000 0 0x1ffe0000>;
+			  0x82000000 0 0xc0012000 0xc0012000 0 0x1ffee000>;
 		num-lanes = <2>;
+		bus-range = <0x00 0xff>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "msi";
 		#interrupt-cells = <1>;
-- 
2.1.4

