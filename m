Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755264AbcJLMrv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:47:51 -0400
Subject: [PATCH v2 6/6] PCI: altera: Simplify TLP_CFG_DW1 usage
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Wed, 12 Oct 2016 07:47:47 -0500
Message-ID: <20161012124747.23240.23492.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

TLP_CFG_DW1() was only used with altera->root_bus_nr and RP_DEVFN, so
encode that directly into the macro so we don't have to clutter the uses
with the TLP_REQ_ID() usage.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 8240130..b0ac4df 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -55,18 +55,19 @@
 #define TLP_PAYLOAD_SIZE		0x01
 #define TLP_READ_TAG			0x1d
 #define TLP_WRITE_TAG			0x10
+#define RP_DEVFN			0
+#define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
 #define TLP_CFG_DW0(pcie, bus)						\
     ((((bus == pcie->root_bus_nr) ? TLP_FMTTYPE_CFGRD0			\
 				    : TLP_FMTTYPE_CFGRD1) << 24) |	\
      TLP_PAYLOAD_SIZE)
-#define TLP_CFG_DW1(reqid, tag, be)	(((reqid) << 16) | (tag << 8) | (be))
+#define TLP_CFG_DW1(pcie, tag, be)	\
+    (((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
 #define TLP_CFG_DW2(bus, devfn, offset)	\
 				(((bus) << 24) | ((devfn) << 16) | (offset))
-#define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
 #define TLP_COMP_STATUS(s)		(((s) >> 12) & 7)
 #define TLP_HDR_SIZE			3
 #define TLP_LOOP			500
-#define RP_DEVFN			0
 
 #define LINK_UP_TIMEOUT			HZ
 #define LINK_RETRAIN_TIMEOUT		HZ
@@ -222,8 +223,7 @@ static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
 	u32 headers[TLP_HDR_SIZE];
 
 	headers[0] = TLP_CFG_DW0(pcie, bus);
-	headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, RP_DEVFN),
-					TLP_READ_TAG, byte_en);
+	headers[1] = TLP_CFG_DW1(pcie, TLP_READ_TAG, byte_en);
 	headers[2] = TLP_CFG_DW2(bus, devfn, where);
 
 	tlp_write_packet(pcie, headers, 0, false);
@@ -238,8 +238,7 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
 	int ret;
 
 	headers[0] = TLP_CFG_DW0(pcie, bus);
-	headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, RP_DEVFN),
-					TLP_WRITE_TAG, byte_en);
+	headers[1] = TLP_CFG_DW1(pcie, TLP_WRITE_TAG, byte_en);
 	headers[2] = TLP_CFG_DW2(bus, devfn, where);
 
 	/* check alignment to Qword */

