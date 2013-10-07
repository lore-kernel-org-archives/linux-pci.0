Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gg0-f181.google.com ([209.85.161.181]:64384 "EHLO
	mail-gg0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab3JGXiu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2013 19:38:50 -0400
Received: by mail-gg0-f181.google.com with SMTP id i2so1269194ggn.26
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2013 16:38:49 -0700 (PDT)
Subject: [PATCH] PCI: mvebu: Make mvebu_pcie_align_resource() static
To: Jason Cooper <jason@lakedaemon.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org
Date: Mon, 07 Oct 2013 17:38:46 -0600
Message-ID: <20131007233846.11805.50302.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

mvebu_pcie_align_resource() is only used inside pci-mvebu.c, so
make it static.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-mvebu.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 729d5a1..bf4ff23 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -673,11 +673,11 @@ static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	return bus;
 }
 
-resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
-					  const struct resource *res,
-					  resource_size_t start,
-					  resource_size_t size,
-					  resource_size_t align)
+static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
+						 const struct resource *res,
+						 resource_size_t start,
+						 resource_size_t size,
+						 resource_size_t align)
 {
 	if (dev->bus->number != 0)
 		return start;

