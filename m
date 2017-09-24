Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org, alex.williamson@redhat.com
Subject: [PATCH 4/5] PCI: wait device ready after pci_pm_reset()
Date: Sat, 23 Sep 2017 20:16:57 -0400
Message-Id: <1506212218-29103-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
References: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
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

Rev 3.1 Sec 2.3.1 Request Handling Rules says a device can issue CRS
following a D3hot->D0 transition. Add pci_dev_wait() call with 1 second
timeout to see if device is available before returning.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fd4a3b6..074adf9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3963,6 +3963,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
  */
 static int pci_pm_reset(struct pci_dev *dev, int probe)
 {
+	unsigned int delay = dev->d3_delay;
 	u16 csr;
 
 	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
@@ -3988,7 +3989,10 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
-	return 0;
+	if (delay < pci_pm_d3_delay)
+		delay = pci_pm_d3_delay;
+
+	return pci_dev_wait(dev, "PM D3->D0", delay, 1000);
 }
 
 void pci_reset_secondary_bus(struct pci_dev *dev)
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
