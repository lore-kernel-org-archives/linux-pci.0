Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:48192
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727422AbeHJSPe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Aug 2018 14:15:34 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 1/4] PCI: Add setup_platform_service_irq hook to struct pci_host_bridge
Date: Fri, 10 Aug 2018 21:09:37 +0530
Message-ID: <1533915580-31805-2-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add setup_platform_service_irq hook to struct pci_host_bridge.
Some platforms have dedicated interrupt line from root complex to
interrupt controller for PCIe services like AER/PME etc.
This hook is to register platform IRQ's to PCIe port services.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 include/linux/pci.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b..c28f575 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -470,6 +470,7 @@ struct pci_host_bridge {
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
+	int (*setup_platform_service_irq)(struct pci_host_bridge *, int *, int);
 	void		*release_data;
 	struct msi_controller *msi;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
-- 
1.7.1
