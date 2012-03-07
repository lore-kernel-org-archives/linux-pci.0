Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:30889
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751147Ab2CGHOg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2012 02:14:36 -0500
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <jbarnes@virtuousgeek.org>, Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: [PATCH] PCI: PCIe: Fix uninitialized variable 'cap_mask'
Date: Wed, 7 Mar 2012 15:16:26 +0800
Message-ID: <1331104586-5720-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Get rid of these:

drivers/pci/pcie/portdrv_core.c: In function 'pcie_port_device_register':
drivers/pci/pcie/portdrv_core.c:275:16: warning: 'cap_mask' may be used
uninitialized in this function [-Wuninitialized]
drivers/pci/pcie/portdrv_core.c:240:6: note: 'cap_mask' was declared here

In some cases, 'cap_mask' may be not set in pcie_port_platform_notify,
holding a garbage value.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 drivers/pci/pcie/portdrv_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 595654a..751b464 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -237,7 +237,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	int services = 0, pos;
 	u16 reg16;
 	u32 reg32;
-	int cap_mask;
+	int cap_mask = 0;
 	int err;
 
 	if (pcie_ports_disabled)
-- 
1.5.6.5


