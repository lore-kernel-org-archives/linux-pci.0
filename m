Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:48023 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab3A3ELE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 23:11:04 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI: fix build warning in iov.c
Date: Wed, 30 Jan 2013 12:10:38 +0800
Message-ID: <1359519038-25424-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Delete unused variable rc to fix build warning in driver/pci/iov.c

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/iov.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index f8720af..4ea7139 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -33,7 +33,6 @@ static inline u8 virtfn_devfn(struct pci_dev *dev, int id)
 
 static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
 {
-	int rc;
 	struct pci_bus *child;
 
 	if (bus->number == busnr)
-- 
1.7.1


