Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35410 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbbKOMoE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2015 07:44:04 -0500
From: Bogicevic Sasa <brutallesale@gmail.com>
To: bhelgaas@google.com
Cc: wangyijing@huawei.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bogicevic Sasa <brutallesale@gmail.com>
Subject: [PATCH] drivers:pci:hotplug Fix  simple_strtoul is obsolete, use kstrtoul instead
Date: Sun, 15 Nov 2015 13:43:55 +0100
Message-Id: <1447591435-3957-1-git-send-email-brutallesale@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fixes messages "simple_strtoul is obsolete, use kstrtoul instead"
from checkpatch.pl script

Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index d379d49..a1160c8 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -103,7 +103,7 @@ static ssize_t power_write_file(struct pci_slot *pci_slot, const char *buf,
 	u8 power;
 	int retval = 0;
 
-	lpower = simple_strtoul(buf, NULL, 10);
+	lpower = kstrtoul(buf, NULL, 10);
 	power = (u8)(lpower & 0xff);
 	dbg("power = %d\n", power);
 
@@ -160,7 +160,7 @@ static ssize_t attention_write_file(struct pci_slot *pci_slot, const char *buf,
 	u8 attention;
 	int retval = 0;
 
-	lattention = simple_strtoul(buf, NULL, 10);
+	lattention = kstrtoul(buf, NULL, 10);
 	attention = (u8)(lattention & 0xff);
 	dbg(" - attention = %d\n", attention);
 
@@ -226,7 +226,7 @@ static ssize_t test_write_file(struct pci_slot *pci_slot, const char *buf,
 	u32 test;
 	int retval = 0;
 
-	ltest = simple_strtoul(buf, NULL, 10);
+	ltest = kstrtoul(buf, NULL, 10);
 	test = (u32)(ltest & 0xffffffff);
 	dbg("test = %d\n", test);
 
-- 
2.1.4

