Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V2 4/7] PCI: wait device ready after pci_pm_reset()
Date: Mon, 27 Nov 2017 01:20:25 -0500
Message-Id: <1511763628-11856-5-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
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

Rev 3.1 Sec 2.3.1 Request Handling Rules says a device can issue CRS
following a D3hot->D0 transition. Add pci_dev_wait() call to see if
device is available before returning.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ed3c3bc..87e4688 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3990,7 +3990,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
-	return 0;
+	return pci_dev_wait(dev, "PM D3->D0", PCIE_RESET_READY_POLL_MS);
 }
 
 void pci_reset_secondary_bus(struct pci_dev *dev)
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
