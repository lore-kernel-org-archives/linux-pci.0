Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:5134 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752847AbdLMNF6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Dec 2017 08:05:58 -0500
From: Maximilian Heyne <mheyne@amazon.de>
To: linux-pci@vger.kernel.org
Cc: Maximilian Heyne <mheyne@amazon.de>
Subject: [PATCH] pci-stub: enable SR-IOV configuration through sysfs
Date: Wed, 13 Dec 2017 14:05:33 +0100
Message-Id: <1513170333-19102-1-git-send-email-mheyne@amazon.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, SR-IOV VFs can only be configured through sysfs, if a driver
is loaded for the device. Sometimes we don't care about the PF, but only
want to assign VFs to guests, which is now possible with this patch.

Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 drivers/pci/pci-stub.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
index 886fb35..aa007c3 100644
--- a/drivers/pci/pci-stub.c
+++ b/drivers/pci/pci-stub.c
@@ -32,10 +32,27 @@ static int pci_stub_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return 0;
 }
 
+static void pci_stub_remove(struct pci_dev *dev)
+{
+	pci_disable_sriov(dev);
+}
+
+static int pci_stub_sriov_configure(struct pci_dev *dev, int num_vfs)
+{
+	if (!num_vfs) {
+		pci_disable_sriov(dev);
+		return 0;
+	}
+
+	return pci_enable_sriov(dev, num_vfs);
+}
+
 static struct pci_driver stub_driver = {
-	.name		= "pci-stub",
-	.id_table	= NULL,	/* only dynamic id's */
-	.probe		= pci_stub_probe,
+	.name			= "pci-stub",
+	.id_table		= NULL,	/* only dynamic IDs */
+	.probe			= pci_stub_probe,
+	.remove			= pci_stub_remove,
+	.sriov_configure	= pci_stub_sriov_configure,
 };
 
 static int __init pci_stub_init(void)
-- 
2.7.4
