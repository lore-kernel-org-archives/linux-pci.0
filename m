Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41577 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836Ab2KSSh7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Nov 2012 13:37:59 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: Scott Murray <scott@spiteful.org>, linux-pci@vger.kernel.org
Subject: [PATCH 088/493] pci: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:20:37 -0500
Message-Id: <1353349642-3677-88-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Scott Murray <scott@spiteful.org> 
Cc: linux-pci@vger.kernel.org 
---
 drivers/pci/hotplug/cpcihp_zt5550.c | 2 +-
 drivers/pci/ioapic.c                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
index 6bf8d2a..34b2a4a 100644
--- a/drivers/pci/hotplug/cpcihp_zt5550.c
+++ b/drivers/pci/hotplug/cpcihp_zt5550.c
@@ -290,7 +290,7 @@ static struct pci_driver zt5550_hc_driver = {
 	.name		= "zt5550_hc",
 	.id_table	= zt5550_hc_pci_tbl,
 	.probe		= zt5550_hc_init_one,
-	.remove		= __devexit_p(zt5550_hc_remove_one),
+	.remove		= zt5550_hc_remove_one,
 };
 
 static int __init zt5550_init(void)
diff --git a/drivers/pci/ioapic.c b/drivers/pci/ioapic.c
index 22436f7..2b24fb4 100644
--- a/drivers/pci/ioapic.c
+++ b/drivers/pci/ioapic.c
@@ -110,7 +110,7 @@ static struct pci_driver ioapic_driver = {
 	.name		= "ioapic",
 	.id_table	= ioapic_devices,
 	.probe		= ioapic_probe,
-	.remove		= __devexit_p(ioapic_remove),
+	.remove		= ioapic_remove,
 };
 
 static int __init ioapic_init(void)
-- 
1.8.0

