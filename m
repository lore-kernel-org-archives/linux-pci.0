Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0138.outbound.protection.outlook.com ([157.56.110.138]:1591
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751444AbaKJTZC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 10 Nov 2014 14:25:02 -0500
From: <suravee.suthikulpanit@amd.com>
To: <bhelgaas@google.com>
CC: <liviu.dudau@arm.com>, <lorenzo.pieralisi@arm.com>,
	<will.deacon@arm.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 1/2] PCI: Add new pci_ops for setting MSI parent for PCI bus
Date: Mon, 10 Nov 2014 13:24:39 -0600
Message-ID: <1415647480-3320-2-git-send-email-suravee.suthikulpanit@amd.com>
In-Reply-To: <1415647480-3320-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1415647480-3320-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

In the pci_scan_root_bus, pci_bus is created and passed down to:
    pci_scan_child_bus
        pci_scan_bridge
    	pci_add_new_bus
    	    pci_alloc_child_bus

In pci_alloc_child_bus, the parent's msi_chip is propagated to child,
and the referenced by PCI devices when calling arch_setup_msi_irq().

However, in the current implementation of pci_scan_root_bus, the msi_chip
of the root_bus is not set before handing off to pci_scan_child_bus.

This patch proposes a new callback function in the struct pci_ops
to allow host controller to provide a call back for specifying
msi_chip to be used.

Cc: Bjorn Helgass <bhelgaas@google.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/pci/probe.c | 3 +++
 include/linux/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5ed9930..cf7114d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2081,6 +2081,9 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 	if (!b)
 		return NULL;
 
+	if (ops->set_msi_parent)
+		ops->set_msi_parent(b);
+
 	if (!found) {
 		dev_info(&b->dev,
 		 "No busn resource found for root bus, will use [bus %02x-ff]\n",
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5be8db4..6093544 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -560,6 +560,7 @@ static inline int pcibios_err_to_errno(int err)
 struct pci_ops {
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	int (*set_msi_parent)(struct pci_bus *bus);
 };
 
 /*
-- 
1.9.3

