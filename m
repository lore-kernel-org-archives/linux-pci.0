Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:33760 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724AbaBLW5P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 12 Feb 2014 17:57:15 -0500
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: mvebu - Call request_resources on the apertures
Date: Wed, 12 Feb 2014 15:57:08 -0700
Message-Id: <1392245828-23244-2-git-send-email-jgunthorpe@obsidianresearch.com>
In-Reply-To: <1392245828-23244-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1392245828-23244-1-git-send-email-jgunthorpe@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is typical for host drivers to request a resource for the
aperture, once this is done the PCI core will properly populate
resources for all BARs in the system.

With this patch cat /proc/iomem will now show:

e0000000-efffffff : PCI MEM 0000
  e0000000-e00fffff : PCI Bus 0000:01
    e0000000-e001ffff : 0000:01:00.0

Tested on Kirkwood

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/pci/host/pci-mvebu.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

Arnd: Please confirm your SOB line, thanks.

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index ef8691a..360a024 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -109,7 +109,9 @@ struct mvebu_pcie {
 	struct mvebu_pcie_port *ports;
 	struct msi_chip *msi;
 	struct resource io;
+	char io_name[30];
 	struct resource realio;
+	char mem_name[30];
 	struct resource mem;
 	struct resource busn;
 	int nports;
@@ -681,10 +683,30 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
 {
 	struct mvebu_pcie *pcie = sys_to_pcie(sys);
 	int i;
+	int domain = 0;
 
-	if (resource_size(&pcie->realio) != 0)
+#ifdef CONFIG_PCI_DOMAINS
+	domain = sys->domain;
+#endif
+
+	snprintf(pcie->mem_name, sizeof(pcie->mem_name), "PCI MEM %04x",
+		 domain);
+	pcie->mem.name = pcie->mem_name;
+
+	snprintf(pcie->io_name, sizeof(pcie->io_name), "PCI I/O %04x", domain);
+	pcie->realio.name = pcie->io_name;
+
+	if (request_resource(&iomem_resource, &pcie->mem))
+		return 0;
+
+	if (resource_size(&pcie->realio) != 0) {
+		if (request_resource(&ioport_resource, &pcie->realio)) {
+			release_resource(&pcie->mem);
+			return 0;
+		}
 		pci_add_resource_offset(&sys->resources, &pcie->realio,
 					sys->io_offset);
+	}
 	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
 	pci_add_resource(&sys->resources, &pcie->busn);
 
-- 
1.8.1.2

