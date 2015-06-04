Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33353 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbbFDWBr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 18:01:47 -0400
Received: by obbea3 with SMTP id ea3so42358341obb.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 15:01:46 -0700 (PDT)
Subject: [PATCH 1/5] PCI: imx6: Rename imx6_pcie_start_link() to
 imx6_pcie_establish_link()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>
Date: Thu, 04 Jun 2015 17:01:44 -0500
Message-ID: <20150604220144.4377.40573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename imx6_pcie_start_link() to imx6_pcie_establish_link() to follow the
convention of other DesignWare-based host drivers.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index fdb9536..8cc0123 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -359,7 +359,7 @@ static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
 	return dw_handle_msi_irq(pp);
 }
 
-static int imx6_pcie_start_link(struct pcie_port *pp)
+static int imx6_pcie_establish_link(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 	uint32_t tmp;
@@ -432,7 +432,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	imx6_pcie_start_link(pp);
+	imx6_pcie_establish_link(pp);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);

