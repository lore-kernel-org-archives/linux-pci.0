Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH] PCI: rework error checking in the reset path
Date: Mon, 23 Oct 2017 17:36:48 -0400
Message-Id: <1508794608-15310-1-git-send-email-okaya@codeaurora.org>
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

The return codes from various reset types are not consistent. The code is
assuming that all reset types will return -ENOTTY when things go wrong.
Instead of relying on negative error status, let's bail out if the
operation is successful instead.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6078dfc..a753e07 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4200,20 +4200,20 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	might_sleep();
 
 	rc = pci_dev_specific_reset(dev, 0);
-	if (rc != -ENOTTY)
+	if (!rc)
 		return rc;
 	if (pcie_has_flr(dev)) {
 		pcie_flr(dev);
 		return 0;
 	}
 	rc = pci_af_flr(dev, 0);
-	if (rc != -ENOTTY)
+	if (!rc)
 		return rc;
 	rc = pci_pm_reset(dev, 0);
-	if (rc != -ENOTTY)
+	if (!rc)
 		return rc;
 	rc = pci_dev_reset_slot_function(dev, 0);
-	if (rc != -ENOTTY)
+	if (!rc)
 		return rc;
 	return pci_parent_bus_reset(dev, 0);
 }
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
