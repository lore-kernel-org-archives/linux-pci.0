Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59467 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab3IQF0s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2013 01:26:48 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MT900FVN8GIUF10@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 17 Sep 2013 14:26:47 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jason Cooper' <jason@lakedaemon.net>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <001a01ceb366$5e9481b0$1bbd8510$%han@samsung.com>
In-reply-to: <001a01ceb366$5e9481b0$1bbd8510$%han@samsung.com>
Subject: [PATCH V2 2/3] PCI: mvebu: make local functions static
Date: Tue, 17 Sep 2013 14:26:46 +0900
Message-id: <001b01ceb366$812673a0$83735ae0$%han@samsung.com>
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
index d66530e..b54ceb1 100644
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


