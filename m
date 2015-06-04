Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35567 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354AbbFDWCI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 18:02:08 -0400
Received: by oihd6 with SMTP id d6so41003811oih.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 15:02:07 -0700 (PDT)
Subject: [PATCH 4/5] PCI: layerscape: Factor out ls_pcie_establish_link()
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
Date: Thu, 04 Jun 2015 17:02:06 -0500
Message-ID: <20150604220205.4377.47992.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604220144.4377.40573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150604220144.4377.40573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All other DesignWare-based drivers have a *_establish_link() function.

This functionality is trivial for Layerscape, but factor out a
ls_pcie_establish_link() for consistency with the other drivers.  No
functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index bb5894f..434b116 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -62,23 +62,30 @@ static int ls_pcie_link_up(struct pcie_port *pp)
 	return 1;
 }
 
-static void ls_pcie_host_init(struct pcie_port *pp)
+static int ls_pcie_establish_link(struct pcie_port *pp)
 {
-	struct ls_pcie *pcie = to_ls_pcie(pp);
 	int count = 0;
-	u32 val;
-
-	dw_pcie_setup_rc(pp);
 
 	while (!dw_pcie_link_up(pp)) {
 		usleep_range(100, 1000);
 		count++;
 		if (count >= 200) {
 			dev_err(pp->dev, "phy link never came up\n");
-			return;
+			return -EINVAL;
 		}
 	}
 
+	return 0;
+}
+
+static void ls_pcie_host_init(struct pcie_port *pp)
+{
+	struct ls_pcie *pcie = to_ls_pcie(pp);
+	u32 val;
+
+	dw_pcie_setup_rc(pp);
+	ls_pcie_establish_link(pp);
+
 	/*
 	 * LS1021A Workaround for internal TKT228622
 	 * to fix the INTx hang issue

