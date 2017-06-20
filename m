Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] PCI: Enable ECRC only if device supports it
From: Bjorn Helgaas <bhelgaas@google.com>
To: John Mazzie <john_mazzie@dell.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Jun 2017 14:02:07 -0500
Message-ID: <20170620190207.9292.39574.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

John reported that an Intel QuickAssist crypto accelerator didn't work in a
Dell PowerEdge R730.  The problem seems to be that we enabled ECRC when the
device doesn't support it:

  85:00.0 Co-processor [0b40]: Intel Corporation DH895XCC Series QAT [8086:0435]
    Capabilities: [100 v1] Advanced Error Reporting
      AERCap: First Error Pointer: 00, GenCap- CGenEn+ ChkCap- ChkEn+

1302fcf0d03e ("PCI: Configure *all* devices, not just hot-added ones")
exposed the problem because it applies settings from the _HPX method to all
devices, not just hot-added ones.  The R730 supplies an _HPX method that
allows the kernel to enable ECRC.

Only enable ECRC if the device advertises support for it.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1571798
Fixes: 1302fcf0d03e ("PCI: Configure *all* devices, not just hot-added ones")
Reported-by: John Mazzie <john_mazzie@dell.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 31001017b3c4..c31310db0404 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1730,6 +1730,11 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 	/* Initialize Advanced Error Capabilities and Control Register */
 	pci_read_config_dword(dev, pos + PCI_ERR_CAP, &reg32);
 	reg32 = (reg32 & hpp->adv_err_cap_and) | hpp->adv_err_cap_or;
+	/* Don't enable ECRC generation or checking if unsupported */
+	if (!(reg32 & PCI_ERR_CAP_ECRC_GENC))
+		reg32 &= ~PCI_ERR_CAP_ECRC_GENE;
+	if (!(reg32 & PCI_ERR_CAP_ECRC_CHKC))
+		reg32 &= ~PCI_ERR_CAP_ECRC_CHKE;
 	pci_write_config_dword(dev, pos + PCI_ERR_CAP, reg32);
 
 	/*
