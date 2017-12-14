Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:59013 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbdLNNCR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 08:02:17 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] PCI: endpoint: Fix find_first_zero_bit() usage
Date: Thu, 14 Dec 2017 14:01:46 +0100
Message-Id: <20171214130147.1790-4-niklas.cassel@axis.com>
In-Reply-To: <20171214130147.1790-1-niklas.cassel@axis.com>
References: <20171214130147.1790-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

find_first_zero_bit()'s parameter 'size' is defined in bits,
not in bytes.

Calling find_first_zero_bit() with the wrong size unit
will lead to insidious bugs.

Fix this by calling find_first_zero_bit() with size BITS_PER_LONG,
rather than sizeof() and add missing find_first_zero_bit() return
handling.

Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index e8f65eb51c1a..c9a2fb9dd49d 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -103,7 +103,10 @@ static int pci_epc_epf_link(struct config_item *epc_item,
 	struct pci_epf *epf = epf_group->epf;
 
 	func_no = find_first_zero_bit(&epc_group->function_num_map,
-				      sizeof(epc_group->function_num_map));
+				      BITS_PER_LONG);
+	if (func_no >= BITS_PER_LONG)
+		return -EINVAL;
+
 	set_bit(func_no, &epc_group->function_num_map);
 	epf->func_no = func_no;
 
-- 
2.14.2
