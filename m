Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Joao Pinto <jpinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 Pratyush Anand <pratyush.anand@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: marvell: enable MSI for PCIe on Armada 7K/8K
Date: Tue, 30 Aug 2016 14:57:10 +0200
Message-Id: <1472561830-20932-4-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Kumar Gala <galak@codeaurora.org>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Shadi Ammouri <shadi@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds a reference to the appropriate MSI controller in the
description of the PCIe controllers on Marvel Armada 7K and 8K
platforms.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Please only apply once the DT binding and the driver change have been
accepted.

 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 3 +++
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index ceb83b0..ff469e1 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -177,6 +177,7 @@
 			#interrupt-cells = <1>;
 			device_type = "pci";
 			dma-coherent;
+			msi-parent = <&gic_v2m0>;
 
 			bus-range = <0 0xff>;
 			ranges =
@@ -202,6 +203,7 @@
 			#interrupt-cells = <1>;
 			device_type = "pci";
 			dma-coherent;
+			msi-parent = <&gic_v2m0>;
 
 			bus-range = <0 0xff>;
 			ranges =
@@ -228,6 +230,7 @@
 			#interrupt-cells = <1>;
 			device_type = "pci";
 			dma-coherent;
+			msi-parent = <&gic_v2m0>;
 
 			bus-range = <0 0xff>;
 			ranges =
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 2d863f2..43cecf0 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -177,6 +177,7 @@
 			#interrupt-cells = <1>;
 			device_type = "pci";
 			dma-coherent;
+			msi-parent = <&gic_v2m0>;
 
 			bus-range = <0 0xff>;
 			ranges =
@@ -202,6 +203,7 @@
 			#interrupt-cells = <1>;
 			device_type = "pci";
 			dma-coherent;
+			msi-parent = <&gic_v2m0>;
 
 			bus-range = <0 0xff>;
 			ranges =
@@ -228,6 +230,7 @@
 			#interrupt-cells = <1>;
 			device_type = "pci";
 			dma-coherent;
+			msi-parent = <&gic_v2m0>;
 
 			bus-range = <0 0xff>;
 			ranges =
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
