Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48842 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984Ab2A0JME (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 27 Jan 2012 04:12:04 -0500
From: Thomas Renninger <trenn@suse.de>
To: jbarnes@virtuousgeek.org
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai.lu@oracle.com>,
	trenn@suse.de, bhelgaas@google.com
Subject: [PATCH] PCI: workaround hard-wired bus number
Date: Fri, 27 Jan 2012 10:11:47 +0100
Message-Id: <1327655507-33999-1-git-send-email-trenn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yinghai Lu <yinghai.lu@oracle.com>

Fixes PCI device detection on IBM xSeries IBM 3850 M2 / x3950 M2
when using ACPI resources (_CRS).
This is default, a manual workaround (without this patch)
would be pci=nocrs boot param.

Tested-by: garyhade@us.ibm.com
CC: trenn@suse.de
CC: bhelgaas@google.com
Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/pci/probe.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7cc9e2f..1e255c8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -651,6 +651,10 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 	dev_dbg(&dev->dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
 		secondary, subordinate, pass);
 
+	/* some bridge primary bus is hard wired to 0 */
+	if (!primary && (primary != bus->number) && secondary && subordinate)
+		primary = bus->number;
+
 	/* Check if setup is sensible at all */
 	if (!pass &&
 	    (primary != bus->number || secondary <= bus->number)) {
-- 
1.7.6.1

