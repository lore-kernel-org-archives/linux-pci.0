Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:42807 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab2IYI0p (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:45 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 14/29] PCI: kill pci_find_next_bus in pci_sysfs
Date: Tue, 25 Sep 2012 01:26:15 -0700
Message-Id: <1348561590-28067-15-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci-sysfs.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 02d107b..2631851 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -290,15 +290,15 @@ static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
 				size_t count)
 {
 	unsigned long val;
-	struct pci_bus *b = NULL;
+	struct pci_host_bridge *host_bridge = NULL;
 
 	if (strict_strtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
 	if (val) {
 		mutex_lock(&pci_remove_rescan_mutex);
-		while ((b = pci_find_next_bus(b)) != NULL)
-			pci_rescan_bus(b);
+		for_each_pci_host_bridge(host_bridge)
+			pci_rescan_bus(host_bridge->bus);
 		mutex_unlock(&pci_remove_rescan_mutex);
 	}
 	return count;
-- 
1.7.7

