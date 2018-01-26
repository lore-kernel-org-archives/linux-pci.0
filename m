Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752244AbeAZWz7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jan 2018 17:55:59 -0500
Subject: [PATCH 3/8] PCI/DPC: Rename struct dpc_dev.rp to rp_extensions
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>
Date: Fri, 26 Jan 2018 16:55:56 -0600
Message-ID: <20180126225556.58614.79210.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180126225043.58614.99920.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180126225043.58614.99920.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

"rp" is ambiguous: it might mean "this DPC device is a Root Port."  But in
fact, it means "this DPC device is a Root Port *and* it supports a set of
DPC Extensions."

Rename "rp" to "rp_extensions" to make this more clear.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/pcie-dpc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 52702f7b911a..0bbdf513067a 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -42,7 +42,7 @@ struct dpc_dev {
 	struct pcie_device	*dev;
 	struct work_struct	work;
 	u16			cap_pos;
-	bool			rp;
+	bool			rp_extensions;
 	u32			rp_pio_status;
 };
 
@@ -126,9 +126,9 @@ static void dpc_work(struct work_struct *work)
 	pci_unlock_rescan_remove();
 
 	dpc_wait_link_inactive(dpc);
-	if (dpc->rp && dpc_wait_rp_inactive(dpc))
+	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
 		return;
-	if (dpc->rp && dpc->rp_pio_status) {
+	if (dpc->rp_extensions && dpc->rp_pio_status) {
 		pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
 				       dpc->rp_pio_status);
 		dpc->rp_pio_status = 0;
@@ -326,7 +326,7 @@ static int dpc_probe(struct pcie_device *dev)
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
 
-	dpc->rp = (cap & PCI_EXP_DPC_CAP_RP_EXT);
+	dpc->rp_extensions = (cap & PCI_EXP_DPC_CAP_RP_EXT);
 
 	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
