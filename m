Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17583 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbdI3IRF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Sep 2017 04:17:05 -0400
Date: Sat, 30 Sep 2017 11:16:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] misc: pci_endpoint_test: Avoid triggering a BUG()
Message-ID: <20170930081651.htijnjc6nyibo2uv@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170930081552.rm4tjhxcyegpg3vn@mwanda>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If you call ida_simple_remove(&pci_endpoint_test_ida, id) with a
negative "id" then it triggers an immediate BUG_ON().  Let's not allow
that.

Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index c0d323077ad0..d40a34f594c7 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -597,6 +597,8 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 
 	if (sscanf(misc_device->name, DRV_MODULE_NAME ".%d", &id) != 1)
 		return;
+	if (id < 0)
+		return;
 
 	misc_deregister(&test->miscdev);
 	ida_simple_remove(&pci_endpoint_test_ida, id);
