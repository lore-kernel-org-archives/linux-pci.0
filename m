Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62922 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933709Ab3GWSIY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2013 14:08:24 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so12092794oag.33
        for <linux-pci@vger.kernel.org>; Tue, 23 Jul 2013 11:08:23 -0700 (PDT)
Subject: [PATCH] PCI: pciehp: Convert pciehp to be builtin only, not modular
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Date: Tue, 23 Jul 2013 12:08:21 -0600
Message-ID: <20130723180821.19616.52936.stgit@bhelgaas-glaptop>
In-Reply-To: <20130723180001.19616.72450.stgit@bhelgaas-glaptop>
References: <20130723180001.19616.72450.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Convert pciehp to be builtin only, with no module option.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/Kconfig |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 569f82f..3b94cfc 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -14,15 +14,12 @@ config PCIEPORTBUS
 # Include service Kconfig here
 #
 config HOTPLUG_PCI_PCIE
-	tristate "PCI Express Hotplug driver"
+	bool "PCI Express Hotplug driver"
 	depends on HOTPLUG_PCI && PCIEPORTBUS
 	help
 	  Say Y here if you have a motherboard that supports PCI Express Native
 	  Hotplug
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called pciehp.
-
 	  When in doubt, say N.
 
 source "drivers/pci/pcie/aer/Kconfig"

