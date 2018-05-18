Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:39810 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751184AbeERQ5w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 May 2018 12:57:52 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH] PCI: Prevent users from disabling devices in use
Date: Fri, 18 May 2018 10:59:53 -0600
Message-Id: <20180518165953.30848-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch returns busy status if a user tried to alter the enabled
status of a device owned by a driver. There is no good reason to provide
a convenient method to a user for altering the fundamental state of a
pci device out from under a driver using it.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 366d93af051d..7ff3a3dce641 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -287,6 +287,8 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 	/* this can crash the machine when done on the "wrong" device */
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
+	if (pdev->driver)
+		return -EBUSY;
 
 	if (!val) {
 		if (pci_is_enabled(pdev))
-- 
2.13.6
