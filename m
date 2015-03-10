Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Paul Bolle <pebolle@tiscali.nl>
CC: Florian Fainelli <f.fainelli@gmail.com>,
	Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<devicetree@vger.kernel.org>, "Ray Jui" <rjui@broadcom.com>
Subject: [PATCH v4 2/4] pci: iProc: define iProc PCIe platform bus binding
Date: Mon, 9 Mar 2015 17:21:15 -0700
Message-ID: <1425946878-13169-3-git-send-email-rjui@broadcom.com>
In-Reply-To: <1425946878-13169-1-git-send-email-rjui@broadcom.com>
References: <1425946878-13169-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Document the Broadcom iProc PCIe platform interface device tree binding

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbraden@broadcom.com>
---
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |   63 ++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
new file mode 100644
index 0000000..f7ce50e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
@@ -0,0 +1,63 @@
+* Broadcom iProc PCIe controller with the platform bus interface
+
+Required properties:
+- compatible: Must be "brcm,iproc-pcie"
+- reg: base address and length of the PCIe controller I/O register space
+- #interrupt-cells: set to <1>
+- interrupt-map-mask and interrupt-map, standard PCI properties to define the
+  mapping of the PCIe interface to interrupt numbers
+- linux,pci-domain: PCI domain ID. Should be unique for each host controller
+- bus-range: PCI bus numbers covered
+- #address-cells: set to <3>
+- #size-cells: set to <2>
+- device_type: set to "pci"
+- ranges: ranges for the PCI memory and I/O regions
+
+Optional properties:
+- phys: phandle of the PCIe PHY device
+- phy-names: must be "pcie-phy"
+
+Example:
+	pcie0: pcie@18012000 {
+		compatible = "brcm,iproc-pcie";
+		reg = <0x18012000 0x1000>;
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
+
+		linux,pci-domain = <0>;
+
+		bus-range = <0x00 0xff>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x81000000 0 0	  0x28000000 0 0x00010000
+			  0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
+
+		phys = <&phy 0 5>;
+		phy-names = "pcie-phy";
+	};
+
+	pcie1: pcie@18013000 {
+		compatible = "brcm,iproc-pcie";
+		reg = <0x18013000 0x1000>;
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
+
+		linux,pci-domain = <1>;
+
+		bus-range = <0x00 0xff>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x81000000 0 0	  0x48000000 0 0x00010000
+			  0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
+
+		phys = <&phy 1 6>;
+		phy-names = "pcie-phy";
+	};
-- 
1.7.9.5

