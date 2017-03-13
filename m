Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:12244 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbdCMOZX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2017 10:25:23 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <hch@infradead.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v4 16/23] PCI: Add device IDs for DRA74x and DRA72x
Date: Mon, 13 Mar 2017 19:52:52 +0530
Message-ID: <20170313142259.25397-17-kishon@ti.com>
In-Reply-To: <20170313142259.25397-1-kishon@ti.com>
References: <20170313142259.25397-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add device IDs for DRA74x and DRA72x devices. These devices have
configurable PCI endpoint.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a4f77feecbb0..5f6b71d15393 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -862,6 +862,8 @@
 #define PCI_DEVICE_ID_TI_X620		0xac8d
 #define PCI_DEVICE_ID_TI_X420		0xac8e
 #define PCI_DEVICE_ID_TI_XX20_FM	0xac8f
+#define PCI_DEVICE_ID_TI_DRA74x		0xb500
+#define PCI_DEVICE_ID_TI_DRA72x		0xb501
 
 #define PCI_VENDOR_ID_SONY		0x104d
 
-- 
2.11.0
