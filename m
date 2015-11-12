Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jisheng Zhang <jszhang@marvell.com>
To: <wangzhou1@hisilicon.com>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] PCI: hisi: Fix Section mismatch compilation warning for probe()
Date: Thu, 12 Nov 2015 20:02:08 +0800
Message-ID: <1447329728-1589-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Following compilation warning occurs when compiled with:
CONFIG_DEBUG_SECTION_MISMATCH=y

 WARNING: drivers/pci/host/built-in.o(.data+0x308): Section mismatch in
 reference from the variable hisi_pcie_driver to the function
 .init.text:hisi_pcie_probe()

Fix it by dropping __init from hisi_pcie_probe().

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Fixes: 500a1d9a43e0 ("PCI: hisi: Add HiSilicon SoC Hip05 PCIe driver")
---
 drivers/pci/host/pcie-hisi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 35457ec..1cc0a21 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -139,7 +139,7 @@ static int __init hisi_add_pcie_port(struct pcie_port *pp,
 	return 0;
 }
 
-static int __init hisi_pcie_probe(struct platform_device *pdev)
+static int hisi_pcie_probe(struct platform_device *pdev)
 {
 	struct hisi_pcie *hisi_pcie;
 	struct pcie_port *pp;
-- 
2.6.2

