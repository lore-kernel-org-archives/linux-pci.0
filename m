Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org, alex.williamson@redhat.com
Subject: [PATCH V12 4/5] PCI: Handle CRS ("device not ready") returned by
 device after FLR
Date: Wed, 23 Aug 2017 00:56:10 -0400
Message-Id: <1503464171-6471-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1503464171-6471-1-git-send-email-okaya@codeaurora.org>
References: <1503464171-6471-1-git-send-email-okaya@codeaurora.org>
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
requests.  See PCIe r3.1, sec 2.3.1 and 6.6.2.

After an FLR, read the Vendor ID and use pci_bus_wait_crs() to wait for a
value that indicates the device is ready only if CRS visibility is
supported and device is responding with 0x0001.

If pci_bus_wait_crs() fails, i.e., the device has responded with CRS status
for at least the timeout interval, fall back to the old behavior of reading
the Command register until it is not ~0.

Also increase the timeout value from 1 second to 60 seconds to have
consistent behavior for root ports that do and do not support CRS
visibility.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc34..5980ab3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3819,19 +3819,35 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
  */
 static void pci_flr_wait(struct pci_dev *dev)
 {
+	int timeout_ms = 60000;
 	int i = 0;
 	u32 id;
 
+	/*
+	 * Per PCIe r3.1, sec 6.6.2, the device should finish FLR within
+	 * 100ms, but even after that, it may respond to config requests
+	 * with CRS status if it requires more time.
+	 */
+	msleep(100);
+
+	if (pci_bus_read_config_dword(dev->bus, dev->devfn, PCI_VENDOR_ID, &id))
+		return;
+
+	if (pci_bus_crs_visibility_pending(id) &&
+		pci_bus_wait_crs(dev->bus, dev->devfn, id, timeout_ms))
+		return;
+
+	timeout_ms -= 100;
 	do {
 		msleep(100);
 		pci_read_config_dword(dev, PCI_COMMAND, &id);
-	} while (i++ < 10 && id == ~0);
+	} while (i++ < (timeout_ms / 100) && id == ~0);
 
 	if (id == ~0)
 		dev_warn(&dev->dev, "Failed to return from FLR\n");
 	else if (i > 1)
 		dev_info(&dev->dev, "Required additional %dms to return from FLR\n",
-			 (i - 1) * 100);
+			 i * 100);
 }
 
 /**
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
