Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:58971 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbdLNNCE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 08:02:04 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] PCI: endpoint: Populate func_no before calling pci_epc_add_epf()
Date: Thu, 14 Dec 2017 14:01:45 +0100
Message-Id: <20171214130147.1790-3-niklas.cassel@axis.com>
In-Reply-To: <20171214130147.1790-1-niklas.cassel@axis.com>
References: <20171214130147.1790-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

func_no is a member of struct pci_epf.
struct pci_epf is used as an argument to pci_epc_add_epf(),
therefore func_no should be populated before calling pci_epc_add_epf().

Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Suggested-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 4f74386c1ced..e8f65eb51c1a 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -97,22 +97,20 @@ static int pci_epc_epf_link(struct config_item *epc_item,
 {
 	int ret;
 	u32 func_no = 0;
-	struct pci_epc *epc;
-	struct pci_epf *epf;
 	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item);
 	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
-
-	epc = epc_group->epc;
-	epf = epf_group->epf;
-	ret = pci_epc_add_epf(epc, epf);
-	if (ret)
-		goto err_add_epf;
+	struct pci_epc *epc = epc_group->epc;
+	struct pci_epf *epf = epf_group->epf;
 
 	func_no = find_first_zero_bit(&epc_group->function_num_map,
 				      sizeof(epc_group->function_num_map));
 	set_bit(func_no, &epc_group->function_num_map);
 	epf->func_no = func_no;
 
+	ret = pci_epc_add_epf(epc, epf);
+	if (ret)
+		goto err_add_epf;
+
 	ret = pci_epf_bind(epf);
 	if (ret)
 		goto err_epf_bind;
-- 
2.14.2
