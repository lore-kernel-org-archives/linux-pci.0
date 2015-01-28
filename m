Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:60775 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbbA2DJ3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jan 2015 22:09:29 -0500
Received: by mail-oi0-f53.google.com with SMTP id i138so22666299oig.12
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2015 19:09:28 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: [PATCH v2 1/3] dt/bindings: add versatile PCI binding
Date: Wed, 28 Jan 2015 10:16:16 -0600
Message-Id: <1422461778-6769-2-git-send-email-robh@kernel.org>
In-Reply-To: <1422461778-6769-1-git-send-email-robh@kernel.org>
References: <1422461778-6769-1-git-send-email-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add binding documentation for the PCI controller found on Versatile PB
boards.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
 .../devicetree/bindings/pci/versatile.txt          | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/versatile.txt

diff --git a/Documentation/devicetree/bindings/pci/versatile.txt b/Documentation/devicetree/bindings/pci/versatile.txt
new file mode 100644
index 0000000..2cc6071
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/versatile.txt
@@ -0,0 +1,59 @@
+* ARM Versatile Platform Baseboard PCI interface
+
+PCI host controller found on the ARM Versatile PB board's FPGA.
+
+Required properties:
+- compatible: should contain "arm,versatile-pci" to identify the Versatile PCI
+  controller.
+- reg: base addresses and lengths of the pci controller. There must be 3
+  entries:
+	- Versatile specific registers
+	- Self Config space
+	- Config space
+- #address-cells: set to <3>
+- #size-cells: set to <2>
+- device_type: set to "pci"
+- bus-range: set to <0 0xff>
+- ranges: ranges for the PCI memory and I/O regions
+- #interrupt-cells: set to <1>
+- interrupt-map-mask and interrupt-map: standard PCI properties	to define
+	the mapping of the PCI interface to interrupt numbers.
+
+Example:
+
+pci-controller@10001000 {
+	compatible = "arm,versatile-pci";
+	device_type = "pci";
+	reg = <0x10001000 0x1000
+	       0x41000000 0x10000
+	       0x42000000 0x100000>;
+	bus-range = <0 0xff>;
+	#address-cells = <3>;
+	#size-cells = <2>;
+	#interrupt-cells = <1>;
+
+	ranges = <0x01000000 0 0x00000000 0x43000000 0 0x00010000   /* downstream I/O */
+		  0x02000000 0 0x50000000 0x50000000 0 0x10000000   /* non-prefetchable memory */
+		  0x42000000 0 0x60000000 0x60000000 0 0x10000000>; /* prefetchable memory */
+
+	interrupt-map-mask = <0x1800 0 0 7>;
+	interrupt-map = <0x1800 0 0 1 &sic 28
+			 0x1800 0 0 2 &sic 29
+			 0x1800 0 0 3 &sic 30
+			 0x1800 0 0 4 &sic 27
+
+			 0x1000 0 0 1 &sic 27
+			 0x1000 0 0 2 &sic 28
+			 0x1000 0 0 3 &sic 29
+			 0x1000 0 0 4 &sic 30
+
+			 0x0800 0 0 1 &sic 30
+			 0x0800 0 0 2 &sic 27
+			 0x0800 0 0 3 &sic 28
+			 0x0800 0 0 4 &sic 29
+
+			 0x0000 0 0 1 &sic 29
+			 0x0000 0 0 2 &sic 30
+			 0x0000 0 0 3 &sic 27
+			 0x0000 0 0 4 &sic 28>;
+};
-- 
2.1.0

