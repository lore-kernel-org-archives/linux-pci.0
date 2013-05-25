Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:36616 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881Ab3EYLhD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 May 2013 07:37:03 -0400
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: [PATCH 1/3] PCI: add 0x prefix when printing the BAR registers position in __pci_read_base
Date: Sat, 25 May 2013 19:36:25 +0800
Message-ID: <1369481787-21500-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1369481787-21500-1-git-send-email-haokexin@gmail.com>
References: <1369481787-21500-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We print the BAR registers position in hexadecimal format, so it
is more readable if 0x prefix is added. Also fix the following
checkpatch warning:
  WARNING: Prefer dev_dbg(... to dev_printk(KERN_DEBUG, ...

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: A new patch introduced in v2.

 drivers/pci/probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 70f10fa..2505d5e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -278,9 +278,9 @@ out:
 		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
 
 	if (bar_too_big)
-		dev_err(&dev->dev, "reg %x: can't handle 64-bit BAR\n", pos);
+		dev_err(&dev->dev, "reg 0x%x: can't handle 64-bit BAR\n", pos);
 	if (res->flags && !bar_disabled)
-		dev_printk(KERN_DEBUG, &dev->dev, "reg %x: %pR\n", pos, res);
+		dev_dbg(&dev->dev, "reg 0x%x: %pR\n", pos, res);
 
 	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
 }
-- 
1.8.1.4

