Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:4596 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbaEDE0l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 4 May 2014 00:26:41 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	<sparclinux@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	<x86@kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 11/13] PCI, acpiphp: Use new pci_is_bridge() to simplify code
Date: Sun, 4 May 2014 12:23:46 +0800
Message-ID: <1399177428-3784-12-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1399177428-3784-1-git-send-email-wangyijing@huawei.com>
References: <1399177428-3784-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we can use new pci_is_bridge() helper function
to simplify code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index bccc27e..f1f9bd1 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -516,8 +516,7 @@ static void __ref enable_slot(struct acpiphp_slot *slot)
 			if (PCI_SLOT(dev->devfn) != slot->device)
 				continue;
 
-			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
+			if (pci_is_bridge(dev)) {
 				max = pci_scan_bridge(bus, dev, max, pass);
 				if (pass && dev->subordinate) {
 					check_hotplug_bridge(slot, dev);
-- 
1.7.1


