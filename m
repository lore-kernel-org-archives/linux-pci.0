Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v11 38/60] PCI: Check if resource is allocated before trying to assign one
Date: Thu,  7 Apr 2016 17:15:51 -0700
Message-Id: <1460074573-7481-39-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In following alt_size support, we will call pci_assign_resource() several
times on one resource list, and some resources could have been assigned
already.

Skip allocated resource in the list, as pci_assign_resource()
only can handle not assigned resource.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4d2898d..b5529cc 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -385,7 +385,7 @@ static void assign_requested_resources_sorted(struct list_head *head,
 	list_for_each_entry(dev_res, head, list) {
 		res = dev_res->res;
 		idx = res - &dev_res->dev->resource[0];
-		if (resource_size(res) &&
+		if (!res->parent && resource_size(res) &&
 		    pci_assign_resource(dev_res->dev, idx)) {
 			if (fail_head)
 				add_to_list(fail_head, dev_res->dev, res);
-- 
1.8.4.5
