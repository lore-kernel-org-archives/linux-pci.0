Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33067 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752121AbaDRMUE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Apr 2014 08:20:04 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>
Subject: [PATCH 5/7] bus: mvebu-mbus: Avoid setting an undefined window size
Date: Fri, 18 Apr 2014 14:19:51 +0200
Message-Id: <1397823593-1932-6-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

The mbus hardware requires a power of two size, and size aligned base.
Currently, if a non-power of two is passed in to the low level routines
they configure the register in a way that results in undefined behaviour.

Call WARN and return EINVAL instead.

Also, update the debugfs routines to show a message if there is an
invalid register setting.

All together this makes the recent problems with silent failure
of PCI very obvious, noisy and debuggable.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 293e2e0..afee0f7 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -56,6 +56,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/debugfs.h>
+#include <linux/log2.h>
 
 /*
  * DDR target is the same on all platforms.
@@ -266,6 +267,17 @@ static int mvebu_mbus_setup_window(struct mvebu_mbus_state *mbus,
 		mbus->soc->win_cfg_offset(win);
 	u32 ctrl, remap_addr;
 
+	if (!is_power_of_2(size)) {
+		WARN(true, "Invalid MBus window size: 0x%zx\n", size);
+		return -EINVAL;
+	}
+
+	if ((base & (phys_addr_t)(size - 1)) != 0) {
+		WARN(true, "Invalid MBus base/size: %pa len 0x%zx\n", &base,
+		     size);
+		return -EINVAL;
+	}
+
 	ctrl = ((size - 1) & WIN_CTRL_SIZE_MASK) |
 		(attr << WIN_CTRL_ATTR_SHIFT)    |
 		(target << WIN_CTRL_TGT_SHIFT)   |
@@ -413,6 +425,10 @@ static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 			   win, (unsigned long long)wbase,
 			   (unsigned long long)(wbase + wsize), wtarget, wattr);
 
+		if (!is_power_of_2(wsize) ||
+		    ((wbase & (u64)(wsize - 1)) != 0))
+			seq_puts(seq, " (Invalid base/size!!)");
+
 		if (win < mbus->soc->num_remappable_wins) {
 			seq_printf(seq, " (remap %016llx)\n",
 				   (unsigned long long)wremap);
-- 
1.9.2

