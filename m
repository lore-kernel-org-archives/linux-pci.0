Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:38054 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757101AbaC0WrH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Mar 2014 18:47:07 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so5120261obc.16
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2014 15:47:06 -0700 (PDT)
From: Rob Herring <robherring2@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, liviu.dudau@arm.com
Cc: linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH 2/3] dt/bindings: add versatile PCI binding
Date: Thu, 27 Mar 2014 17:46:37 -0500
Message-Id: <1395960398-4238-3-git-send-email-robherring2@gmail.com>
In-Reply-To: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
References: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rob Herring <robh@kernel.org>

Add binding documentation for the PCI controller found on Versatile PB
boards.

Signed-off-by: Rob Herring <robh@kernel.org>
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
1.8.3.2

