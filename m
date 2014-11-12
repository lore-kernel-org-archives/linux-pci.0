Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:55459 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbaKLCoE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 21:44:04 -0500
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 12 Nov 2014 08:14:00 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 579DE1258044
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 08:14:00 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAC2hhDv60293250
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 08:13:43 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAC2hupD007207
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 08:13:57 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] PCI: Remove to_hotplug_slot()
Date: Wed, 12 Nov 2014 13:43:52 +1100
Message-Id: <1415760232-12748-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

struct hotplug_slot doesn't have kobj. to_hotplug_slot(), which
intends converts kobj to hotplug slot, isn't valid any more.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 include/linux/pci_hotplug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 2706ee9..8c78950 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -109,7 +109,6 @@ struct hotplug_slot {
 	struct list_head		slot_list;
 	struct pci_slot			*pci_slot;
 };
-#define to_hotplug_slot(n) container_of(n, struct hotplug_slot, kobj)
 
 static inline const char *hotplug_slot_name(const struct hotplug_slot *slot)
 {
-- 
1.8.3.2

