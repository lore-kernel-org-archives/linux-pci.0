Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vignesh R <vigneshr@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Chris Welch <Chris.Welch@viavisolutions.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 3/4] ARM: dts: dra7: Add DT property to allow unaligned mem access to PCIe RC
Date: Fri, 1 Dec 2017 11:43:10 +0530
Message-ID: <20171201061311.16691-4-vigneshr@ti.com>
In-Reply-To: <20171201061311.16691-1-vigneshr@ti.com>
References: <20171201061311.16691-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add ti,syscon-unaligned-access property to PCIe RC nodes in order to
enable workaround for errata i870 in PCIe RC mode as well.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index ac9216293b7c..e4182f4cc36d 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -314,6 +314,7 @@
 						<0 0 0 2 &pcie1_intc 2>,
 						<0 0 0 3 &pcie1_intc 3>,
 						<0 0 0 4 &pcie1_intc 4>;
+				ti,syscon-unaligned-access = <&scm_conf1 0x14 2>;
 				status = "disabled";
 				pcie1_intc: interrupt-controller {
 					interrupt-controller;
@@ -367,6 +368,7 @@
 						<0 0 0 2 &pcie2_intc 2>,
 						<0 0 0 3 &pcie2_intc 3>,
 						<0 0 0 4 &pcie2_intc 4>;
+				ti,syscon-unaligned-access = <&scm_conf1 0x14 1>;
 				pcie2_intc: interrupt-controller {
 					interrupt-controller;
 					#address-cells = <0>;
-- 
2.15.0
