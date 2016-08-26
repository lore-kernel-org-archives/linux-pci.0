Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0069.outbound.protection.outlook.com ([104.47.41.69]:49804
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756575AbcHZBtM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Aug 2016 21:49:12 -0400
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>,
        Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v4 1/2] PCI: altera: Rework configs accessors
Date: Fri, 26 Aug 2016 09:47:24 +0800
Message-ID: <1472176045-27815-2-git-send-email-lftan@altera.com>
In-Reply-To: <1472176045-27815-1-git-send-email-lftan@altera.com>
References: <1472176045-27815-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rework configs accessors so a future patch can use them in _probe()
with struct altera_pcie instead of struct pci_bus.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/host/pcie-altera.c | 64 +++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 58eef99..34e6258 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -330,22 +330,14 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
-				int where, int size, u32 *value)
+static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
+				 unsigned int devfn, int where, int size,
+				 u32 *value)
 {
-	struct altera_pcie *pcie = bus->sysdata;
 	int ret;
 	u32 data;
 	u8 byte_en;
 
-	if (altera_pcie_hide_rc_bar(bus, devfn, where))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn))) {
-		*value = 0xffffffff;
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
 	switch (size) {
 	case 1:
 		byte_en = 1 << (where & 3);
@@ -358,7 +350,7 @@ static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
 		break;
 	}
 
-	ret = tlp_cfg_dword_read(pcie, bus->number, devfn,
+	ret = tlp_cfg_dword_read(pcie, busno, devfn,
 				 (where & ~DWORD_MASK), byte_en, &data);
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
@@ -378,20 +370,14 @@ static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
-				 int where, int size, u32 value)
+static int _altera_pcie_cfg_write(struct altera_pcie *pcie, u8 busno,
+				  unsigned int devfn, int where, int size,
+				  u32 value)
 {
-	struct altera_pcie *pcie = bus->sysdata;
 	u32 data32;
 	u32 shift = 8 * (where & 3);
 	u8 byte_en;
 
-	if (altera_pcie_hide_rc_bar(bus, devfn, where))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
 	switch (size) {
 	case 1:
 		data32 = (value & 0xff) << shift;
@@ -407,8 +393,40 @@ static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
 		break;
 	}
 
-	return tlp_cfg_dword_write(pcie, bus->number, devfn,
-		(where & ~DWORD_MASK), byte_en, data32);
+	return tlp_cfg_dword_write(pcie, busno, devfn, (where & ~DWORD_MASK),
+				   byte_en, data32);
+}
+
+static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 *value)
+{
+	struct altera_pcie *pcie = bus->sysdata;
+
+	if (altera_pcie_hide_rc_bar(bus, devfn, where))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn))) {
+		*value = 0xffffffff;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	return _altera_pcie_cfg_read(pcie, bus->number, devfn, where, size,
+				     value);
+}
+
+static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 value)
+{
+	struct altera_pcie *pcie = bus->sysdata;
+
+	if (altera_pcie_hide_rc_bar(bus, devfn, where))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return _altera_pcie_cfg_write(pcie, bus->number, devfn, where, size,
+				     value);
 }
 
 static struct pci_ops altera_pcie_ops = {
-- 
1.8.2.1

