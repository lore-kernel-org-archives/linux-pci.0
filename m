Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:27277 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab3HANFu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 09:05:50 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI/trivial: Fix comment typo for pci_add_cap_save_buffer()
Date: Thu, 1 Aug 2013 21:05:27 +0800
Message-ID: <1375362327-25404-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix trivial comment typo for pci_add_cap_save_buffer().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a599a6b..a8d5fd0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1992,7 +1992,7 @@ static void pci_add_saved_cap(struct pci_dev *pci_dev,
 }
 
 /**
- * pci_add_save_buffer - allocate buffer for saving given capability registers
+ * pci_add_cap_save_buffer - allocate buffer for saving given capability registers
  * @dev: the PCI device
  * @cap: the capability to allocate the buffer for
  * @size: requested size of the buffer
-- 
1.7.1


