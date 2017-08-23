Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53523 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932118AbdHWQDF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 12:03:05 -0400
From: Colin King <colin.king@canonical.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][pci-next] PCI: endpoint: fix incorrect end of table check in while loop
Date: Wed, 23 Aug 2017 17:03:03 +0100
Message-Id: <20170823160303.23366-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Currently, the while loop will iterate until a matching name is found
or until the id pointer wraps around to NULL (the latter is incorrect).

The end of a pci_epf_device_id table is terminated with zero'd entries
for name and driver_data, so can change the while loop to iterate while
the first character in the name is a non-zero character.

Detected by CoverityScan, CID#1454557 ("Logically dead code")

Fixes: 9e9d6eb48623 ("PCI: endpoint: Add an API to get matching "pci_epf_device_id")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index ae6fac5995e3..70eccc04ee7f 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -273,7 +273,7 @@ pci_epf_match_device(const struct pci_epf_device_id *id, struct pci_epf *epf)
 	if (!id || !epf)
 		return NULL;
 
-	while (id) {
+	while (*id->name) {
 		if (strcmp(epf->name, id->name) == 0)
 			return id;
 		id++;
-- 
2.14.1
