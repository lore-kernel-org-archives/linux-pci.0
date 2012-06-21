Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:20468 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759195Ab2FUJrI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 05:47:08 -0400
From: Jiang Liu <jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
CC: Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	<linux-pci@vger.kernel.org>, Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v9 09/11] x86/PCI: get rid of redundant log messages
Date: Thu, 21 Jun 2012 17:37:01 +0800
Message-ID: <1340271423-4352-10-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
References: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For each resource of a PCI host bridge, the arch code and PCI
code log following messages:
"pci_root PNP0A08:00: host bridge window [io 0x0000-0x03af]",
"pci_bus 0000:00: root bus resource [io  0x0000-0x03af]"

Signed-off-by: Jiang Liu <liuj97@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/acpi.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index f701179..5f778ae 100644
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


