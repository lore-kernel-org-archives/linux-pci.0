Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56570 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbcFRSA7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 18 Jun 2016 14:00:59 -0400
Subject: [PATCH] PCI: Document connection between pci_power_t and hardware
 PM capability
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>
Date: Sat, 18 Jun 2016 13:00:56 -0500
Message-ID: <20160618180056.7267.67911.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The dev.pme_support field, pci_pm_init(), and pci_pme_capable() depend on
the fact that the pci_power_t values (PCI_D0, PCI_D1, etc.) match the
definition of the PME_Support field of the Power Management Capabilities
register in the Power Management capability (see PCI Bus Power Management
spec r1.2, sec 3.2.3).

Add a note to this effect at the pci_power_t typedef.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8597b42..85cede3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -101,6 +101,10 @@ enum {
 	DEVICE_COUNT_RESOURCE = PCI_NUM_RESOURCES,
 };
 
+/*
+ * pci_power_t values must match the bits in the PME_Support field of the
+ * Power Management Capabilities register in the Power Management capability.
+ */
 typedef int __bitwise pci_power_t;
 
 #define PCI_D0		((pci_power_t __force) 0)

