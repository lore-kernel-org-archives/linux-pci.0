Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:57347 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab3ENNIB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2013 09:08:01 -0400
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: [PATCH 2/2] PCI: unset the resource if we can't get the correct CPU address
Date: Tue, 14 May 2013 21:07:56 +0800
Message-ID: <1368536876-27307-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1368536876-27307-1-git-send-email-haokexin@gmail.com>
References: <1368536876-27307-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In the current kernel, we just set the CPU address to the bus address
if we can't find the match region for one specific bus address. If BAR
of one pci device is set to address which happens to be a legitimate
CPU address by firmware, the kernel will think this resource is legal
and will not try to reassign later. In cases the CPU address and bus
address isn't equal, the device will not work. So we should check
if we can translate the bus address to CPU address correctly. If not,
we should unset this resource and wish the kernel will reassign it
later.

Since we will invoke pcibios_bus_to_resource unconditionally if we
don't goto fail, move it out of if/else wrap.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/pci/probe.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 70f10fa..c96772f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -250,12 +250,10 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			pci_write_config_dword(dev, pos + 4, 0);
 			region.start = 0;
 			region.end = sz64;
-			pcibios_bus_to_resource(dev, res, &region);
 			bar_disabled = true;
 		} else {
 			region.start = l64;
 			region.end = l64 + sz64;
-			pcibios_bus_to_resource(dev, res, &region);
 		}
 	} else {
 		sz = pci_size(l, sz, mask);
@@ -265,7 +263,12 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 
 		region.start = l;
 		region.end = l + sz;
-		pcibios_bus_to_resource(dev, res, &region);
+	}
+
+	if (!pcibios_bus_to_resource(dev, res, &region)) {
+		res->flags |= IORESOURCE_UNSET;
+		res->end -= res->start;
+		res->start = 0;
 	}
 
 	goto out;
-- 
1.8.1.4

