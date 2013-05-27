Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Libo Chen <libo.chen@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lizefan@huawei.com>, <libo.chen@huawei.com>,
	<gregkh@linuxfoundation.org>
Subject: [PATCH 09/24] drivers/pci/ioapic: Convert to module_pci_driver
Date: Mon, 27 May 2013 10:28:53 +0800
Message-ID: <1369621733-20048-1-git-send-email-libo.chen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

use module_pci_driver instead of init/exit, make code clean.

Signed-off-by: Libo Chen <libo.chen@huawei.com>
---
 drivers/pci/ioapic.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/ioapic.c b/drivers/pci/ioapic.c
index 3c6bbdd..1b90579 100644
--- a/drivers/pci/ioapic.c
+++ b/drivers/pci/ioapic.c
@@ -113,17 +113,6 @@ static struct pci_driver ioapic_driver = {
 	.remove		= ioapic_remove,
 };
 
-static int __init ioapic_init(void)
-{
-	return pci_register_driver(&ioapic_driver);
-}
-
-static void __exit ioapic_exit(void)
-{
-	pci_unregister_driver(&ioapic_driver);
-}
-
-module_init(ioapic_init);
-module_exit(ioapic_exit);
+module_pci_driver(ioapic_driver);
 
 MODULE_LICENSE("GPL");
-- 
1.7.1


