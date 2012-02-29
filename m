Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 32/39] PCI: Strict checking of valid range for bridge
Date: Wed, 29 Feb 2012 15:07:31 -0800
Message-Id: <1330556858-11768-33-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

children bridges busn range should be able to be allocated from parent bus range.

to avoid overlapping between sibling bridges on same bus.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c540022..5c031f0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -801,6 +801,30 @@ reduce_needed_size:
 	return ret;
 }
 
+static int __devinit pci_bridge_check_busn_broken(struct pci_bus *bus,
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
+		 "check if busn %02x-%02x is in busn_res: %pR\n",
+		 secondary, subordinate, &bus->busn_res);
+	ret = allocate_resource(&bus->busn_res, &busn_res,
+			 (subordinate - secondary + 1),
+			 secondary, subordinate,
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

