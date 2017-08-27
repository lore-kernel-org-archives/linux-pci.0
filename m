Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org, alex.williamson@redhat.com
Subject: [PATCH V13 3/4] PCI: Handle CRS ('device not ready') returned by
 device after FLR
Date: Sun, 27 Aug 2017 13:40:50 -0400
Message-Id: <1503855651-17409-3-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1503855651-17409-1-git-send-email-okaya@codeaurora.org>
References: <1503855651-17409-1-git-send-email-okaya@codeaurora.org>
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

Sporadic reset issues have been observed with Intel 750 NVMe drive while
assigning the physical function to the guest machine.  The sequence of
events observed is as follows:

- perform a Function Level Reset (FLR)
- sleep up to 1000ms total
- read ~0 from PCI_COMMAND
- warn that the device didn't return from FLR
- touch the device before it's ready
- device drops config writes when we restore register settings
- incomplete register restore leaves device in inconsistent state
- device probe fails because device is in inconsistent state

After reset, an endpoint may respond to config requests with Configuration
Request Retry Status (CRS) to indicate that it is not ready to accept new
requests. See PCIe r3.1, sec 2.3.1 and 6.6.2.

Increase the timeout value from 1 second to 60 seconds to cover the period
where device responds with CRS and also report polling progress.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 52 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc34..abab64b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3811,27 +3811,49 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
-/*
- * We should only need to wait 100ms after FLR, but some devices take longer.
- * Wait for up to 1000ms for config space to return something other than -1.
- * Intel IGD requires this when an LCD panel is attached.  We read the 2nd
- * dword because VFs don't implement the 1st dword.
- */
 static void pci_flr_wait(struct pci_dev *dev)
 {
-	int i = 0;
+	int delay = 1, timeout = 60000;
 	u32 id;
 
-	do {
-		msleep(100);
+	/*
+	 * Per PCIe r3.1, sec 6.6.2, a device must complete an FLR within
+	 * 100ms, but may silently discard requests while the FLR is in
+	 * progress.  Wait 100ms before trying to access the device.
+	 */
+	msleep(100);
+
+	/*
+	 * After 100ms, the device should not silently discard config
+	 * requests, but it may still indicate that it needs more time by
+	 * responding to them with CRS completions.  The Root Port will
+	 * generally synthesize ~0 data to complete the read (except when
+	 * CRS SV is enabled and the read was for the Vendor ID; in that
+	 * case it synthesizes 0x0001 data).
+	 *
+	 * Wait for the device to return a non-CRS completion.  Read the
+	 * Command register instead of Vendor ID so we don't have to
+	 * contend with the CRS SV value.
+	 */
+	pci_read_config_dword(dev, PCI_COMMAND, &id);
+	while (id == ~0) {
+		if (delay > timeout) {
+			dev_warn(&dev->dev, "not ready %dms after FLR; giving up\n",
+				 delay - 1);
+			return;
+		}
+
+		if (delay > 1000)
+			dev_info(&dev->dev, "not ready %dms after FLR; waiting\n",
+				 delay - 1);
+
+		msleep(delay);
+		delay *= 2;
 		pci_read_config_dword(dev, PCI_COMMAND, &id);
-	} while (i++ < 10 && id == ~0);
+	}
 
-	if (id == ~0)
-		dev_warn(&dev->dev, "Failed to return from FLR\n");
-	else if (i > 1)
-		dev_info(&dev->dev, "Required additional %dms to return from FLR\n",
-			 (i - 1) * 100);
+	if (delay > 1000)
+		dev_info(&dev->dev, "ready %dms after FLR\n", delay - 1);
 }
 
 /**
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
