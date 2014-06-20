Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:65122 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965694AbaFTNw2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jun 2014 09:52:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] thunderbolt: fix format string for size_t
Date: Fri, 20 Jun 2014 15:52:11 +0200
Message-Id: <1403272331-3790755-3-git-send-email-arnd@arndb.de>
In-Reply-To: <1403272331-3790755-1-git-send-email-arnd@arndb.de>
References: <1403272331-3790755-1-git-send-email-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The result of "sizeof(struct tb_drom_entry_port)" is a size_t, which
is not necessarily the same as 'long', so we should use the appropriate
%z format string instead of %l.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thunderbolt/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index bc0449f..b133f3f 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -323,7 +323,7 @@ static int tb_drom_parse_entry(struct tb_switch *sw,
 		struct tb_drom_entry_port *entry = (void *) header;
 		if (header->len != sizeof(*entry)) {
 			tb_sw_warn(sw,
-				"port entry has size %#x (expected %#lx)\n",
+				"port entry has size %#x (expected %#zx)\n",
 				header->len, sizeof(struct tb_drom_entry_port));
 			return -EIO;
 		}
-- 
1.8.3.2

