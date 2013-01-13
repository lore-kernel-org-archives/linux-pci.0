Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f73.google.com ([209.85.215.73]:62794 "EHLO
	mail-la0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab3AMXdY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Jan 2013 18:33:24 -0500
Received: by mail-la0-f73.google.com with SMTP id fq13so214225lab.2
        for <linux-pci@vger.kernel.org>; Sun, 13 Jan 2013 15:33:22 -0800 (PST)
Subject: [PATCH v7 2/4] PCI: shpchp: Make shpchp_wq non-ordered
To: Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Daniel J Blueman <daniel@quora.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Tejun Heo <tj@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <liuj97@gmail.com>
Date: Sun, 13 Jan 2013 16:27:43 -0700
Message-ID: <20130113232743.7225.11180.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20130113232606.7225.94802.stgit@bhelgaas.mtv.corp.google.com>
References: <20130113232606.7225.94802.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

e24dcbef93 ("shpchp: update workqueue usage") was described as adding
non-ordered shpchp_wq, but it actually made it an *ordered* workqueue.

This patch changes shpchp_wq to be non-ordered, as described in the
e24dcbef93 commit log and as was done for pciehp by a827ea307b ("pciehp:
update workqueue usage").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Tejun Heo <tj@kernel.org>
---
 drivers/pci/hotplug/shpchp_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index b6de307..59ca86c 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -366,7 +366,7 @@ static int __init shpcd_init(void)
 {
 	int retval = 0;
 
-	shpchp_wq = alloc_ordered_workqueue("shpchp", 0);
+	shpchp_wq = alloc_workqueue("shpchp", 0, 0);
 	if (!shpchp_wq)
 		return -ENOMEM;
 

