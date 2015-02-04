Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:41782 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964917AbbBDWim (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Feb 2015 17:38:42 -0500
From: Sasha Levin <sasha.levin@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Sasha Levin <sasha.levin@oracle.com>, <stable@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Alexander Graf <agraf@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Subject: [PATCH v3] PCI/sysfs: off by two when checking the limit on driver_override length
Date: Wed,  4 Feb 2015 17:38:15 -0500
Message-Id: <1423089495-5647-1-git-send-email-sasha.levin@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When printing the driver_override parameter when it is 4095 and 4094 bytes
long the printing code would access invalid memory because we need count+1
bytes for printing.

Cc: <stable@vger.kernel.org> # v3.16+
Fixes: 782a985d ("PCI: Introduce new device binding path using pci_dev.driver_override")
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 drivers/pci/pci-sysfs.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index aa012fb..312f23a 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -521,7 +521,8 @@ static ssize_t driver_override_store(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	char *driver_override, *old = pdev->driver_override, *cp;
 
-	if (count > PATH_MAX)
+	/* We need to keep extra room for a newline */
+	if (count >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
 	driver_override = kstrndup(buf, count, GFP_KERNEL);
@@ -549,7 +550,7 @@ static ssize_t driver_override_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%s\n", pdev->driver_override);
+	return snprintf(buf, PAGE_SIZE, "%s\n", pdev->driver_override);
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
1.7.10.4

