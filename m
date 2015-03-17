Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:47322 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbbCQMWm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2015 08:22:42 -0400
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux@arm.linux.org.uk
Cc: linux-kernel@codethink.co.uk,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Linux ARM Kernel list <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI List <linux-pci@vger.kernel.org>
Subject: [PATCH] ARM: add PCI hotplug support
Date: Tue, 17 Mar 2015 12:22:32 +0000
Message-Id: <1426594952-1456-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hotplug on PCIe should work with ARM, however the necessary
PCIe hotplug is not availale as the menu items for PCI hotplug
have not been included.

Add the include of PCI hotplug support to the ARM main Kconfig
so that it can be selected.

The only issue that was found during this is that the PCI code
did not assign interrupts properly to newly probed devices. This
will need to be fixed for any interrupt capable devices.

This has been tested on a Marvell 88F6281 with a TI XIO3130
PCIe bridge (with hotplug enabled) and fixes for IRQ assignment
added.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Linux ARM Kernel list <linux-arm-kernel@lists.infradead.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Linux PCI List <linux-pci@vger.kernel.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a..4574ab4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1302,6 +1302,7 @@ config PCI_HOST_ITE8152
 	select DMABOUNCE
 
 source "drivers/pci/Kconfig"
+source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/pcie/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
-- 
2.1.4

