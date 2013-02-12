Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45887 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933369Ab3BLQ3i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 11:29:38 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: [PATCH 17/32] arm: plat-orion: convert 'int remap' to 'u32 remap'
Date: Tue, 12 Feb 2013 17:28:51 +0100
Message-Id: <1360686546-24277-18-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we have ORION_ADDR_MAP_NO_REMAP in place, we can easily
convert the 'int remap' field to a 'u32 remap' field, and accept any
remapping address, except the magical ORION_ADDR_MAP_NO_REMAP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/addr-map.c              |    4 ++--
 arch/arm/plat-orion/include/plat/addr-map.h |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-orion/addr-map.c b/arch/arm/plat-orion/addr-map.c
index dd98638..b1d4806 100644
--- a/arch/arm/plat-orion/addr-map.c
+++ b/arch/arm/plat-orion/addr-map.c
@@ -69,7 +69,7 @@ static int __init orion_cpu_win_can_remap(const struct orion_addr_map_cfg *cfg,
 void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
 				const int win, const u32 base,
 				const u32 size, const u8 target,
-				const u8 attr, const int remap)
+				const u8 attr, const u32 remap)
 {
 	void __iomem *addr = cfg->win_cfg_base(cfg, win);
 	u32 ctrl, base_high, remap_addr;
@@ -86,7 +86,7 @@ void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
 	writel(base_high, addr + WIN_BASE_OFF);
 	writel(ctrl, addr + WIN_CTRL_OFF);
 	if (cfg->cpu_win_can_remap(cfg, win)) {
-		if (remap < 0)
+		if (remap == ORION_ADDR_MAP_NO_REMAP)
 			remap_addr = base;
 		else
 			remap_addr = remap;
diff --git a/arch/arm/plat-orion/include/plat/addr-map.h b/arch/arm/plat-orion/include/plat/addr-map.h
index 0861b8c..6533c47 100644
--- a/arch/arm/plat-orion/include/plat/addr-map.h
+++ b/arch/arm/plat-orion/include/plat/addr-map.h
@@ -38,10 +38,10 @@ struct orion_addr_map_info {
 	const u32 size;
 	const u8 target;
 	const u8 attr;
-	const int remap;
+	const u32 remap;
 };
 
-#define ORION_ADDR_MAP_NO_REMAP (-1)
+#define ORION_ADDR_MAP_NO_REMAP (0xFFFFFFFF)
 
 void __init orion_config_wins(struct orion_addr_map_cfg *cfg,
 			      const struct orion_addr_map_info *info);
@@ -49,7 +49,7 @@ void __init orion_config_wins(struct orion_addr_map_cfg *cfg,
 void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
 				const int win, const u32 base,
 				const u32 size, const u8 target,
-				const u8 attr, const int remap);
+				const u8 attr, const u32 remap);
 
 void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
 					const void __iomem *ddr_window_cpu_base);
-- 
1.7.9.5

