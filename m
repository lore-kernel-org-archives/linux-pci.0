Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:35143 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdKQJnA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2017 04:43:00 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: use ffz() instead of find_first_zero_bit()
Date: Fri, 17 Nov 2017 10:42:48 +0100
Message-Id: <20171117094248.15265-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

find_first_zero_bit()'s parameter 'size' is defined in bits,
not in bytes.

Calling find_first_zero_bit() with the wrong size unit
will lead to insidious bugs.

Fix this by using replacing find_first_zero_bit() with ffz(),
since ffz() only works on a single 'unsigned long' and therefore
does not need a size argument.

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
