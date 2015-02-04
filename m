Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:27053 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbbBDAyN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Feb 2015 19:54:13 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	"3.12+" <stable@vger.kernel.org>
Subject: [PATCH] PCI: disable auto realloc detection for lsi devices
Date: Tue,  3 Feb 2015 16:54:06 -0800
Message-Id: <1423011246-14429-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

LSI cards do not work if pci core change pci bar vaules.
will need to disable/enable pcie link of bridge manually.

So disable auto realloc if there is any lsi device on that pci root
bus.

If BIOS is broken, solution would be booting pci=realloc and
1. check with lsi to get new hba firmware to handle BAR changing.
2. or disable/enable pcie link manually to get firmare reset.

Need to backport to kernel before 3.12 as this one can not be
applied directly.

Reported-by: Paul Johnson <pjay@nwtrail.com>
Tested-by: Paul Johnson <pjay@nwtrail.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=92351
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: 3.12+ <stable@vger.kernel.org> # 3.12+

---
 drivers/pci/setup-bus.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -1548,14 +1548,31 @@ static int iov_resources_unassigned(stru
 	return 0;
 }
 
+static int strange_dev_check(struct pci_dev *dev, void *data)
+{
+	bool *found = data;
+
+	/* LSI device firmware is not happy with changing BAR value */
+	if (dev->vendor == PCI_VENDOR_ID_LSI_LOGIC) {
+		*found = true;
+		return 1; /* return early from pci_walk_bus() */
+	}
+
+	return 0;
+}
 static enum enable_type pci_realloc_detect(struct pci_bus *bus,
 			 enum enable_type enable_local)
 {
 	bool unassigned = false;
+	bool found = false;
 
 	if (enable_local != undefined)
 		return enable_local;
 
+	pci_walk_bus(bus, strange_dev_check, &found);
+	if (found)
+		return enable_local;
+
 	pci_walk_bus(bus, iov_resources_unassigned, &unassigned);
 	if (unassigned)
 		return auto_enabled;
