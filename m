Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([58.251.152.67]:50979 "EHLO
	szxga04-in.huawei.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752070Ab2EZJyc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 26 May 2012 05:54:32 -0400
Received: from huawei.com (szxga04-in [172.24.2.12])
 by szxga04-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4M005O2JJTOV@szxga04-in.huawei.com> for
 linux-pci@vger.kernel.org; Sat, 26 May 2012 17:55:05 +0800 (CST)
Received: from szxrg01-dlp.huawei.com ([172.24.2.119])
 by szxga04-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4M00330JJT65@szxga04-in.huawei.com> for
 linux-pci@vger.kernel.org; Sat, 26 May 2012 17:55:05 +0800 (CST)
Date: Sat, 26 May 2012 17:54:03 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH v7 10/10] PCI, x86: get rid of redundant log messages
In-reply-to: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Message-id: <1338026043-3968-11-git-send-email-jiang.liu@huawei.com>
MIME-version: 1.0
Content-type: text/plain
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For each resource of a PCI host bridge, the arch code and PCI
code log following messages:
"pci_root PNP0A08:00: host bridge window [io 0x0000-0x03af]",
"pci_bus 0000:00: root bus resource [io  0x0000-0x03af]"

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/pci/acpi.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 76ad029..4368387 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -295,13 +295,6 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
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
1.7.1


