Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org
Subject: [PATCH V4 7/7] PCI: Handle link reset via hotplug if supported
Date: Thu, 28 Jun 2018 15:31:05 -0400
Message-Id: <1530214274-21139-7-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
References: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Oza Pawandeep <poza@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Sinan Kaya <okaya@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

If a bridge supports hotplug and observes a PCIe fatal error, the following
events happen:

1. AER driver removes the devices from PCI tree on fatal error
2. AER driver brings down the link by issuing a secondary bus reset waits
for the link to come up.
3. Hotplug driver observes a link down interrupt
4. Hotplug driver tries to remove the devices waiting for the rescan lock
but devices are already removed by the AER driver and AER driver is waiting
for the link to come back up.
5. AER driver tries to re-enumerate devices after polling for the link
state to go up.
6. Hotplug driver obtains the lock and tries to remove the devices again.

If a bridge is a hotplug capable bridge, bounce the error handling to the
hotplug driver so that hotplug driver can mask link up/down interrupts
while performing a secondary bus reset.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/pciehp_core.c | 20 ++++++++++++++++++++
 drivers/pci/pcie/err.c            |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 44a6a63..43a49cc 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -299,6 +299,24 @@ static int pciehp_resume(struct pcie_device *dev)
 }
 #endif /* PM */
 
+static pci_ers_result_t pciehp_reset_link(struct pci_dev *pdev)
+{
+	struct pcie_device *pciedev;
+	struct controller *ctrl;
+	struct device *devhp;
+	struct slot *slot;
+	int rc;
+
+	devhp = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_HP);
+	pciedev = to_pcie_device(devhp);
+	ctrl = get_service_data(pciedev);
+	slot = ctrl->slot;
+
+	rc = reset_slot(slot->hotplug_slot, 0);
+
+	return !rc ? PCI_ERS_RESULT_RECOVERED : PCI_ERS_RESULT_DISCONNECT;
+}
+
 static struct pcie_port_service_driver hpdriver_portdrv = {
 	.name		= PCIE_MODULE_NAME,
 	.port_type	= PCIE_ANY_PORT,
@@ -311,6 +329,8 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
 	.suspend	= pciehp_suspend,
 	.resume		= pciehp_resume,
 #endif	/* PM */
+
+	.reset_link	= pciehp_reset_link,
 };
 
 static int __init pcied_init(void)
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index a3a26f1..0b66779 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -308,6 +308,11 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 		pci_dev_put(pdev);
 	}
 
+	/* handle link reset via hotplug driver if supported */
+	if (dev->is_hotplug_bridge &&
+		pcie_port_find_device(dev, PCIE_PORT_SERVICE_HP))
+		service = PCIE_PORT_SERVICE_HP;
+
 	result = reset_link(udev, service);
 
 	if ((service == PCIE_PORT_SERVICE_AER) &&
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
