Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35992 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425157AbdD1Izz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2017 04:55:55 -0400
Received: by mail-pg0-f67.google.com with SMTP id v1so4379409pgv.3
        for <linux-pci@vger.kernel.org>; Fri, 28 Apr 2017 01:55:54 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH -next] PCI: endpoint: functions: Fix return value check in pci_epf_test_probe()
Date: Fri, 28 Apr 2017 08:55:48 +0000
Message-Id: <20170428085548.15942-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix the return value check which testing the wrong variable
in pci_epf_test_probe().

Fixes: 79ba640e377b ("PCI: endpoint: functions: Add an EP function
to test PCI")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d6a7a12..53fff80 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -441,7 +441,7 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 	struct device *dev = &epf->dev;
 
 	epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
-	if (!epf)
+	if (!epf_test)
 		return -ENOMEM;
 
 	epf->header = &test_header;
