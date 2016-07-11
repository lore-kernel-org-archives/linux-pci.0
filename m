Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11395 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1030631AbcGKLwX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2016 07:52:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6BBnPKj092498
	for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2016 07:52:22 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0b-001b2d01.pphosted.com with ESMTP id 243euc6egk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2016 07:52:22 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <imunsie@au1.ibm.com>;
	Mon, 11 Jul 2016 21:52:18 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id CF0A13578053
	for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2016 21:52:16 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u6BBqGJS11665540
	for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2016 21:52:16 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u6BBqFQ5031675
	for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2016 21:52:16 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Michael Neuling <mikey@neuling.org>,
	Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 13/15] PCI/hotplug: pnv_php: export symbols and move struct types needed by cxl
Date: Mon, 11 Jul 2016 21:50:20 +1000
In-Reply-To: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
References: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1468237822-26276-14-git-send-email-imunsie@au.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

The cxl driver will use infrastructure from pnv_php to handle device tree
updates when switching bi-modal CAPI cards into CAPI mode.

To enable this, export pnv_php_find_slot() and
pnv_php_set_slot_power_state(), and add corresponding declarations, as well
as the definition of struct pnv_php_slot, to asm/pnv-pci.h.

Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

---

V1->V2:

	- Dropped extraneous "select HOTPLUG_PCI_POWERNV_BASE" in Kconfig,
	  which was accidentally left in from an earlier non-public
	  revision. Thanks to Gavin Shan for pointing it out
---
 arch/powerpc/include/asm/pnv-pci.h | 28 ++++++++++++++++++++++++++++
 drivers/pci/hotplug/pnv_php.c      | 32 +++++---------------------------
 2 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index c47097f..0cbd813 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -11,6 +11,7 @@
 #define _ASM_PNV_PCI_H
 
 #include <linux/pci.h>
+#include <linux/pci_hotplug.h>
 #include <misc/cxl-base.h>
 #include <asm/opal-api.h>
 
@@ -47,4 +48,31 @@ void pnv_cxl_phb_set_peer_afu(struct pci_dev *dev, struct cxl_afu *afu);
 
 #endif
 
+struct pnv_php_slot {
+	struct hotplug_slot		slot;
+	struct hotplug_slot_info	slot_info;
+	uint64_t			id;
+	char				*name;
+	int				slot_no;
+	struct kref			kref;
+#define PNV_PHP_STATE_INITIALIZED	0
+#define PNV_PHP_STATE_REGISTERED	1
+#define PNV_PHP_STATE_POPULATED		2
+#define PNV_PHP_STATE_OFFLINE		3
+	int				state;
+	struct device_node		*dn;
+	struct pci_dev			*pdev;
+	struct pci_bus			*bus;
+	bool				power_state_check;
+	void				*fdt;
+	void				*dt;
+	struct of_changeset		ocs;
+	struct pnv_php_slot		*parent;
+	struct list_head		children;
+	struct list_head		link;
+};
+extern struct pnv_php_slot *pnv_php_find_slot(struct device_node *dn);
+extern int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
+					uint8_t state);
+
 #endif
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 6086db6..2d2f704 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -22,30 +22,6 @@
 #define DRIVER_AUTHOR	"Gavin Shan, IBM Corporation"
 #define DRIVER_DESC	"PowerPC PowerNV PCI Hotplug Driver"
 
-struct pnv_php_slot {
-	struct hotplug_slot		slot;
-	struct hotplug_slot_info	slot_info;
-	uint64_t			id;
-	char				*name;
-	int				slot_no;
-	struct kref			kref;
-#define PNV_PHP_STATE_INITIALIZED	0
-#define PNV_PHP_STATE_REGISTERED	1
-#define PNV_PHP_STATE_POPULATED		2
-#define PNV_PHP_STATE_OFFLINE		3
-	int				state;
-	struct device_node		*dn;
-	struct pci_dev			*pdev;
-	struct pci_bus			*bus;
-	bool				power_state_check;
-	void				*fdt;
-	void				*dt;
-	struct of_changeset		ocs;
-	struct pnv_php_slot		*parent;
-	struct list_head		children;
-	struct list_head		link;
-};
-
 static LIST_HEAD(pnv_php_slot_list);
 static DEFINE_SPINLOCK(pnv_php_lock);
 
@@ -91,7 +67,7 @@ static struct pnv_php_slot *pnv_php_match(struct device_node *dn,
 	return NULL;
 }
 
-static struct pnv_php_slot *pnv_php_find_slot(struct device_node *dn)
+struct pnv_php_slot *pnv_php_find_slot(struct device_node *dn)
 {
 	struct pnv_php_slot *php_slot, *tmp;
 	unsigned long flags;
@@ -108,6 +84,7 @@ static struct pnv_php_slot *pnv_php_find_slot(struct device_node *dn)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(pnv_php_find_slot);
 
 /*
  * Remove pdn for all children of the indicated device node.
@@ -316,8 +293,8 @@ out:
 	return ret;
 }
 
-static int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
-					uint8_t state)
+int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
+				 uint8_t state)
 {
 	struct pnv_php_slot *php_slot = slot->private;
 	struct opal_msg msg;
@@ -347,6 +324,7 @@ static int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pnv_php_set_slot_power_state);
 
 static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
 {
-- 
2.8.1

