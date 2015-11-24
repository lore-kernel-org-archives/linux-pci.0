Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56506 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685AbbKXPIK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Nov 2015 10:08:10 -0500
From: Prarit Bhargava <prarit@redhat.com>
To: linux-pci@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>,
	Sasha Levin <sasha.levin@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
Subject: [PATCH] PCI: Fix NUMA bounds check
Date: Tue, 24 Nov 2015 10:08:05 -0500
Message-Id: <1448377685-7515-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Suggested here: http://marc.info/?l=linux-pci&m=144706760307247&w=2

P.

-----8<-----
The fix for 1266963 ("PCI: Prevent out of bounds access in numa_node
override") should allow for the setting of all valid NUMA states including
NUMA_NO_NODE, which is also interpreted as "any node".  This change splits
the test into a range check, and then a separate check to see if the node
is online.

Fixes: 1266963 ("PCI: Prevent out of bounds access in numa_node override")
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/pci/pci-sysfs.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9261868..6e98182 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -216,7 +216,10 @@ static ssize_t numa_node_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (node >= MAX_NUMNODES || !node_online(node))
+	if (node < NUMA_NO_NODE || node >= MAX_NUMNODES)
+		return -EINVAL;
+
+	if (node != NUMA_NO_NODE && !node_online(node))
 		return -EINVAL;
 
 	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
-- 
1.7.9.3

