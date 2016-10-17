Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33631 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932489AbcJQO5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 10:57:44 -0400
Received: by mail-pa0-f66.google.com with SMTP id hh10so9329994pac.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Oct 2016 07:57:44 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH -next] PCI: rockchip: Add missing of_node_put() in rockchip_pcie_init_irq_domain()
Date: Mon, 17 Oct 2016 14:57:22 +0000
Message-Id: <1476716242-31684-1-git-send-email-weiyj.lk@gmail.com>
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
 drivers/pci/host/pcie-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index e0b22da..ab88859 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -949,6 +949,7 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
 						    &intx_domain_ops, rockchip);
 	if (!rockchip->irq_domain) {
 		dev_err(dev, "failed to get a INTx IRQ domain\n");
+		of_node_put(intc);
 		return -EINVAL;
 	}

