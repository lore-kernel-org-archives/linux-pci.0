Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43246 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbdFIJDu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2017 05:03:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 03/11] PCI: pci-driver: convert to use DRIVER_ATTR_WO
Date: Fri,  9 Jun 2017 11:03:06 +0200
Message-Id: <20170609090314.13991-3-gregkh@linuxfoundation.org>
In-Reply-To: <20170609090314.13991-1-gregkh@linuxfoundation.org>
References: <20170609090314.13991-1-gregkh@linuxfoundation.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We are trying to get rid of DRIVER_ATTR(), and all of the pci-driver
core driver attributes can be trivially changed to use DRIVER_ATTR_WO().

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-pci@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci-driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 192e7b681b96..934a78a2fbef 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -96,7 +96,7 @@ static void pci_free_dynids(struct pci_driver *drv)
  *
  * Allow PCI IDs to be added to an existing driver via sysfs.
  */
-static ssize_t store_new_id(struct device_driver *driver, const char *buf,
+static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 			    size_t count)
 {
 	struct pci_driver *pdrv = to_pci_driver(driver);
@@ -154,7 +154,7 @@ static ssize_t store_new_id(struct device_driver *driver, const char *buf,
 		return retval;
 	return count;
 }
-static DRIVER_ATTR(new_id, S_IWUSR, NULL, store_new_id);
+static DRIVER_ATTR_WO(new_id);
 
 /**
  * store_remove_id - remove a PCI device ID from this driver
@@ -164,7 +164,7 @@ static DRIVER_ATTR(new_id, S_IWUSR, NULL, store_new_id);
  *
  * Removes a dynamic pci device ID to this driver.
  */
-static ssize_t store_remove_id(struct device_driver *driver, const char *buf,
+static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
 			       size_t count)
 {
 	struct pci_dynid *dynid, *n;
@@ -198,7 +198,7 @@ static ssize_t store_remove_id(struct device_driver *driver, const char *buf,
 
 	return retval;
 }
-static DRIVER_ATTR(remove_id, S_IWUSR, NULL, store_remove_id);
+static DRIVER_ATTR_WO(remove_id);
 
 static struct attribute *pci_drv_attrs[] = {
 	&driver_attr_new_id.attr,
-- 
2.13.1
