Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34605 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933833AbeCGPmx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2018 10:42:53 -0500
Received: by mail-ot0-f195.google.com with SMTP id n74so2451931ota.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Mar 2018 07:42:53 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>
Subject: [PATCH 3/9] PCI: kirin: fix missing dependency on PCI_MSI_IRQ_DOMAIN
Date: Wed,  7 Mar 2018 09:42:37 -0600
Message-Id: <20180307154243.3205-4-robh@kernel.org>
In-Reply-To: <20180307154243.3205-1-robh@kernel.org>
References: <20180307154243.3205-1-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIE_DW_HOST depends on PCI_MSI_IRQ_DOMAIN and since kirin selects
PCIE_DW_HOST, it must also depend on PCI_MSI_IRQ_DOMAIN. This was found
by 0-day once building on all arches was enabled.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 0f666b1ce289..2f3f5c50aa48 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -176,6 +176,7 @@ config PCIE_ARTPEC6_EP
 config PCIE_KIRIN
 	depends on OF && ARM64
 	bool "HiSilicon Kirin series SoCs PCIe controllers"
+	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
-- 
2.14.1
