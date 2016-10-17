Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36628 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934300AbcJQPFA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 11:05:00 -0400
Received: by mail-pa0-f66.google.com with SMTP id os4so5252610pac.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Oct 2016 08:05:00 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH -next] x86/PCI: VMD: Remove unnecessary pci_set_drvdata()
Date: Mon, 17 Oct 2016 15:04:44 +0000
Message-Id: <1476716684-6778-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/host/vmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 37e29b5..6614b3552 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -719,7 +719,6 @@ static void vmd_remove(struct pci_dev *dev)
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
 
 	vmd_detach_resources(vmd);
-	pci_set_drvdata(dev, NULL);
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_stop_root_bus(vmd->bus);
 	pci_remove_root_bus(vmd->bus);



