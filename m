Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-fa0-f74.google.com ([209.85.161.74]:51086 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946434Ab2CPXsB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Mar 2012 19:48:01 -0400
Received: by faaa19 with SMTP id a19so214757faa.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Mar 2012 16:48:00 -0700 (PDT)
Subject: [PATCH v2 1/7] PCI: fix bridge I/O window bus-to-resource conversion
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 16 Mar 2012 17:47:59 -0600
Message-ID: <20120316234758.6649.22169.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
References: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In 5bfa14ed9f3c, I forgot to initialize res2.flags before calling
pcibios_bus_to_resource(), which depends on the resource type to locate the
correct aperture.  This bug won't hurt x86, which currently never has an
offset between bus and CPU addresses, but will affect other architectures.

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

