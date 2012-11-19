Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41487 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326Ab2KSSfQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Nov 2012 13:35:16 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: Scott Murray <scott@spiteful.org>, linux-pci@vger.kernel.org
Subject: [PATCH 475/493] pci: remove use of __devexit
Date: Mon, 19 Nov 2012 13:27:04 -0500
Message-Id: <1353349642-3677-475-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Scott Murray <scott@spiteful.org> 
Cc: linux-pci@vger.kernel.org 
---
 drivers/pci/hotplug/cpcihp_zt5550.c | 2 +-
 drivers/pci/ioapic.c                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
index 34b2a4a..449b4bb 100644
--- a/drivers/pci/hotplug/cpcihp_zt5550.c
+++ b/drivers/pci/hotplug/cpcihp_zt5550.c
@@ -271,7 +271,7 @@ init_hc_error:
 
 }
 
-static void __devexit zt5550_hc_remove_one(struct pci_dev *pdev)
+static void zt5550_hc_remove_one(struct pci_dev *pdev)
 {
 	cpci_hp_stop();
 	cpci_hp_unregister_bus(bus0);
diff --git a/drivers/pci/ioapic.c b/drivers/pci/ioapic.c
index 4fdc61e..3c6bbdd 100644
--- a/drivers/pci/ioapic.c
+++ b/drivers/pci/ioapic.c
@@ -88,7 +88,7 @@ exit_free:
 	return -ENODEV;
 }
 
-static void __devexit ioapic_remove(struct pci_dev *dev)
+static void ioapic_remove(struct pci_dev *dev)
 {
 	struct ioapic *ioapic = pci_get_drvdata(dev);
 
-- 
1.8.0

