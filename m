Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH 8/9] MIPS: BMIPS: add PCI bindings for 7425, 7435
Date: Wed, 11 Oct 2017 18:34:28 -0400
Message-Id: <1507761269-7017-9-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds the PCIe nodes for the Broadcom STB PCIe root complex.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7425.dtsi     | 25 +++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi     | 26 ++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts |  4 ++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts |  4 ++++
 4 files changed, 59 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index f56fb25..2c416f6 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -494,4 +494,29 @@
 			status = "disabled";
 		};
 	};
+
+	pcie: pcie@10410000 {
+		reg = <0x10410000 0x830c>;
+		compatible = "brcm,bcm7425-pcie", "brcm,pci-plat-dev";
+		interrupts = <37>, <37>;
+		interrupt-names = "pcie", "msi";
+		interrupt-parent = <&periph_intc>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		linux,pci-domain = <0>;
+		brcm,ssc;
+		msi-controller;
+		#interrupt-cells = <1>;
+		/* 4x128mb windows */
+		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0 0x08000000>,
+			 <0x2000000 0x0 0xd8000000 0xd8000000 0 0x08000000>,
+			 <0x2000000 0x0 0xe0000000 0xe0000000 0 0x08000000>,
+			 <0x2000000 0x0 0xe8000000 0xe8000000 0 0x08000000>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &periph_intc 33
+				 0 0 0 2 &periph_intc 34
+				 0 0 0 3 &periph_intc 35
+				 0 0 0 4 &periph_intc 36>;
+	};
+
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index f2cead2..2f869e5 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -509,4 +509,30 @@
 			status = "disabled";
 		};
 	};
+
+	pcie: pcie@10410000 {
+		reg = <0x10410000 0x930c>;
+		interrupts = <0x27>, <0x27>;
+		interrupt-names = "pcie", "msi";
+		interrupt-parent = <&periph_intc>;
+		compatible = "brcm,bcm7435-pcie", "brcm,pci-plat-dev";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		linux,pci-domain = <0>;
+		brcm,ssc;
+		msi-controller;
+		#interrupt-cells = <1>;
+		/* 4x128mb windows */
+		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0 0x08000000>,
+			 <0x2000000 0x0 0xd8000000 0xd8000000 0 0x08000000>,
+			 <0x2000000 0x0 0xe0000000 0xe0000000 0 0x08000000>,
+			 <0x2000000 0x0 0xe8000000 0xe8000000 0 0x08000000>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &periph_intc 35
+				 0 0 0 2 &periph_intc 36
+				 0 0 0 3 &periph_intc 37
+				 0 0 0 4 &periph_intc 38>;
+		status = "disabled";
+	};
+
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index 73aa006..3a87ac5 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -143,3 +143,7 @@
 &mspi {
 	status = "okay";
 };
+
+&pcie {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index 0a915f3..456d024 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -119,3 +119,7 @@
 &mspi {
 	status = "okay";
 };
+
+&pcie {
+	status = "okay";
+};
-- 
1.9.0.138.g2de3478
