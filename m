Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>, <lftan.linux@gmail.com>
Subject: [PATCH 1/3] PCI: altera: fix incorrect devfn for requester ID
Date: Thu, 3 Dec 2015 17:54:47 +0800
Message-ID: <1449136489-2559-2-git-send-email-lftan@altera.com>
In-Reply-To: <1449136489-2559-1-git-send-email-lftan@altera.com>
References: <1449136489-2559-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Requester ID should use the rootport devfn and it should be always 0.
But, devfn argument in these 2 functions can be rootport or endpoint.
It causes the issue when accessing configuration register from
multi-functions PCIe devices.

Tested on Ethernet adapter card with multi-functions.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/host/pcie-altera.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index e5dda38..f05180f 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -57,6 +57,7 @@
 #define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
 #define TLP_HDR_SIZE			3
 #define TLP_LOOP			500
+#define RP_DEVFN			0
 
 #define INTX_NUM			4
 
@@ -233,7 +234,7 @@ static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
 	else
 		headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD1);
 
-	headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, devfn),
+	headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, RP_DEVFN),
 					TLP_READ_TAG, byte_en);
 	headers[2] = TLP_CFG_DW2(bus, devfn, where);
 
@@ -253,7 +254,7 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
 	else
 		headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR1);
 
-	headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, devfn),
+	headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, RP_DEVFN),
 					TLP_WRITE_TAG, byte_en);
 	headers[2] = TLP_CFG_DW2(bus, devfn, where);
 
-- 
1.8.2.1

