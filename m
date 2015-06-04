Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36802 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbbFDWCB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 18:02:01 -0400
Received: by oihb142 with SMTP id b142so40930107oih.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 15:02:00 -0700 (PDT)
Subject: [PATCH 3/5] PCI: layerscape: Use dw_pcie_link_up() consistently
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
Date: Thu, 04 Jun 2015 17:01:58 -0500
Message-ID: <20150604220158.4377.97359.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604220144.4377.40573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150604220144.4377.40573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All the other DesignWare-based drivers use dw_pcie_link_up(), so use it in
this driver, too, for consistency.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 4a6e62f..bb5894f 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -70,7 +70,7 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	while (!ls_pcie_link_up(pp)) {
+	while (!dw_pcie_link_up(pp)) {
 		usleep_range(100, 1000);
 		count++;
 		if (count >= 200) {

