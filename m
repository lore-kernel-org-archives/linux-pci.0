Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bhelgaas@google.com, keith.busch@intel.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
Date: Tue, 17 Jul 2018 10:31:23 -0500
Message-Id: <20180717153135.25925-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we don't own AER, we shouldn't touch the AER error bits. This
happens unconditionally on device probe(). Clearing AER bits
willy-nilly might cause firmware to miss errors. Instead
these bits should get cleared by FFS, or via ACPI _HPX method.

This race is mostly of theoretical significance, as it is not easy to
reasonably demonstrate it in testing.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/aer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..18037a2a8231 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -383,6 +383,9 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return -ENODEV;
 
+	if (pcie_aer_get_firmware_first(dev))
+		return -EIO;
+
 	pos = dev->aer_cap;
 	if (!pos)
 		return -EIO;
-- 
2.14.3
