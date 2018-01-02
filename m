Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V3 3/6] PCI: Make pci_flr_wait() generic and rename to
 pci_dev_wait()
Date: Tue,  2 Jan 2018 12:00:20 -0500
Message-Id: <1514912423-13341-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1514912423-13341-1-git-send-email-okaya@codeaurora.org>
References: <1514912423-13341-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Rev 3.1 Sec 2.3.1 Request Handling Rules:
Valid reset conditions after which a device is permitted to return CRS
are:
* Cold, Warm, and Hot Resets,
* FLR
* A reset initiated in response to a D3hot to D0 uninitialized

Try to reuse FLR implementation towards other reset types.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ef15162..736d809 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -125,6 +125,9 @@ static int __init pcie_port_pm_setup(char *str)
 }
 __setup("pcie_port_pm=", pcie_port_pm_setup);
 
+/* time to wait after a reset for device to become responsive */
+#define PCIE_RESET_READY_POLL_MS 60000
+
 /**
  * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
  * @bus: pointer to PCI bus structure to search
@@ -3945,20 +3948,13 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
-static int pci_flr_wait(struct pci_dev *dev)
+static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 {
-	int delay = 1, timeout = 60000;
+	int delay = 1;
 	u32 id;
 
 	/*
-	 * Per PCIe r3.1, sec 6.6.2, a device must complete an FLR within
-	 * 100ms, but may silently discard requests while the FLR is in
-	 * progress.  Wait 100ms before trying to access the device.
-	 */
-	msleep(100);
-
-	/*
-	 * After 100ms, the device should not silently discard config
+	 * After reset, the device should not silently discard config
 	 * requests, but it may still indicate that it needs more time by
 	 * responding to them with CRS completions.  The Root Port will
 	 * generally synthesize ~0 data to complete the read (except when
@@ -3972,14 +3968,14 @@ static int pci_flr_wait(struct pci_dev *dev)
 	pci_read_config_dword(dev, PCI_COMMAND, &id);
 	while (id == ~0) {
 		if (delay > timeout) {
-			dev_warn(&dev->dev, "not ready %dms after FLR; giving up\n",
-				 100 + delay - 1);
+			dev_warn(&dev->dev, "not ready %dms after %s; giving up\n",
+				 delay - 1, reset_type);
 			return -ENOTTY;
 		}
 
 		if (delay > 1000)
-			dev_info(&dev->dev, "not ready %dms after FLR; waiting\n",
-				 100 + delay - 1);
+			dev_info(&dev->dev, "not ready %dms after %s; waiting\n",
+				 delay - 1, reset_type);
 
 		msleep(delay);
 		delay *= 2;
@@ -3987,7 +3983,8 @@ static int pci_flr_wait(struct pci_dev *dev)
 	}
 
 	if (delay > 1000)
-		dev_info(&dev->dev, "ready %dms after FLR\n", 100 + delay - 1);
+		dev_info(&dev->dev, "ready %dms after %s\n", delay - 1,
+			 reset_type);
 
 	return 0;
 }
@@ -4024,7 +4021,15 @@ int pcie_flr(struct pci_dev *dev)
 		dev_err(&dev->dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
-	return pci_flr_wait(dev);
+
+	/*
+	 * Per PCIe r3.1, sec 6.6.2, a device must complete an FLR within
+	 * 100ms, but may silently discard requests while the FLR is in
+	 * progress.  Wait 100ms before trying to access the device.
+	 */
+	msleep(100);
+
+	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
@@ -4057,7 +4062,16 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 		dev_err(&dev->dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
 
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
-	return pci_flr_wait(dev);
+
+	/*
+	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
+	 * updated 27 July 2006; a device must complete an FLR within
+	 * 100ms, but may silently discard requests while the FLR is in
+	 * progress.  Wait 100ms before trying to access the device.
+	 */
+	msleep(100);
+
+	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
 }
 
 /**
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
