Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:34839 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbbHDVyw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 17:54:52 -0400
Received: by iodd187 with SMTP id d187so31173793iod.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2015 14:54:52 -0700 (PDT)
Subject: [PATCH v5 8/9] PCI: xgene: Look for OF "msi-parent" in host
 controller, not root bus
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Duc Dang <dhdang@apm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Simon Horman <horms@verge.net.au>,
	James Morse <james.morse@arm.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>
Date: Tue, 04 Aug 2015 16:54:50 -0500
Message-ID: <20150804215450.9189.61176.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Look for the "msi-parent" in the PCI host controller OF node, not the root
bus OF node.  This makes it the same as MVEBU.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 5e0d6de..3cb58a3 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -506,8 +506,7 @@ static int xgene_pcie_msi_enable(struct xgene_pcie_port *port,
 {
 	struct device_node *msi_node;
 
-	msi_node = of_parse_phandle(bus->dev.of_node,
-					"msi-parent", 0);
+	msi_node = of_parse_phandle(port->dev.of_node, "msi-parent", 0);
 	if (!msi_node)
 		return -ENODEV;
 

