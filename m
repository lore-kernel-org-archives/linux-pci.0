Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 6 May 2012 23:11:56 +0800
From: Xudong Hao <xudong.hao@linux.intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, xiantao.zhang@intel.com, xudong.hao@intel.com
Subject: [PATCH] PCI: save/restore max Latency Value for device LTR
Message-ID: <20120506151156.GA13805@hp-xd.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

LTR: Save Max snoop/no-snoop Latency Value in pci_save_pcie_state, and restore them in pci_restore_pcie_state.

Signed-off-by: Xudong Hao <xudong.hao@intel.com>

---
 drivers/pci/pci.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 111569c..c8573c3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -875,6 +875,12 @@ static int pci_save_pcie_state(struct pci_dev *dev)
        pci_read_config_word(dev, pos + PCI_EXP_LNKCTL2, &cap[i++]);
    if (pcie_cap_has_sltctl2(dev->pcie_type, flags))
        pci_read_config_word(dev, pos + PCI_EXP_SLTCTL2, &cap[i++]);
+   if (pci_ltr_supported(dev)) {
+       pci_read_config_word(dev, pos + PCI_LTR_MAX_SNOOP_LAT,
+                           &cap[i++]);
+       pci_read_config_word(dev, pos + PCI_LTR_MAX_NOSNOOP_LAT,
+                           &cap[i++]);
+   }

    return 0;
 }
@@ -908,6 +914,12 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
        pci_write_config_word(dev, pos + PCI_EXP_LNKCTL2, cap[i++]);
    if (pcie_cap_has_sltctl2(dev->pcie_type, flags))
        pci_write_config_word(dev, pos + PCI_EXP_SLTCTL2, cap[i++]);
+   if (pci_ltr_supported(dev)) {
+       pci_write_config_word(dev, pos + PCI_LTR_MAX_SNOOP_LAT,
+                           cap[i++]);
+       pci_write_config_word(dev, pos + PCI_LTR_MAX_NOSNOOP_LAT,
+                           cap[i++]);
+   }
 }


--
1.6.0.rc1

