Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964789AbcJGQhi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:37:38 -0400
Subject: [PATCH 06/11] PCI: hisi: Reorder struct hisi_pcie
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:37:34 -0500
Message-ID: <20161007163734.25540.45525.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reorder struct hisi_pcie to put generic fields first.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index e6bbe94..e14ce13 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -37,9 +37,9 @@ struct pcie_soc_ops {
 };
 
 struct hisi_pcie {
+	struct pcie_port pp;		/* pp.dbi_base is DT rc_dbi */
 	struct regmap *subctrl;
 	u32 port_id;
-	struct pcie_port pp;
 	struct pcie_soc_ops *soc_ops;
 };
 
@@ -109,7 +109,6 @@ static int hisi_pcie_link_up_hip05(struct hisi_pcie *hisi)
 
 	regmap_read(hisi->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
 		    0x100 * hisi->port_id, &val);
-
 	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
 }
 
@@ -178,13 +177,13 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 
 	pp = &hisi->pp;
 	pp->dev = &pdev->dev;
-	driver = (pdev->dev).driver;
 
+	driver = (pdev->dev).driver;
 	match = of_match_device(driver->of_match_table, &pdev->dev);
 	hisi->soc_ops = (struct pcie_soc_ops *) match->data;
 
 	hisi->subctrl =
-	syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
+	    syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
 	if (IS_ERR(hisi->subctrl)) {
 		dev_err(pp->dev, "cannot get subctrl base\n");
 		return PTR_ERR(hisi->subctrl);

