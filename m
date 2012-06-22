Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65325 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761253Ab2FVG6B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 02:58:01 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so3169265pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 23:58:01 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v10 10/13] x86/PCI: get rid of redundant log messages
Date: Fri, 22 Jun 2012 14:55:19 +0800
Message-Id: <1340348122-29021-11-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
References: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

For each resource of a PCI host bridge, the arch code and PCI
code log following messages:
"pci_root PNP0A08:00: host bridge window [io 0x0000-0x03af]",
"pci_bus 0000:00: root bus resource [io  0x0000-0x03af]"

Signed-off-by: Jiang Liu <liuj97@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/acpi.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 912b54b..505acdd 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -314,13 +314,6 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
 	}
 
 	info->res_num++;
-	if (addr.translation_offset)
-		dev_info(&info->bridge->dev, "host bridge window %pR "
-			 "(PCI address [%#llx-%#llx])\n",
-			 res, res->start - addr.translation_offset,
-			 res->end - addr.translation_offset);
-	else
-		dev_info(&info->bridge->dev, "host bridge window %pR\n", res);
 
 	return AE_OK;
 }
-- 
1.7.9.5

