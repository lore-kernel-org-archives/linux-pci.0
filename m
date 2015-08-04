Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35325 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbbHDVyH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 17:54:07 -0400
Received: by igr7 with SMTP id 7so83734186igr.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2015 14:54:06 -0700 (PDT)
Subject: [PATCH v5 2/9] PCI: Add pci_scan_root_bus_msi()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Duc Dang <dhdang@apm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Simon Horman <horms@verge.net.au>,
	James Morse <james.morse@arm.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>
Date: Tue, 04 Aug 2015 16:54:04 -0500
Message-ID: <20150804215404.9189.41823.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Add a pci_scan_root_bus_msi() interface so an arch can specify the MSI
controller up front.  This removes the need for a pcibios callback to set
the MSI controller later.

This is not exported because I'd like to replace the variety of "scan root
bus" interfaces with a single, more extensible interface that can handle
the MSI controller, domain, pci_ops, resources, etc.  I hope this interface
is temporary.

[bhelgaas: changelog, split into separate patch, move to drivers/pci/pci.h]
Suggested-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h   |    5 +++++
 drivers/pci/probe.c |   14 ++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4ff0ff1..1d4c95c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -223,6 +223,11 @@ enum pci_bar_type {
 	pci_bar_mem64,		/* A 64-bit memory BAR */
 };
 
+struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
+				      struct pci_ops *ops, void *sysdata,
+				      struct list_head *resources,
+				      struct msi_controller *msi);
+
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int crs_timeout);
 int pci_setup_device(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cefd636..9ff4df0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2096,8 +2096,9 @@ void pci_bus_release_busn_res(struct pci_bus *b)
 			res, ret ? "can not be" : "is");
 }
 
-struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata,
+		struct list_head *resources, struct msi_controller *msi)
 {
 	struct resource_entry *window;
 	bool found = false;
@@ -2114,6 +2115,8 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 	if (!b)
 		return NULL;
 
+	b->msi = msi;
+
 	if (!found) {
 		dev_info(&b->dev,
 		 "No busn resource found for root bus, will use [bus %02x-ff]\n",
@@ -2128,6 +2131,13 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 
 	return b;
 }
+
+struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	return pci_scan_root_bus_msi(parent, bus, ops, sysdata, resources,
+				     NULL);
+}
 EXPORT_SYMBOL(pci_scan_root_bus);
 
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,

