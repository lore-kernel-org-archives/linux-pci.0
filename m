Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34125 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbdH3OZM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2017 10:25:12 -0400
From: Jan Glauber <jglauber@cavium.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-kernel@vger.kernel.org, david.daney@cavium.com,
        Jon Masters <jcm@redhat.com>,
        Robert Richter <robert.richter@cavium.com>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v3 3/3] PCI: Avoid slot reset for Cavium cn8xxx root ports
Date: Wed, 30 Aug 2017 16:24:54 +0200
Message-Id: <20170830142454.10971-4-jglauber@cavium.com>
In-Reply-To: <20170830142454.10971-1-jglauber@cavium.com>
References: <20170830142454.10971-1-jglauber@cavium.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Root ports of cn8xxx do not function after a slot reset when used with
some e1000e and LSI HBA devices. Add a quirk to prevent slot reset on
these root ports.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/pci/quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 85191b8..6679971 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -845,6 +845,22 @@ static void quirk_cavium_sriov_rnm_link(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xa018, quirk_cavium_sriov_rnm_link);
 #endif
 
+/*
+ * Root port on some Cavium CN8xxx chips do not successfully complete
+ * a bus reset when used with certain types of child devices. Config
+ * space access to the child may quit responding. Flag all devices under
+ * the secondary bus as non-resettable.
+ */
+static void quirk_CN8xxx_secondary_bus(struct pci_dev *dev)
+{
+	struct pci_dev *pdev;
+
+	dev_warn(&dev->dev, "Cavium CN8xxx quirk detected; reset for devices on secondary bus disabled\n");
+	list_for_each_entry(pdev, &dev->subordinate->devices, bus_list)
+		pdev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_CN8xxx_secondary_bus);
+
 /*
  * Some settings of MMRBC can lead to data corruption so block changes.
  * See AMD 8131 HyperTransport PCI-X Tunnel Revision Guide
-- 
2.9.0.rc0.21.g7777322
