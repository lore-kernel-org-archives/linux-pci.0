Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:40346 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbdK0PuV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Nov 2017 10:50:21 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] PCI: endpoint: Fix find_first_zero_bit() usage
Date: Mon, 27 Nov 2017 16:49:55 +0100
Message-Id: <20171127154955.22214-4-niklas.cassel@axis.com>
In-Reply-To: <20171127154955.22214-1-niklas.cassel@axis.com>
References: <20171127154955.22214-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

find_first_zero_bit()'s parameter 'size' is defined in bits,
not in bytes.

Calling find_first_zero_bit() with the wrong size unit
will lead to insidious bugs.

Fix this by calling find_first_zero_bit() with size
BITS_PER_LONG, rather than sizeof().

Also add proper error handling for find_first_zero_bit(),
since this was missing.

Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index e1f5adc9e113..0a22a7976580 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -109,7 +109,12 @@ static int pci_epc_epf_link(struct config_item *epc_item,
 		return ret;
 
 	func_no = find_first_zero_bit(&epc_group->function_num_map,
-				      sizeof(epc_group->function_num_map));
+				      BITS_PER_LONG);
+	if (func_no >= BITS_PER_LONG) {
+		ret = -EINVAL;
+		dev_err(&epc->dev, "failed to link endpoint function device\n");
+		goto err_func_no;
+	}
 	set_bit(func_no, &epc_group->function_num_map);
 	epf->func_no = func_no;
 
@@ -121,6 +126,7 @@ static int pci_epc_epf_link(struct config_item *epc_item,
 
 err_epf_bind:
 	clear_bit(func_no, &epc_group->function_num_map);
+err_func_no:
 	pci_epc_remove_epf(epc, epf);
 
 	return ret;
-- 
2.14.2
