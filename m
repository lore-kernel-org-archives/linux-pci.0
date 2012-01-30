Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46476 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194Ab2A3LSR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Jan 2012 06:18:17 -0500
From: Thomas Renninger <trenn@suse.de>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI: workaround hard-wired bus number V2
Date: Mon, 30 Jan 2012 12:18:15 +0100
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai.lu@oracle.com>
References: <1327655507-33999-1-git-send-email-trenn@suse.de> <CAErSpo54EuF3ZmiHZmCvTK5vd0oHws7W+82WPYwLQ9PeL1MG6g@mail.gmail.com> <20120127093835.1d2737db@jbarnes-desktop>
In-Reply-To: <20120127093835.1d2737db@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Message-Id: <201201301218.15712.trenn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yinghai Lu <yinghai.lu@oracle.com>

Fixes PCI device detection on IBM xSeries IBM 3850 M2 / x3950 M2
when using ACPI resources (_CRS).
This is default, a manual workaround (without this patch)
would be pci=nocrs boot param.

V2: Add dev_warn if the workaround is hit. This should reveal
how common such setups are (via google) and point to possible
problems if things are still not working as expected.
-> Suggested by Jan Beulich.

Tested-by: garyhade@us.ibm.com
---
 drivers/pci/probe.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7cc9e2f..71eac9c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -651,6 +651,11 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 	dev_dbg(&dev->dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
 		secondary, subordinate, pass);
 
+	if (!primary && (primary != bus->number) && secondary && subordinate) {
+		dev_warn(&dev->dev, "Primary bus is hard wired to 0\n");
+		primary = bus->number;
+	}
+
 	/* Check if setup is sensible at all */
 	if (!pass &&
 	    (primary != bus->number || secondary <= bus->number)) {
