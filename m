Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:38385 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047AbbAGUxP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jan 2015 15:53:15 -0500
From: Sasha Levin <sasha.levin@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Sasha Levin <sasha.levin@oracle.com>, <stable@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Alexander Graf <agraf@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Subject: [PATCH v2] PCI/sysfs: off by two when checking the limit on driver_override length
Date: Wed,  7 Jan 2015 15:52:57 -0500
Message-Id: <1420663977-30707-1-git-send-email-sasha.levin@oracle.com>
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
 drivers/pci/pci-sysfs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index aa012fb..17459ed 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -521,7 +521,8 @@ static ssize_t driver_override_store(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	char *driver_override, *old = pdev->driver_override, *cp;
 
-	if (count > PATH_MAX)
+	/* We need to keep extra room for a newline */
+	if (count >= (PATH_MAX - 1))
 		return -EINVAL;
 
 	driver_override = kstrndup(buf, count, GFP_KERNEL);
-- 
1.7.10.4

