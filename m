Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754888AbcJLNn1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:43:27 -0400
Subject: [PATCH v2 7/8] PCI: hisi: Pass device-specific struct to internal
 functions
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:43:23 -0500
Message-ID: <20161012134323.28562.40975.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Only interfaces used from outside the driver, e.g., those called by the
DesignWare core, need to accept pointers to the generic struct pcie_port.
Internal interfaces can accept pointers to the device-specific struct,
which makes them more straightforward.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index b508aae..bfff666 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -126,13 +126,13 @@ static struct pcie_host_ops hisi_pcie_host_ops = {
 	.link_up = hisi_pcie_link_up,
 };
 
-static int hisi_add_pcie_port(struct pcie_port *pp,
-				     struct platform_device *pdev)
+static int hisi_add_pcie_port(struct hisi_pcie *hisi_pcie,
+			      struct platform_device *pdev)
 {
+	struct pcie_port *pp = &hisi_pcie->pp;
 	struct device *dev = pp->dev;
 	int ret;
 	u32 port_id;
-	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
 
 	if (of_property_read_u32(dev->of_node, "port-id", &port_id)) {
 		dev_err(dev, "failed to read port-id\n");
@@ -190,7 +190,7 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pp->dbi_base);
 	}
 
-	ret = hisi_add_pcie_port(pp, pdev);
+	ret = hisi_add_pcie_port(hisi_pcie, pdev);
 	if (ret)
 		return ret;
 

