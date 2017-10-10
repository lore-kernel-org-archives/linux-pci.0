Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:32281 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754416AbdJJKRK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2017 06:17:10 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>
Subject: [PATCH 3/4] PCI: dwc: dra7xx: Add support for SoC specific compatible strings
Date: Tue, 10 Oct 2017 15:46:05 +0530
Message-ID: <20171010101606.15951-4-kishon@ti.com>
In-Reply-To: <20171010101606.15951-1-kishon@ti.com>
References: <20171010101606.15951-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

dra74x/dra76x and dra72x has separate compatible strings. Add support
for these compatible strings in pci-dra7xx driver.

This is a preparatory patch for adding 2-lane mode support and
dra74/dra72 should add it's own driver data for 2-lane mode
configuration.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 362607f727ee..78a87a8f1362 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -542,6 +542,22 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
 		.compatible = "ti,dra7-pcie-ep",
 		.data = &dra7xx_pcie_ep_of_data,
 	},
+	{
+		.compatible = "ti,dra746-pcie-rc",
+		.data = &dra7xx_pcie_rc_of_data,
+	},
+	{
+		.compatible = "ti,dra746-pcie-ep",
+		.data = &dra7xx_pcie_ep_of_data,
+	},
+	{
+		.compatible = "ti,dra726-pcie-rc",
+		.data = &dra7xx_pcie_rc_of_data,
+	},
+	{
+		.compatible = "ti,dra726-pcie-ep",
+		.data = &dra7xx_pcie_ep_of_data,
+	},
 	{},
 };
 
-- 
2.11.0
