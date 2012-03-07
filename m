Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qy0-f202.google.com ([209.85.216.202]:50124 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031691Ab2CGBAN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2012 20:00:13 -0500
Received: by qcsp5 with SMTP id p5so724827qcs.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Mar 2012 17:00:12 -0800 (PST)
Subject: [PATCH v1 1/9] PCI: fix bridge I/O window bus-to-resource conversion
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Tue, 06 Mar 2012 18:00:12 -0700
Message-ID: <20120307010012.27465.79826.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307005905.27465.71131.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307005905.27465.71131.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pcibios_bus_to_resource() depends on the resource type to find the
correct aperture, so initialize res2.flags first.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 944e05a..5e1ca3c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -367,6 +367,7 @@ static void __devinit pci_read_bridge_io(struct pci_bus *child)
 
 	if (base && base <= limit) {
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
+		res2.flags = res->flags;
 		region.start = base;
 		region.end = limit + 0xfff;
 		pcibios_bus_to_resource(dev, &res2, &region);

