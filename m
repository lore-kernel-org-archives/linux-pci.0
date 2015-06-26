Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35567 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbbFZBGp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jun 2015 21:06:45 -0400
Received: by pdbci14 with SMTP id ci14so63904933pdb.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2015 18:06:45 -0700 (PDT)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Tanmay Inamdar <tinamdar@apm.com>, patches@apm.com,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH 1/1] pci: xgene: Enable huge outbound bar support
Date: Thu, 25 Jun 2015 18:05:56 -0700
Message-Id: <1435280756-24455-1-git-send-email-dhdang@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

X-Gene PCIe controllers support huge outbound BARs (with size upto
64GB). This patch configures additional 1 outbound BAR for X-Gene
PCIe controllers with size larger than 4GB. This is required to
support devices that request huge outbound memory (nVidia K40 as an
example)

Signed-off-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 33 +++++++++++++++++++--------------
 drivers/pci/host/pci-xgene.c           |  6 +++++-
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index d8f3a1c..039206b 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -404,10 +404,11 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = < 0x00 0x1f2b0000 0x0 0x00010000   /* Controller registers */
-				0xe0 0xd0000000 0x0 0x00040000>; /* PCI config space */
+				0xe0 0x00000000 0x0 0x00040000>; /* PCI config space */
 			reg-names = "csr", "cfg";
 			ranges = <0x01000000 0x00 0x00000000 0xe0 0x10000000 0x00 0x00010000   /* io */
-				  0x02000000 0x00 0x80000000 0xe1 0x80000000 0x00 0x80000000>; /* mem */
+				  0x02000000 0x00 0x80000000 0xe1 0x80000000 0x00 0x80000000   /* mem */
+				  0x02000000 0x10 0x00000000 0xf0 0x00000000 0x10 0x00000000>; /* mem */
 			dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
 				      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
 			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
@@ -428,10 +429,11 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = < 0x00 0x1f2c0000 0x0 0x00010000   /* Controller registers */
-				0xd0 0xd0000000 0x0 0x00040000>; /* PCI config space */
+				0xd0 0x00000000 0x0 0x00040000>; /* PCI config space */
 			reg-names = "csr", "cfg";
-			ranges = <0x01000000 0x0 0x00000000 0xd0 0x10000000 0x00 0x00010000   /* io  */
-				  0x02000000 0x0 0x80000000 0xd1 0x80000000 0x00 0x80000000>; /* mem */
+			ranges = <0x01000000 0x00 0x00000000 0xd0 0x10000000 0x00 0x00010000   /* io  */
+				  0x02000000 0x00 0x80000000 0xd1 0x80000000 0x00 0x80000000   /* mem */
+				  0x02000000 0x08 0x00000000 0xd8 0x00000000 0x08 0x00000000>; /* mem */
 			dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
 				      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
 			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
@@ -452,10 +454,11 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg =  < 0x00 0x1f2d0000 0x0 0x00010000   /* Controller registers */
-				 0x90 0xd0000000 0x0 0x00040000>; /* PCI config space */
+				 0x90 0x00000000 0x0 0x00040000>; /* PCI config space */
 			reg-names = "csr", "cfg";
-			ranges = <0x01000000 0x0 0x00000000 0x90 0x10000000 0x0 0x00010000   /* io  */
-				  0x02000000 0x0 0x80000000 0x91 0x80000000 0x0 0x80000000>; /* mem */
+			ranges = <0x01000000 0x00 0x00000000 0x90 0x10000000 0x00 0x00010000   /* io  */
+				  0x02000000 0x00 0x80000000 0x91 0x80000000 0x00 0x80000000   /* mem */
+				  0x02000000 0x04 0x00000000 0x94 0x00000000 0x04 0x00000000>; /* mem */
 			dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
 				      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
 			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
@@ -476,10 +479,11 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = < 0x00 0x1f500000 0x0 0x00010000   /* Controller registers */
-				0xa0 0xd0000000 0x0 0x00040000>; /* PCI config space */
+				0xa0 0x00000000 0x0 0x00040000>; /* PCI config space */
 			reg-names = "csr", "cfg";
-			ranges = <0x01000000 0x0 0x00000000 0xa0 0x10000000 0x0 0x00010000   /* io   */
-				  0x02000000 0x0 0x80000000 0xa1 0x80000000 0x0 0x80000000>; /* mem  */
+			ranges = <0x01000000 0x00 0x00000000 0xa0 0x10000000 0x00 0x00010000   /* io  */
+				  0x02000000 0x00 0x80000000 0xa1 0x80000000 0x00 0x80000000   /* mem */
+				  0x02000000 0x10 0x00000000 0xb0 0x00000000 0x10 0x00000000>; /* mem */
 			dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
 				      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
 			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
@@ -500,10 +504,11 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = < 0x00 0x1f510000 0x0 0x00010000   /* Controller registers */
-				0xc0 0xd0000000 0x0 0x00200000>; /* PCI config space */
+				0xc0 0x00000000 0x0 0x00040000>; /* PCI config space */
 			reg-names = "csr", "cfg";
-			ranges = <0x01000000 0x0 0x00000000 0xc0 0x10000000 0x0 0x00010000   /* io  */
-				  0x02000000 0x0 0x80000000 0xc1 0x80000000 0x0 0x80000000>; /* mem */
+			ranges = <0x01000000 0x00 0x00000000 0xc0 0x10000000 0x00 0x00010000   /* io  */
+				  0x02000000 0x00 0x80000000 0xc1 0x80000000 0x00 0x80000000   /* mem */
+				  0x02000000 0x08 0x00000000 0xc8 0x00000000 0x08 0x00000000>; /* mem */
 			dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
 				      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
 			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index a9dfb70..62d7843 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -305,6 +305,7 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *port,
 	struct resource_entry *window;
 	struct device *dev = port->dev;
 	int ret;
+	u32 omr_idx = 0;
 
 	resource_list_for_each_entry(window, res) {
 		struct resource *res = window->res;
@@ -321,8 +322,11 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *port,
 				return ret;
 			break;
 		case IORESOURCE_MEM:
-			xgene_pcie_setup_ob_reg(port, res, OMR1BARL, res->start,
+			xgene_pcie_setup_ob_reg(port, res,
+						OMR1BARL + (omr_idx * 0x18),
+						res->start,
 						res->start - window->offset);
+			omr_idx++;
 			break;
 		case IORESOURCE_BUS:
 			break;
-- 
1.9.1

