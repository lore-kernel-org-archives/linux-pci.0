Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 6/9] PCI: Retry on type IORESOURCE_IO allocation.
Date: Sat,  4 Feb 2012 22:55:05 -0800
Message-Id: <1328424908-6385-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1328424908-6385-1-git-send-email-yinghai@kernel.org>
References: <1328424908-6385-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During reenabling pci reallocating for pci bridge by clean the small size in
bridge and assign with requested + optional size for first several try,
Ram mention could have problem with one case
	https://bugzilla.kernel.org/show_bug.cgi?id=15960

After checking the booting log in
	https://lkml.org/lkml/2010/4/19/44
	[regression, bisected] Xonar DX invalid PCI I/O range since 977d17bb174

We should not stop too early for io ports.
	Apr 19 10:19:38 [kernel] pci 0000:04:00.0: BAR 7: can't assign io (size 0x4000)
	Apr 19 10:19:38 [kernel] pci 0000:05:01.0: BAR 8: assigned [mem 0x80400000-0x805fffff]
	Apr 19 10:19:38 [kernel] pci 0000:05:01.0: BAR 7: can't assign io (size 0x2000)
	Apr 19 10:19:38 [kernel] pci 0000:05:02.0: BAR 7: can't assign io (size 0x1000)
	Apr 19 10:19:38 [kernel] pci 0000:05:03.0: BAR 7: can't assign io (size 0x1000)
	Apr 19 10:19:38 [kernel] pci 0000:08:00.0: BAR 7: can't assign io (size 0x1000)
	Apr 19 10:19:38 [kernel] pci 0000:09:04.0: BAR 0: can't assign io (size 0x100)
and clear 00:1c.0 to retry again.

The patch remove the IORESOUCE_IO checking, and try one more time.
and we will have chance to get allocation for 00:1c.0 io port range because
from 0x4000 to 0x8000 could be used.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 2991a89..162edfb 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1292,7 +1292,6 @@ pci_assign_unassigned_resources(void)
 	struct pci_dev_resource *fail_res;
 	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
 				  IORESOURCE_PREFETCH;
-	unsigned long failed_type;
 	int pci_try_num = 1;
 
 	/* don't realloc if asked to do so */
@@ -1327,16 +1326,7 @@ again:
 	if (list_empty(&fail_head))
 		goto enable_and_dump;
 
-	failed_type = 0;
-	list_for_each_entry(fail_res, &fail_head, list)
-		failed_type |= fail_res->flags;
-
-	/*
-	 * io port are tight, don't try extra
-	 * or if reach the limit, don't want to try more
-	 */
-	failed_type &= type_mask;
-	if ((failed_type == IORESOURCE_IO) || (tried_times >= pci_try_num)) {
+	if (tried_times >= pci_try_num) {
 		free_list(&fail_head);
 		goto enable_and_dump;
 	}
-- 
1.7.7

