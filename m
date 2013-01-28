Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58286 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab3A1S5F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 13:57:05 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v2 15/27] arm: plat-orion: introduce orion_{alloc,free}_cpu_win() functions
Date: Mon, 28 Jan 2013 19:56:24 +0100
Message-Id: <1359399397-29729-16-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/plat-orion/addr-map.c              |   50 +++++++++++++++++++++++++++
 arch/arm/plat-orion/include/plat/addr-map.h |    7 ++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm/plat-orion/addr-map.c b/arch/arm/plat-orion/addr-map.c
index dd98638..8f4ef82 100644
--- a/arch/arm/plat-orion/addr-map.c
+++ b/arch/arm/plat-orion/addr-map.c
@@ -109,6 +109,56 @@ static void __init orion_disable_cpu_win(const struct orion_addr_map_cfg *cfg,
 }
 
 /*
+ * Find an unused address decoding window, and enable it according to
+ * the arguments passed (base, size, target, attributes, remap).
+ */
+int __init orion_alloc_cpu_win(const struct orion_addr_map_cfg *cfg,
+			       const u32 base, const u32 size,
+			       const u8 target, const u8 attr, const int remap)
+{
+	int win;
+
+	for (win = 0; win < cfg->num_wins; win++) {
+		void __iomem *addr = cfg->win_cfg_base(cfg, win);
+		u32 ctrl = readl(addr + WIN_CTRL_OFF);
+		if (!(ctrl & WIN_CTRL_ENABLE))
+			break;
+	}
+
+	/* No more windows available */
+	if (win == cfg->num_wins)
+		return -ENOMEM;
+
+	orion_setup_cpu_win(cfg, win, base, size, target, attr, remap);
+	return 0;
+}
+
+/*
+ * Free an address decoding window, given its base address.
+ */
+int __init orion_free_cpu_win(const struct orion_addr_map_cfg *cfg,
+			      const u32 base)
+{
+	int win;
+
+	for (win = 0; win < cfg->num_wins; win++) {
+		void __iomem *addr = cfg->win_cfg_base(cfg, win);
+		u32 winbase = readl(addr + WIN_BASE_OFF);
+		u32 ctrl = readl(addr + WIN_CTRL_OFF);
+
+		if (!(ctrl & WIN_CTRL_ENABLE))
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
+/*
  * Configure a number of windows.
  */
 static void __init orion_setup_cpu_wins(const struct orion_addr_map_cfg * cfg,
diff --git a/arch/arm/plat-orion/include/plat/addr-map.h b/arch/arm/plat-orion/include/plat/addr-map.h
index b76c065..f8bb539 100644
--- a/arch/arm/plat-orion/include/plat/addr-map.h
+++ b/arch/arm/plat-orion/include/plat/addr-map.h
@@ -49,6 +49,13 @@ void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
 				const u32 size, const u8 target,
 				const u8 attr, const int remap);
 
+int __init orion_alloc_cpu_win(const struct orion_addr_map_cfg *cfg,
+			       const u32 base, const u32 size,
+			       const u8 target, const u8 attr, const int remap);
+
+int __init orion_free_cpu_win(const struct orion_addr_map_cfg *cfg,
+			      const u32 base);
+
 void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
 					const void __iomem *ddr_window_cpu_base);
 #endif
-- 
1.7.9.5

