Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:40358 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab2A0Szh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2012 13:55:37 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Yinghai Lu <yinghai.lu@oracle.com>
Subject: [PATCH 6/7] pciehp: Add Disable/enable link functions
Date: Fri, 27 Jan 2012 10:55:14 -0800
Message-Id: <1327690515-2991-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1327690515-2991-1-git-send-email-yinghai@kernel.org>
References: <1327690515-2991-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Will use it during power off/on slots

Signed-off-by: Yinghai Lu <yinghai.lu@oracle.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index ea54aef..fdab8a6 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -352,6 +352,42 @@ int pciehp_check_link_status(struct controller *ctrl)
 	return retval;
 }
 
+static int __pciehp_link_set(struct controller *ctrl, bool enable)
+{
+	u16 lnk_ctrl;
+	int retval = 0;
+
+	retval = pciehp_readw(ctrl, PCI_EXP_LNKCTL, &lnk_ctrl);
+	if (retval) {
+		ctrl_err(ctrl, "Cannot read LNKCTRL register\n");
+		return retval;
+	}
+
+	if (enable)
+		lnk_ctrl &= ~PCI_EXP_LNKCTL_LD;
+	else
+		lnk_ctrl |= PCI_EXP_LNKCTL_LD;
+
+	retval = pciehp_writew(ctrl, PCI_EXP_LNKCTL, lnk_ctrl);
+	if (retval) {
+		ctrl_err(ctrl, "Cannot write LNKCTRL register\n");
+		return retval;
+	}
+	ctrl_dbg(ctrl, "%s: lnk_ctrl = %x\n", __func__, lnk_ctrl);
+
+	return retval;
+}
+
+static int pciehp_link_enable(struct controller *ctrl)
+{
+	return __pciehp_link_set(ctrl, true);
+}
+
+static int pciehp_link_disable(struct controller *ctrl)
+{
+	return __pciehp_link_set(ctrl, false);
+}
+
 int pciehp_get_attention_status(struct slot *slot, u8 *status)
 {
 	struct controller *ctrl = slot->ctrl;
-- 
1.7.7

