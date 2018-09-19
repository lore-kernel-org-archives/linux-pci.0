Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40353 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732265AbeISULY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2018 16:11:24 -0400
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jim Quinlan <jim2101024@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 08/12] MIPS: BMIPS: add PCI bindings for 7425, 7435
Date: Wed, 19 Sep 2018 10:32:03 -0400
Message-Id: <1537367527-20773-9-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds the PCIe nodes for the Broadcom STB PCIe root complex.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7425.dtsi     | 28 ++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi     | 28 ++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts |  4 ++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts |  4 ++++
 4 files changed, 64 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 410e61e..0edcbe4 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -584,4 +584,32 @@
 			};
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
+		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0x0 0x20000000>;
+		/* 768M or 1GB memc0, 0-1GB memc1 */
+		dma-ranges =
+			<0x02000000 0x0 0x00000000 0x00000000 0x0 0x10000000>,
+			<0x02000000 0x0 0x10000000 0x20000000 0x0 0x30000000>,
+			<0x02000000 0x0 0x40000000 0x90000000 0x0 0x40000000>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &periph_intc 33
+				 0 0 0 2 &periph_intc 34
+				 0 0 0 3 &periph_intc 35
+				 0 0 0 4 &periph_intc 36>;
+	};
+
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 8398b7f..50bc7a0 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -599,4 +599,32 @@
 			};
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
+		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0x0 0x20000000>;
+		/* 768M or 1GB memc0, 0-1GB memc1 */
+		dma-ranges =
+			<0x02000000 0x0 0x00000000 0x00000000 0x0 0x10000000>,
+			<0x02000000 0x0 0x10000000 0x20000000 0x0 0x30000000>,
+			<0x02000000 0x0 0x40000000 0x90000000 0x0 0x40000000>;
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
index 0ed2221..22270a9 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -152,3 +152,7 @@
 &waketimer {
 	status = "okay";
 };
+
+&pcie {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index 2c145a8..91bc1ec 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -128,3 +128,7 @@
 &waketimer {
 	status = "okay";
 };
+
+&pcie {
+	status = "okay";
+};
-- 
1.9.0.138.g2de3478
