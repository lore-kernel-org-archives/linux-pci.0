Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35456 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbbGIVVW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2015 17:21:22 -0400
Received: by pdrg1 with SMTP id g1so39726921pdr.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2015 14:21:22 -0700 (PDT)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
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
Subject: [PATCH v3 1/2] arm64: dts: Add 1 more window with large size for X-Gene PCIe nodes
Date: Thu,  9 Jul 2015 14:20:11 -0700
Message-Id: <d4b73718e3d9f265be3cde883ed23c51a3bb1444.1436476099.git.dhdang@apm.com>
In-Reply-To: <cover.1436476099.git.dhdang@apm.com>
References: <cover.1436476099.git.dhdang@apm.com>
In-Reply-To: <cover.1436476099.git.dhdang@apm.com>
References: <1481643.dA4ocqzitg@wuerfel> <cover.1436476099.git.dhdang@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds 1 additional window with large size (up to 64GB) for
X-Gene PCIe nodes to support devices that require huge BAR.

Each X-Gene PCIe node now will have 2 memory windows:1 non-prefetchable
32-bit window and 1 prefetchable 64-bit window.

Signed-off-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index d8f3a1c..80a8050 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -407,7 +407,8 @@
 				0xe0 0xd0000000 0x0 0x00040000>; /* PCI config space */
 			reg-names = "csr", "cfg";
 			ranges = <0x01000000 0x00 0x00000000 0xe0 0x10000000 0x00 0x00010000   /* io */
-				  0x02000000 0x00 0x80000000 0xe1 0x80000000 0x00 0x80000000>; /* mem */
+				  0x02000000 0x00 0x80000000 0xe1 0x80000000 0x00 0x80000000   /* mem */
+				  0x43000000 0xf0 0x00000000 0xf0 0x00000000 0x10 0x00000000>; /* mem */
 			dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
 				      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
 			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
@@ -430,8 +431,9 @@
 			reg = < 0x00 0x1f2c0000 0x0 0x00010000   /* Controller registers */
 				0xd0 0xd0000000 0x0 0x00040000>; /* PCI config space */
 			reg-names = "csr", "cfg";
-			ranges = <0x01000000 0x0 0x00000000 0xd0 0x10000000 0x00 0x00010000   /* io  */
-				  0x02000000 0x0 0x80000000 0xd1 0x80000000 0x00 0x80000000>; /* mem */
+			ranges = <0x01000000 0x00 0x00000000 0xd0 0x10000000 0x00 0x00010000   /* io  */
+				  0x02000000 0x00 0x80000000 0xd1 0x80000000 0x00 0x80000000   /* mem */
+				  0x43000000 0xd8 0x00000000 0xd8 0x00000000 0x08 0x00000000>; /* mem */
 			dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
 				      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
 			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
@@ -454,8 +456,9 @@
 			reg =  < 0x00 0x1f2d0000 0x0 0x00010000   /* Controller registers */
 				 0x90 0xd0000000 0x0 0x00040000>; /* PCI config space */
 			reg-names = "csr", "cfg";
-			ranges = <0x01000000 0x0 0x00000000 0x90 0x10000000 0x0 0x00010000   /* io  */
-				  0x02000000 0x0 0x80000000 0x91 0x80000000 0x0 0x80000000>; /* mem */
+			ranges = <0x01000000 0x00 0x00000000 0x90 0x10000000 0x00 0x00010000   /* io  */
+				  0x02000000 0x00 0x80000000 0x91 0x80000000 0x00 0x80000000   /* mem */
+				  0x43000000 0x94 0x00000000 0x94 0x00000000 0x04 0x00000000>; /* mem */
 			dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
 				      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
 			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
@@ -478,8 +481,9 @@
 			reg = < 0x00 0x1f500000 0x0 0x00010000   /* Controller registers */
 				0xa0 0xd0000000 0x0 0x00040000>; /* PCI config space */
 			reg-names = "csr", "cfg";
-			ranges = <0x01000000 0x0 0x00000000 0xa0 0x10000000 0x0 0x00010000   /* io   */
-				  0x02000000 0x0 0x80000000 0xa1 0x80000000 0x0 0x80000000>; /* mem  */
+			ranges = <0x01000000 0x00 0x00000000 0xa0 0x10000000 0x00 0x00010000   /* io  */
+				  0x02000000 0x00 0x80000000 0xa1 0x80000000 0x00 0x80000000   /* mem */
+				  0x43000000 0xb0 0x00000000 0xb0 0x00000000 0x10 0x00000000>; /* mem */
 			dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
 				      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
 			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
@@ -502,8 +506,9 @@
 			reg = < 0x00 0x1f510000 0x0 0x00010000   /* Controller registers */
 				0xc0 0xd0000000 0x0 0x00200000>; /* PCI config space */
 			reg-names = "csr", "cfg";
-			ranges = <0x01000000 0x0 0x00000000 0xc0 0x10000000 0x0 0x00010000   /* io  */
-				  0x02000000 0x0 0x80000000 0xc1 0x80000000 0x0 0x80000000>; /* mem */
+			ranges = <0x01000000 0x00 0x00000000 0xc0 0x10000000 0x00 0x00010000   /* io  */
+				  0x02000000 0x00 0x80000000 0xc1 0x80000000 0x00 0x80000000   /* mem */
+				  0x43000000 0xc8 0x00000000 0xc8 0x00000000 0x08 0x00000000>; /* mem */
 			dma-ranges = <0x42000000 0x80 0x00000000 0x80 0x00000000 0x00 0x80000000
 				      0x42000000 0x00 0x00000000 0x00 0x00000000 0x80 0x00000000>;
 			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-- 
1.9.1

