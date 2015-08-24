Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:45681 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932774AbbHXMnJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 24 Aug 2015 08:43:09 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: linux-pci@vger.kernel.org, gpiccoli@linux.vnet.ibm.com,
	bhelgaas@google.com, mst@redhat.com
Subject: [PATCH 2/2] powerpc/PCI: Disable MSI/MSI-X interrupts at PCI probe time in OF case
Date: Mon, 24 Aug 2015 22:42:47 +1000
Message-Id: <1440420167-8879-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1440420167-8879-1-git-send-email-mpe@ellerman.id.au>
References: <1440420167-8879-1-git-send-email-mpe@ellerman.id.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>

Since commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if
kernel doesn't support MSI"), the setup of dev->msi_cap/msix_cap and the
disable of MSI/MSI-X interrupts isn't being done at PCI probe time, as
the logic responsible for this was moved in the aforementioned commit
from pci_device_add() to pci_setup_device(). The latter function is not
reachable on PowerPC pseries platform during Open Firmware PCI probing
time.

This exhibits as drivers not being able to enable MSI, eg:

  bnx2x 0000:01:00.0: no msix capability found

This patch calls pci_msi_setup_pci_dev() explicitly to disable MSI/MSI-X
during PCI probe time on pSeries platform.

Fixes: 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI")
[mpe: Flesh out change log and clarify comment]
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/pci_of_scan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 42e02a2d570b..efc3fa54c90b 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -191,6 +191,9 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 
 	pci_device_add(dev, bus);
 
+	/* Setup MSI caps & disable MSI/MSI-X interrupts */
+	pci_msi_setup_pci_dev(dev);
+
 	return dev;
 }
 EXPORT_SYMBOL(of_create_pci_dev);
-- 
2.1.4

