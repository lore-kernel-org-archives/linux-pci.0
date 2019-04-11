Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7F2C10F14
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB28217D4
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZH75nVMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDKRF4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:05:56 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7215 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfDKRF4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:05:56 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf73f00001>; Thu, 11 Apr 2019 10:05:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:05:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 11 Apr 2019 10:05:55 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:05:55 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:05:51 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 22/30] PCI: tegra: Access endpoint config only if PCIe link is up
Date:   Thu, 11 Apr 2019 22:33:47 +0530
Message-ID: <20190411170355.6882-23-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002353; bh=/uTwWlgzwk7z7SGRbNXlsQHwX59fQj2PYyUrVtTu+VQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZH75nVMYMSaI8DGvVuFudCl2JdRAvqqKCePggd+hN+gw7fJueskwDe+9tBy0o7DqN
         cHaadeXC9H3w/AsQ6WdwEhiFaz63gBd9NlSy6tMPjqrRiUSPUe1k9cjeUMd+D0b1fk
         gS/Wd3qnQDUe2whM3sDkJFbhjhMpm27Bv2co57lFsiS9c7+/LbNJW7LzPRM3q1AWYr
         L56He1vOE0i0qXAH/9c9ZlpEfKCXMMyevWz2vCaSkRkQBo3+8qnvuk6QBtr7y/orzt
         JFlpF9QytZRU3GNpPpLqPYOFqkHZQBBhDfHxFtGA0INIuOv8ZTe+GiVzTQNRZnlIxB
         BLtipMd/m9mlw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe link up check in config read and write callback functions
before accessing endpoint config registers.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index d08a63132c77..c050687020f0 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -426,6 +426,14 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
 	return readl(pcie->pads + offset);
 }
 
+static bool tegra_pcie_link_status(struct tegra_pcie_port *port)
+{
+	u32 value;
+
+	value = readl(port->base + RP_LINK_CONTROL_STATUS);
+	return !!(value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE);
+}
+
 /*
  * The configuration space mapping on Tegra is somewhat similar to the ECAM
  * defined by PCIe. However it deviates a bit in how the 4 bits for extended
@@ -491,20 +499,50 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 static int tegra_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 *value)
 {
+	struct tegra_pcie *pcie = bus->sysdata;
+	struct pci_dev *bridge;
+	struct tegra_pcie_port *port;
+
 	if (bus->number == 0)
 		return pci_generic_config_read32(bus, devfn, where, size,
 						 value);
 
+	bridge = pcie_find_root_port(bus->self);
+
+	list_for_each_entry(port, &pcie->ports, list)
+		if (port->index + 1 == PCI_SLOT(bridge->devfn))
+			break;
+
+	/* If there is no link, then there is no device */
+	if (!tegra_pcie_link_status(port)) {
+		*value = 0xffffffff;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
 	return pci_generic_config_read(bus, devfn, where, size, value);
 }
 
 static int tegra_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
 				   int where, int size, u32 value)
 {
+	struct tegra_pcie *pcie = bus->sysdata;
+	struct tegra_pcie_port *port;
+	struct pci_dev *bridge;
+
 	if (bus->number == 0)
 		return pci_generic_config_write32(bus, devfn, where, size,
 						  value);
 
+	bridge = pcie_find_root_port(bus->self);
+
+	list_for_each_entry(port, &pcie->ports, list)
+		if (port->index + 1 == PCI_SLOT(bridge->devfn))
+			break;
+
+	/* If there is no link, then there is no device */
+	if (!tegra_pcie_link_status(port))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	return pci_generic_config_write(bus, devfn, where, size, value);
 }
 
-- 
2.17.1

