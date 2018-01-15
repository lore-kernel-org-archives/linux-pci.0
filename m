Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Jonas Gorski <jonas.gorski@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v4 7/8] MIPS: BMIPS: Add PCI bindings for 7425, 7435
Date: Mon, 15 Jan 2018 18:28:44 -0500
Message-Id: <1516058925-46522-8-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-mips@linux-mips.org, linux-pci@vger.kernel.org,
 Kevin Cernekee <cernekee@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
 Jim Quinlan <jim2101024@gmail.com>, bcm-kernel-feedback-list@broadcom.com,
 Gregory Fong <gregory.0xf0@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Adds the PCIe nodes for the Broadcom STB PCIe root complex.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7425.dtsi     | 26 ++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi     | 27 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts |  4 ++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts |  4 ++++
 4 files changed, 61 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index e4fb9b6..02168d0 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -495,4 +495,30 @@
 			status = "disabled";
 		};
 	};
+
+	pcie: pcie@10410000 {
+		reg = <0x10410000 0x830c>;
+		compatible = "brcm,bcm7425-pcie";
+		interrupts = <37>, <37>;
+		interrupt-names = "pcie", "msi";
+		interrupt-parent = <&periph_intc>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		linux,pci-domain = <0>;
+		brcm,enable-ssc;
+		bus-range = <0x00 0xff>;
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
index 1484e89..84881224 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -510,4 +510,31 @@
 			status = "disabled";
 		};
 	};
+
+	pcie: pcie@10410000 {
+		reg = <0x10410000 0x930c>;
+		interrupts = <0x27>, <0x27>;
+		interrupt-names = "pcie", "msi";
+		interrupt-parent = <&periph_intc>;
+		compatible = "brcm,bcm7435-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		linux,pci-domain = <0>;
+		brcm,enable-ssc;
+		bus-range = <0x00 0xff>;
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
index ce762c7..a958e56 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -144,3 +144,7 @@
 &mspi {
 	status = "okay";
 };
+
+&pcie {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index d4dd31a..f41791e 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -120,3 +120,7 @@
 &mspi {
 	status = "okay";
 };
+
+&pcie {
+	status = "okay";
+};
-- 
1.9.0.138.g2de3478


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
