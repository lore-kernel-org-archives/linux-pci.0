Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36193 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbbKHRYh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Nov 2015 12:24:37 -0500
Received: by wmww144 with SMTP id w144so59756155wmw.1
        for <linux-pci@vger.kernel.org>; Sun, 08 Nov 2015 09:24:36 -0800 (PST)
From: Mathias Krause <minipli@googlemail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Mathias Krause <minipli@googlemail.com>,
	Sasha Levin <sasha.levin@oracle.com>,
	Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] PCI: Prevent out of bounds access in numa_node override - part 2
Date: Sun,  8 Nov 2015 18:24:04 +0100
Message-Id: <1447003444-27108-1-git-send-email-minipli@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 1266963170f5 ("PCI: Prevent out of bounds access in numa_node
override") missed that the user provided node could also be negative.
Handle this case as well to really avoid out-of-bounds accesses to
the node_states[] array.

Fixes: 1266963170f5 ("PCI: Prevent out of bounds access in numa_node...")
Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Prarit Bhargava <prarit@redhat.com>
CC: stable@vger.kernel.org	# v3.19+
---
 drivers/pci/pci-sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 92618686604c..87835d50b927 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -216,7 +216,7 @@ static ssize_t numa_node_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (node >= MAX_NUMNODES || !node_online(node))
+	if (node < 0 || node >= MAX_NUMNODES || !node_online(node))
 		return -EINVAL;
 
 	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
-- 
1.7.10.4

