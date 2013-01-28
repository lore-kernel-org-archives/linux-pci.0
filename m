Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58268 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab3A1S5C (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 13:57:02 -0500
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
Subject: [PATCH v2 13/27] arm: plat-orion: introduce WIN_CTRL_ENABLE in address mapping code
Date: Mon, 28 Jan 2013 19:56:22 +0100
Message-Id: <1359399397-29729-14-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of hardcoding "1" as being the bit value to enable an address
decoding window, introduce and use a WIN_CTRL_ENABLE definition.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/addr-map.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-orion/addr-map.c b/arch/arm/plat-orion/addr-map.c
index febe386..4dec3db 100644
--- a/arch/arm/plat-orion/addr-map.c
+++ b/arch/arm/plat-orion/addr-map.c
@@ -38,6 +38,7 @@ EXPORT_SYMBOL_GPL(mv_mbus_dram_info);
  * CPU Address Decode Windows registers
  */
 #define WIN_CTRL_OFF		0x0000
+#define   WIN_CTRL_ENABLE       BIT(0)
 #define WIN_BASE_OFF		0x0004
 #define WIN_REMAP_LO_OFF	0x0008
 #define WIN_REMAP_HI_OFF	0x000c
@@ -79,7 +80,8 @@ void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
 	}
 
 	base_high = base & 0xffff0000;
-	ctrl = ((size - 1) & 0xffff0000) | (attr << 8) | (target << 4) | 1;
+	ctrl = ((size - 1) & 0xffff0000) | (attr << 8) | (target << 4) |
+		WIN_CTRL_ENABLE;
 
 	writel(base_high, addr + WIN_BASE_OFF);
 	writel(ctrl, addr + WIN_CTRL_OFF);
-- 
1.7.9.5

