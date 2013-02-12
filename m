Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45894 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933365Ab3BLQ3j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 11:29:39 -0500
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
Subject: [PATCH 18/32] arm: plat-orion: remove __init from addr-map functions needed after boot time
Date: Tue, 12 Feb 2013 17:28:52 +0100
Message-Id: <1360686546-24277-19-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The I/O and memory windows of PCIe interfaces will now be configurable
dynamically, while the system runs, so we need to keep some the
plat-orion/addr-map.c functions around even after the system
initialization has completed.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/addr-map.c              |   18 +++++++++---------
 arch/arm/plat-orion/include/plat/addr-map.h |    8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-orion/addr-map.c b/arch/arm/plat-orion/addr-map.c
index b1d4806..a187524 100644
--- a/arch/arm/plat-orion/addr-map.c
+++ b/arch/arm/plat-orion/addr-map.c
@@ -48,7 +48,7 @@ EXPORT_SYMBOL_GPL(mv_mbus_dram_info);
 /*
  * Default implementation
  */
-static void __init __iomem *
+static void __iomem *
 orion_win_cfg_base(const struct orion_addr_map_cfg *cfg, int win)
 {
 	return cfg->bridge_virt_base + (win << 4);
@@ -57,8 +57,8 @@ orion_win_cfg_base(const struct orion_addr_map_cfg *cfg, int win)
 /*
  * Default implementation
  */
-static int __init orion_cpu_win_can_remap(const struct orion_addr_map_cfg *cfg,
-					  const int win)
+static int orion_cpu_win_can_remap(const struct orion_addr_map_cfg *cfg,
+				   const int win)
 {
 	if (win < cfg->remappable_wins)
 		return 1;
@@ -66,10 +66,10 @@ static int __init orion_cpu_win_can_remap(const struct orion_addr_map_cfg *cfg,
 	return 0;
 }
 
-void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
-				const int win, const u32 base,
-				const u32 size, const u8 target,
-				const u8 attr, const u32 remap)
+void orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
+			 const int win, const u32 base,
+			 const u32 size, const u8 target,
+			 const u8 attr, const u32 remap)
 {
 	void __iomem *addr = cfg->win_cfg_base(cfg, win);
 	u32 ctrl, base_high, remap_addr;
@@ -95,8 +95,8 @@ void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
 	}
 }
 
-static void __init orion_disable_cpu_win(const struct orion_addr_map_cfg *cfg,
-					 const int win)
+static void orion_disable_cpu_win(const struct orion_addr_map_cfg *cfg,
+				  const int win)
 {
 	void __iomem *addr = cfg->win_cfg_base(cfg, win);
 
diff --git a/arch/arm/plat-orion/include/plat/addr-map.h b/arch/arm/plat-orion/include/plat/addr-map.h
index 6533c47..a5b21a9 100644
--- a/arch/arm/plat-orion/include/plat/addr-map.h
+++ b/arch/arm/plat-orion/include/plat/addr-map.h
@@ -46,10 +46,10 @@ struct orion_addr_map_info {
 void __init orion_config_wins(struct orion_addr_map_cfg *cfg,
 			      const struct orion_addr_map_info *info);
 
-void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
-				const int win, const u32 base,
-				const u32 size, const u8 target,
-				const u8 attr, const u32 remap);
+void orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
+			 const int win, const u32 base,
+			 const u32 size, const u8 target,
+			 const u8 attr, const u32 remap);
 
 void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
 					const void __iomem *ddr_window_cpu_base);
-- 
1.7.9.5

