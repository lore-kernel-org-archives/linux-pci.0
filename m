Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, haiyangz@microsoft.com, haddenh@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH 4/5] hv: Reverse order of resources in hyperv_mmio
Date: Wed, 24 Feb 2016 21:24:01 +0000
Message-Id: <1456349042-16275-5-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1456349042-16275-1-git-send-email-jakeo@microsoft.com>
References: <1456349042-16275-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

A patch later in this series allocates child nodes
in this resource tree.  For that to work, this tree
needs to be sorted in ascending order.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 1da18e1..b090548 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1090,7 +1090,6 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 	new_res->end = end;
 
 	/*
-	 * Stick ranges from higher in address space at the front of the list.
 	 * If two ranges are adjacent, merge them.
 	 */
 	do {
@@ -1111,7 +1110,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 			break;
 		}
 
-		if ((*old_res)->end < new_res->start) {
+		if ((*old_res)->start > new_res->end) {
 			new_res->sibling = *old_res;
 			if (prev_res)
 				(*prev_res)->sibling = new_res;
-- 
1.9.1
