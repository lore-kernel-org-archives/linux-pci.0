Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:42442 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934305AbdKQPAv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2017 10:00:51 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: endpoint: Fix find_first_zero_bit() usage
Date: Fri, 17 Nov 2017 16:00:41 +0100
Message-Id: <20171117150041.30509-3-niklas.cassel@axis.com>
In-Reply-To: <20171117150041.30509-1-niklas.cassel@axis.com>
References: <20171117150041.30509-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

find_first_zero_bit()'s parameter 'size' is defined in bits,
not in bytes.

Calling find_first_zero_bit() with the wrong size unit
will lead to insidious bugs.

Fix this by using replacing find_first_zero_bit() with ffz(),
since ffz() only works on a single 'unsigned long' and therefore
does not need a size argument.

Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 4f74386c1ced..96b984685640 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -108,8 +108,7 @@ static int pci_epc_epf_link(struct config_item *epc_item,
 	if (ret)
 		goto err_add_epf;
 
-	func_no = find_first_zero_bit(&epc_group->function_num_map,
-				      sizeof(epc_group->function_num_map));
+	func_no = ffz(epc_group->function_num_map);
 	set_bit(func_no, &epc_group->function_num_map);
 	epf->func_no = func_no;
 
-- 
2.14.2
