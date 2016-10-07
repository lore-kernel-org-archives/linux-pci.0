Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964789AbcJGQhq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:37:46 -0400
Subject: [PATCH 07/11] PCI: hisi: Swap order of hisi_apb_writel() reg/val
 arguments
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:37:41 -0500
Message-ID: <20161007163741.25540.5909.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of hisi_apb_writel() arguments to match the "dev, pos, val"
order used by pci_write_config_word() and other drivers.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index e14ce13..c6b0459 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -48,7 +48,7 @@ static u32 hisi_apb_readl(struct hisi_pcie *hisi, u32 reg)
 	return readl(hisi->pp.dbi_base + reg);
 }
 
-static void hisi_apb_writel(struct hisi_pcie *hisi, u32 val, u32 reg)
+static void hisi_apb_writel(struct hisi_pcie *hisi, u32 reg, u32 val)
 {
 	writel(val, hisi->pp.dbi_base + reg);
 }
@@ -88,15 +88,15 @@ static int hisi_cfg_write(struct pcie_port *pp, int where, int  size, u32 val)
 	walker += (where & 0x3);
 	reg = where & ~0x3;
 	if (size == 4)
-		hisi_apb_writel(hisi, val, reg);
+		hisi_apb_writel(hisi, reg, val);
 	else if (size == 2) {
 		reg_val = hisi_apb_readl(hisi, reg);
 		*(u16 __force *) walker = val;
-		hisi_apb_writel(hisi, reg_val, reg);
+		hisi_apb_writel(hisi, reg, reg_val);
 	} else if (size == 1) {
 		reg_val = hisi_apb_readl(hisi, reg);
 		*(u8 __force *) walker = val;
-		hisi_apb_writel(hisi, reg_val, reg);
+		hisi_apb_writel(hisi, reg, reg_val);
 	} else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 

