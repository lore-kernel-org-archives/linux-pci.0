Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45832 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933295Ab3BLQ3a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 11:29:30 -0500
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
Subject: [PATCH 11/32] arm: plat-orion: refactor the orion_disable_wins() function
Date: Tue, 12 Feb 2013 17:28:45 +0100
Message-Id: <1360686546-24277-12-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In the address decoding code, the orion_disable_wins() function is
used at boot time to disable all address decoding windows, before
configuring only the ones that are needed. This allows to make sure
that no configuration is left from the bootloader.

As a preparation for the introduction of address decoding window
allocation/deallocation function, we refactor this function into an
orion_disable_cpu_win() which disables a single window.

The orion_config_wins() function is changed to call
orion_disable_cpu_win() in a loop, to preserve an identical behavior.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/addr-map.c |   35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/arm/plat-orion/addr-map.c b/arch/arm/plat-orion/addr-map.c
index 4dec3db..dd98638 100644
--- a/arch/arm/plat-orion/addr-map.c
+++ b/arch/arm/plat-orion/addr-map.c
@@ -95,6 +95,19 @@ void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
 	}
 }
 
+static void __init orion_disable_cpu_win(const struct orion_addr_map_cfg *cfg,
+					 const int win)
+{
+	void __iomem *addr = cfg->win_cfg_base(cfg, win);
+
+	writel(0, addr + WIN_BASE_OFF);
+	writel(0, addr + WIN_CTRL_OFF);
+	if (cfg->cpu_win_can_remap(cfg, win)) {
+		writel(0, addr + WIN_REMAP_LO_OFF);
+		writel(0, addr + WIN_REMAP_HI_OFF);
+	}
+}
+
 /*
  * Configure a number of windows.
  */
@@ -108,36 +121,22 @@ static void __init orion_setup_cpu_wins(const struct orion_addr_map_cfg * cfg,
 	}
 }
 
-static void __init orion_disable_wins(const struct orion_addr_map_cfg * cfg)
-{
-	void __iomem *addr;
-	int i;
-
-	for (i = 0; i < cfg->num_wins; i++) {
-		addr = cfg->win_cfg_base(cfg, i);
-
-		writel(0, addr + WIN_BASE_OFF);
-		writel(0, addr + WIN_CTRL_OFF);
-		if (cfg->cpu_win_can_remap(cfg, i)) {
-			writel(0, addr + WIN_REMAP_LO_OFF);
-			writel(0, addr + WIN_REMAP_HI_OFF);
-		}
-	}
-}
-
 /*
  * Disable, clear and configure windows.
  */
 void __init orion_config_wins(struct orion_addr_map_cfg * cfg,
 			      const struct orion_addr_map_info *info)
 {
+	int win;
+
 	if (!cfg->cpu_win_can_remap)
 		cfg->cpu_win_can_remap = orion_cpu_win_can_remap;
 
 	if (!cfg->win_cfg_base)
 		cfg->win_cfg_base = orion_win_cfg_base;
 
-	orion_disable_wins(cfg);
+	for (win = 0; win < cfg->num_wins; win++)
+		orion_disable_cpu_win(cfg, win);
 
 	if (info)
 		orion_setup_cpu_wins(cfg, info);
-- 
1.7.9.5

