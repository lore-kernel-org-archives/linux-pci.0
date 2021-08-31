Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DE8C432BE
	for <linux-pci@archiver.kernel.org>; Tue, 31 Aug 2021 07:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4107760F23
	for <linux-pci@archiver.kernel.org>; Tue, 31 Aug 2021 07:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbhHaH4u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 31 Aug 2021 03:56:50 -0400
Received: from mailgw.kylinos.cn ([123.150.8.42]:15037 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240042AbhHaH4t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Aug 2021 03:56:49 -0400
X-UUID: f110768550af4e67adecc495e18cfae1-20210831
X-CPASD-INFO: 28d840706ec84b87ac91782c99a21c10
        @e4ieWGFiZWBihaWEg6WDcYGUaWFnZFKye3OBYl-
        TXVCVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3gXqeWGReZw==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: 28d840706ec84b87ac91782c99a21c10
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:0.0,URL:-5,T
        VAL:196.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:174.0,IP:-2.0,MAL:0.0,ATTNUM:0
        .0,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CF
        OB:0.0,SPC:0.0,SIG:-5,AUF:2,DUF:10512,ACD:27,DCD:129,SL:0,AG:0,CFC:0.647,CFSR
        :0.029,UAT:0,RAF:0,VERSION:2.3.4
X-CPASD-ID: f110768550af4e67adecc495e18cfae1-20210831
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1, 1
X-UUID: f110768550af4e67adecc495e18cfae1-20210831
X-User: lizhenneng@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <lizhenneng@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1145832434; Tue, 31 Aug 2021 15:53:40 +0800
From:   Zhenneng Li <lizhenneng@kylinos.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhenneng Li <lizhenneng@kylinos.cn>
Subject: [PATCH] PCI/sysfs: add write attribute for boot_vga
Date:   Tue, 31 Aug 2021 15:55:28 +0800
Message-Id: <20210831075528.535909-1-lizhenneng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add writing attribute for boot_vga sys node,
so we can config default video display
output dynamically when there are two video
cards on a machine.

Xorg server will determine running on which
video card based on boot_vga node's value.

Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
---
 drivers/pci/pci-sysfs.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7bbf2673c7f2..a6ba19ce7adb 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -664,7 +664,29 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 			  !!(pdev->resource[PCI_ROM_RESOURCE].flags &
 			     IORESOURCE_ROM_SHADOW));
 }
-static DEVICE_ATTR_RO(boot_vga);
+
+static ssize_t boot_vga_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	unsigned long val;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *vga_dev = vga_default_device();
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val != 1)
+		return -EINVAL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (pdev != vga_dev)
+		vga_set_default_device(pdev);
+
+	return count;
+}
+static DEVICE_ATTR_RW(boot_vga);
 
 static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *bin_attr, char *buf,
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
