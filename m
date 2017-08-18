Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v11 3/4] PCI: Handle CRS ("device not ready") returned by
 device after FLR
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 18 Aug 2017 16:32:17 -0500
Message-ID: <20170818213217.15145.38764.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170818212310.15145.21732.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170818212310.15145.21732.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Sinan Kaya <okaya@codeaurora.org>

XXX I think this needs to somehow use the same timeout for the PCI_COMMAND
loop as for the CRS part, so this works on machines without CRS Software
Visibility. -- bhelgaas

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
value that indicates the device is ready.

If pci_bus_wait_crs() fails, i.e., the device has responded with CRS status
for at least the timeout interval, fall back to the old behavior of reading
the Command register until it is not ~0.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
[bhelgaas: changelog, adjust for Vendor ID test being inside
pci_bus_wait_crs(), drop PCI_COMMAND tweaks]
Not-Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc3456dc1..34c0aa1f37aa 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3821,17 +3821,32 @@ static void pci_flr_wait(struct pci_dev *dev)
 {
 	int i = 0;
 	u32 id;
+	bool ret;
+
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
+	ret = pci_bus_wait_crs(dev->bus, dev->devfn, &id, 60000);
+	if (ret)
+		return;
 
 	do {
 		msleep(100);
 		pci_read_config_dword(dev, PCI_COMMAND, &id);
-	} while (i++ < 10 && id == ~0);
+	} while (i++ < 9 && id == ~0);
 
 	if (id == ~0)
 		dev_warn(&dev->dev, "Failed to return from FLR\n");
 	else if (i > 1)
 		dev_info(&dev->dev, "Required additional %dms to return from FLR\n",
-			 (i - 1) * 100);
+			 i * 100);
 }
 
 /**


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
