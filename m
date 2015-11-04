Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24761 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbKDNjx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 08:39:53 -0500
Date: Wed, 4 Nov 2015 16:39:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, rfi@lists.rocketboards.org,
	linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] PCI: altera: fix loop in tlp_read_packet()
Message-ID: <20151104133936.GI20966@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The problem is that TLP_LOOP is 500 and the "loop" variable was a u8 so
"loop < TLP_LOOP" is always true.  We only need this condition to work
if there is a problem so it would have been easy to miss this in
testing.  Anyway, lets just make it a normal for loop with "int i"
instead of over thinking things and making it complicated.

Fixes: 6bb4dd154ae8 ('PCI: altera: Add Altera PCIe host controller driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index e5dda38..b05de63 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -166,16 +166,16 @@ static bool altera_pcie_valid_config(struct altera_pcie *pcie,
 
 static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
 {
-	u8 loop;
 	bool sop = 0;
 	u32 ctrl;
 	u32 reg0, reg1;
+	int i;
 
 	/*
 	 * Minimum 2 loops to read TLP headers and 1 loop to read data
 	 * payload.
 	 */
-	for (loop = 0; loop < TLP_LOOP; loop++) {
+	for (i = 0; i < TLP_LOOP; i++) {
 		ctrl = cra_readl(pcie, RP_RXCPL_STATUS);
 		if ((ctrl & RP_RXCPL_SOP) || (ctrl & RP_RXCPL_EOP) || sop) {
 			reg0 = cra_readl(pcie, RP_RXCPL_REG0);
