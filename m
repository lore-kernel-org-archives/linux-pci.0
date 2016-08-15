Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Ley Foon Tan <lftan.linux@gmail.com>,
	Ley Foon Tan <lftan@altera.com>
Subject: [PATCH] PCI: altera: Retrain link in rootport mode only
Date: Mon, 15 Aug 2016 16:36:19 +0800
Message-ID: <1471250179-24198-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Altera PCIe IP can be configured as rootport or device and they might have
same vendor ID. It will cause the system hang issue if Altera PCIe is in
endpoint mode and work with other PCIe rootport that from other vendors.
So, add the rootport mode checking in link retrain fixup function.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/host/pcie-altera.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 58eef99..6477738 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -139,6 +139,9 @@ static void altera_pcie_retrain(struct pci_dev *dev)
 	u16 linkcap, linkstat;
 	struct altera_pcie *pcie = dev->bus->sysdata;
 
+	if (!pci_is_root_bus(dev->bus))
+		return;
+
 	if (!altera_pcie_link_is_up(pcie))
 		return;
 
-- 
1.8.2.1
