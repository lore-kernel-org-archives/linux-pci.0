Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 4/7] pciehp: print out link status when dlla get active.
Date: Fri, 27 Jan 2012 10:55:12 -0800
Message-Id: <1327690515-2991-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1327690515-2991-1-git-send-email-yinghai@kernel.org>
References: <1327690515-2991-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use it get timestamp to calculate time for the pci conf access readness.

and let it return bool instead of int.

also remove inline attribute, let compiler decide it.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug/pciehp_hpc.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index ad8c1be..a1a9879 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -241,13 +241,20 @@ static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 	return retval;
 }
 
-static inline int check_link_active(struct controller *ctrl)
+static bool check_link_active(struct controller *ctrl)
 {
-	u16 link_status;
+	bool ret = false;
+	u16 lnk_status;
 
-	if (pciehp_readw(ctrl, PCI_EXP_LNKSTA, &link_status))
-		return 0;
-	return !!(link_status & PCI_EXP_LNKSTA_DLLLA);
+	if (pciehp_readw(ctrl, PCI_EXP_LNKSTA, &lnk_status))
+		return ret;
+
+	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+
+	if (ret)
+		ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
+
+	return ret;
 }
 
 static void pcie_wait_link_active(struct controller *ctrl)
-- 
1.7.7

