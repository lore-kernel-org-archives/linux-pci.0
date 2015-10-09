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
Subject: [PATCH v2 4/5] arm64: Juno: Add support for the PCIe host bridge on Juno R1
Date: Fri,  9 Oct 2015 17:57:28 +0100
Message-Id: <1444409849-5685-5-git-send-email-Liviu.Dudau@arm.com>
In-Reply-To: <1444409849-5685-1-git-send-email-Liviu.Dudau@arm.com>
References: <1444409849-5685-1-git-send-email-Liviu.Dudau@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Juno R1 board sports a functional PCIe host bridge that is
compliant with the SBSA standard found [1] here. With the right
firmware that initialises the XpressRICH3 controller one can
use the generic Host Bridge driver to use the PCIe hardware.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0029a/
---
 arch/arm64/boot/dts/arm/juno-r1.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index c627511..a702a6b 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -109,7 +109,26 @@
 
 	#include "juno-base.dtsi"
 
+	pcie-controller@40000000 {
+		compatible = "arm,juno-r1-pcie", "plda,xpressrich3", "pci-host-ecam-generic";
+		device_type = "pci";
+		reg = <0 0x40000000 0 0x10000000>;	/* ECAM config space */
+		bus-range = <0 255>;
+		linux,pci-domain = <0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		dma-coherent;
+		ranges = <0x01000000 0x00 0x5f800000 0x00 0x5f800000 0x0 0x00800000
+			  0x02000000 0x00 0x50000000 0x00 0x50000000 0x0 0x08000000
+		          0x42000000 0x40 0x00000000 0x40 0x00000000 0x1 0x00000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &gic 0 0 0 136 4
+			         0 0 0 2 &gic 0 0 0 137 4
+				 0 0 0 3 &gic 0 0 0 138 4
+				 0 0 0 4 &gic 0 0 0 139 4>;
+		msi-parent = <&v2m_0>;
+	};
 };
 
 &memtimer {
-- 
2.6.0

