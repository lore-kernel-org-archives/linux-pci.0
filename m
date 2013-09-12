Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:52908 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348Ab3ILIUo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2013 04:20:44 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/2] PCI: Warn if power_state != PCI_D0 when write MSI message
Date: Thu, 12 Sep 2013 16:20:12 +0800
Message-ID: <1378974012-13364-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we setup MSI, if device power state is not equal to PCI_D0,
system will silently ignore writing MSI message, but pci_enable_msi()
still return 0 which seems setup successfully. So we should warn here
to help diagnose this issue.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index aca7578..25ed59d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -291,6 +291,8 @@ void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	if (entry->dev->current_state != PCI_D0) {
 		/* Don't touch the hardware now */
+		dev_warn(&entry->dev->dev,
+			"current_state != PCI_D0, ignore writing MSI message!\n");
 	} else if (entry->msi_attrib.is_msix) {
 		void __iomem *base;
 		base = entry->mask_base +
-- 
1.7.1


