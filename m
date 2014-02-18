Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next 14/35] igb: Use pci_enable_msix_range() instead of pci_enable_msix()
Date: Tue, 18 Feb 2014 11:11:43 +0100
Message-Id: <cc1ca90a844e469ebb5c4460af540a121f5cf678.1392717503.git.agordeev@redhat.com>
In-Reply-To: <cover.1392717502.git.agordeev@redhat.com>
References: <cover.1392717502.git.agordeev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As result of deprecation of MSI-X/MSI enablement functions
pci_enable_msix() and pci_enable_msi_block() all drivers
using these two interfaces need to be updated to use the
new pci_enable_msi_range() and pci_enable_msix_range()
interfaces.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: e1000-devel@lists.sourceforge.net
Cc: netdev@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/net/ethernet/intel/igb/igb_main.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 46d31a4..84dfa3f 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1111,10 +1111,11 @@ static void igb_set_interrupt_capability(struct igb_adapter *adapter, bool msix)
 	for (i = 0; i < numvecs; i++)
 		adapter->msix_entries[i].entry = i;
 
-	err = pci_enable_msix(adapter->pdev,
-			      adapter->msix_entries,
-			      numvecs);
-	if (err == 0)
+	err = pci_enable_msix_range(adapter->pdev,
+				    adapter->msix_entries,
+				    numvecs,
+				    numvecs);
+	if (err > 0)
 		return;
 
 	igb_reset_interrupt_capability(adapter);
-- 
1.7.7.6

