Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:56156 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbdLLORD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Dec 2017 09:17:03 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] PCI: endpoint: Fix find_first_zero_bit() usage
Date: Tue, 12 Dec 2017 15:16:34 +0100
Message-Id: <20171212141634.5985-4-niklas.cassel@axis.com>
In-Reply-To: <20171212141634.5985-1-niklas.cassel@axis.com>
References: <20171212141634.5985-1-niklas.cassel@axis.com>
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
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index e1f5adc9e113..f5ccd1aa2963 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -109,7 +109,11 @@ static int pci_epc_epf_link(struct config_item *epc_item,
 		return ret;
 
 	func_no = find_first_zero_bit(&epc_group->function_num_map,
-				      sizeof(epc_group->function_num_map));
+				      BITS_PER_LONG);
+	if (func_no >= BITS_PER_LONG) {
+		ret = -EINVAL;
+		goto err_func_no;
+	}
 	set_bit(func_no, &epc_group->function_num_map);
 	epf->func_no = func_no;
 
@@ -121,6 +125,7 @@ static int pci_epc_epf_link(struct config_item *epc_item,
 
 err_epf_bind:
 	clear_bit(func_no, &epc_group->function_num_map);
+err_func_no:
 	pci_epc_remove_epf(epc, epf);
 
 	return ret;
-- 
2.14.2
