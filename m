Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:54959 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750754AbaF1JqF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Jun 2014 05:46:05 -0400
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ryan Desfosses <ryan@desfo.org>, linux-pci@vger.kernel.org
Subject: [PATCH 1/1] drivers/pci/hotplug/cpqphp_sysfs.c: remove unnecessary null test before debugfs_remove
Date: Sat, 28 Jun 2014 11:44:43 +0200
Message-Id: <1403948683-10410-1-git-send-email-fabf@skynet.be>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix checkpatch warning:
"WARNING: debugfs_remove(NULL) is safe this check is probably not required"

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ryan Desfosses <ryan@desfo.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/pci/hotplug/cpqphp_sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_sysfs.c b/drivers/pci/hotplug/cpqphp_sysfs.c
index 4a392c4..d81648f 100644
--- a/drivers/pci/hotplug/cpqphp_sysfs.c
+++ b/drivers/pci/hotplug/cpqphp_sysfs.c
@@ -216,8 +216,7 @@ void cpqhp_create_debugfs_files(struct controller *ctrl)
 
 void cpqhp_remove_debugfs_files(struct controller *ctrl)
 {
-	if (ctrl->dentry)
-		debugfs_remove(ctrl->dentry);
+	debugfs_remove(ctrl->dentry);
 	ctrl->dentry = NULL;
 }
 
-- 
1.8.4.5

