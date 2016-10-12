Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755325AbcJLNM2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:12:28 -0400
Subject: [PATCH v2 3/5] PCI: xilinx: Removed unused xilinx_pcie_assign_msi()
 argument
To: Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:10:55 -0500
Message-ID: <20161012131055.25793.89053.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012130819.25793.17542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012130819.25793.17542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

xilinx_pcie_assign_msi() doesn't use the struct xilinx_pcie_port pointer
passed to it, so remove the argument completely.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 8a0eb03..c8616fa 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -229,11 +229,10 @@ static void xilinx_pcie_destroy_msi(unsigned int irq)
 
 /**
  * xilinx_pcie_assign_msi - Allocate MSI number
- * @port: PCIe port structure
  *
  * Return: A valid IRQ on success and error value on failure.
  */
-static int xilinx_pcie_assign_msi(struct xilinx_pcie_port *port)
+static int xilinx_pcie_assign_msi(void)
 {
 	int pos;
 
@@ -276,7 +275,7 @@ static int xilinx_pcie_msi_setup_irq(struct msi_controller *chip,
 	struct msi_msg msg;
 	phys_addr_t msg_addr;
 
-	hwirq = xilinx_pcie_assign_msi(port);
+	hwirq = xilinx_pcie_assign_msi();
 	if (hwirq < 0)
 		return hwirq;
 

