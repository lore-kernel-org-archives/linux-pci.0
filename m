Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:25100 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934430AbbDXI7z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2015 04:59:55 -0400
From: Zhichang Yuan <yuanzhichang@hisilicon.com>
To: <bhelgaas@google.com>, <grant.likely@linaro.org>
CC: <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>,
	<gabriele.paoloni@huawei.com>, <Liviu.Dudau@arm.com>,
	Zhichang Yuan <yuanzhichang@hisilicon.com>
Subject: [PATCH v2] of/pci: fix a bug in function pci_pio_to_address
Date: Fri, 24 Apr 2015 17:05:09 +0800
Message-ID: <1429866309-202444-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In the patch whose commit id is 41f8bba7f5552d0, function pci_pio_to_address
was modified to retieve the corresponding I/O port by CPU physical address.
But the convertion processing is not correct. It will return a wrong I/O port.
This patch will fix it.

Fixes: 41f8bba7f555 ("of/pci: Add pci_register_io_range() and pci_pio_to_address()")
CC: stable@vger.kernel.org
Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
---
changes since V1:
Improved commit message.

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

