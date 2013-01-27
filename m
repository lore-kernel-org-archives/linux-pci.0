Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:38238 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab3A0TYQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 14:24:16 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 07/22] PCI: Kill pci_find_next_bus in pci_sysfs
Date: Sun, 27 Jan 2013 11:23:34 -0800
Message-Id: <1359314629-18651-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace that with hotplug-safe version for iteration.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci-sysfs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9c6e9bb..6f41daf 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -289,15 +289,15 @@ static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
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
1.7.10.4

