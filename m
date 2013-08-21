Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:37076 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab3HUXjR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2013 19:39:17 -0400
Received: by mail-oa0-f52.google.com with SMTP id f4so1199989oah.39
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2013 16:39:17 -0700 (PDT)
Subject: [PATCH v7 1/5] PCI: Drop "PCI-E" prefix from Max Payload Size
 message
To: Yijing Wang <wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	jiang.liu@huawei.com, Hanjun Guo <guohanjun@huawei.com>
Date: Wed, 21 Aug 2013 17:39:14 -0600
Message-ID: <20130821233914.2300.6269.stgit@bhelgaas-glaptop>
In-Reply-To: <20130821233722.2300.81773.stgit@bhelgaas-glaptop>
References: <20130821233722.2300.81773.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The conventional spelling is "PCIe", but I think even that is superfluous,
so remove the whole thing.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 46ada5c..9a33430 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1596,7 +1596,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 	pcie_write_mps(dev, mps);
 	pcie_write_mrrs(dev);
 
-	dev_info(&dev->dev, "PCI-E Max Payload Size set to %4d/%4d (was %4d), "
+	dev_info(&dev->dev, "Max Payload Size set to %4d/%4d (was %4d), "
 		 "Max Read Rq %4d\n", pcie_get_mps(dev), 128 << dev->pcie_mpss,
 		 orig_mps, pcie_get_readrq(dev));
 

