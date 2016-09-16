Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46763 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965392AbcIPUGu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2016 16:06:50 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        cov@codeaurora.org, alex.williamson@redhat.com,
        vikrams@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/5] PCI: save and restore bus on parent bus reset
Date: Fri, 16 Sep 2016 16:06:32 -0400
Message-Id: <1474056395-21843-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1474056395-21843-1-git-send-email-okaya@codeaurora.org>
References: <1474056395-21843-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Device states on the bus are saved and restored for all bus resets except
the one initiated through pci_dev_reset. Filling the hole.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aab9d51..8aecab1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -51,6 +51,10 @@ static void pci_pme_list_scan(struct work_struct *work);
 static LIST_HEAD(pci_pme_list);
 static DEFINE_MUTEX(pci_pme_list_mutex);
 static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
+static void pci_dev_lock(struct pci_dev *dev);
+static void pci_dev_unlock(struct pci_dev *dev);
+static void pci_bus_save_and_disable(struct pci_bus *bus);
+static void pci_bus_restore(struct pci_bus *bus);
 
 struct pci_pme_device {
 	struct list_head list;
@@ -3888,8 +3892,18 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 	if (probe)
 		return 0;
 
+	if (!probe) {
+		pci_dev_unlock(dev);
+		pci_bus_save_and_disable(dev->bus);
+	}
+
 	pci_reset_bridge_secondary_bus(dev->bus->self);
 
+	if (!probe) {
+		pci_bus_restore(dev->bus);
+		pci_dev_lock(dev);
+	}
+
 	return 0;
 }
 
-- 
1.9.1

