Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:55513 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756771AbcHCIom (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2016 04:44:42 -0400
Message-Id: <2854e6672ea67bdbbf0edb3a6418ea4c013fb91c.1470213106.git.lukas@wunner.de>
In-Reply-To: <20160726164038.1481-1-andreas.noever@gmail.com>
References: <20160726164038.1481-1-andreas.noever@gmail.com>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 3 Aug 2016 10:44:12 +0200
Subject: [PATCH] thunderbolt: Don't declare Falcon Ridge unsupported
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>
Cc: Xavier Gnata <xavier.gnata@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Falcon Ridge 4C has been supported by the driver from the beginning,
Falcon Ridge 2C support was just added. Don't irritate users with a
warning declaring the opposite.

Cc: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/thunderbolt/switch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 1e116f5..9840fde 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -372,7 +372,9 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, u64 route)
 
 	if (sw->config.device_id != PCI_DEVICE_ID_INTEL_LIGHT_RIDGE &&
 	    sw->config.device_id != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
-	    sw->config.device_id != PCI_DEVICE_ID_INTEL_PORT_RIDGE)
+	    sw->config.device_id != PCI_DEVICE_ID_INTEL_PORT_RIDGE &&
+	    sw->config.device_id != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE &&
+	    sw->config.device_id != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE)
 		tb_sw_warn(sw, "unsupported switch device id %#x\n",
 			   sw->config.device_id);
 
-- 
2.8.1

