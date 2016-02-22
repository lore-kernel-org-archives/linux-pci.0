Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v3] pci: Wait for up to 1000ms after FLR reset
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: allen.m.kay@intel.com, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Date: Mon, 22 Feb 2016 13:05:48 -0700
Message-ID: <20160222200351.4709.85363.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some devices take longer than the spec indicates to return from FLR
reset, a notable case of this is Intel integrated graphics (IGD),
which can often take an additional 300ms powering down an attached
LCD panel as part of the FLR.  Allow devices up to 1000ms, testing
every 100ms whether the second dword of config space is read as -1.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
v3: Read 2nd dword since SR-IOV VFs don't implement the 1st dword
v2: Change loop to incorporate initial 100ms delay, replace delay in
    callee functions, add comment.

 drivers/pci/pci.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 602eb42..365ac76 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3414,6 +3414,29 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
+/*
+ * We should only need to wait 100ms after FLR, but some devices take longer.
+ * Wait for up to 1000ms for config space to return something other than -1.
+ * Intel IGD requires this when an LCD panel is attached.  We read the 2nd
+ * dword because VFs don't implement the 1st dword.
+ */
+static void pci_flr_wait(struct pci_dev *dev)
+{
+	int i = 0;
+	u32 id;
+
+	do {
+		msleep(100);
+		pci_read_config_dword(dev, PCI_COMMAND, &id);
+	} while (i++ < 10 && id == ~0);
+
+	if (id == ~0)
+		dev_warn(&dev->dev, "Failed to return from FLR\n");
+	else if (i > 1)
+		dev_info(&dev->dev, "Required additional "
+			 "%dms to return from FLR\n", (i - 1) * 100);
+}
+
 static int pcie_flr(struct pci_dev *dev, int probe)
 {
 	u32 cap;
@@ -3429,7 +3452,7 @@ static int pcie_flr(struct pci_dev *dev, int probe)
 		dev_err(&dev->dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
-	msleep(100);
+	pci_flr_wait(dev);
 	return 0;
 }
 
@@ -3459,7 +3482,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 		dev_err(&dev->dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
 
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
-	msleep(100);
+	pci_flr_wait(dev);
 	return 0;
 }
 
