Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34910 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbbKITAn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2015 14:00:43 -0500
Received: by wmdw130 with SMTP id w130so42294690wmd.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2015 11:00:42 -0800 (PST)
From: Mathias Krause <minipli@googlemail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Mathias Krause <minipli@googlemail.com>,
	Sasha Levin <sasha.levin@oracle.com>,
	Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2] PCI: Prevent out of bounds access in numa_node override - part 2
Date: Mon,  9 Nov 2015 20:00:27 +0100
Message-Id: <1447095627-12798-1-git-send-email-minipli@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 1266963170f5 ("PCI: Prevent out of bounds access in numa_node
override") missed that the user provided node could also be negative.
Handle this case as well to avoid out-of-bounds accesses to the
node_states[] array.  However, allow the special value -1, i.e.
NUMA_NO_NODE, to be able to set the 'no specific node' configuration.

Fixes: 1266963170f5 ("PCI: Prevent out of bounds access in numa_node...")
Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: stable@vger.kernel.org	# v3.19+
---
v2: allow NUMA_NO_NODE

 drivers/pci/pci-sysfs.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 92618686604c..6e9818227b19 100644
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
1.7.10.4

