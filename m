Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gx0-f202.google.com ([209.85.161.202]:63766 "EHLO
	mail-gx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab2ARAfE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2012 19:35:04 -0500
Received: by ggnv2 with SMTP id v2so273030ggn.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2012 16:35:03 -0800 (PST)
Subject: [PATCH 1/4] PCI: log bridge reconfiguration information
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Tue, 17 Jan 2012 17:35:02 -0700
Message-ID: <20120118003502.467.22617.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
References: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reassigning bus numbers is major reconfiguration that we should tell the
user about.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7cc9e2f..e282580 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -654,7 +654,8 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 	/* Check if setup is sensible at all */
 	if (!pass &&
 	    (primary != bus->number || secondary <= bus->number)) {
-		dev_dbg(&dev->dev, "bus configuration invalid, reconfiguring\n");
+		dev_info(&dev->dev, "invalid config (primary %02x, bridge to [bus %02x-%02x]); reconfiguring\n",
+			 primary, secondary, subordinate);
 		broken = 1;
 	}
 
@@ -743,6 +744,9 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 		/*
 		 * We need to blast all three values with a single write.
 		 */
+		dev_info(&dev->dev,
+			 "assigned primary %02x, bridge to [bus %02x-%02x]\n",
+			 child->primary, child->secondary, child->subordinate);
 		pci_write_config_dword(dev, PCI_PRIMARY_BUS, buses);
 
 		if (!is_cardbus) {

