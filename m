Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33461 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbbFDWBx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 18:01:53 -0400
Received: by oiww2 with SMTP id w2so41068154oiw.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 15:01:53 -0700 (PDT)
Subject: [PATCH 2/5] PCI: dra7xx: Use dw_pcie_link_up() consistently
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
Date: Thu, 04 Jun 2015 17:01:51 -0500
Message-ID: <20150604220151.4377.38040.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604220144.4377.40573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150604220144.4377.40573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We already use dw_pcie_link_up() once in dra7xx_pcie_establish_link(), but
we duplicate its code later.  Use dw_pcie_link_up() for consistency.  No
functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-dra7xx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 2d57e19..e3d15d7 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -107,8 +107,7 @@ static int dra7xx_pcie_establish_link(struct pcie_port *pp)
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
 	while (retries--) {
-		reg = dra7xx_pcie_readl(dra7xx,	PCIECTRL_DRA7XX_CONF_PHY_CS);
-		if (reg & LINK_UP)
+		if (dw_pcie_link_up(pp))
 			break;
 		usleep_range(10, 20);
 	}

