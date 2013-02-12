Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45824 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933360Ab3BLQ33 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 11:29:29 -0500
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
Subject: [PATCH 10/32] arm: plat-orion: introduce WIN_CTRL_ENABLE in address mapping code
Date: Tue, 12 Feb 2013 17:28:44 +0100
Message-Id: <1360686546-24277-11-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
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

