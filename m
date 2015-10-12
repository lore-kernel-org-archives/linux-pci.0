Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	device-tree <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/5] Documentation: of: Document the bindings used by Juno R1 PCIe host bridge
Date: Mon, 12 Oct 2015 11:07:37 +0100
Message-Id: <1444644459-2780-4-git-send-email-Liviu.Dudau@arm.com>
In-Reply-To: <1444644459-2780-1-git-send-email-Liviu.Dudau@arm.com>
References: <1444644459-2780-1-git-send-email-Liviu.Dudau@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

ARM's Juno R1 board used PLDA XpressRICH3-AXI IP to implement a PCIe host
bridge. Introduce "plda" as vendor prefix for PLDA and document the DT
bindings for PLDA XpressRICH3-AXI IP as well as ARM's Juno R1.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>

---
 Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt   | 10 ++++++++++
 .../devicetree/bindings/pci/plda,xpressrich3-axi.txt         | 12 ++++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt        |  1 +
 3 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt

diff --git a/Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt b/Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
new file mode 100644
index 0000000..f7514c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
@@ -0,0 +1,10 @@
+* ARM Juno R1 PCIe interface
+
+This PCIe host controller is based on PLDA XpressRICH3-AXI IP
+and thus inherits all the common properties defined in plda,xpressrich3-axi.txt
+as well as the base properties defined in host-generic-pci.txt.
+
+Required properties:
+ - compatible: "arm,juno-r1-pcie"
+ - dma-coherent: The host controller bridges the AXI transactions into PCIe bus
+   in a manner that makes the DMA operations to appear coherent to the CPUs.
diff --git a/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt b/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt
new file mode 100644
index 0000000..f3f75bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt
@@ -0,0 +1,12 @@
+* PLDA XpressRICH3-AXI host controller
+
+The PLDA XpressRICH3-AXI host controller can be configured in a manner that
+makes it compliant with the SBSA[1] standard published by ARM Ltd. For those
+scenarios, the host-generic-pci.txt bindings apply with the following additions
+to the compatible property:
+
+Required properties:
+ - compatible: should contain "plda,xpressrich3-axi" to identify the IP used.
+
+
+[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0029a/
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 82d2ac9..57653eb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -168,6 +168,7 @@ pericom	Pericom Technology Inc.
 phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
 plathome	Plat'Home Co., Ltd.
+plda	PLDA
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 powervr	PowerVR (deprecated, use img)
 qca	Qualcomm Atheros, Inc.
-- 
2.6.0

