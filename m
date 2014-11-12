Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18719 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755072AbaKLD1L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 22:27:11 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEW00M7ZPLA26E0@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 12 Nov 2014 12:27:10 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jason Cooper' <jason@lakedaemon.net>
Subject: [PATCH] PCI: mvebu: Add a blank line after declarations
Date: Wed, 12 Nov 2014 12:27:54 +0900
Message-id: <002b01cffe28$a57021d0$f0506570$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch fixes the following checkpatch warning.

  WARNING: Missing a blank line after declarations

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pci-mvebu.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index b1315e1..0c775afa 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -622,6 +622,7 @@ static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
 
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
+
 		if (bus->number == 0 && port->devfn == devfn)
 			return port;
 		if (bus->number != 0 &&
@@ -751,6 +752,7 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
 
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
+
 		if (!port->base)
 			continue;
 		mvebu_pcie_setup_hw(port);
@@ -777,6 +779,7 @@ static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 static void mvebu_pcie_add_bus(struct pci_bus *bus)
 {
 	struct mvebu_pcie *pcie = sys_to_pcie(bus->sysdata);
+
 	bus->msi = pcie->msi;
 }
 
-- 
1.7.9.5


