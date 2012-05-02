Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34019 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab2EBOnb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 May 2012 10:43:31 -0400
Received: by pbbrp8 with SMTP id rp8so1180903pbb.19
        for <linux-pci@vger.kernel.org>; Wed, 02 May 2012 07:43:31 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Don Dutile <ddutile@redhat.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH] PCI, x86: avoid redundant insert_resource() call in pci_mmcfg_insert_resources()
Date: Wed,  2 May 2012 22:41:46 +0800
Message-Id: <1335969706-13604-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <20120427151726.870d6966.izumi.taku@jp.fujitsu.com>
References: <20120427151726.870d6966.izumi.taku@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

For hot-pluggable host bridges present at boot time, pci_mmconfig_insert() will
insert resources used by MMCFG items for those host bridges. So avoid redundant
call to insert_resource() when pci_mmcfg_insert_resources() is called later.

Reported-By: Taku Izumi <izumi.taku@jp.fujitsu.com>
Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/pci/mmconfig-shared.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index f4d9ff9..7bba722 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -371,8 +371,13 @@ static void __init pci_mmcfg_insert_resources(void)
 {
 	struct pci_mmcfg_region *cfg;
 
+	/*
+	 * Insert resources for MMCFG items if the resource hasn't been
+	 * inserted by pci_mmconfig_insert() yet.
+	 */
 	list_for_each_entry(cfg, &pci_mmcfg_list, list)
-		insert_resource(&iomem_resource, &cfg->res);
+		if (!cfg->res.parent)
+			insert_resource(&iomem_resource, &cfg->res);
 
 	/* Mark that the resources have been inserted. */
 	pci_mmcfg_resources_inserted = 1;
-- 
1.7.9.5

