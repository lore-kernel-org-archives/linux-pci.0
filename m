Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37558 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbbJDVtn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 4 Oct 2015 17:49:43 -0400
From: Sasha Levin <sasha.levin@oracle.com>
To: bhelgaas@google.com, prarit@redhat.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sasha Levin <sasha.levin@oracle.com>
Subject: [PATCH] PCI: prevent out of bounds access in numa_node override
Date: Sun,  4 Oct 2015 17:49:29 -0400
Message-Id: <1443995369-11399-1-git-send-email-sasha.levin@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 63692df1 ("PCI: Allow numa_node override via sysfs") didn't check that
the numa node provided by userspace is valid. Passing a node number too high
would attempt to access invalid memory and trigger a kernel panic.

Fixes: 63692df1 ("PCI: Allow numa_node override via sysfs")
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 drivers/pci/pci-sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 312f23a..e9abca8 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -216,7 +216,7 @@ static ssize_t numa_node_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (!node_online(node))
+	if (node > MAX_NUMNODES || !node_online(node))
 		return -EINVAL;
 
 	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
-- 
1.7.10.4

