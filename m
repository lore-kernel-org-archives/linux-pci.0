Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45905 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933371Ab3BLQ3l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 11:29:41 -0500
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
Subject: [PATCH 19/32] arm: plat-orion: introduce orion_{alloc,free}_cpu_win() functions
Date: Tue, 12 Feb 2013 17:28:53 +0100
Message-Id: <1360686546-24277-20-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In the address decoding code, we implement two new functions:
orion_alloc_cpu_win() and orion_free_cpu_win(). The first function
finds an unused address decoding window, and configures it according
to the given arguments (in terms of base address, size, target,
attributes). The second function frees an address decoding window,
given a physical base address.

Those two new functions will be used by the PCIe code, which needs to
dynamically register address decoding windows depending on the PCIe
devices that are detected.

The orion_free_cpu_win() function is only here to handle error cases
in the PCIe devices initialization, in the normal case, address
decoding windows are never freed.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/addr-map.c              |   75 +++++++++++++++++++++++++++
 arch/arm/plat-orion/include/plat/addr-map.h |    7 +++
 2 files changed, 82 insertions(+)

diff --git a/arch/arm/plat-orion/addr-map.c b/arch/arm/plat-orion/addr-map.c
index a187524..a7bdc21 100644
--- a/arch/arm/plat-orion/addr-map.c
+++ b/arch/arm/plat-orion/addr-map.c
@@ -108,6 +108,81 @@ static void orion_disable_cpu_win(const struct orion_addr_map_cfg *cfg,
 	}
 }
 
+static int orion_window_is_free(const struct orion_addr_map_cfg *cfg,
+				const int win)
+{
+	void __iomem *addr = cfg->win_cfg_base(cfg, win);
+	u32 ctrl = readl(addr + WIN_CTRL_OFF);
+	return !(ctrl & WIN_CTRL_ENABLE);
+}
+
+/*
+ * Find an unused address decoding window, and enable it according to
+ * the arguments passed (base, size, target, attributes, remap).
+ */
+int orion_alloc_cpu_win(const struct orion_addr_map_cfg *cfg,
+			const u32 base, const u32 size,
+			const u8 target, const u8 attr, const u32 remap)
+{
+	int win;
+
+	/*
+	 * If we don't need to remap, try to first allocate a window
+	 * that doesn't have remapping capabilities, since those are
+	 * pretty limited in number.
+	 */
+	if (remap == ORION_ADDR_MAP_NO_REMAP) {
+		for (win = cfg->remappable_wins; win < cfg->num_wins; win++)
+			if (orion_window_is_free(cfg, win))
+				break;
+
+		if (win < cfg->num_wins) {
+			orion_setup_cpu_win(cfg, win, base, size, target, attr, remap);
+			return 0;
+		}
+	}
+
+	/*
+	 * We need a remap window, or we haven't found a non-remap
+	 * capable window.
+	 */
+	for (win = 0; win < cfg->num_wins; win++)
+		if (orion_window_is_free(cfg, win))
+			break;
+
+	if (win < cfg->num_wins) {
+		orion_setup_cpu_win(cfg, win, base, size, target, attr, remap);
+		return 0;
+	}
+
+	/* No window found */
+	return -ENOMEM;
+}
+
+/*
+ * Free an address decoding window, given its base address.
+ */
+int orion_free_cpu_win(const struct orion_addr_map_cfg *cfg,
+		       const u32 base)
+{
+	int win;
+
+	for (win = 0; win < cfg->num_wins; win++) {
+		void __iomem *addr = cfg->win_cfg_base(cfg, win);
+		u32 winbase = readl(addr + WIN_BASE_OFF);
+
+		if (orion_window_is_free(cfg, win))
+			continue;
+
+		if (winbase == (base & 0xffff0000)) {
+			orion_disable_cpu_win(cfg, win);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 /*
  * Configure a number of windows.
  */
diff --git a/arch/arm/plat-orion/include/plat/addr-map.h b/arch/arm/plat-orion/include/plat/addr-map.h
index a5b21a9..fc46878 100644
--- a/arch/arm/plat-orion/include/plat/addr-map.h
+++ b/arch/arm/plat-orion/include/plat/addr-map.h
@@ -51,6 +51,13 @@ void orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
 			 const u32 size, const u8 target,
 			 const u8 attr, const u32 remap);
 
+int orion_alloc_cpu_win(const struct orion_addr_map_cfg *cfg,
+			const u32 base, const u32 size,
+			const u8 target, const u8 attr, const u32 remap);
+
+int orion_free_cpu_win(const struct orion_addr_map_cfg *cfg,
+		       const u32 base);
+
 void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
 					const void __iomem *ddr_window_cpu_base);
 #endif
-- 
1.7.9.5

