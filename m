Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:22180 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012Ab2AUKIz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 21 Jan 2012 05:08:55 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 02/21] PCI: Make add_to_list() return status
Date: Sat, 21 Jan 2012 02:08:18 -0800
Message-Id: <1327140517-14811-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1327140517-14811-1-git-send-email-yinghai@kernel.org>
References: <1327140517-14811-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

will be used for resource_list_x duplication for try requested+optional at first.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9d932f4..0282fde 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -64,7 +64,7 @@ void pci_realloc(void)
  * @add_size:	additional size to be optionally added
  *              to the resource
  */
-static void add_to_list(struct resource_list_x *head,
+static int add_to_list(struct resource_list_x *head,
 		 struct pci_dev *dev, struct resource *res,
 		 resource_size_t add_size, resource_size_t min_align)
 {
@@ -75,7 +75,7 @@ static void add_to_list(struct resource_list_x *head,
 	tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
 	if (!tmp) {
 		pr_warning("add_to_list: kmalloc() failed!\n");
-		return;
+		return -ENOMEM;
 	}
 
 	tmp->next = ln;
@@ -87,6 +87,8 @@ static void add_to_list(struct resource_list_x *head,
 	tmp->add_size = add_size;
 	tmp->min_align = min_align;
 	list->next = tmp;
+
+	return 0;
 }
 
 static void add_to_failed_list(struct resource_list_x *head,
-- 
1.7.7

