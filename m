Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19424 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbcHHTOa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Aug 2016 15:14:30 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/3] pcie: Don't search capabilities on removed devices
Date: Mon,  8 Aug 2016 13:14:25 -0600
Message-Id: <1470683667-28418-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch returns immediately if trying to find a pcie capability
on a removed device, as seen with an all 1's completion from config
read. Previously this function would iterate the maximum 480 times to
search for a capability at position 0xffc. There is never a case where
we'd expect all 1's to a successful config read on a capability register,
so this is a safe criteria to check before bailing on the device.

While accessing a removed device shouldn't be fatal, it's doesn't
accomplish anything. Instead, the code was testing completion synthesis
capabilities which is observed to cause distruption to normal operations.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aab9d51..e884608 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -331,7 +331,7 @@ int pci_find_next_ext_capability(struct pci_dev *dev, int start, int cap)
 	if (header == 0)
 		return 0;
 
-	while (ttl-- > 0) {
+	while (ttl-- > 0 && header != -1) {
 		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
 			return pos;
 
-- 
2.7.2

