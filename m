Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 2/4] PCI/ASPM: Use correct capability pointer to program
 LTR_L1.2_THRESHOLD
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>
Date: Mon, 13 Nov 2017 17:12:00 -0600
Message-ID: <20171113231200.4120.54400.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171113230937.4120.68038.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171113230937.4120.68038.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Previously we programmed the LTR_L1.2_THRESHOLD in the parent (upstream)
device using the capability pointer of the *child* (downstream) device,
which corrupted some random word of the parent's config space.

Use the parent's L1 SS capability pointer to program its
LTR_L1.2_THRESHOLD.

Fixes: aeda9adebab8 ("PCI/ASPM: Configure L1 substate settings")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org	# v4.11+
CC: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pcie/aspm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 46c59afb8355..a378dd9d2473 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -657,7 +657,7 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 					0xFF00, link->l1ss.ctl1);
 
 		/* Program LTR L1.2 threshold in both ports */
-		pci_clear_and_set_dword(parent,	dw_cap_ptr + PCI_L1SS_CTL1,
+		pci_clear_and_set_dword(parent,	up_cap_ptr + PCI_L1SS_CTL1,
 					0xE3FF0000, link->l1ss.ctl1);
 		pci_clear_and_set_dword(child, dw_cap_ptr + PCI_L1SS_CTL1,
 					0xE3FF0000, link->l1ss.ctl1);
