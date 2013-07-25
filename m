Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:59713 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489Ab3GYR5b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2013 13:57:31 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so2239275obc.10
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2013 10:57:30 -0700 (PDT)
Subject: [PATCH 2/2] PCI: pciehp: Convert pciehp to be builtin only,
 not modular
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Paul Mundt <lethal@linux-sh.org>,
	Paul Mackerras <paulus@samba.org>,
	Yinghai Lu <yinghai@kernel.org>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 25 Jul 2013 11:57:27 -0600
Message-ID: <20130725175727.6006.98109.stgit@bhelgaas-glaptop>
In-Reply-To: <20130725175242.6006.56007.stgit@bhelgaas-glaptop>
References: <20130725175242.6006.56007.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Convert pciehp to be builtin only, with no module option.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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

