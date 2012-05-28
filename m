Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([58.251.152.66]:47443 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab2E1Hx7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 May 2012 03:53:59 -0400
Received: from huawei.com (szxga03-in [172.24.2.9])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4Q009ZK2CI3B@szxga03-in.huawei.com> for
 linux-pci@vger.kernel.org; Mon, 28 May 2012 15:33:54 +0800 (CST)
Received: from szxrg01-dlp.huawei.com ([172.24.2.119])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4Q00MCJ2C9HV@szxga03-in.huawei.com> for
 linux-pci@vger.kernel.org; Mon, 28 May 2012 15:33:54 +0800 (CST)
Date: Mon, 28 May 2012 15:33:00 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH] PCI: export symbol pci_bus_sem to module
To: Bjorn Helgaas <bhelgaas@google.com>,
	Amos Kong <kongjianjun@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Message-id: <1338190380-5144-1-git-send-email-jiang.liu@huawei.com>
MIME-version: 1.0
Content-type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changeset "9080648 PCI: acpiphp: remove all functions in slot,
even without ACPI _EJx" introduces pci_bus_sem into the acpiphp
driver, but pci_bus_sem hasn't been exported to modules yet.
So export symbol pci_bus_sem to modules, otherwise the acpiphp
driver can't be built as module any more.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 drivers/pci/search.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 9d75dc8..e0c7a22 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -15,6 +15,8 @@
 #include "pci.h"
 
 DECLARE_RWSEM(pci_bus_sem);
+EXPORT_SYMBOL(pci_bus_sem);
+
 /*
  * find the upstream PCIe-to-PCI bridge of a PCI device
  * if the device is PCIE, return NULL
-- 
1.7.1


