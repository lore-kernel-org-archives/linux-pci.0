Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38351 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbbKOMhw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2015 07:37:52 -0500
From: Bogicevic Sasa <brutallesale@gmail.com>
To: bhelgaas@google.com
Cc: wangyijing@huawei.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bogicevic Sasa <brutallesale@gmail.com>
Subject: [PATCH] drivers:pci:hotplug Fix space prohibited after function name
Date: Sun, 15 Nov 2015 13:37:36 +0100
Message-Id: <1447591056-3733-1-git-send-email-brutallesale@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fixes warning that a space is prohibited after function name

Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 2bac1b9..d379d49 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -226,7 +226,7 @@ static ssize_t test_write_file(struct pci_slot *pci_slot, const char *buf,
 	u32 test;
 	int retval = 0;
 
-	ltest = simple_strtoul (buf, NULL, 10);
+	ltest = simple_strtoul(buf, NULL, 10);
 	test = (u32)(ltest & 0xffffffff);
 	dbg("test = %d\n", test);
 
-- 
2.1.4

