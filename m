Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9993 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdJXGrA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2017 02:47:00 -0400
From: Vidya Sagar <vidyas@nvidia.com>
To: <treding@nvidia.com>, <bhelgaas@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V3 2/2] ARM64: tegra: limit PCIe config space mapping to 4K for T186
Date: Tue, 24 Oct 2017 12:14:49 +0530
Message-ID: <1508827489-10842-3-git-send-email-vidyas@nvidia.com>
In-Reply-To: <1508827489-10842-1-git-send-email-vidyas@nvidia.com>
References: <1508827489-10842-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

reduces PCIe config space mapping size from its current 256MB
to 4K to have only 4K of virtual memory mapping and to be
in line with driver implementation

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* no change in this patch

 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 7c3a2bdd4644..c64550c32d72 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -361,7 +361,7 @@
 		device_type = "pci";
 		reg = <0x0 0x10003000 0x0 0x00000800   /* PADS registers */
 		       0x0 0x10003800 0x0 0x00000800   /* AFI registers */
-		       0x0 0x40000000 0x0 0x10000000>; /* configuration space */
+		       0x0 0x40000000 0x0 0x00001000>; /* configuration space */
 		reg-names = "pads", "afi", "cs";
 
 		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
@@ -379,9 +379,9 @@
 		ranges = <0x82000000 0 0x10000000 0x0 0x10000000 0 0x00001000   /* port 0 configuration space */
 			  0x82000000 0 0x10001000 0x0 0x10001000 0 0x00001000   /* port 1 configuration space */
 			  0x82000000 0 0x10004000 0x0 0x10004000 0 0x00001000   /* port 2 configuration space */
-			  0x81000000 0 0x0        0x0 0x50000000 0 0x00010000   /* downstream I/O (64 KiB) */
-			  0x82000000 0 0x50100000 0x0 0x50100000 0 0x07F00000   /* non-prefetchable memory (127 MiB) */
-			  0xc2000000 0 0x58000000 0x0 0x58000000 0 0x28000000>; /* prefetchable memory (640 MiB) */
+			  0x81000000 0 0x0        0x0 0x40001000 0 0x00010000   /* downstream I/O (64 KiB) */
+			  0x82000000 0 0x40100000 0x0 0x40100000 0 0x07F00000   /* non-prefetchable memory (127 MiB) */
+			  0xc2000000 0 0x48000000 0x0 0x48000000 0 0x38000000>; /* prefetchable memory (896 MiB) */
 
 		clocks = <&bpmp TEGRA186_CLK_AFI>,
 			 <&bpmp TEGRA186_CLK_PCIE>,
-- 
2.7.4
