Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A2AC32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 20:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8322083D
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 20:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8322083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeKGFji (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:39:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:7263 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeKGFji (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 00:39:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 12:12:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="103944916"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.46])
  by fmsmga004.fm.intel.com with ESMTP; 06 Nov 2018 12:12:43 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2] PCI: Configure MPS on rescan
Date:   Tue,  6 Nov 2018 13:12:42 -0700
Message-Id: <20181106201242.2862-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During pci_rescan_bus(), we may encounter new buses and devices which
don't have MPS set for compatibility. Using this path, newly discovered
buses and devices would then require their MPS to be configured after
driver attachment, which may be too late for drivers which do memory
transactions on probe.

This additionally ensures that any pcie_bus_config kernel settings will
be applied to the buses and devices discovered through this path prior
to driver attachment.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
v1: https://patchwork.kernel.org/patch/10642019/

 drivers/pci/probe.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b1c05b5054a0..126cd426b6f2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3156,6 +3156,34 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 	return max;
 }
 
+/*
+ * Walks the PCI/PCIe tree to find the first instance of a PCIe device and
+ * hands off the PCIe bus to pcie_bus_configure_settings to walk the rest.
+ */
+static int pcie_rescan_bus_configure_settings(struct pci_dev *dev, void *data)
+{
+	if (pci_is_pcie(dev)) {
+		struct pci_bus *child, *bus = dev->bus;
+
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
+
+		return 1;
+	}
+	return 0;
+}
+
+/**
+ * pci_bus_configure_settings - Configure bus settings
+ * @bus: PCI/PCIE bus to configure
+ *
+ * Currently only configures PCIe bus settings related to MPS and MRRS.
+ */
+static void pci_bus_configure_settings(struct pci_bus *bus)
+{
+	pci_walk_bus(bus, pcie_rescan_bus_configure_settings, NULL);
+}
+
 /**
  * pci_rescan_bus - Scan a PCI bus for devices
  * @bus: PCI bus to scan
@@ -3171,6 +3199,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 
 	max = pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
+	pci_bus_configure_settings(bus);
 	pci_bus_add_devices(bus);
 
 	return max;
-- 
2.14.4

