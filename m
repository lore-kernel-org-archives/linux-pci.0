Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:58848 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759914AbcAKMLw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2016 07:11:52 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: designware: remove unused variable
Date: Mon, 11 Jan 2016 13:11:24 +0100
Message-ID: <4643317.WUGgxPjcvu@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A cleanup patch removed the only use of the 'ret' variable
in wr_conf but forgot to remove the variable:

pci/host/pcie-designware.c: In function 'dw_pcie_wr_conf':
pci/host/pcie-designware.c:683:6: warning: unused variable 'ret' [-Wunused-variable]

This cleans that part up as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 50a1a3b06ddd ("PCI: designware: Simplify control flow")
---
This came up this morning on linux-next with ARM randconfig builds

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 9a666dbff127..21716827847a 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -680,7 +680,6 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 			int where, int size, u32 val)
 {
 	struct pcie_port *pp = bus->sysdata;
-	int ret;
 
 	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;

