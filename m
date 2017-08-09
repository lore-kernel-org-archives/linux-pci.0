Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37867 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbdHIHtE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2017 03:49:04 -0400
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, bhelgaas@google.com,
        songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] PCI: dwc: make dw_pcie_host_ops const
Date: Wed,  9 Aug 2017 13:18:48 +0530
Message-Id: <1502264928-30004-1-git-send-email-bhumirks@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make these structures const as they are only stored in the ops field of
a pcie_port structure, which is of type const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/pci/dwc/pcie-hisi.c  | 2 +-
 drivers/pci/dwc/pcie-kirin.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
index e51acee..518cd7e 100644
--- a/drivers/pci/dwc/pcie-hisi.c
+++ b/drivers/pci/dwc/pcie-hisi.c
@@ -223,7 +223,7 @@ static int hisi_pcie_link_up(struct dw_pcie *pci)
 	return hisi_pcie->soc_ops->hisi_pcie_link_up(hisi_pcie);
 }
 
-static struct dw_pcie_host_ops hisi_pcie_host_ops = {
+static const struct dw_pcie_host_ops hisi_pcie_host_ops = {
 	.rd_own_conf = hisi_pcie_cfg_read,
 	.wr_own_conf = hisi_pcie_cfg_write,
 };
diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
index 33fddb9..a623f96 100644
--- a/drivers/pci/dwc/pcie-kirin.c
+++ b/drivers/pci/dwc/pcie-kirin.c
@@ -441,7 +441,7 @@ static void kirin_pcie_host_init(struct pcie_port *pp)
 	.link_up = kirin_pcie_link_up,
 };
 
-static struct dw_pcie_host_ops kirin_pcie_host_ops = {
+static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
 	.rd_own_conf = kirin_pcie_rd_own_conf,
 	.wr_own_conf = kirin_pcie_wr_own_conf,
 	.host_init = kirin_pcie_host_init,
-- 
1.9.1
