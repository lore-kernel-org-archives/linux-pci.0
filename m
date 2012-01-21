Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 16/21] PCI: remove add_to_failed_list()
Date: Sat, 21 Jan 2012 02:08:32 -0800
Message-Id: <1327140517-14811-17-git-send-email-yinghai@kernel.org>
In-Reply-To: <1327140517-14811-1-git-send-email-yinghai@kernel.org>
References: <1327140517-14811-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

only one user, just use add_to_list instead.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ae0b1f2..090217a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -89,14 +89,6 @@ static int add_to_list(struct list_head *head,
 	return 0;
 }
 
-static void add_to_failed_list(struct list_head *head,
-				struct pci_dev *dev, struct resource *res)
-{
-	add_to_list(head, dev, res,
-			0 /* dont care */,
-			0 /* dont care */);
-}
-
 static void remove_from_list(struct list_head *head,
 				 struct resource *res)
 {
@@ -302,8 +294,10 @@ static void assign_requested_resources_sorted(struct list_head *head,
 				 */
 				if (!((idx == PCI_ROM_RESOURCE) &&
 				      (!(res->flags & IORESOURCE_ROM_ENABLE))))
-					add_to_failed_list(fail_head,
-							   dev_res->dev, res);
+					add_to_list(fail_head,
+						    dev_res->dev, res,
+						    0 /* dont care */,
+						    0 /* dont care */);
 			}
 			reset_resource(res);
 		}
-- 
1.7.7

