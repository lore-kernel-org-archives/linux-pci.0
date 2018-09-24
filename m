Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F3EC433F4
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 09:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38558214C5
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 09:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38558214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeIXPou (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:44:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:56726 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbeIXPou (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Sep 2018 11:44:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 02:43:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="259747063"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 24 Sep 2018 02:43:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B391A113; Mon, 24 Sep 2018 12:42:59 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Len Brown <lenb@kernel.org>,
        Peter Anemone <peter.anemone@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2] ACPI / hotplug / PCI: Don't scan for non-hotplug bridges if slot is not bridge
Date:   Mon, 24 Sep 2018 12:42:59 +0300
Message-Id: <20180924094259.74789-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HP 6730b laptop has an ethernet NIC connected to one of the PCIe root
ports. The root ports itself are native PCIe hotplug capable. Now,
during boot after PCI devices are scanned the BIOS triggers ACPI bus
check directly to the NIC:

  [    0.942239] ACPI: \_SB_.PCI0.RP06.NIC_: Bus check in hotplug_event()

It is not clear why it is sending bus check but regardless the ACPI
hotplug notify handler calls enable_slot() directly (instead of going
through acpiphp_check_bridge() as there is no bridge) which ends up
handling special case for non-hotplug bridges with native PCIe hotplug.
This results a crash of some kind but the reporter only sees black
screen so it is hard to figure out the exact spot and what actually
happens. Based on few fix proposals it was tracked to crash somewhere
inside pci_assign_unassigned_bridge_resources().

In any case we should not really be in that special branch at all
because the ACPI notify happened to a slot that is not a PCI bridge (it
is just a regular PCI device).

Fix this so that we only go to that special branch if we are calling
enable_slot() for a bridge (e.g the ACPI notification was for the bridge).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=201127
Fixes: 84c8b58ed3ad ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug
Reported-by: Peter Anemone <peter.anemone@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Changes from v1:

  * Pass bool instead of a bridge pointer

 drivers/pci/hotplug/acpiphp_glue.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index ef0b1b6ba86f..12afa7fdf77e 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -457,17 +457,18 @@ static void acpiphp_native_scan_bridge(struct pci_dev *bridge)
 /**
  * enable_slot - enable, configure a slot
  * @slot: slot to be enabled
+ * @bridge: true if enable is for the whole bridge (not a single slot)
  *
  * This function should be called per *physical slot*,
  * not per each slot object in ACPI namespace.
  */
-static void enable_slot(struct acpiphp_slot *slot)
+static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus = slot->bus;
 	struct acpiphp_func *func;
 
-	if (bus->self && hotplug_is_native(bus->self)) {
+	if (bridge && bus->self && hotplug_is_native(bus->self)) {
 		/*
 		 * If native hotplug is used, it will take care of hotplug
 		 * slot management and resource allocation for hotplug
@@ -701,7 +702,7 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
 					trim_stale_devices(dev);
 
 			/* configure all functions */
-			enable_slot(slot);
+			enable_slot(slot, true);
 		} else {
 			disable_slot(slot);
 		}
@@ -785,7 +786,7 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
 		if (bridge)
 			acpiphp_check_bridge(bridge);
 		else if (!(slot->flags & SLOT_IS_GOING_AWAY))
-			enable_slot(slot);
+			enable_slot(slot, false);
 
 		break;
 
@@ -973,7 +974,7 @@ int acpiphp_enable_slot(struct acpiphp_slot *slot)
 
 	/* configure all functions */
 	if (!(slot->flags & SLOT_ENABLED))
-		enable_slot(slot);
+		enable_slot(slot, false);
 
 	pci_unlock_rescan_remove();
 	return 0;
-- 
2.18.0

