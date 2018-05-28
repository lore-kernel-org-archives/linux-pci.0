Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	ryan@finnie.org,
	timur@codeaurora.org
Subject: [PATCH V3 1/2] PCI: Try to clean up resources via remove if shutdown
 doesn't exist
Date: Mon, 28 May 2018 17:21:10 -0400
Message-Id: <1527542471-10316-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

It is up to a driver to implement shutdown() callback. If shutdown()
callback is not implemented, PCI device can have pending interrupt and
even do DMA transactions while the system is going down.

If kexec is in use, this can damage the newly booting kexec kernel
or even prevent it from booting altogether. Fallback to calling the
remove() callback if shutdown() isn't implemented for a given driver.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=199779
Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
Cc: stable@vger.kernel.org
Reported-by: Ryan Finnie <ryan@finnie.org>
---
 drivers/pci/pci-driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index cbda0e6..75a00fe 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -477,8 +477,17 @@ static void pci_device_shutdown(struct device *dev)
 
 	pm_runtime_resume(dev);
 
+	/*
+	 * Try shutdown callback if it exists, otherwise fallback to remove
+	 * callback. PCI drivers can do DMA and have pending interrupts.
+	 * Leaving the DMA and interrupts pending could damage the newly
+	 * booting kexec kernel as well as prevent it from booting altogether
+	 * if the pending interrupt is level.
+	 */
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
+	else if (drv && drv->remove)
+		drv->remove(pci_dev);
 
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
