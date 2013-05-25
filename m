Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:36620 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881Ab3EYLhE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 May 2013 07:37:04 -0400
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: [PATCH 2/3] PCI: converge the unnecessary sprinkling of pcibios_bus_to_resource in __pci_read_base
Date: Sat, 25 May 2013 19:36:26 +0800
Message-ID: <1369481787-21500-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1369481787-21500-1-git-send-email-haokexin@gmail.com>
References: <1369481787-21500-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since we will invoke pcibios_bus_to_resource unconditionally if we
don't goto fail, move it out of if/else wrap. No function change.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Split these changed into a new patch compare with the v1 patch.

 drivers/pci/probe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2505d5e..c57eb27 100644
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
@@ -265,9 +263,10 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 
 		region.start = l;
 		region.end = l + sz;
-		pcibios_bus_to_resource(dev, res, &region);
 	}
 
+	pcibios_bus_to_resource(dev, res, &region);
+
 	goto out;
 
 
-- 
1.8.1.4

