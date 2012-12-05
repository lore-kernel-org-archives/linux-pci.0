Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f202.google.com ([74.125.82.202]:42074 "EHLO
	mail-we0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260Ab2LEU5c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2012 15:57:32 -0500
Received: by mail-we0-f202.google.com with SMTP id t57so395504wey.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Dec 2012 12:57:31 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.17.131.112])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id E689B20004E
	for <linux-pci@vger.kernel.org>; Wed,  5 Dec 2012 12:57:30 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 4CF75180280
	for <linux-pci@vger.kernel.org>; Wed,  5 Dec 2012 12:57:30 -0800 (PST)
Subject: [PATCH 02/12] PCI: Use standard PCIe Capability Link register field
	names
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 05 Dec 2012 13:57:30 -0700
Message-ID: <20121205205730.13851.16303.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
References: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the standard #defines for PCIe Link Status and Capability registers
rather than bare numbers.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 81d0667..7ec6973 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -521,7 +521,7 @@ static unsigned char pcie_link_speed[] = {
 
 void pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
 {
-	bus->cur_bus_speed = pcie_link_speed[linksta & 0xf];
+	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
 }
 EXPORT_SYMBOL_GPL(pcie_update_link_speed);
 
@@ -610,7 +610,7 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 		u16 linksta;
 
 		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
-		bus->max_bus_speed = pcie_link_speed[linkcap & 0xf];
+		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
 
 		pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
 		pcie_update_link_speed(bus, linksta);

