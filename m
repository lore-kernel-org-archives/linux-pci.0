Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50400 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdA3EwG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Jan 2017 23:52:06 -0500
From: Shailendra Verma <shailendra.v@samsung.com>
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.shailesh@samsung.com,
        ashish.kalra@samsung.com,
        Shailendra Verma <shailendra.v@samsung.com>,
        Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] Pci: host - Fix possible NULL derefrence.
Date: Mon, 30 Jan 2017 10:19:35 +0530
Message-id: <1485751775-29126-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170130044942epcas2p4c3e879675c189ff46c27b5f35bbc350f@epcas2p4.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

of_match_device could return NULL, and so can cause a NULL
pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 drivers/pci/host/pcie-hisi.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 56154c2..3256f8f 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -174,6 +174,10 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	driver = dev->driver;
 
 	match = of_match_device(driver->of_match_table, dev);
+	if (!match) {
+		dev_err(dev, "Error: No device match found\n");
+		return -ENODEV;
+	}
 	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
 
 	hisi_pcie->subctrl =
-- 
1.7.9.5

