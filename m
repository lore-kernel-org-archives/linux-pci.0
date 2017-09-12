Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36157 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdILLNp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2017 07:13:45 -0400
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] PCI: make pci_dev_type const
Date: Tue, 12 Sep 2017 16:43:33 +0530
Message-Id: <1505214813-9591-1-git-send-email-bhumirks@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make this const as it not modified in the file referencing it. 
It is only stored in a const field 'type' of a device structure. 
Also, add const to the variable declaration in the header file.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/pci/pci-sysfs.c | 2 +-
 drivers/pci/pci.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 1eecfa3..882d6c3 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1788,6 +1788,6 @@ static umode_t sriov_attrs_are_visible(struct kobject *kobj,
 	NULL,
 };
 
-struct device_type pci_dev_type = {
+const struct device_type pci_dev_type = {
 	.groups = pci_dev_attr_groups,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a6560c9..1db36f2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -192,7 +192,7 @@ static inline int pci_no_d1d2(struct pci_dev *dev)
 }
 extern const struct attribute_group *pci_dev_groups[];
 extern const struct attribute_group *pcibus_groups[];
-extern struct device_type pci_dev_type;
+extern const struct device_type pci_dev_type;
 extern const struct attribute_group *pci_bus_groups[];
 
 
-- 
1.9.1
