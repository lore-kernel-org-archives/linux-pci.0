Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE56C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 15:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1421B2086E
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 15:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1421B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeIZVgW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:36:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:28593 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbeIZVgW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 17:36:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 08:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="260426177"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by orsmga005.jf.intel.com with ESMTP; 26 Sep 2018 08:21:19 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH] PCI: Fix bus error reset when CONFIG_SYSFS not set
Date:   Wed, 26 Sep 2018 09:23:26 -0600
Message-Id: <20180926152326.14821-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci slot component is not compiled if the kernel config does not
set CONFIG_SYSFS, but a previous commit used a lock symbol from there
without considering when it isn't defined.

This patch fixes that by moving the mutex definition to a context outside
CONFIG_SYSFS. This also made it obvious the implementation missed going
to the fallback when there were no bus slots, so this is also fixed.

Fixes: 131b0ca2c7b263fd ("PCI/ERR: Use slot reset if available")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.c  | 24 ++++++++++++++----------
 drivers/pci/slot.c |  1 -
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2b4117011313..f6104a551b60 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -35,6 +35,8 @@
 #include <linux/aer.h>
 #include "pci.h"
 
+DEFINE_MUTEX(pci_slot_mutex);
+
 const char *pci_power_names[] = {
 	"error", "D0", "D1", "D2", "D3hot", "D3cold", "unknown",
 };
@@ -5201,21 +5203,23 @@ static int pci_bus_reset(struct pci_bus *bus, int probe)
 int pci_bus_error_reset(struct pci_dev *bridge)
 {
 	struct pci_bus *bus = bridge->subordinate;
+	struct pci_slot *slot;
 
 	if (!bus)
 		return -ENOTTY;
 
 	mutex_lock(&pci_slot_mutex);
-	if (!list_empty(&bus->slots)) {
-		struct pci_slot *slot;
-
-		list_for_each_entry(slot, &bus->slots, list)
-			if (pci_probe_reset_slot(slot))
-				goto bus_reset;
-		list_for_each_entry(slot, &bus->slots, list)
-			if (pci_slot_reset(slot, 0))
-				goto bus_reset;
-	}
+	if (list_empty(&bus->slots))
+		goto bus_reset;
+
+	list_for_each_entry(slot, &bus->slots, list)
+		if (pci_probe_reset_slot(slot))
+			goto bus_reset;
+
+	list_for_each_entry(slot, &bus->slots, list)
+		if (pci_slot_reset(slot, 0))
+			goto bus_reset;
+
 	mutex_unlock(&pci_slot_mutex);
 	return 0;
 bus_reset:
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 3da03fcc6fbf..c46d5e1ff536 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -14,7 +14,6 @@
 
 struct kset *pci_slots_kset;
 EXPORT_SYMBOL_GPL(pci_slots_kset);
-DEFINE_MUTEX(pci_slot_mutex);
 
 static ssize_t pci_slot_attr_show(struct kobject *kobj,
 					struct attribute *attr, char *buf)
-- 
2.14.4

