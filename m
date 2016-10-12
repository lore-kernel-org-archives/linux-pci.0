Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755359AbcJLMrn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:47:43 -0400
Subject: [PATCH v2 5/6] PCI: altera: Simplify TLB_CFG_DW0 usage
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Wed, 12 Oct 2016 07:47:39 -0500
Message-ID: <20161012124739.23240.41668.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All TLP_CFG_DW0() uses follow the same pattern based on the root bus
number, so pull that into the macro itself to declutter the users.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index a99765a..8240130 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -55,7 +55,10 @@
 #define TLP_PAYLOAD_SIZE		0x01
 #define TLP_READ_TAG			0x1d
 #define TLP_WRITE_TAG			0x10
-#define TLP_CFG_DW0(fmttype)		(((fmttype) << 24) | TLP_PAYLOAD_SIZE)
+#define TLP_CFG_DW0(pcie, bus)						\
+    ((((bus == pcie->root_bus_nr) ? TLP_FMTTYPE_CFGRD0			\
+				    : TLP_FMTTYPE_CFGRD1) << 24) |	\
+     TLP_PAYLOAD_SIZE)
 #define TLP_CFG_DW1(reqid, tag, be)	(((reqid) << 16) | (tag << 8) | (be))
 #define TLP_CFG_DW2(bus, devfn, offset)	\
 				(((bus) << 24) | ((devfn) << 16) | (offset))
@@ -218,11 +221,7 @@ static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
 {
 	u32 headers[TLP_HDR_SIZE];
 
-	if (bus == pcie->root_bus_nr)
-		headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD0);
-	else
-		headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD1);
-
+	headers[0] = TLP_CFG_DW0(pcie, bus);
 	headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, RP_DEVFN),
 					TLP_READ_TAG, byte_en);
 	headers[2] = TLP_CFG_DW2(bus, devfn, where);
@@ -238,11 +237,7 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
 	u32 headers[TLP_HDR_SIZE];
 	int ret;
 
-	if (bus == pcie->root_bus_nr)
-		headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR0);
-	else
-		headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR1);
-
+	headers[0] = TLP_CFG_DW0(pcie, bus);
 	headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, RP_DEVFN),
 					TLP_WRITE_TAG, byte_en);
 	headers[2] = TLP_CFG_DW2(bus, devfn, where);

