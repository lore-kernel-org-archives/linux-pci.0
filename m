Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 31/36] PCI: Get new realloc size for bridge for last try
Date: Mon,  6 Jul 2015 16:39:21 -0700
Message-Id: <1436225966-27247-32-git-send-email-yinghai@kernel.org>
In-Reply-To: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current realloc path would not shrink bridge resource through
pbus_size_mem() checking with the old size.

That cause problem: when "must+optional" resource allocation fails,
the cached bridge resource size will prevent "must" resource to get
allocated smaller resource.

Clear the old resource size for last try or third and later try.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=81431
Tested-by: TJ <linux@iam.tj>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 5b2944a..4959f72 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2277,8 +2277,15 @@ again:
 		res->start = fail_res->start;
 		res->end = fail_res->end;
 		res->flags = fail_res->flags;
-		if (fail_res->dev->subordinate)
+		if (fail_res->dev->subordinate) {
 			res->flags = 0;
+			/* last or third times and later */
+			if (tried_times + 1 == pci_try_num ||
+			    tried_times + 1 > 2) {
+				res->start = 0;
+				res->end = res->start - 1;
+			}
+		}
 	}
 	free_list(&fail_head);
 
@@ -2352,8 +2359,12 @@ again:
 		res->start = fail_res->start;
 		res->end = fail_res->end;
 		res->flags = fail_res->flags;
-		if (fail_res->dev->subordinate)
+		if (fail_res->dev->subordinate) {
 			res->flags = 0;
+			/* last time */
+			res->start = 0;
+			res->end = res->start - 1;
+		}
 	}
 	free_list(&fail_head);
 
-- 
1.8.4.5

