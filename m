Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751989AbdKMWkx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Nov 2017 17:40:53 -0500
Subject: [PATCH v1 2/3] PCI: altera: Rename altera_pcie_link_is_up() to
 altera_pcie_link_up()
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        rfi@lists.rocketboards.org,
        =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
        Ley Foon Tan <lftan@altera.com>,
        linux-arm-kernel@lists.infradead.org,
        Tanmay Inamdar <tinamdar@apm.com>
Date: Mon, 13 Nov 2017 16:40:51 -0600
Message-ID: <20171113224051.29024.76516.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171113224001.29024.87126.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171113224001.29024.87126.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Rename altera_pcie_link_is_up() to altera_pcie_link_up() to follow the
convention of other drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index b468b8cccf8d..5cc4f594d79a 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -105,7 +105,7 @@ static inline u32 cra_readl(struct altera_pcie *pcie, const u32 reg)
 	return readl_relaxed(pcie->cra_base + reg);
 }
 
-static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
+static bool altera_pcie_link_up(struct altera_pcie *pcie)
 {
 	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
 }
@@ -142,7 +142,7 @@ static bool altera_pcie_valid_device(struct altera_pcie *pcie,
 {
 	/* If there is no link, then there is no device */
 	if (bus->number != pcie->root_bus_nr) {
-		if (!altera_pcie_link_is_up(pcie))
+		if (!altera_pcie_link_up(pcie))
 			return false;
 	}
 
@@ -412,7 +412,7 @@ static void altera_wait_link_retrain(struct altera_pcie *pcie)
 	/* Wait for link is up */
 	start_jiffies = jiffies;
 	for (;;) {
-		if (altera_pcie_link_is_up(pcie))
+		if (altera_pcie_link_up(pcie))
 			break;
 
 		if (time_after(jiffies, start_jiffies + LINK_UP_TIMEOUT)) {
@@ -427,7 +427,7 @@ static void altera_pcie_retrain(struct altera_pcie *pcie)
 {
 	u16 linkcap, linkstat, linkctl;
 
-	if (!altera_pcie_link_is_up(pcie))
+	if (!altera_pcie_link_up(pcie))
 		return;
 
 	/*
