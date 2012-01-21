Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 03/21] PCI: Move get_res_add_size() early
Date: Sat, 21 Jan 2012 02:08:19 -0800
Message-Id: <1327140517-14811-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1327140517-14811-1-git-send-email-yinghai@kernel.org>
References: <1327140517-14811-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Need to call it from __assign_resources_sorted() later.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 0282fde..75d43eb 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -99,6 +99,21 @@ static void add_to_failed_list(struct resource_list_x *head,
 			0 /* dont care */);
 }
 
+static resource_size_t get_res_add_size(struct resource_list_x *realloc_head,
+					struct resource *res)
+{
+	struct resource_list_x *list;
+
+	/* check if it is in realloc_head list */
+	for (list = realloc_head->next; list && list->res != res;
+			list = list->next)
+		;
+	if (list)
+		return list->add_size;
+
+	return 0;
+}
+
 static void __dev_sort_resources(struct pci_dev *dev,
 				 struct resource_list *head)
 {
@@ -550,20 +565,6 @@ static resource_size_t calculate_memsize(resource_size_t size,
 	return size;
 }
 
-static resource_size_t get_res_add_size(struct resource_list_x *realloc_head,
-					struct resource *res)
-{
-	struct resource_list_x *list;
-
-	/* check if it is in realloc_head list */
-	for (list = realloc_head->next; list && list->res != res;
-			list = list->next);
-	if (list)
-		return list->add_size;
-
-	return 0;
-}
-
 /**
  * pbus_size_io() - size the io window of a given bus
  *
-- 
1.7.7

