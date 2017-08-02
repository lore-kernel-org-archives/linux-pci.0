Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org, alex.williamson@redhat.com
Subject: [PATCH V7 2/3] PCI: handle CRS returned by device after FLR
Date: Wed,  2 Aug 2017 15:15:16 -0400
Message-Id: <1501701317-32249-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1501701317-32249-1-git-send-email-okaya@codeaurora.org>
References: <1501701317-32249-1-git-send-email-okaya@codeaurora.org>
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

An endpoint is allowed to issue Configuration Request Retry Status (CRS)
following a Function Level Reset (FLR) request to indicate that it is
not ready to accept new requests. CRS is defined in PCIe r3.1, sec 2.3.1.
Request Handling Rules and CRS usage in FLR context is mentioned in
PCIe r3.1, sec 6.6.2. Function-Level Reset.

Adding a vendor ID read if this is a physical function before attempting
to read any other registers on the endpoint. A CRS indication will only
be given if the address to be read is vendor ID register.
pci_bus_read_dev_vendor_id() knows how to deal with CRS returned values.

Calling pci_bus_read_dev_vendor_id() with 60 seconds timeout to be
consistent with the rest of the kernel CRS timeout policy.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2ed604a..ad49e73 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3813,30 +3813,25 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 
 /*
  * We should only need to wait 100ms after FLR for virtual functions.
- * Wait for up to 1000ms for config space to return something other than -1.
- * Intel IGD requires this when an LCD panel is attached.  We read the 2nd
- * dword because VFs don't implement the 1st dword.
+ * Wait for up to 60s for config space to return something other than -1.
+ * Intel IGD requires 300ms when an LCD panel is attached.  We use
+ * pci_bus_read_dev_vendor_id() for reading the vendor ID as it handles
+ * CRS gracefully.
  */
 static void pci_flr_wait(struct pci_dev *dev)
 {
-	int i = 0;
 	u32 id;
+	bool ret;
 
-	if (dev->is_virtfn) {
-		msleep(100);
-		return;
-	}
+	/* don't touch the HW before waiting 100ms */
+	msleep(100);
 
-	do {
-		msleep(100);
-		pci_read_config_dword(dev, PCI_COMMAND, &id);
-	} while (i++ < 10 && id == ~0);
+	if (dev->is_virtfn)
+		return;
 
-	if (id == ~0)
+	ret = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id, 60000);
+	if (!ret)
 		dev_warn(&dev->dev, "Failed to return from FLR\n");
-	else if (i > 1)
-		dev_info(&dev->dev, "Required additional %dms to return from FLR\n",
-			 (i - 1) * 100);
 }
 
 /**
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
