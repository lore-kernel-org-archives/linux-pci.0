Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11771 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbdJWOiC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2017 10:38:02 -0400
From: Vidya Sagar <vidyas@nvidia.com>
To: <treding@nvidia.com>, <bhelgaas@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V2 5/7] ARM64: tegra: limit PCIe config space mapping to 4K for T132
Date: Mon, 23 Oct 2017 20:05:10 +0530
Message-ID: <1508769312-12465-6-git-send-email-vidyas@nvidia.com>
In-Reply-To: <1508769312-12465-1-git-send-email-vidyas@nvidia.com>
References: <1508769312-12465-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

reduces PCIe config space mapping size from its current 256MB
to 4K to have only 4K of virtual memory mapping and to be
in line with driver implementation

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* no changes in this patch

 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index c2f0f2743578..2f0ff087112e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -17,7 +17,7 @@
 		device_type = "pci";
 		reg = <0x0 0x01003000 0x0 0x00000800   /* PADS registers */
 		       0x0 0x01003800 0x0 0x00000800   /* AFI registers */
-		       0x0 0x02000000 0x0 0x10000000>; /* configuration space */
+		       0x0 0x11FFF000 0x0 0x00001000>; /* configuration space */
 		reg-names = "pads", "afi", "cs";
 		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
 			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
-- 
2.7.4
