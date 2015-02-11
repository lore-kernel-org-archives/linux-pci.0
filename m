Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.arm.com ([217.140.108.86]:43005 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbbBKE6a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Feb 2015 23:58:30 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: jiang.liu@linux.intel.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] drivers: of: pci: remove duplicate kfree in of_pci_get_host_bridge_resources
Date: Wed, 11 Feb 2015 04:58:35 +0000
Message-Id: <1423630715-23568-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit d2be00c0fb5a ("of/pci: Free resources on failure in
of_pci_get_host_bridge_resources()") fixed the error code path in
of_pci_get_host_bridge_resources() by adding code that runs through the
resources list to free all resources in it and then calls kfree on the
bus_range resource pointer to complete the memory deallocation.
Since the bus_range resource is added to the resources list through
pci_add_resource, the resource_list_for_each_entry loop in the error
exit path frees it already and freeing it anew could trigger a double
free, hence this patch removes the superfluos kfree call on the bus_range
resource.

Fixes: d2be00c0fb5a ("of/pci: Free resources on failure in of_pci_get_host_bridge_resources()")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reported-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 drivers/of/of_pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 110fece..62426d8 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -229,7 +229,6 @@ parse_failed:
 	resource_list_for_each_entry(window, resources)
 		kfree(window->res);
 	pci_free_resource_list(resources);
-	kfree(bus_range);
 	return err;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
-- 
2.2.1

