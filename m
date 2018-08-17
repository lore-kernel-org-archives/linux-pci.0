Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43200 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeHQLT4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2018 07:19:56 -0400
Received: by mail-pl0-f68.google.com with SMTP id x6-v6so3379858plv.10
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2018 01:17:30 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:1501:200:5efe:a66f:53fa])
        by smtp.gmail.com with ESMTPSA id t186-v6sm1509519pgd.77.2018.08.17.01.17.29
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 01:17:29 -0700 (PDT)
From: Jiecheng Wu <jasonwood2031@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH] dpc.c: fix missing return value check of pci_find_ext_capability()
Date: Fri, 17 Aug 2018 16:17:19 +0800
Message-Id: <20180817081719.11156-1-jasonwood2031@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function dpc_probe() defined in drivers/pci/pcie/dpc.c calls pci_find_ext_capability(). Function pci_find_ext_capability() returns the address of the requested extended capability structure within the device's PCI configuration space or 0 if the device does not support it. The return value of this function should be checked against 0.
---
 drivers/pci/pcie/dpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index f03279f..30ff550 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -226,6 +226,8 @@ static int dpc_probe(struct pcie_device *dev)
 		return -ENOMEM;
 
 	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
+	if (!dpc->cap_pos)
+		return -ENODEV;
 	dpc->dev = dev;
 	set_service_data(dev, dpc);
 
-- 
2.6.4
