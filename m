Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:24608 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab3IWEfD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Sep 2013 00:35:03 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MTK007B39ZU1UG0@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 23 Sep 2013 13:35:01 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jason Cooper' <jason@lakedaemon.net>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <000c01ceb816$19f0dd10$4dd29730$%han@samsung.com>
In-reply-to: <000c01ceb816$19f0dd10$4dd29730$%han@samsung.com>
Subject: [PATCH V3 2/3] PCI: mvebu: make local functions static
Date: Mon, 23 Sep 2013 13:35:01 +0900
Message-id: <000f01ceb816$4419dce0$cc4d96a0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

mvebu_pcie_add_bus(), mvebu_pcie_align_resource()  are used only
in this file. Thus, these local functions should be staticized
in order to fix the following sparse warnings:

drivers/pci/host/pci-mvebu.c:684:6: warning: symbol 'mvebu_pcie_add_bus' was not declared. Should it be static?
drivers/pci/host/pci-mvebu.c:690:17: warning: symbol 'mvebu_pcie_align_resource' was not declared. Should it be static?

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 77f8a7c..0bd3ba8 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -681,17 +681,17 @@ static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	return bus;
 }
 
-void mvebu_pcie_add_bus(struct pci_bus *bus)
+static void mvebu_pcie_add_bus(struct pci_bus *bus)
 {
 	struct mvebu_pcie *pcie = sys_to_pcie(bus->sysdata);
 	bus->msi = pcie->msi;
 }
 
-resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
-					  const struct resource *res,
-					  resource_size_t start,
-					  resource_size_t size,
-					  resource_size_t align)
+static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
+						const struct resource *res,
+						resource_size_t start,
+						resource_size_t size,
+						resource_size_t align)
 {
 	if (dev->bus->number != 0)
 		return start;
-- 
1.7.10.4


