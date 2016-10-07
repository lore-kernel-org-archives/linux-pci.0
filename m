Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964789AbcJGQiF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:38:05 -0400
Subject: [PATCH 09/11] PCI: hisi: Include register block base in
 PCIE_SYS_STATE4 register address
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:38:01 -0500
Message-ID: <20161007163801.25540.80597.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Include the PCIE_HIP06_CTRL_OFF block base in the PCIE_SYS_STATE4 register
address so reads of PCIE_SYS_STATE4 don't have to mention both.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 707dafd..405a7f7 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -22,11 +22,11 @@
 
 #include "pcie-designware.h"
 
-#define PCIE_LTSSM_LINKUP_STATE				0x11
-#define PCIE_LTSSM_STATE_MASK				0x3F
-#define PCIE_SUBCTRL_SYS_STATE4_REG			0x6818
-#define PCIE_SYS_STATE4						0x31c
-#define PCIE_HIP06_CTRL_OFF					0x1000
+#define PCIE_SUBCTRL_SYS_STATE4_REG		0x6818
+#define PCIE_HIP06_CTRL_OFF			0x1000
+#define PCIE_SYS_STATE4				(PCIE_HIP06_CTRL_OFF + 0x31c)
+#define PCIE_LTSSM_LINKUP_STATE			0x11
+#define PCIE_LTSSM_STATE_MASK			0x3F
 
 #define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
 
@@ -104,8 +104,7 @@ static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi)
 {
 	u32 val;
 
-	val = dw_pcie_readl_rc(&hisi->pp, PCIE_HIP06_CTRL_OFF + PCIE_SYS_STATE4);
-
+	val = dw_pcie_readl_rc(&hisi->pp, PCIE_SYS_STATE4);
 	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
 }
 

