Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755834AbdLOW7z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Dec 2017 17:59:55 -0500
Subject: [PATCH] rapidio/tsi721: use PCI_EXP_DEVCTL2_COMP_TIMEOUT macro
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>,
        Matt Porter <mporter@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org
Date: Fri, 15 Dec 2017 16:59:52 -0600
Message-ID: <20171215225952.177299.86044.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Use the existing PCI_EXP_DEVCTL2_COMP_TIMEOUT macro instead of hard-coding
the PCIe Completion Timeout Value mask.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/rapidio/devices/tsi721.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 9a68914100ad..bb655854713d 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -2880,8 +2880,9 @@ static int tsi721_probe(struct pci_dev *pdev,
 				 "Invalid MRRS override value %d", pcie_mrrs);
 	}
 
-	/* Adjust PCIe completion timeout. */
-	pcie_capability_clear_and_set_word(pdev, PCI_EXP_DEVCTL2, 0xf, 0x2);
+	/* Set PCIe completion timeout to 1-10ms */
+	pcie_capability_clear_and_set_word(pdev, PCI_EXP_DEVCTL2,
+					   PCI_EXP_DEVCTL2_COMP_TIMEOUT, 0x2);
 
 	/*
 	 * FIXUP: correct offsets of MSI-X tables in the MSI-X Capability Block
