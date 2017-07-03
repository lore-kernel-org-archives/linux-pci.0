Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:43789 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753881AbdGCLJt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2017 07:09:49 -0400
Date: Mon, 3 Jul 2017 14:09:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: fix pci_try_reset_function()
Message-ID: <20170701135323.x5vaj4e2wcs2mcro@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is a reversed if condition so the function doesn't work.

Fixes: e94fae7aeef4 ("PCI: Protect pci_error_handlers->reset_notify() usage with device_lock()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5b49d662f996..3bf28bf04c3d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4269,7 +4269,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 	if (rc)
 		return rc;
 
-	if (pci_dev_trylock(dev))
+	if (!pci_dev_trylock(dev))
 		return -EAGAIN;
 
 	pci_dev_save_and_disable(dev);
