Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964814AbcJGQhG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:37:06 -0400
Subject: [PATCH 02/11] PCI: hisi: Rename config accessors
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:37:02 -0500
Message-ID: <20161007163702.25540.81780.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename hisi_pcie_cfg_read() to hisi_cfg_read() and hisi_pcie_cfg_write() to
hisi_cfg_write() for consistency with other drivers.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 15a1167..d590999 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -55,8 +55,7 @@ static void hisi_apb_writel(struct hisi_pcie *pcie, u32 val, u32 reg)
 }
 
 /* HipXX PCIe host only supports 32-bit config access */
-static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
-			      u32 *val)
+static int hisi_cfg_read(struct pcie_port *pp, int where, int size, u32 *val)
 {
 	u32 reg;
 	u32 reg_val;
@@ -80,8 +79,7 @@ static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
 }
 
 /* HipXX PCIe host only supports 32-bit config access */
-static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
-				u32 val)
+static int hisi_cfg_write(struct pcie_port *pp, int where, int  size, u32 val)
 {
 	u32 reg_val;
 	u32 reg;
@@ -133,8 +131,8 @@ static int hisi_pcie_link_up(struct pcie_port *pp)
 }
 
 static struct pcie_host_ops hisi_pcie_host_ops = {
-	.rd_own_conf = hisi_pcie_cfg_read,
-	.wr_own_conf = hisi_pcie_cfg_write,
+	.rd_own_conf = hisi_cfg_read,
+	.wr_own_conf = hisi_cfg_write,
 	.link_up = hisi_pcie_link_up,
 };
 

