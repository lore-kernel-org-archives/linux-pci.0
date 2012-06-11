Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56371 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755592Ab2FKPFk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jun 2012 11:05:40 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v2 10/10] ARM: tegra: trimslice: Initialize PCIe from DT
Date: Mon, 11 Jun 2012 17:05:18 +0200
Message-Id: <1339427118-32263-11-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With the device tree support in place, probe the PCIe controller from
the device tree and remove the corresponding workaround in the board
file.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

---
Changes in v2:
- new patch
---
 arch/arm/boot/dts/tegra-trimslice.dts  |    4 ++++
 arch/arm/mach-tegra/board-dt-tegra20.c |   18 ------------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index 9de5636..fc48f371 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -274,6 +274,10 @@
 		};
 	};
 
+	pci {
+		status = "okay";
+	};
+
 	usb@c5000000 {
 		status = "okay";
 	};
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index c7b6ae2..3a8b825 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -116,21 +116,6 @@ static void __init tegra_dt_init(void)
 				tegra20_auxdata_lookup, NULL);
 }
 
-#ifdef CONFIG_MACH_TRIMSLICE
-static struct tegra_pcie_pdata trimslice_pcie_pdata = {
-	.enable_ports = {
-		[0] = true,
-		[1] = true,
-	},
-};
-
-static void __init trimslice_init(void)
-{
-	tegra_pcie_device.dev.platform_data = &trimslice_pcie_pdata;
-	platform_device_register(&tegra_pcie_device);
-}
-#endif
-
 #ifdef CONFIG_MACH_PAZ00
 static void __init paz00_init(void)
 {
@@ -142,9 +127,6 @@ static struct {
 	char *machine;
 	void (*init)(void);
 } board_init_funcs[] = {
-#ifdef CONFIG_MACH_TRIMSLICE
-	{ "compulab,trimslice", trimslice_init },
-#endif
 #ifdef CONFIG_MACH_PAZ00
 	{ "compal,paz00", paz00_init },
 #endif
-- 
1.7.10.4

