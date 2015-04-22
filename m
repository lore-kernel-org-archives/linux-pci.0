Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:21334 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038AbbDVNa0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Apr 2015 09:30:26 -0400
From: Zhichang Yuan <yuanzhichang@hisilicon.com>
To: <bhelgaas@google.com>, <grant.likely@linaro.org>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<Liviu.Dudau@arm.com>, Zhichang Yuan <yuanzhichang@hisilicon.com>
Subject: [[PATCH v1]] of/pci: fix a bug in function pci_pio_to_address
Date: Wed, 22 Apr 2015 21:35:59 +0800
Message-ID: <1429709759-79006-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In the patch whose commit id is 41f8bba7f5552d0, function pci_pio_to_address
was introduced to retieve the corresponding I/O port by CPU address. But the
convertion processing is not correct. It will return a wrong I/O port.
This patch will fix it.

Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
---
 drivers/of/address.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 78a7dcb..6906a3f 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -765,7 +765,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
 	spin_lock(&io_range_lock);
 	list_for_each_entry(res, &io_range_list, list) {
 		if (address >= res->start && address < res->start + res->size) {
-			addr = res->start - address + offset;
+			addr = address - res->start + offset;
 			break;
 		}
 		offset += res->size;
-- 
1.9.1

