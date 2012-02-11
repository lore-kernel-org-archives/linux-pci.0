Return-Path: <linux-arch-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 22/22] PCI: clean up rescan_bus_bridge_resize
Date: Fri, 10 Feb 2012 20:06:25 -0800
Message-Id: <1328933185-15154-23-git-send-email-yinghai@kernel.org>
In-Reply-To: <1328933185-15154-1-git-send-email-yinghai@kernel.org>
References: <1328933185-15154-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Should only use it with bridge instead of bus.
it could get new subordinate. so can not use it with reguar bus.

in that case, use may need to make all children devices get removed already.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci-sysfs.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 68caf29..a3fa64e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -337,7 +337,7 @@ dev_bridge_rescan_store(struct device *dev, struct device_attribute *attr,
 
 	if (val) {
 		mutex_lock(&pci_remove_rescan_mutex);
-		pci_rescan_bus(pdev->subordinate);
+		pci_rescan_bus_bridge_resize(pdev);
 		mutex_unlock(&pci_remove_rescan_mutex);
 	}
 	return count;
@@ -387,10 +387,7 @@ dev_bus_rescan_store(struct device *dev, struct device_attribute *attr,
 
 	if (val) {
 		mutex_lock(&pci_remove_rescan_mutex);
-		if (!pci_is_root_bus(bus) && list_empty(&bus->devices))
-			pci_rescan_bus_bridge_resize(bus->self);
-		else
-			pci_rescan_bus(bus);
+		pci_rescan_bus(bus);
 		mutex_unlock(&pci_remove_rescan_mutex);
 	}
 	return count;
-- 
1.7.7

