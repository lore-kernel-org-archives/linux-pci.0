Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7513 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498Ab1KJOCX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Nov 2011 09:02:23 -0500
From: Prarit Bhargava <prarit@redhat.com>
To: linux-pci@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, mstowe@redhat.com,
	ddutile@redhat.com, jparadis@redhat.com,
	matthew.wilcox@linux.intel.com, jbarnes@virtuousgeek.org
Subject: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
Date: Thu, 10 Nov 2011 09:00:13 -0500
Message-Id: <1320933613-25909-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Stratus systems have a hierarchy that includes a PCIE Downstream bridge
connected to a PCIE Upstream bridge and a PCI Downstream bridge.  The system
boots with this wrong hierarchy into a crippled mode (USB doesn't work,
network doesn't work ...).  Avoiding the Downstream bridge check in
only_one_child() causes all the bridges to be enumerated and the system
to function properly.

Unfortunately this hardware is currently available so we should at least
keep it functional.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Cc: mstowe@redhat.com
Cc: ddutile@redhat.com
Cc: jparadis@redhat.com
Cc: matthew.wilcox@linux.intel.com
Cc: jbarnes@virtuousgeek.org
---
 drivers/pci/probe.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 04e74f4..bc76812 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/pci-aspm.h>
+#include <linux/dmi.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -1275,7 +1276,15 @@ static int only_one_child(struct pci_bus *bus)
 	struct pci_dev *parent = bus->self;
 	if (!parent || !pci_is_pcie(parent))
 		return 0;
-	if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
+	if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT)
+		return 1;
+	/*
+	 * Stratus/NEC ftServer systems have a broken PCIE hierarchy in which
+	 * one upstream and one downstream port are plugged into a downstream
+	 * port.  Avoiding the downstream port check here results in a
+	 * functional system.
+	 */
+	if (!dmi_name_in_vendors("ftServer") &&
 	    parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM)
 		return 1;
 	return 0;
-- 
1.7.1

