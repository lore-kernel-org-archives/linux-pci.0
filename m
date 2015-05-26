Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36847 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbbEZRyD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 May 2015 13:54:03 -0400
Subject: [PATCH 1/2] PCI: Move pci_ari_enabled() to global header
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, lenb@kernel.org
Date: Tue, 26 May 2015 11:54:02 -0600
Message-ID: <20150526175401.31963.23112.stgit@gimli.home>
In-Reply-To: <20150526174611.31963.91186.stgit@gimli.home>
References: <20150526174611.31963.91186.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is useful outside of drivers/pci, particularly for deriving INTx
routing via ACPI _PRT.  Also convert to bool return.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.h   |   11 -----------
 include/linux/pci.h |   11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9bd762c2..c1b2a43 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -216,17 +216,6 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *fail_head);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
 
-/**
- * pci_ari_enabled - query ARI forwarding status
- * @bus: the PCI bus
- *
- * Returns 1 if ARI forwarding is enabled, or 0 if not enabled;
- */
-static inline int pci_ari_enabled(struct pci_bus *bus)
-{
-	return bus->self && bus->self->ari_enabled;
-}
-
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 353db8d..2925561 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1905,4 +1905,15 @@ static inline bool pci_is_dev_assigned(struct pci_dev *pdev)
 {
 	return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) == PCI_DEV_FLAGS_ASSIGNED;
 }
+
+/**
+ * pci_ari_enabled - query ARI forwarding status
+ * @bus: the PCI bus
+ *
+ * Returns true if ARI forwarding is enabled.
+ */
+static inline bool pci_ari_enabled(struct pci_bus *bus)
+{
+	return bus->self && bus->self->ari_enabled;
+}
 #endif /* LINUX_PCI_H */

