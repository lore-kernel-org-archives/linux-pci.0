Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32996 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbcDJKsg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Apr 2016 06:48:36 -0400
From: Andreas Noever <andreas.noever@gmail.com>
To: helgaas@kernel.org, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
Subject: [PATCH] thunderbolt: Fix double free of drom buffer
Date: Sun, 10 Apr 2016 12:48:27 +0200
Message-Id: <1460285307-3557-1-git-send-email-andreas.noever@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If tb_drom_read fails sw->drom is freed but not set to NULL. sw->drom
is then freed again in the error path of sw_switch_alloc.

The bug can be triggered by unplugging a thunderbolt device shortly
after it is detected by the thunderbolt driver.

Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org
---
 drivers/thunderbolt/eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 0dde34e..545c60c 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -444,6 +444,7 @@ int tb_drom_read(struct tb_switch *sw)
 	return tb_drom_parse_entries(sw);
 err:
 	kfree(sw->drom);
+	sw->drom = NULL;
 	return -EIO;
 
 }
-- 
2.8.0

