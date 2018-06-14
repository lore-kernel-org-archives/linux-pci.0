Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39358 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbeFNMVt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jun 2018 08:21:49 -0400
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: fix restoring resized BAR state on resume
Date: Thu, 14 Jun 2018 14:21:45 +0200
Message-Id: <20180614122146.62118-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Resize BARs after resume to the expected size again.

Signed-off-by: Christian König <christian.koenig@amd.com>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199959
CC: stable@vger.kernel.org      # v4.15+
---
 drivers/pci/pci.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bd6f156dc3cf..d4685090378b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1159,6 +1159,33 @@ static void pci_restore_config_space(struct pci_dev *pdev)
 	}
 }
 
+static void pci_restore_rebar_state(struct pci_dev *pdev)
+{
+	unsigned int pos, nbars, i;
+	u32 ctrl;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+	if (!pos)
+		return;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
+		    PCI_REBAR_CTRL_NBAR_SHIFT;
+
+	for (i = 0; i < nbars; i++, pos += 8) {
+		struct resource *res;
+		int bar_idx, size;
+
+		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
+		res = pdev->resource + bar_idx;
+		size = order_base_2((resource_size(res) >> 20) | 1) - 1;
+		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
+		ctrl |= size << 8;
+		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
+	}
+}
+
 /**
  * pci_restore_state - Restore the saved state of a PCI device
  * @dev: - PCI device that we're dealing with
@@ -1174,6 +1201,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_pri_state(dev);
 	pci_restore_ats_state(dev);
 	pci_restore_vc_state(dev);
+	pci_restore_rebar_state(dev);
 
 	pci_cleanup_aer_error_status_regs(dev);
 
-- 
2.14.1
