Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51548 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461AbbDIPvp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Apr 2015 11:51:45 -0400
Subject: [PATCH] PCI: Export pci_probe_reset_function()
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org
Date: Thu, 09 Apr 2015 09:51:43 -0600
Message-ID: <20150409155100.6891.72838.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The equivalent bus and slot versions of this are already exported and
vfio-pci would like a function-probe available so we can expose
function-level reset capabilities to the user without necessarily
using it to perform a reset before enabling the device for the user.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.c   |    1 +
 include/linux/pci.h |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 81f06e8..9f3e691 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3524,6 +3524,7 @@ int pci_probe_reset_function(struct pci_dev *dev)
 {
 	return pci_dev_reset(dev, 1);
 }
+EXPORT_SYMBOL_GPL(pci_probe_reset_function);
 
 /**
  * pci_reset_function - quiesce and reset a PCI device function
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 211e9da..233d1ae 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -986,6 +986,7 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
 int __pci_reset_function(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
+int pci_probe_reset_function(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);

