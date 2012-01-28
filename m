Return-Path: <linux-arch-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 10/13] PCI: Strict checking of valid range for bridge
Date: Fri, 27 Jan 2012 18:49:28 -0800
Message-Id: <1327718971-9598-11-git-send-email-yinghai@kernel.org>
In-Reply-To: <1327718971-9598-1-git-send-email-yinghai@kernel.org>
References: <1327718971-9598-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

children bridges busn range should be able to be allocated from parent bus range.

to avoid overlapping between sibling bridges on same bus.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 83df3fb..e12f65f0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -791,6 +791,33 @@ reduce_needed_size:
 	return ret;
 }
 
+static int __devinit pci_bridge_check_busn_res(struct pci_bus *bus,
+				struct pci_dev *dev,
+				int secondary, int subordinate)
+{
+	int broken = 0;
+
+	struct resource busn_res;
+	int ret;
+
+	memset(&busn_res, 0, sizeof(struct resource));
+	dev_printk(KERN_DEBUG, &dev->dev,
+		 "check if busn %02x-%02x is in busn_res: %06llx-%06llx\n",
+		 secondary, subordinate,
+		 (unsigned long long)bus->busn_res.start,
+		 (unsigned long long)bus->busn_res.end);
+	ret = allocate_resource(&bus->busn_res, &busn_res,
+			 (subordinate - secondary + 1),
+			 (pci_domain_nr(bus)<<8) | secondary,
+			 (pci_domain_nr(bus)<<8) | subordinate,
+			 1, NULL, NULL);
+	if (ret)
+		broken = 1;
+	else
+		release_resource(&busn_res);
+
+	return broken;
+}
 /*
  * If it's a bridge, configure it and scan the bus behind it.
  * For CardBus bridges, we don't scan behind as the devices will
-- 
1.7.7

