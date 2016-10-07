Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938966AbcJGQWX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:22:23 -0400
Subject: [PATCH 04/10] PCI: altera: Rename _altera_pcie_cfg_read() to
 altera_raw_cfg_read()
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Fri, 07 Oct 2016 11:22:19 -0500
Message-ID: <20161007162218.22796.11928.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename _altera_pcie_cfg_read() and _altera_pcie_cfg_write() to
altera_raw_cfg_read() and altera_raw_cfg_write() to convey a little
more information than an underline does.

The difference is that altera_pcie_cfg_read() requires a pointer to a
struct pci_bus, while altera_raw_cfg_read() needs only a pointer to a
struct altera_pcie, so it can be used before enumerating the bus.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 243e6bc..5362ac1 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -261,9 +261,9 @@ static int tlp_cfg_dword_write(struct altera_pcie *altera, u8 bus, u32 devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int _altera_pcie_cfg_read(struct altera_pcie *altera, u8 busno,
-				 unsigned int devfn, int where, int size,
-				 u32 *value)
+static int altera_raw_cfg_read(struct altera_pcie *altera, u8 busno,
+			       unsigned int devfn, int where, int size,
+			       u32 *value)
 {
 	int ret;
 	u32 data;
@@ -301,9 +301,9 @@ static int _altera_pcie_cfg_read(struct altera_pcie *altera, u8 busno,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int _altera_pcie_cfg_write(struct altera_pcie *altera, u8 busno,
-				  unsigned int devfn, int where, int size,
-				  u32 value)
+static int altera_raw_cfg_write(struct altera_pcie *altera, u8 busno,
+				unsigned int devfn, int where, int size,
+				u32 value)
 {
 	u32 data32;
 	u32 shift = 8 * (where & 3);
@@ -341,8 +341,8 @@ static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	return _altera_pcie_cfg_read(altera, bus->number, devfn, where, size,
-				     value);
+	return altera_raw_cfg_read(altera, bus->number, devfn, where, size,
+				   value);
 }
 
 static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
@@ -356,8 +356,8 @@ static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
 	if (!altera_pcie_valid_config(altera, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	return _altera_pcie_cfg_write(altera, bus->number, devfn, where, size,
-				     value);
+	return altera_raw_cfg_write(altera, bus->number, devfn, where, size,
+				    value);
 }
 
 static struct pci_ops altera_pcie_ops = {
@@ -371,9 +371,9 @@ static int altera_read_cap_word(struct altera_pcie *altera, u8 busno,
 	u32 data;
 	int ret;
 
-	ret = _altera_pcie_cfg_read(altera, busno, devfn,
-				    PCIE_CAP_OFFSET + offset, sizeof(*value),
-				    &data);
+	ret = altera_raw_cfg_read(altera, busno, devfn,
+				  PCIE_CAP_OFFSET + offset, sizeof(*value),
+				  &data);
 	*value = data;
 	return ret;
 }
@@ -381,9 +381,9 @@ static int altera_read_cap_word(struct altera_pcie *altera, u8 busno,
 static int altera_write_cap_word(struct altera_pcie *altera, u8 busno,
 				 unsigned int devfn, int offset, u16 value)
 {
-	return _altera_pcie_cfg_write(altera, busno, devfn,
-				      PCIE_CAP_OFFSET + offset, sizeof(value),
-				      value);
+	return altera_raw_cfg_write(altera, busno, devfn,
+				    PCIE_CAP_OFFSET + offset, sizeof(value),
+				    value);
 }
 
 static void altera_wait_link_retrain(struct altera_pcie *altera)

