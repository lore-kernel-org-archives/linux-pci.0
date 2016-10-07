Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964789AbcJGQha (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:37:30 -0400
Subject: [PATCH 05/11] PCI: hisi: Pass device-specific struct to internal
 functions
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:37:26 -0500
Message-ID: <20161007163726.25540.90872.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index 64f668c..e6bbe94 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -135,10 +135,10 @@ static struct pcie_host_ops hisi_pcie_host_ops = {
 	.link_up = hisi_pcie_link_up,
 };
 
-static int hisi_add_pcie_port(struct pcie_port *pp,
-				     struct platform_device *pdev)
+static int hisi_add_pcie_port(struct hisi_pcie *hisi,
+			      struct platform_device *pdev)
 {
-	struct hisi_pcie *hisi = to_hisi_pcie(pp);
+	struct pcie_port *pp = &hisi->pp;
 	int ret;
 	u32 port_id;
 
@@ -197,7 +197,7 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pp->dbi_base);
 	}
 
-	ret = hisi_add_pcie_port(pp, pdev);
+	ret = hisi_add_pcie_port(hisi, pdev);
 	if (ret)
 		return ret;
 

