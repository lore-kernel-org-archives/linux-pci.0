Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] pci: Wait for up to an additional 1000ms after FLR reset
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: allen.m.kay@intel.com, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Date: Fri, 12 Feb 2016 16:51:08 -0700
Message-ID: <20160212235013.16862.53910.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some devices take longer than the spec indicates to return from FLR
reset, a notable case of this is Intel integrated graphics (IGD),
which can often take an additional 300ms powering down an attached
LCD panel as part of the FLR.  Allow devices up to an additional
1000ms, testing every 100ms whether the first dword of config space
is read as -1.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

Copying KVM list as this patch is required for IGD assignment.

 drivers/pci/pci.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 602eb42..3b90a42 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3414,6 +3414,25 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
+static void pci_wait_alive(struct pci_dev *dev)
+{
+	int i;
+	u32 id;
+
+	for (i = 0; i < 10; i++) {
+		pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
+		if (~id != 0) {
+			if (i > 0)
+				dev_info(&dev->dev, "Required additional %d"
+				         "ms to return from reset\n", i * 100);
+			return;
+		}
+		msleep(100);
+	}
+
+	dev_warn(&dev->dev, "Failed to return from reset\n");
+}
+
 static int pcie_flr(struct pci_dev *dev, int probe)
 {
 	u32 cap;
@@ -3430,6 +3449,7 @@ static int pcie_flr(struct pci_dev *dev, int probe)
 
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
 	msleep(100);
+	pci_wait_alive(dev);
 	return 0;
 }
 
@@ -3460,6 +3480,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
 	msleep(100);
+	pci_wait_alive(dev);
 	return 0;
 }
 
