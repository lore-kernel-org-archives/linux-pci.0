Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        alex.williamson@redhat.com
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 1/3] PCI: limit FLR wait time to 100ms maximum
Date: Wed,  2 Aug 2017 15:15:15 -0400
Message-Id: <1501701317-32249-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Code is currently allowing PCIe devices to extend polling time up to 1
second. Reducing the wait time for virtual functions to 100ms maximum to
satisfy spec requirement mentioned in PCIe r3.1, sec 6.6.2. Function-Level
Reset (FLR).

SR-IOV r1.1, sec 2.2.2 also mentions that the virtual function's presence
from configuration space is not affected from FLR. There is no point in
polling the command register since it should always return success.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc34..2ed604a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3812,7 +3812,7 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
 /*
- * We should only need to wait 100ms after FLR, but some devices take longer.
+ * We should only need to wait 100ms after FLR for virtual functions.
  * Wait for up to 1000ms for config space to return something other than -1.
  * Intel IGD requires this when an LCD panel is attached.  We read the 2nd
  * dword because VFs don't implement the 1st dword.
@@ -3822,6 +3822,11 @@ static void pci_flr_wait(struct pci_dev *dev)
 	int i = 0;
 	u32 id;
 
+	if (dev->is_virtfn) {
+		msleep(100);
+		return;
+	}
+
 	do {
 		msleep(100);
 		pci_read_config_dword(dev, PCI_COMMAND, &id);
-- 
1.9.1
