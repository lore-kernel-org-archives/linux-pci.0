Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org, alex.williamson@redhat.com
Subject: [PATCH V6 1/2] PCI: limit FLR wait time to 100ms maximum
Date: Wed,  2 Aug 2017 13:18:23 -0400
Message-Id: <1501694304-16554-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
