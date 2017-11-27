Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] PCI: endpoint: Fix error handling in pci_epc_epf_link()
Date: Mon, 27 Nov 2017 16:49:54 +0100
Message-Id: <20171127154955.22214-3-niklas.cassel@axis.com>
In-Reply-To: <20171127154955.22214-1-niklas.cassel@axis.com>
References: <20171127154955.22214-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The error handling in pci_epc_epf_link() was broken,
since the clean up code for pci_epc_add_epf() did clear_bit(),
even though the matching set_bit() is done after pci_epc_add_epf().

Also, clear_bit() should be done before pci_epc_remove_epf(),
since clean up code should normally do things in the reverse order.

Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 4f74386c1ced..e1f5adc9e113 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -106,7 +106,7 @@ static int pci_epc_epf_link(struct config_item *epc_item,
 	epf = epf_group->epf;
 	ret = pci_epc_add_epf(epc, epf);
 	if (ret)
-		goto err_add_epf;
+		return ret;
 
 	func_no = find_first_zero_bit(&epc_group->function_num_map,
 				      sizeof(epc_group->function_num_map));
@@ -120,10 +120,8 @@ static int pci_epc_epf_link(struct config_item *epc_item,
 	return 0;
 
 err_epf_bind:
-	pci_epc_remove_epf(epc, epf);
-
-err_add_epf:
 	clear_bit(func_no, &epc_group->function_num_map);
+	pci_epc_remove_epf(epc, epf);
 
 	return ret;
 }
-- 
2.14.2
