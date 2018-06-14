Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44219 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754885AbeFNMVu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jun 2018 08:21:50 -0400
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: cleanup PCI_REBAR_CTRL_BAR_SHIFT handling
Date: Thu, 14 Jun 2018 14:21:46 +0200
Message-Id: <20180614122146.62118-2-christian.koenig@amd.com>
In-Reply-To: <20180614122146.62118-1-christian.koenig@amd.com>
References: <20180614122146.62118-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

That was hard coded instead of properly defined in the header for some
reason.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/pci.c             | 6 +++---
 include/uapi/linux/pci_regs.h | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d4685090378b..a905e35d9360 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1181,7 +1181,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
 		res = pdev->resource + bar_idx;
 		size = order_base_2((resource_size(res) >> 20) | 1) - 1;
 		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
-		ctrl |= size << 8;
+		ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
 		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
 	}
 }
@@ -3066,7 +3066,7 @@ int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
 		return pos;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-	return (ctrl & PCI_REBAR_CTRL_BAR_SIZE) >> 8;
+	return (ctrl & PCI_REBAR_CTRL_BAR_SIZE) >> PCI_REBAR_CTRL_BAR_SHIFT;
 }
 
 /**
@@ -3089,7 +3089,7 @@ int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
 	ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
-	ctrl |= size << 8;
+	ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
 	pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
 	return 0;
 }
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 0c79eac5e9b8..7358ad00f5dd 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -950,8 +950,9 @@
 #define PCI_REBAR_CTRL		8	/* control register */
 #define  PCI_REBAR_CTRL_BAR_IDX		0x00000007  /* BAR index */
 #define  PCI_REBAR_CTRL_NBAR_MASK	0x000000E0  /* # of resizable BARs */
-#define  PCI_REBAR_CTRL_NBAR_SHIFT	5  	    /* shift for # of BARs */
+#define  PCI_REBAR_CTRL_NBAR_SHIFT	5	    /* shift for # of BARs */
 #define  PCI_REBAR_CTRL_BAR_SIZE	0x00001F00  /* BAR size */
+#define  PCI_REBAR_CTRL_BAR_SHIFT	8	    /* shift for BAR size */
 
 /* Dynamic Power Allocation */
 #define PCI_DPA_CAP		4	/* capability register */
-- 
2.14.1
