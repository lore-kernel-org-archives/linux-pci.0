Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from p3plsmtps2ded02.prod.phx3.secureserver.net ([208.109.80.59]:54989
	"EHLO p3plsmtps2ded02.prod.phx3.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420AbcC3WLy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 30 Mar 2016 18:11:54 -0400
From: Jake Oshins <jakeo@microsoft.com>
To: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, haiyangz@microsoft.com, haddenh@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 4/7] drivers:hv: Reverse order of resources in hyperv_mmio
Date: Wed, 30 Mar 2016 16:48:44 -0700
Message-Id: <1459381727-25039-5-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1459381727-25039-1-git-send-email-jakeo@microsoft.com>
References: <y>
 <1459381727-25039-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A patch later in this series allocates child nodes
in this resource tree.  For that to work, this tree
needs to be sorted in ascending order.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 60553c1..1ce47d0 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1049,7 +1049,6 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 	new_res->end = end;

 	/*
-	 * Stick ranges from higher in address space at the front of the list.
 	 * If two ranges are adjacent, merge them.
 	 */
 	do {
@@ -1070,7 +1069,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 			break;
 		}

-		if ((*old_res)->end < new_res->start) {
+		if ((*old_res)->start > new_res->end) {
 			new_res->sibling = *old_res;
 			if (prev_res)
 				(*prev_res)->sibling = new_res;
--
1.9.1

