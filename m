Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36842 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbcJQO6p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 10:58:45 -0400
Received: by mail-pa0-f67.google.com with SMTP id os4so5247391pac.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Oct 2016 07:58:44 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: bhelgaas@google.com, michal.simek@xilinx.com,
        soren.brinkmann@xilinx.com, bharat.kumar.gogada@xilinx.com,
        robh@kernel.org, paul.gortmaker@windriver.com,
        colin.king@canonical.com
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH -next] PCI: xilinx-nwl: Add missing of_node_put() in nwl_pcie_init_irq_domain()
Date: Mon, 17 Oct 2016 14:58:17 +0000
Message-Id: <1476716297-31808-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

This node pointer is returned by of_get_next_child() with refcount
incremented in this function. of_node_put() on it before exitting
this function on error.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 43eaa4a..c16b26c 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -535,6 +535,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 
 	if (!pcie->legacy_irq_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
+		of_node_put(legacy_intc_node);
 		return -ENOMEM;
 	}

