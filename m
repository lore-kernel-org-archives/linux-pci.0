Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>, <sarah.a.sharp@linux.intel.com>,
	<linux-kernel@vger.kernel.org>,
	Alexander Gordeev <agordeev@redhat.com>,
	linux-pci@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 2/5] xhci: Use pci_enable_msix_exact() instead of pci_enable_msix()
Date: Tue, 22 Apr 2014 15:22:59 +0300
Message-Id: <1398169382-12097-3-git-send-email-mathias.nyman@linux.intel.com>
In-Reply-To: <1398169382-12097-1-git-send-email-mathias.nyman@linux.intel.com>
References: <1398169382-12097-1-git-send-email-mathias.nyman@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alexander Gordeev <agordeev@redhat.com>

As result of deprecation of MSI-X/MSI enablement functions
pci_enable_msix() and pci_enable_msi_block() all drivers
using these two interfaces need to be updated to use the
new pci_enable_msi_range()  or pci_enable_msi_exact()
and pci_enable_msix_range() or pci_enable_msix_exact()
interfaces.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 988ed5f..b0b8399 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -291,7 +291,7 @@ static int xhci_setup_msix(struct xhci_hcd *xhci)
 		xhci->msix_entries[i].vector = 0;
 	}
 
-	ret = pci_enable_msix(pdev, xhci->msix_entries, xhci->msix_count);
+	ret = pci_enable_msix_exact(pdev, xhci->msix_entries, xhci->msix_count);
 	if (ret) {
 		xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 				"Failed to enable MSI-X");
-- 
1.8.3.2

