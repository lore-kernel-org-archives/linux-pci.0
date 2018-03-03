Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:29436 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeCCEd2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Mar 2018 23:33:28 -0500
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/IOV: Skip initializing the base addresses from the VF config space
Date: Sat,  3 Mar 2018 05:33:10 +0100
Message-Id: <1520051590-11750-1-git-send-email-karahmed@amazon.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per PCIe r4.0, sec 9.3.4.1.11, the BARs registers from the VF config space
are all RO Zero for PCI VFs. So just skip reading them for VFs.

This is an optimization when enabling SR-IOV on a device with many VFs.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 drivers/pci/probe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a96837e..7204d46 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -329,6 +329,10 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 	if (dev->non_compliant_bars)
 		return;
 
+	/* Per PCIe r4.0, sec 9.3.4.1.11, the VF BARs are all RO Zero */
+	if (dev->is_virtfn)
+		return;
+
 	for (pos = 0; pos < howmany; pos++) {
 		struct resource *res = &dev->resource[pos];
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
-- 
2.7.4
