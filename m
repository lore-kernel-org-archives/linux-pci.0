Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:64257 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbcEROQw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2016 10:16:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: host-generic: select IRQ_DOMAIN
Date: Wed, 18 May 2016 16:15:53 +0200
Message-Id: <1463581000-983246-1-git-send-email-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The generic PCI host controller calls of_irq_parse_and_map_pci
in its IRQ fixup, but that function is only available when
CONFIG_IRQ_DOMAIN is set:

drivers/pci/built-in.o: In function `pci_host_common_probe':
drivers/pci/host/pci-host-common.c:181: undefined reference to `of_irq_parse_and_map_pci'

There is no downside in enabling the domains here, so let's
use a Kconfig select statement to ensure it's always available
to this driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 66329b932e29..64734ba070a2 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -87,6 +87,7 @@ config PCI_HOST_GENERIC
 	bool "Generic PCI host controller"
 	depends on (ARM || ARM64) && OF
 	select PCI_HOST_COMMON
+	select IRQ_DOMAIN
 	help
 	  Say Y here if you want to support a simple generic PCI host
 	  controller, such as the one emulated by kvmtool.
-- 
2.7.0

